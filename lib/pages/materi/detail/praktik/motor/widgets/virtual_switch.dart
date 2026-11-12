import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

/// Toggle switch bergaya saklar fisik (ON/OFF) dengan animasi tuas.
class VirtualSwitch extends StatelessWidget {
  const VirtualSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.accentColor,
    this.subtitle,
  });

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          onChanged(!value);
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSpacing.minTouchTarget),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: value ? accentColor.withValues(alpha: 0.08) : AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.input),
              border: Border.all(
                color: value ? accentColor.withValues(alpha: 0.5) : AppColors.border,
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        label,
                        style: AppTypography.label.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: AppTypography.overline.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 54,
                  height: 30,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: value ? accentColor : AppColors.circuitPinHeader,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.shadow.withValues(alpha: 0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
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
