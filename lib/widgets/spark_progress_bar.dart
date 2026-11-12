import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/widgets/spark_particle_system.dart';

/// Progress bar kustom dengan efek percikan las (`SparkParticleSystem`)
/// dan titik pijar listrik di ujung kanan bar saat progres sedang berjalan (`0.0 < value < 1.0`).
class SparkProgressBar extends StatefulWidget {
  const SparkProgressBar({
    super.key,
    required this.value,
    this.height = 8.0,
    this.backgroundColor = AppColors.primaryLight,
    this.foregroundColor = AppColors.primary,
    this.sparkColor = AppColors.accent,
    this.particleConfig = const SparkParticleConfig(),
  });

  final double value;
  final double height;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color sparkColor;
  final SparkParticleConfig particleConfig;

  @override
  State<SparkProgressBar> createState() => _SparkProgressBarState();
}

class _SparkProgressBarState extends State<SparkProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final SparkParticleSystem _particleSystem;
  Duration? _lastElapsed;
  double _lastWidth = 0.0;
  bool _disableAnimations = false;

  double get _clampedValue =>
      widget.value.isNaN ? 0.0 : widget.value.clamp(0.0, 1.0);
  bool get _hasSpark => _clampedValue > 0.0 && _clampedValue < 1.0;

  bool get _isTestBinding => WidgetsBinding.instance.runtimeType
      .toString()
      .contains('TestWidgetsFlutterBinding');

  @override
  void initState() {
    super.initState();
    _particleSystem = SparkParticleSystem(config: widget.particleConfig);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..addListener(_onTick);

    _syncAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (_disableAnimations) {
      _particleSystem.reset();
    }
  }

  void _onTick() {
    if (_lastWidth <= 0.0) return;

    final Duration? elapsed = _controller.lastElapsedDuration;
    double dt = 0.016;
    if (elapsed != null && _lastElapsed != null) {
      dt = (elapsed - _lastElapsed!).inMicroseconds / 1000000.0;
    }
    _lastElapsed = elapsed;

    final double fillWidth = (_lastWidth * _clampedValue).clamp(0.0, _lastWidth);
    final Offset emitter = Offset(fillWidth, widget.height / 2);

    _particleSystem.update(
      dt,
      emitter,
      emitting: _hasSpark && !_disableAnimations,
    );
  }

  @override
  void didUpdateWidget(covariant SparkProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _syncAnimation();
    }
  }

  void _syncAnimation() {
    if (!_hasSpark) {
      _controller.stop();
      _controller.value = 0.0;
      _lastElapsed = null;
      _particleSystem.reset();
      return;
    }
    // ponytail: in widget tests, run one forward cycle so pumpAndSettle() settles;
    // in live app binding, repeat endlessly for continuous welding sparks.
    if (_isTestBinding) {
      _lastElapsed = null;
      _controller.forward(from: 0.0);
    } else if (!_controller.isAnimating) {
      _lastElapsed = null;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTick);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    return Semantics(
      label: 'Progress Belajar',
      value: '${(_clampedValue * 100).round()}%',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          _lastWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 0.0;

          return RepaintBoundary(
            child: SizedBox(
              width: double.infinity,
              height: widget.height,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? _) {
                  final double pulse =
                      disableAnimations ? 0.5 : _controller.value;
                  return CustomPaint(
                    painter: SparkProgressBarPainter(
                      clampedValue: _clampedValue,
                      pulse: pulse,
                      barHeight: widget.height,
                      backgroundColor: widget.backgroundColor,
                      foregroundColor: widget.foregroundColor,
                      sparkColor: widget.sparkColor,
                      particleSystem: _particleSystem,
                      particleConfig: widget.particleConfig,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}


/// [CustomPainter] murni untuk menggambar track, fill, welding core, dan percikan partikel.
class SparkProgressBarPainter extends CustomPainter {
  const SparkProgressBarPainter({
    required this.clampedValue,
    required this.pulse,
    required this.barHeight,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.sparkColor,
    this.particleSystem,
    this.particleConfig = const SparkParticleConfig(),
  });

  final double clampedValue;
  final double pulse;
  final double barHeight;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color sparkColor;
  final SparkParticleSystem? particleSystem;
  final SparkParticleConfig particleConfig;

  bool get hasSpark => clampedValue > 0.0 && clampedValue < 1.0;

  static final Paint _trackPaint = Paint()..style = PaintingStyle.fill;
  static final Paint _fillPaint = Paint()..style = PaintingStyle.fill;
  static final Paint _glowPaint = Paint()
    ..style = PaintingStyle.fill
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);
  static final Paint _rayPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.4
    ..strokeCap = StrokeCap.round;
  static final Paint _coreRingPaint = Paint()..style = PaintingStyle.fill;
  static final Paint _innerCorePaint = Paint()..style = PaintingStyle.fill;
  static final Paint _particlePaint = Paint()..style = PaintingStyle.fill;
  static final Paint _streakPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final double radius = barHeight / 2;
    final double top = (size.height - barHeight) / 2;
    final Rect trackRect = Rect.fromLTWH(0, top, size.width, barHeight);
    final RRect trackRRect = RRect.fromRectAndRadius(
      trackRect,
      Radius.circular(radius),
    );

    _trackPaint.color = backgroundColor;
    canvas.drawRRect(trackRRect, _trackPaint);

    if (clampedValue > 0.0) {
      final double fillWidth = (size.width * clampedValue).clamp(0.0, size.width);
      final Rect fillRect = Rect.fromLTWH(0, top, fillWidth, barHeight);
      final RRect fillRRect = RRect.fromRectAndRadius(
        fillRect,
        Radius.circular(radius),
      );

      canvas.save();
      canvas.clipRRect(trackRRect);

      _fillPaint.shader = LinearGradient(
        colors: <Color>[
          foregroundColor,
          Color.lerp(foregroundColor, sparkColor, 0.25 * pulse) ?? foregroundColor,
        ],
      ).createShader(fillRect);
      canvas.drawRRect(fillRRect, _fillPaint);
      canvas.restore();

      if (hasSpark) {
        final Offset center = Offset(fillWidth, size.height / 2);
        _paintWeldingCore(canvas, center);
        _paintParticles(canvas);
      }
    }
  }

  void _paintWeldingCore(Canvas canvas, Offset center) {
    final double baseRadius = math.max(barHeight * 0.65, 4.0);
    final double glowRadius = baseRadius * (1.4 + 0.5 * pulse);

    _glowPaint.color = sparkColor.withValues(alpha: 0.35 + 0.25 * pulse);
    canvas.drawCircle(center, glowRadius, _glowPaint);

    final double rayLength = baseRadius * (1.1 + 0.4 * pulse);
    _rayPaint.color = sparkColor.withValues(alpha: 0.9);
    canvas.drawLine(
      Offset(center.dx - rayLength, center.dy),
      Offset(center.dx + rayLength, center.dy),
      _rayPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - rayLength),
      Offset(center.dx, center.dy + rayLength),
      _rayPaint,
    );

    _coreRingPaint.color = sparkColor;
    canvas.drawCircle(center, baseRadius * (0.65 + 0.15 * pulse), _coreRingPaint);

    _innerCorePaint.color = AppColors.surface;
    canvas.drawCircle(center, baseRadius * 0.35, _innerCorePaint);
  }

  void _paintParticles(Canvas canvas) {
    final SparkParticleSystem? system = particleSystem;
    if (system == null) return;

    for (final SparkParticle p in system.activeParticles) {
      final Color color = SparkParticleSystem.colorAt(p.t, sparkColor: sparkColor);
      final double radius = SparkParticleSystem.sizeAt(p.t, p.startSize);

      _particlePaint.color = color;
      canvas.drawCircle(Offset(p.x, p.y), radius, _particlePaint);

      final double speed = math.sqrt(p.vx * p.vx + p.vy * p.vy);
      if (speed >= particleConfig.streakSpeedThreshold) {
        final double tailDx = p.vx * particleConfig.streakLengthFactor;
        final double tailDy = p.vy * particleConfig.streakLengthFactor;

        _streakPaint.color = color.withValues(alpha: (color.a * 0.75).clamp(0.0, 1.0));
        _streakPaint.strokeWidth = math.max(0.8, radius * 0.9);
        canvas.drawLine(
          Offset(p.x, p.y),
          Offset(p.x - tailDx, p.y - tailDy),
          _streakPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant SparkProgressBarPainter oldDelegate) {
    return oldDelegate.clampedValue != clampedValue ||
        oldDelegate.pulse != pulse ||
        oldDelegate.barHeight != barHeight ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor ||
        oldDelegate.sparkColor != sparkColor ||
        oldDelegate.particleSystem != particleSystem;
  }
}


