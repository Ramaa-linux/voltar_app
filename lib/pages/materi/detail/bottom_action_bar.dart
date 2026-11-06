import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

/// Tombol aksi bawah: "Tandai Selesai".
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.isDone,
    required this.onMarkDone,
  });

  final bool isDone;
  final VoidCallback onMarkDone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.pagePadding,
          AppSpacing.md,
          AppSpacing.pagePadding,
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton(
            onPressed: isDone ? null : onMarkDone,
            style: FilledButton.styleFrom(
              backgroundColor: isDone ? AppColors.textTertiary : AppColors.primary,
              disabledBackgroundColor: AppColors.textTertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
            ),
            child: Text(
              isDone ? 'Sudah Selesai' : 'Tandai Selesai',
              style: AppTypography.button,
            ),
          ),
        ),
      ),
    );
  }
}