import 'package:flutter/material.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/motor_sim_controller.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/painters/servo_painter.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/virtual_potentiometer.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/virtual_push_button.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/virtual_switch.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

class ServoControls extends StatelessWidget {
  const ServoControls({super.key, required this.controller});

  final MotorSimController controller;

  @override
  Widget build(BuildContext context) {
    const Color accent = MotorPalette.servoBlue;

    if (controller.inputDevice == InputDevice.potentiometer) {
      final int angleRound = controller.servoTargetAngle.round();
      return VirtualPotentiometer(
        adcValue: controller.servoAdc,
        onChanged: controller.setServoAdc,
        mappedLabel: 'Sudut: $angleRound°',
        mapFormulaText: 'map(${controller.servoAdc}, 0, 1023, 0, 180) = $angleRound°',
        accentColor: accent,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'PRESET SUDUT & LANGKAH (TAHAN UNTUK REPEAT)',
          style: AppTypography.overline.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: <Widget>[
            for (final int deg in const <int>[0, 90, 180]) ...<Widget>[
              if (deg > 0) const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: VirtualPushButton(
                  key: Key('servo_btn_$deg'),
                  label: '$deg°',
                  accentColor: accent,
                  isActive: !controller.servoSweepEnabled &&
                      (controller.servoTargetAngle - deg).abs() < 0.5,
                  onTap: () => controller.setServoTargetAngle(deg.toDouble()),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: <Widget>[
            Expanded(
              child: VirtualPushButton(
                key: const Key('servo_btn_minus10'),
                label: '−10°',
                icon: Icons.remove_rounded,
                accentColor: accent,
                onPressStart: () => controller.startServoHold(-10.0),
                onPressEnd: controller.stopServoHold,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: VirtualPushButton(
                key: const Key('servo_btn_plus10'),
                label: '+10°',
                icon: Icons.add_rounded,
                accentColor: accent,
                onPressStart: () => controller.startServoHold(10.0),
                onPressEnd: controller.stopServoHold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        VirtualSwitch(
          key: const Key('servo_switch_sweep'),
          label: 'Mode Sweep (0° ↔ 180°)',
          subtitle: 'Bergerak bolak-balik otomatis seperti contoh Arduino Sweep',
          value: controller.servoSweepEnabled,
          onChanged: controller.setServoSweepEnabled,
          accentColor: accent,
        ),
        if (controller.servoSweepEnabled) ...<Widget>[
          const SizedBox(height: AppSpacing.xs),
          _buildSweepSpeedSelector(accent),
        ],
      ],
    );
  }

  Widget _buildSweepSpeedSelector(Color accent) {
    const List<(SpeedPreset, String)> items = <(SpeedPreset, String)>[
      (SpeedPreset.slow, 'Lambat'),
      (SpeedPreset.medium, 'Sedang'),
      (SpeedPreset.fast, 'Cepat'),
    ];
    return Row(
      children: <Widget>[
        Text(
          'Kecepatan Sweep:',
          style: AppTypography.overline.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(width: AppSpacing.sm),
        for (final (SpeedPreset preset, String text) in items)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: GestureDetector(
                onTap: () => controller.setServoSweepSpeed(preset),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: controller.servoSweepSpeed == preset
                        ? accent
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: AppTypography.overline.copyWith(
                      color: controller.servoSweepSpeed == preset
                          ? AppColors.textOnPrimary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
