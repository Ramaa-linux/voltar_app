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

class StepperControls extends StatelessWidget {
  const StepperControls({super.key, required this.controller});

  final MotorSimController controller;

  @override
  Widget build(BuildContext context) {
    const Color accent = MotorPalette.stepperGreenDark;
    final int maxSteps =
        controller.stepperStepMode == StepperStepMode.fullStep ? 64 : 128;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildModeBar(accent),
        const SizedBox(height: AppSpacing.sm),
        if (controller.inputDevice == InputDevice.potentiometer)
          VirtualPotentiometer(
            adcValue: controller.stepperAdc,
            onChanged: controller.setStepperAdc,
            mappedLabel:
                'Step: ${controller.stepperStepCounter}/${controller.stepperTargetStep} (${controller.stepperCurrentAngleDeg.toStringAsFixed(1)}°)',
            mapFormulaText:
                'map(${controller.stepperAdc}, 0, 1023, 0, $maxSteps) = ${controller.stepperTargetStep} step',
            accentColor: accent,
          )
        else
          _buildPushButtonControls(accent),
      ],
    );
  }

  Widget _buildModeBar(Color accent) {
    final bool isRotor = controller.stepperViewMode == StepperViewMode.rotor;
    final bool isFull = controller.stepperStepMode == StepperStepMode.fullStep;

    return Row(
      children: <Widget>[
        Expanded(
          child: VirtualPushButton(
            key: const Key('stepper_toggle_view_mode'),
            label: isRotor
                ? 'Rotor (${isFull ? '5.625°' : '2.81°'}/step)'
                : 'Output Shaft 1:64',
            compact: true,
            accentColor: accent,
            onTap: () => controller.setStepperViewMode(
              isRotor ? StepperViewMode.outputShaft : StepperViewMode.rotor,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: VirtualPushButton(
            key: const Key('stepper_toggle_step_mode'),
            label: isFull ? 'Mode: Full-Step (4)' : 'Mode: Half-Step (8)',
            compact: true,
            accentColor: AppColors.primary,
            onTap: () => controller.setStepperStepMode(
              isFull ? StepperStepMode.halfStep : StepperStepMode.fullStep,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPushButtonControls(Color accent) {
    final bool isCw = controller.stepperAutoRunDir >= 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: VirtualPushButton(
                key: const Key('stepper_btn_step_minus'),
                label: '◄ Step −1',
                accentColor: accent,
                onPressStart: () => controller.startStepperHold(-1),
                onPressEnd: controller.stopStepperHold,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: VirtualPushButton(
                key: const Key('stepper_btn_step_plus'),
                label: 'Step +1 ►',
                accentColor: accent,
                onPressStart: () => controller.startStepperHold(1),
                onPressEnd: controller.stopStepperHold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: <Widget>[
            Expanded(
              child: VirtualPushButton(
                key: const Key('stepper_btn_half_rev'),
                label: '½ Putaran (180°)',
                compact: true,
                accentColor: AppColors.primary,
                onTap: () => controller.rotateStepperRevolutions(0.5),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: VirtualPushButton(
                key: const Key('stepper_btn_full_rev'),
                label: '1 Putaran (360°)',
                compact: true,
                accentColor: AppColors.primary,
                onTap: () => controller.rotateStepperRevolutions(1.0),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            VirtualPushButton(
              key: const Key('stepper_btn_reset'),
              label: 'Reset 0°',
              compact: true,
              accentColor: AppColors.accent,
              onTap: controller.resetStepperPosition,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        VirtualSwitch(
          key: const Key('stepper_switch_autorun'),
          label: 'Auto-Run Stepper (${isCw ? 'CW' : 'CCW'})',
          subtitle: 'Melangkah kontinu dengan kecepatan terpilih',
          value: controller.stepperAutoRun,
          onChanged: controller.setStepperAutoRun,
          accentColor: accent,
        ),
        const SizedBox(height: AppSpacing.xs),
        _buildAutoRunOptions(accent, isCw),
      ],
    );
  }

  Widget _buildAutoRunOptions(Color accent, bool isCw) {
    const List<(SpeedPreset, String)> speeds = <(SpeedPreset, String)>[
      (SpeedPreset.slow, 'Lambat'),
      (SpeedPreset.medium, 'Sedang'),
      (SpeedPreset.fast, 'Cepat'),
    ];
    return Row(
      children: <Widget>[
        VirtualPushButton(
          key: const Key('stepper_btn_autodir'),
          label: isCw ? 'Arah: CW ↻' : 'Arah: CCW ↺',
          compact: true,
          accentColor: AppColors.primary,
          onTap: () => controller.setStepperAutoRunDir(isCw ? -1 : 1),
        ),
        const SizedBox(width: AppSpacing.xs),
        for (final (SpeedPreset p, String text) in speeds)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: GestureDetector(
                onTap: () => controller.setStepperSpeedPreset(p),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: controller.stepperSpeedPreset == p
                        ? accent
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: AppTypography.overline.copyWith(
                      color: controller.stepperSpeedPreset == p
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
