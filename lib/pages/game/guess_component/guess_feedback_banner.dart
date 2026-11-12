import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_chip.dart';

class GuessFeedbackBanner extends StatelessWidget {
  const GuessFeedbackBanner({
    super.key,
    required this.isCorrect,
    required this.timedOut,
    required this.correctAnswer,
    required this.explanation,
  });

  final bool isCorrect;
  final bool timedOut;
  final String correctAnswer;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isCorrect ? AppColors.successLight : AppColors.errorLight;
    final Color borderColor = isCorrect ? AppColors.success : AppColors.error;
    final Color textColor = isCorrect ? const Color(0xFF065F46) : const Color(0xFF991B1B);
    final String title = isCorrect
        ? 'Jawaban Benar!'
        : timedOut
            ? 'Waktu Habis!'
            : 'Jawaban Kurang Tepat!';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(isCorrect ? Icons.check_circle : Icons.cancel, color: borderColor, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(title, style: AppTypography.body.copyWith(fontWeight: FontWeight.w700, color: textColor)),
            ],
          ),
          if (!isCorrect) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text('Kunci: $correctAnswer', style: AppTypography.body.copyWith(fontWeight: FontWeight.w700, color: textColor)),
          ],
          const SizedBox(height: AppSpacing.xs),
          Text(explanation, style: AppTypography.caption.copyWith(color: textColor)),
        ],
      ),
    );
  }
}

class GuessHintSheet extends StatelessWidget {
  const GuessHintSheet({super.key, required this.hint, required this.onClose});

  final String hint;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.card)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const VoltChip(label: 'Petunjuk (-5 V)', status: VoltChipStatus.active),
                const Spacer(),
                IconButton(icon: const Icon(Icons.close), onPressed: onClose),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(hint, style: AppTypography.body),
            const SizedBox(height: AppSpacing.lg),
            VoltButton(label: 'Lanjutkan Kuis', fullWidth: true, onPressed: onClose),
          ],
        ),
      ),
    );
  }
}
