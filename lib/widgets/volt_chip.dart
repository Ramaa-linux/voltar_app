import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

/// Status materi pada [VoltChip].
enum VoltChipStatus { active, done, locked }

/// Chip status VoltAR: titik 6px + label 12/500, radius 8, border 1px.
///
/// Warna pasangan sudah ditetapkan token - jangan oper Color langsung.
class VoltChip extends StatelessWidget {
  const VoltChip({
    super.key,
    required this.label,
    this.status = VoltChipStatus.active,
  });

  final String label;
  final VoltChipStatus status;

  @override
  Widget build(BuildContext context) {
    final (Color foreground, Color background) = switch (status) {
      VoltChipStatus.active => (
        AppColors.primaryDark,
        AppColors.primaryLight,
      ),
      VoltChipStatus.done => (AppColors.success, AppColors.successLight),
      VoltChipStatus.locked => (AppColors.textTertiary, AppColors.surface),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: AppBorders.standard,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: foreground,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: AppTypography.label.copyWith(color: foreground)),
        ],
      ),
    );
  }
}
