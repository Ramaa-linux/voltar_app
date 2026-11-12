import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:voltar/pages/game/guess_component/component_data.dart';
import 'package:voltar/pages/game/guess_component/guess_balance.dart';
import 'package:voltar/pages/game/guess_component/guess_controller.dart';
import 'package:voltar/pages/game/guess_component/guess_fx.dart';
import 'package:voltar/pages/game/guess_component/guess_widgets.dart';
import 'package:voltar/pages/game/guess_component/resistor_painter.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';

export 'package:voltar/pages/game/guess_component/guess_controller.dart';
export 'package:voltar/pages/game/guess_component/guess_fx.dart';

/// Full-screen mini-game page "Tebak Komponen" (Fase 19).
class GuessComponentPage extends StatefulWidget {
  const GuessComponentPage({
    super.key,
    this.controller,
    this.sfx,
    this.haptics,
  });

  final GuessController? controller;
  @visibleForTesting
  final GuessSfx? sfx;
  @visibleForTesting
  final GuessHaptics? haptics;

  @override
  State<GuessComponentPage> createState() => _GuessComponentPageState();
}

class _GuessComponentPageState extends State<GuessComponentPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late final GuessController _controller;
  late final bool _ownsController;
  late final GuessSfx _sfx;
  late final GuessHaptics _haptics;

  late final AnimationController _fxController;
  late final FlashOpacityAnimation _flashAnimation;
  late final ValueNotifier<Color> _flashColorNotifier;
  final ValueNotifier<bool> _shakeEnabledNotifier = ValueNotifier<bool>(false);

  bool _flashActive = false;
  GuessPhase _prevPhase = GuessPhase.asking;
  int _prevIndex = 0;
  int _sessionGeneration = 0;
  int? _lastHandledFxKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? GuessController();
    _controller.addListener(_onControllerChanged);

    _sfx = widget.sfx ?? AudioplayersGuessSfx();
    _haptics = widget.haptics ?? PlatformGuessHaptics();
    unawaited(_sfx.preload());

    _fxController = AnimationController(
      vsync: this,
      duration: GuessFxConfig.flashDuration,
    );
    _flashAnimation = FlashOpacityAnimation(_fxController, () => _flashActive);
    _flashColorNotifier = ValueNotifier<Color>(
      AppColors.success.withValues(alpha: GuessFxConfig.flashAlpha),
    );

    _prevPhase = _controller.phase;
    _prevIndex = _controller.currentIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheNextImage();
  }

  void _onControllerChanged() {
    if (!mounted) return;
    _precacheNextImage();
    _handlePhaseTransition();
  }

  void _precacheNextImage() {
    final String? nextImg = _controller.nextQuestionImagePath;
    if (nextImg != null && mounted) {
      precacheImage(AssetImage(nextImg), context).ignore();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _controller.pause(PauseReason.lifecycle);
      unawaited(_sfx.stop());
    } else if (state == AppLifecycleState.resumed) {
      _controller.resume(PauseReason.lifecycle);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onControllerChanged);
    if (_ownsController) {
      _controller.dispose();
    }
    _fxController.dispose();
    unawaited(_sfx.dispose());
    _flashColorNotifier.dispose();
    _shakeEnabledNotifier.dispose();
    super.dispose();
  }

  void _handlePhaseTransition() {
    final GuessPhase currentPhase = _controller.phase;
    final int currentIndex = _controller.currentIndex;

    if (currentPhase == GuessPhase.asking &&
        currentIndex == 0 &&
        (_prevPhase != GuessPhase.asking || _prevIndex != 0)) {
      _sessionGeneration++;
      _stopVisualFx();
      unawaited(_sfx.stop());
    }

    if (_prevPhase == GuessPhase.feedback &&
        currentPhase != GuessPhase.feedback) {
      _stopVisualFx();
      unawaited(_sfx.stop());
    }

    if (_prevPhase == GuessPhase.asking &&
        currentPhase == GuessPhase.feedback) {
      final int fxKey = _sessionGeneration * 1000 + currentIndex;
      if (_lastHandledFxKey != fxKey) {
        _lastHandledFxKey = fxKey;
        _playFx();
      }
    }

    _prevPhase = currentPhase;
    _prevIndex = currentIndex;
  }

  void _playFx() {
    final bool isTimeout = _controller.timedOutForCurrent;
    final bool isCorrect = !isTimeout && _controller.isCurrentAnswerCorrect;

    if (isTimeout && !GuessFxConfig.fxOnTimeout) {
      return;
    }

    if (isCorrect) {
      unawaited(_sfx.playCorrect());
      unawaited(_haptics.correctTick());
      _triggerVisualFx(
        color: AppColors.success.withValues(alpha: GuessFxConfig.flashAlpha),
        shake: false,
      );
    } else {
      unawaited(_sfx.playWrong());
      unawaited(_haptics.wrongVibration());
      _triggerVisualFx(
        color: AppColors.error.withValues(alpha: GuessFxConfig.flashAlpha),
        shake: true,
      );
    }
  }

  void _triggerVisualFx({required Color color, required bool shake}) {
    if (!mounted) return;
    final bool disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (disableAnimations) {
      _stopVisualFx();
      return;
    }
    _flashColorNotifier.value = color;
    _shakeEnabledNotifier.value = shake;
    _flashActive = true;
    _fxController.forward(from: 0.0);
  }

  void _stopVisualFx() {
    _flashActive = false;
    _shakeEnabledNotifier.value = false;
    if (_fxController.isAnimating || _fxController.value != 0.0) {
      _fxController.reset();
    }
  }

  void _exitGame() {
    unawaited(_sfx.stop());
    final GoRouter? router = GoRouter.maybeOf(context);
    if (router != null) {
      if (router.canPop()) {
        router.pop();
      } else {
        router.go(AppRoutes.home);
      }
      return;
    }
    Navigator.of(context).maybePop();
  }

  Future<void> _showHintSheet() async {
    if (_controller.phase != GuessPhase.asking) return;
    _controller.useHint();
    _controller.pause(PauseReason.hintSheet);

    try {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) => GuessHintSheet(
          hint: _controller.currentQuestion.hint,
          onClose: () => Navigator.of(ctx).pop(),
        ),
      );
    } finally {
      if (mounted) {
        _controller.resume(PauseReason.hintSheet);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: ListenableBuilder(
        listenable: _controller,
        builder: (BuildContext context, _) {
          return Stack(
            children: <Widget>[
              Scaffold(
                backgroundColor: AppColors.circuitBoardDark,
                body: SafeArea(
                  child: _buildMainContent(),
                ),
              ),
              Positioned.fill(
                child: GuessFlashOverlay(
                  animation: _flashAnimation,
                  colorListenable: _flashColorNotifier,
                ),
              ),
              if (_controller.phase == GuessPhase.finished)
                Positioned.fill(
                  child: Material(
                    type: MaterialType.transparency,
                    child: _buildGameOverOverlay(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainContent() {
    final ComponentQuestion q = _controller.currentQuestion;
    final bool isAsking = _controller.phase == GuessPhase.asking;

    return Column(
      children: <Widget>[
        GuessGameHeader(
          currentIndex: _controller.currentIndex,
          totalQuestions: _controller.totalQuestions,
          score: _controller.score,
          streak: _controller.streak,
          hintUsed: _controller.hintUsedForCurrent,
          onExit: _exitGame,
          onHintTap: _showHintSheet,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
              vertical: AppSpacing.xs,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GuessShakeWrapper(
                      animation: _fxController,
                      enabled: _shakeEnabledNotifier,
                      child: _buildQuestionCard(q, isAsking),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...List<Widget>.generate(4, (int i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: GuessOptionTile(
                          key: Key('guess_option_$i'),
                          index: i,
                          label: q.options[i],
                          phase: _controller.phase,
                          selectedOption: _controller.selectedOption,
                          correctIndex: q.correctIndex,
                          onTap: () => _controller.selectOption(i),
                        ),
                      );
                    }),
                    if (_controller.phase == GuessPhase.feedback) ...<Widget>[
                      const SizedBox(height: AppSpacing.xs),
                      GuessFeedbackBanner(
                        key: const Key('guess_feedback_banner'),
                        isCorrect: _controller.isCurrentAnswerCorrect,
                        timedOut: _controller.timedOutForCurrent,
                        correctAnswer: q.correctAnswer,
                        explanation: q.explanation,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildQuestionCard(ComponentQuestion q, bool isAsking) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: AppColors.surface.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Text(
                  'Level ${q.difficulty}',
                  style: AppTypography.overline.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              if (isAsking)
                GuessTimerRing(
                  key: ValueKey<String>(
                    'timer_${_controller.currentIndex}_${q.id}',
                  ),
                  duration: const Duration(
                    seconds: GuessBalance.questionSeconds,
                  ),
                  isPaused: _controller.isPaused,
                  onTimeout: _controller.handleTimeout,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (q.isResistor)
            Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.input),
              ),
              child: ResistorVisual(
                key: Key('resistor_visual_${q.id}'),
                bands: q.resistorBands!,
                height: 88,
              ),
            )
          else if (q.hasImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.input),
              child: Container(
                color: AppColors.surface,
                height: 112,
                width: double.infinity,
                child: Image.asset(
                  q.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (BuildContext context, Object e, _) {
                    return const Center(
                      child: AppIcon.cpu(
                        size: AppIconSize.lg,
                        color: AppColors.primaryDark,
                      ),
                    );
                  },
                ),
              ),
            ),
          if (q.isResistor || q.hasImage) const SizedBox(height: AppSpacing.sm),
          Text(
            q.question,
            style: AppTypography.body.copyWith(
              color: AppColors.surface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGameOverOverlay() {
    return Container(
      key: const Key('guess_gameover_overlay'),
      color: Colors.black.withValues(alpha: 0.45),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: GuessGameOverOverlay(
        score: _controller.score,
        correctCount: _controller.correctCount,
        totalQuestions: _controller.totalQuestions,
        bestStreak: _controller.bestStreak,
        starRating: _controller.starRating,
        onRetry: _controller.restartGame,
        onExit: _exitGame,
      ),
    );
  }
}
