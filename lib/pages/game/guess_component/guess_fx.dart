import 'dart:async';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// Centralized configuration for Guess Component juice layer (Fase 19B).
class GuessFxConfig {
  const GuessFxConfig._();

  static const Duration flashDuration = Duration(milliseconds: 300);
  static const double flashAlpha = 0.2;
  static const Duration shakeDuration = Duration(milliseconds: 300);
  static const double shakeAmplitude = 10.0;
  static const int shakeCycles = 3;
  static const int vibrateMillis = 200;
  static const bool fxOnTimeout = true;

  /// Deterministik damped sine shake:
  /// dx = shakeAmplitude * sin(2 * pi * shakeCycles * t) * (1 - t)
  static double computeShakeDx(
    double t, {
    double amplitude = shakeAmplitude,
    int cycles = shakeCycles,
  }) {
    if (t <= 0.0 || t >= 1.0) return 0.0;
    return amplitude * math.sin(2 * math.pi * cycles * t) * (1.0 - t);
  }
}

/// Abstract contract for game sound effects.
abstract interface class GuessSfx {
  Future<void> preload();
  Future<void> playCorrect();
  Future<void> playWrong();
  Future<void> stop();
  Future<void> dispose();
}

/// Abstract contract for game haptics.
abstract interface class GuessHaptics {
  Future<void> wrongVibration();
  Future<void> correctTick();
}

/// Real implementation of [GuessSfx] backed by `audioplayers`.
class AudioplayersGuessSfx implements GuessSfx {
  AudioplayersGuessSfx({AudioPlayer? player})
      : _player = player ?? AudioPlayer(),
        _ownsPlayer = player == null {
    _init();
  }

  final AudioPlayer _player;
  final bool _ownsPlayer;
  int _token = 0;
  bool _disposed = false;

  void _init() {
    unawaited(() async {
      try {
        await AudioPlayer.global.setAudioContext(
          AudioContextConfig(
            respectSilence: true,
            stayAwake: false,
          ).build(),
        );
      } catch (_) {
        // Global audio context may not be supported on all targets; ignore safely.
      }
      try {
        await _player.setReleaseMode(ReleaseMode.stop);
        await _player.setPlayerMode(PlayerMode.lowLatency);
      } catch (_) {
        // Safe fallback.
      }
    }());
  }

  @override
  Future<void> preload() async {
    if (_disposed) return;
    try {
      await AudioCache.instance.loadAll(<String>[
        'audio/benar.mp3',
        'audio/salah.mp3',
      ]);
    } catch (_) {
      // Missing assets or unsupported targets fail gracefully.
    }
  }

  @override
  Future<void> playCorrect() => _play(AssetSource('audio/benar.mp3'));

  @override
  Future<void> playWrong() => _play(AssetSource('audio/salah.mp3'));

  Future<void> _play(Source source) async {
    if (_disposed) return;
    final int currentToken = ++_token;
    try {
      await _player.stop();
      if (_disposed || currentToken != _token) return;
      await _player.play(source);
    } catch (_) {
      // Ignored: missing plugin, missing asset, or audio device busy.
    }
  }

  @override
  Future<void> stop() async {
    _token++;
    if (_disposed) return;
    try {
      await _player.stop();
    } catch (_) {}
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _token++;
    try {
      await _player.stop();
      if (_ownsPlayer) {
        await _player.dispose();
      }
    } catch (_) {}
  }
}

/// Fallback / testing no-op implementation of [GuessSfx].
class SilentGuessSfx implements GuessSfx {
  const SilentGuessSfx();

  @override
  Future<void> preload() async {}

  @override
  Future<void> playCorrect() async {}

  @override
  Future<void> playWrong() async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {}
}

/// Real implementation of [GuessHaptics] with platform dispatching.
class PlatformGuessHaptics implements GuessHaptics {
  PlatformGuessHaptics() {
    _checkVibrator();
  }

  bool _hasVibrator = false;
  bool _checked = false;

  void _checkVibrator() {
    if (kIsWeb) return;
    unawaited(() async {
      try {
        if (defaultTargetPlatform == TargetPlatform.android) {
          _hasVibrator = await Vibration.hasVibrator();
        }
      } catch (_) {
        _hasVibrator = false;
      } finally {
        _checked = true;
      }
    }());
  }

  @override
  Future<void> correctTick() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (_) {}
  }

  @override
  Future<void> wrongVibration() async {
    if (kIsWeb) return;
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        if (!_checked || _hasVibrator) {
          await Vibration.vibrate(duration: GuessFxConfig.vibrateMillis);
        } else {
          await HapticFeedback.heavyImpact();
        }
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        await HapticFeedback.heavyImpact();
      }
    } catch (_) {}
  }
}

/// Fallback / testing no-op implementation of [GuessHaptics].
class NoopGuessHaptics implements GuessHaptics {
  const NoopGuessHaptics();

  @override
  Future<void> correctTick() async {}

  @override
  Future<void> wrongVibration() async {}
}

/// Custom opacity animation driven by [parent] controller with ease-out fade,
/// evaluating to 0.0 whenever flash is inactive or dismissed/completed.
class FlashOpacityAnimation extends Animation<double>
    with AnimationWithParentMixin<double> {
  FlashOpacityAnimation(this.parent, this.isFlashActive);

  @override
  final Animation<double> parent;
  final ValueGetter<bool> isFlashActive;

  @override
  double get value {
    if (!isFlashActive() || parent.isDismissed || parent.isCompleted) {
      return 0.0;
    }
    final double curved = Curves.easeOut.transform(parent.value);
    return (1.0 - curved).clamp(0.0, 1.0);
  }
}

/// Fullscreen transparent screen flash overlay.
class GuessFlashOverlay extends StatelessWidget {
  const GuessFlashOverlay({
    super.key,
    required this.animation,
    required this.colorListenable,
  });

  final Animation<double> animation;
  final ValueListenable<Color> colorListenable;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ExcludeSemantics(
        child: ValueListenableBuilder<Color>(
          valueListenable: colorListenable,
          builder: (BuildContext context, Color color, Widget? child) {
            return FadeTransition(
              key: const Key('guess_fx_flash'),
              opacity: animation,
              child: ColoredBox(
                key: const Key('guess_fx_flash_box'),
                color: color,
                child: const SizedBox.expand(),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Screen shake wrapper for the question card (image + question text).
class GuessShakeWrapper extends StatelessWidget {
  const GuessShakeWrapper({
    super.key,
    required this.animation,
    required this.enabled,
    required this.child,
  });

  final Animation<double> animation;
  final ValueListenable<bool> enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? staticChild) {
        final double dx = (!disableAnimations &&
                enabled.value &&
                animation.status == AnimationStatus.forward)
            ? GuessFxConfig.computeShakeDx(animation.value)
            : 0.0;
        return Transform.translate(
          key: const Key('guess_fx_shake_transform'),
          offset: Offset(dx, 0.0),
          child: staticChild,
        );
      },
      child: child,
    );
  }
}
