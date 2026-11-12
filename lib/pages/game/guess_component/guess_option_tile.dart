import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/press_scale.dart';
import 'guess_controller.dart';

class GuessOptionTile extends StatelessWidget {
  const GuessOptionTile({
    super.key,
    required this.index,
    required this.label,
    required this.phase,
    required this.selectedOption,
    required this.correctIndex,
    required this.onTap,
  });

  final int index;
  final String label;
  final GuessPhase phase;
  final int? selectedOption;
  final int correctIndex;
  final VoidCallback onTap;

  static const List<String> _letters = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final bool isAsking = phase == GuessPhase.asking;
    final bool isSelected = selectedOption == index;
    final bool isCorrectOption = index == correctIndex;

    Color bgColor = AppColors.surface;
    Color borderColor = AppColors.border;
    Color textColor = AppColors.textPrimary;
    Color badgeBg = AppColors.primaryLight;
    Color badgeText = AppColors.primaryDark;

    if (!isAsking) {
      if (isCorrectOption) {
        bgColor = AppColors.successLight;
        borderColor = AppColors.success;
        badgeBg = AppColors.success;
        badgeText = AppColors.textOnPrimary;
      } else if (isSelected && !isCorrectOption) {
        bgColor = AppColors.errorLight;
        borderColor = AppColors.error;
        badgeBg = AppColors.error;
        badgeText = AppColors.textOnPrimary;
      }
    }

    final BorderRadius radius = BorderRadius.circular(AppRadius.button);

    return PressScale(
      enabled: isAsking,
      scale: 0.985,
      child: Material(
        color: bgColor,
        borderRadius: radius,
        child: InkWell(
          onTap: isAsking ? onTap : null,
          borderRadius: radius,
          child: Container(
            constraints: const BoxConstraints(minHeight: AppSpacing.minTouchTarget),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: borderColor,
                width: !isAsking && (isCorrectOption || isSelected) ? 2.0 : 1.0,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: badgeBg, shape: BoxShape.circle),
                  child: Text(
                    _letters[index % 4],
                    style: AppTypography.label.copyWith(
                      color: badgeText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.body.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
