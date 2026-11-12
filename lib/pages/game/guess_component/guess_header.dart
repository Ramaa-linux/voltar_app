import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';

class GuessGameHeader extends StatelessWidget {
  const GuessGameHeader({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.score,
    required this.streak,
    required this.hintUsed,
    required this.onExit,
    required this.onHintTap,
  });

  final int currentIndex;
  final int totalQuestions;
  final int score;
  final int streak;
  final bool hintUsed;
  final VoidCallback onExit;
  final VoidCallback onHintTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            key: const Key('guess_exit_button'),
            icon: const AppIcon.arrowLeft(
              size: AppIconSize.md,
              color: AppColors.surface,
            ),
            tooltip: 'Keluar',
            onPressed: onExit,
          ),
          const SizedBox(width: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Text(
              'Soal ${currentIndex + 1}/$totalQuestions',
              style: AppTypography.label.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Spacer(),
          if (streak > 0) ...<Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppRadius.chip),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.6)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const AppIcon.zap(size: AppIconSize.sm, color: AppColors.accent),
                  const SizedBox(width: 4),
                  Text(
                    'x$streak',
                    style: AppTypography.label.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.chip),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
            ),
            child: Text(
              '$score V',
              style: AppTypography.label.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          IconButton(
            key: const Key('guess_hint_button'),
            icon: AppIcon.helpCircle(
              size: AppIconSize.md,
              color: hintUsed
                  ? AppColors.accent
                  : AppColors.surface.withValues(alpha: 0.9),
            ),
            tooltip: 'Petunjuk (-5 V)',
            onPressed: onHintTap,
          ),
        ],
      ),
    );
  }
}
