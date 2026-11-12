import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/motor_sim_controller.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

/// Pemilih perangkat input (Potensiometer vs Switch/Push Button) + info sinyal aktif.
class InputSelector extends StatelessWidget {
  const InputSelector({
    super.key,
    required this.selectedDevice,
    required this.onChanged,
    required this.accentColor,
  });

  final InputDevice selectedDevice;
  final ValueChanged<InputDevice> onChanged;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final bool isPot = selectedDevice == InputDevice.potentiometer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'PERANGKAT INPUT',
              style: AppTypography.overline.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
            Flexible(
              child: Text(
                isPot ? 'Analog input (ADC 0–1023)' : 'Digital input (HIGH/LOW)',
                overflow: TextOverflow.ellipsis,
                style: AppTypography.overline.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _buildOption(
                  key: const Key('input_device_potentiometer'),
                  label: 'Potensiometer',
                  icon: Icons.tune_rounded,
                  active: isPot,
                  onTap: () => onChanged(InputDevice.potentiometer),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildOption(
                  key: const Key('input_device_push_button'),
                  label: 'Switch / Push Button',
                  icon: Icons.radio_button_checked_rounded,
                  active: !isPot,
                  onTap: () => onChanged(InputDevice.pushButton),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOption({
    required Key key,
    required String label,
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      key: key,
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: AppSpacing.minTouchTarget),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 10),
          decoration: BoxDecoration(
            color: active ? accentColor : AppColors.surface.withValues(alpha: 0.0),
            borderRadius: BorderRadius.circular(AppRadius.input),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 16,
                color: active ? AppColors.textOnPrimary : AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.label.copyWith(
                    color: active ? AppColors.textOnPrimary : AppColors.textSecondary,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
