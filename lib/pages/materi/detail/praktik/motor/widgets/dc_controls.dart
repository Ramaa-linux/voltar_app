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
import 'package:voltar/utils/localization_helper.dart';

class DcControls extends StatelessWidget {
  const DcControls({super.key, required this.controller});

  final MotorSimController controller;

  @override
  Widget build(BuildContext context) {
    const Color accent = MotorPalette.dcMetalMid;
    final int pwm = controller.dcTargetPwm;
    final int duty = controller.dcDutyCyclePercent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildTopBar(context, accent),
        const SizedBox(height: AppSpacing.sm),
        if (controller.inputDevice == InputDevice.potentiometer)
          VirtualPotentiometer(
            adcValue: controller.dcAdc,
            onChanged: controller.setDcAdc,
            mappedLabel: 'PWM: $pwm → Duty: $duty%',
            mapFormulaText: 'map(${controller.dcAdc}, 0, 1023, 0, 255) = $pwm',
            accentColor: AppColors.primary,
          )
        else
          _buildPushButtonControls(context, accent),
        if (controller.isDcStalled) ...<Widget>[
          const SizedBox(height: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(AppRadius.input),
            ),
            child: Text(
              context.t('motorDcStalled', args: [MotorSimController.dcDeadZonePwm.toString()]),
              style: AppTypography.overline.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTopBar(BuildContext context, Color accent) {
    final bool isForward = controller.dcDirection >= 0;
    final bool isFan = controller.dcAttachment == DcAttachment.fan;

    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: VirtualPushButton(
                  key: const Key('dc_dir_forward'),
                  label: context.t('motorDcForward'),
                  compact: true,
                  accentColor: AppColors.success,
                  isActive: isForward,
                  onTap: () => controller.setDcDirection(1),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: VirtualPushButton(
                  key: const Key('dc_dir_reverse'),
                  label: context.t('motorDcReverse'),
                  compact: true,
                  accentColor: AppColors.accent,
                  isActive: !isForward,
                  onTap: () => controller.setDcDirection(-1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        VirtualPushButton(
          key: const Key('dc_toggle_attachment'),
          label: isFan ? 'Kipas ⇄ Roda' : 'Roda ⇄ Kipas',
          compact: true,
          accentColor: accent,
          onTap: () => controller.setDcAttachment(
            isFan ? DcAttachment.wheel : DcAttachment.fan,
          ),
        ),
      ],
    );
  }

  Widget _buildPushButtonControls(BuildContext context, Color accent) {
    final int pwm = controller.dcTargetPwm;
    final double progress = (pwm / 255.0).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Bar kecepatan horizontal bergradient
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.input),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: <Widget>[
                  Text(
                    'AUTO-RAMP SPEED (PWM)',
                    style: AppTypography.overline.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '$pwm / 255 (${controller.dcDutyCyclePercent}%) | ${controller.dcRpm} RPM',
                    style: AppTypography.label.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: SizedBox(
                  height: 10,
                  child: Stack(
                    children: <Widget>[
                      Container(color: AppColors.borderStrong),
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[AppColors.primary, AppColors.success, AppColors.accent],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: <Widget>[
            Expanded(
              child: VirtualPushButton(
                key: const Key('dc_btn_gas'),
                label: context.t('motorDcGas'),
                accentColor: AppColors.success,
                isActive: controller.isGasPressed,
                onPressStart: controller.startDcGas,
                onPressEnd: controller.stopDcGas,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: VirtualPushButton(
                key: const Key('dc_btn_brake'),
                label: context.t('motorDcBrake'),
                accentColor: AppColors.accent,
                isActive: controller.isBrakePressed,
                onPressStart: controller.startDcBrake,
                onPressEnd: controller.stopDcBrake,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            VirtualPushButton(
              key: const Key('dc_btn_stop'),
              label: context.t('motorDcStop'),
              compact: true,
              accentColor: AppColors.error,
              onTap: controller.stopDcMotor,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: <Widget>[
            Expanded(
              child: VirtualPushButton(
                key: const Key('dc_preset_fwd200'),
                label: context.t('motorDcPresetFwd200'),
                compact: true,
                accentColor: AppColors.primary,
                onTap: () => controller.applyDcPreset(direction: 1, pwm: 200),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: VirtualPushButton(
                key: const Key('dc_preset_rev100'),
                label: context.t('motorDcPresetRev100'),
                compact: true,
                accentColor: AppColors.accent,
                onTap: () => controller.applyDcPreset(direction: -1, pwm: 100),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        VirtualSwitch(
          key: const Key('dc_switch_power'),
          label: context.t('motorDcPowerLabel'),
          subtitle: context.t('motorDcPowerSubtitle'),
          value: controller.dcPowerOn,
          onChanged: controller.setDcPowerOn,
          accentColor: AppColors.primary,
        ),
        const SizedBox(height: AppSpacing.xs),
        VirtualSwitch(
          key: const Key('dc_switch_autobrake'),
          label: context.t('motorDcAutoBrakeLabel'),
          subtitle: context.t('motorDcAutoBrakeSubtitle'),
          value: controller.dcAutoBrake,
          onChanged: controller.setDcAutoBrake,
          accentColor: accent,
        ),
      ],
    );
  }
}
