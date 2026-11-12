import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

class GuessGameOverOverlay extends StatelessWidget {
  const GuessGameOverOverlay({
    super.key,
    required this.score,
    required this.correctCount,
    required this.totalQuestions,
    required this.bestStreak,
    required this.starRating,
    required this.onRetry,
    required this.onExit,
  });

  final int score;
  final int correctCount;
  final int totalQuestions;
  final int bestStreak;
  final int starRating;
  final VoidCallback onRetry;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 340),
      child: VoltCard(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const VoltChip(label: 'Sesi Selesai!', status: VoltChipStatus.done),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(3, (int i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      Icons.star_rounded,
                      size: 38,
                      color: i < starRating ? AppColors.accent : AppColors.border,
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text('$score V', style: AppTypography.display.copyWith(color: AppColors.primaryDark), textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.xs),
              Text('Akurasi: $correctCount / $totalQuestions Soal', style: AppTypography.bodyMuted, textAlign: TextAlign.center),
              if (bestStreak > 1) ...<Widget>[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Streak Terbaik: $bestStreak beruntun!',
                  style: AppTypography.label.copyWith(color: AppColors.accent, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              VoltButton(
                key: const Key('guess_retry_button'),
                label: 'Main Lagi',
                icon: AppIconName.play,
                fullWidth: true,
                onPressed: onRetry,
              ),
              const SizedBox(height: AppSpacing.sm),
              VoltButton(
                key: const Key('guess_gameover_exit_button'),
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
