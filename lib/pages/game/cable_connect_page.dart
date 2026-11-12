import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/pages/game/cable_connect/cable_controller.dart';
import 'package:voltar/pages/game/cable_connect/cable_levels.dart';
import 'package:voltar/pages/game/cable_connect/cable_models.dart';
import 'package:voltar/pages/game/cable_connect/cable_painters.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

export 'package:voltar/pages/game/cable_connect/cable_controller.dart';

/// Halaman penuh mini-game Sambung Kabel (Fase 15B).
class CableConnectPage extends StatefulWidget {
  const CableConnectPage({super.key, this.controller});
  final CableConnectController? controller;

  @override
  State<CableConnectPage> createState() => _CableConnectPageState();
}

class _CableConnectPageState extends State<CableConnectPage>
    with WidgetsBindingObserver {
  late final CableConnectController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? CableConnectController();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller.pauseTimer();
    } else if (state == AppLifecycleState.resumed) {
      _controller.resumeTimer();
    }
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
    WidgetsBinding.instance.removeObserver(this);
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: AppColors.circuitBoardDark,
        body: SafeArea(
          child: ListenableBuilder(
            listenable: _controller,
            builder: (BuildContext context, _) {
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _buildTopHud(),
                      _buildComponentChecklist(),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: _buildBoardInteractive(),
                            ),
                          ),
                        ),
                      ),
                      _buildBottomInfo(),
                    ],
                  ),
                  if (_controller.status == CableGameStatus.won)
                    Center(child: _buildWinOverlay()),
                  if (_controller.status == CableGameStatus.gameOver)
                    Center(child: _buildGameOverOverlay()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopHud() {
    final bool timerUrgent = _controller.secondsLeft <= 10;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePadding,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: <Widget>[
          _CircleButton(
            key: const Key('cable_connect_back_button'),
            tooltip: 'Kembali',
            icon: AppIconName.arrowLeft,
            onTap: _exitGame,
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              'Level ${_controller.levelNumber}',
              style: AppTypography.title.copyWith(color: AppColors.surface),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: timerUrgent
                  ? AppColors.error
                  : AppColors.surface.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const AppIcon(
                  AppIconName.zap,
                  size: AppIconSize.sm,
                  color: AppColors.surface,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_controller.secondsLeft}s',
                  style: AppTypography.title.copyWith(color: AppColors.surface),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              '${_controller.score} V',
              style: AppTypography.title.copyWith(color: AppColors.accent),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          _CircleButton(
            key: const Key('cable_connect_reset_button'),
            tooltip: 'Ulang Jalur',
            icon: AppIconName.stop,
            onTap: _controller.resetPath,
          ),
        ],
      ),
    );
  }

  Widget _buildComponentChecklist() {
    int totalResistors = 0;
    int visitedResistors = 0;
    int totalLeds = 0;
    int visitedLeds = 0;

    _controller.level.components.forEach((Pos pos, CellType type) {
      final bool visited = _controller.visitedComponents.contains(pos);
      if (type == CellType.resistor) {
        totalResistors++;
        if (visited) visitedResistors++;
      } else if (type == CellType.led) {
        totalLeds++;
        if (visited) visitedLeds++;
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePadding,
        vertical: AppSpacing.xs,
      ),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.xs,
        alignment: WrapAlignment.center,
        children: <Widget>[
          if (totalResistors > 0)
            VoltChip(
              label: 'Resistor: $visitedResistors/$totalResistors',
              status: visitedResistors == totalResistors
                  ? VoltChipStatus.done
                  : VoltChipStatus.active,
            ),
          if (totalLeds > 0)
            VoltChip(
              label: 'LED: $visitedLeds/$totalLeds',
              status: visitedLeds == totalLeds
                  ? VoltChipStatus.done
                  : VoltChipStatus.active,
            ),
        ],
      ),
    );
  }

  Widget _buildBoardInteractive() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size boardSize = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        return GestureDetector(
          key: const Key('cable_connect_board_gesture'),
          behavior: HitTestBehavior.opaque,
          onPanDown: (DragDownDetails d) =>
              _controller.handleBoardPointer(d.localPosition, boardSize),
          onPanUpdate: (DragUpdateDetails d) =>
              _controller.handleBoardPointer(d.localPosition, boardSize),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.card),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CustomPaint(
                  painter: CableBoardPainter(
                    level: _controller.level,
                    visitedComponents: _controller.visitedComponents,
                    isComplete: _controller.isComplete,
                  ),
                ),
                CustomPaint(
                  painter: CablePathPainter(
                    path: _controller.path,
                    gridWidth: _controller.level.width,
                    gridHeight: _controller.level.height,
                    isComplete: _controller.isComplete,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomInfo() {
    final String? feedback = _controller.feedback;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        AppSpacing.xs,
        AppSpacing.pagePadding,
        AppSpacing.md,
      ),
      child: Text(
        feedback ?? 'Tarik kawat dari (+) melewati semua komponen ke (-).',
        style: AppTypography.bodyMuted.copyWith(
          color: AppColors.surface.withValues(alpha: 0.85),
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildWinOverlay() {
    final String fact = CableLevels.factForLevel(_controller.levelNumber);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 340),
      child: VoltCard(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const VoltChip(
                label: 'Arus Mengalir!',
                status: VoltChipStatus.done,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Rangkaian Tertutup',
                style: AppTypography.heading,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Skor: ${_controller.score} V • Streak: ${_controller.streak}x',
                style: AppTypography.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const AppIcon.lightbulb(
                      size: AppIconSize.md,
                      color: AppColors.primaryDark,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        fact,
                        style: AppTypography.label.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              VoltButton(
                key: const Key('cable_connect_next_button'),
                label: 'Level Berikutnya (+10s)',
                icon: AppIconName.play,
                fullWidth: true,
                onPressed: _controller.nextLevel,
              ),
              const SizedBox(height: AppSpacing.sm),
              VoltButton(
                label: 'Keluar',
                variant: VoltButtonVariant.secondary,
                fullWidth: true,
                onPressed: _exitGame,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverOverlay() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 340),
      child: VoltCard(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const VoltChip(
                label: 'Baterai Habis!',
                status: VoltChipStatus.locked,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Waktu Habis',
                style: AppTypography.heading,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Skor Akhir: ${_controller.score} V',
                style: AppTypography.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              VoltButton(
                key: const Key('cable_connect_retry_button'),
                label: 'Coba Lagi',
                icon: AppIconName.play,
                fullWidth: true,
                onPressed: _controller.retryGame,
              ),
              const SizedBox(height: AppSpacing.sm),
              VoltButton(
                label: 'Keluar',
                variant: VoltButtonVariant.secondary,
                fullWidth: true,
                onPressed: _exitGame,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
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
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.surface.withValues(alpha: 0.15),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: AppIcon(
              icon,
              size: AppIconSize.md,
              color: AppColors.surface,
            ),
          ),
        ),
      ),
    );
  }
}

