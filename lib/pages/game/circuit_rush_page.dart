import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_engine.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_painter.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Halaman penuh mini-game Sirkuit Kilat (Fase 14B).
class CircuitRushPage extends StatefulWidget {
  const CircuitRushPage({super.key, this.engine});

  /// Engine opsional untuk injeksi pada widget test.
  final CircuitRushEngine? engine;

  @override
  State<CircuitRushPage> createState() => _CircuitRushPageState();
}

class _CircuitRushPageState extends State<CircuitRushPage>
    with SingleTickerProviderStateMixin {
  late final CircuitRushEngine _engine;
  late final bool _ownsEngine;
  late final Ticker _ticker;
  Duration? _lastTick;

  @override
  void initState() {
    super.initState();
    _ownsEngine = widget.engine == null;
    _engine = widget.engine ?? CircuitRushEngine();
    _ticker = createTicker(_onTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final bool isTestBinding = WidgetsBinding.instance.runtimeType
        .toString()
        .contains('TestWidgetsFlutterBinding');

    if (!disableAnimations && !isTestBinding && !_ticker.isActive) {
      _lastTick = null;
      _ticker.start();
    } else if (disableAnimations && _ticker.isActive) {
      _ticker.stop();
    }
  }

  void _onTick(Duration elapsed) {
    final Duration? previous = _lastTick;
    _lastTick = elapsed;
    if (previous == null) return;
    final double dt =
        (elapsed - previous).inMicroseconds / Duration.microsecondsPerSecond;
    _engine.update(dt);
  }

  void _exitGame() {
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

  @override
  void dispose() {
    _ticker.dispose();
    if (_ownsEngine) _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: AppColors.circuitBoardDark,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            _engine.setViewport(constraints.maxWidth, constraints.maxHeight);
            return GestureDetector(
              key: const Key('circuit_rush_tap_area'),
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) => _engine.tap(),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  RepaintBoundary(
                    child: CustomPaint(
                      painter: CircuitRushPainter(engine: _engine),
                      size: Size.infinite,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.pagePadding),
                      child: ListenableBuilder(
                        listenable: _engine,
                        builder: (BuildContext context, _) => _buildOverlays(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverlays() {
    return Stack(
      children: <Widget>[
        _TopHud(
          score: _engine.score,
          highScore: _engine.highScore,
          status: _engine.status,
          onBack: _exitGame,
          onTogglePause: () {
            if (_engine.status == CircuitRushStatus.playing) {
              _engine.pause();
            } else if (_engine.status == CircuitRushStatus.paused) {
              _engine.resume();
            }
          },
        ),
        if (_engine.status == CircuitRushStatus.ready)
          Center(child: _ReadyOverlay(onStart: _engine.tap)),
        if (_engine.status == CircuitRushStatus.paused)
          Center(
            child: _PausedOverlay(
              onResume: _engine.resume,
              onRestart: () => _engine.reset(startImmediately: true),
              onExit: _exitGame,
            ),
          ),
        if (_engine.status == CircuitRushStatus.gameOver)
          Center(
            child: _GameOverOverlay(
              score: _engine.score,
              highScore: _engine.highScore,
              coinsCollected: _engine.coinsCollected,
              onRetry: () => _engine.reset(startImmediately: true),
              onExit: _exitGame,
            ),
          ),
      ],
    );
  }
}


class _TopHud extends StatelessWidget {
  const _TopHud({
    required this.score,
    required this.highScore,
    required this.status,
    required this.onBack,
    required this.onTogglePause,
  });

  final int score;
  final int highScore;
  final CircuitRushStatus status;
  final VoidCallback onBack;
  final VoidCallback onTogglePause;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _HudIconButton(
          key: const Key('circuit_rush_back_button'),
          tooltip: 'Kembali',
          icon: AppIconName.arrowLeft,
          onTap: onBack,
        ),
        const SizedBox(width: AppSpacing.md),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const AppIcon.zap(
                size: AppIconSize.sm,
                color: AppColors.accent,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '$score V',
                key: const Key('circuit_rush_score_text'),
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              if (highScore > 0) ...<Widget>[
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Rekor $highScore',
                  style: AppTypography.label.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Spacer(),
        if (status == CircuitRushStatus.playing ||
            status == CircuitRushStatus.paused)
          _HudIconButton(
            key: const Key('circuit_rush_pause_button'),
            tooltip: status == CircuitRushStatus.paused ? 'Lanjut' : 'Jeda',
            icon: status == CircuitRushStatus.paused
                ? AppIconName.play
                : AppIconName.stop,
            onTap: onTogglePause,
          ),
      ],
    );
  }
}

class _HudIconButton extends StatelessWidget {
  const _HudIconButton({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });

  final String tooltip;
  final AppIconName icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: AppSpacing.minTouchTarget,
            height: AppSpacing.minTouchTarget,
            child: Center(
              child: AppIcon(
                icon,
                size: AppIconSize.md,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _ReadyOverlay extends StatelessWidget {
  const _ReadyOverlay({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: VoltCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: const AppIcon.zap(
                size: AppIconSize.lg,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Sirkuit Kilat', style: AppTypography.heading),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Ketuk layar untuk melompat melewati celah resistor dan kumpulkan koin voltase!',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMuted,
            ),
            const SizedBox(height: AppSpacing.lg),
            VoltButton(
              label: 'Mulai Main',
              icon: AppIconName.play,
              fullWidth: true,
              onPressed: onStart,
            ),
          ],
        ),
      ),
    );
  }
}

class _PausedOverlay extends StatelessWidget {
  const _PausedOverlay({
    required this.onResume,
    required this.onRestart,
    required this.onExit,
  });

  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: VoltCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Permainan Dijeda', style: AppTypography.title),
            const SizedBox(height: AppSpacing.lg),
            VoltButton(
              label: 'Lanjutkan',
              icon: AppIconName.play,
              fullWidth: true,
              onPressed: onResume,
            ),
            const SizedBox(height: AppSpacing.sm),
            VoltButton(
              label: 'Ulangi',
              variant: VoltButtonVariant.secondary,
              fullWidth: true,
              onPressed: onRestart,
            ),
            const SizedBox(height: AppSpacing.sm),
            VoltButton(
              label: 'Keluar',
              variant: VoltButtonVariant.secondary,
              fullWidth: true,
              onPressed: onExit,
            ),
          ],
        ),
      ),
    );
  }
}

class _GameOverOverlay extends StatelessWidget {
  const _GameOverOverlay({
    required this.score,
    required this.highScore,
    required this.coinsCollected,
    required this.onRetry,
    required this.onExit,
  });

  final int score;
  final int highScore;
  final int coinsCollected;
  final VoidCallback onRetry;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: VoltCard(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const VoltChip(
                label: 'Korsleting!',
                status: VoltChipStatus.done,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Arus Terputus', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Skor Akhir: $score V • Rekor: $highScore V',
                style: AppTypography.bodyMuted,
              ),
              if (coinsCollected > 0) ...<Widget>[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Koin Voltase: $coinsCollected',
                  style: AppTypography.label.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              VoltButton(
                label: 'Main Lagi',
                icon: AppIconName.play,
                fullWidth: true,
                onPressed: onRetry,
              ),
              const SizedBox(height: AppSpacing.sm),
              VoltButton(
                label: 'Keluar',
                variant: VoltButtonVariant.secondary,
                fullWidth: true,
                onPressed: onExit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
