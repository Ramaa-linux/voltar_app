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
        _buildModeBar(context, accent),
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
          _buildPushButtonControls(context, accent),
      ],
    );
  }

  Widget _buildModeBar(BuildContext context, Color accent) {
    final bool isRotor = controller.stepperViewMode == StepperViewMode.rotor;
    final bool isFull = controller.stepperStepMode == StepperStepMode.fullStep;

    return Row(
      children: <Widget>[
        Expanded(
          child: VirtualPushButton(
            key: const Key('stepper_toggle_view_mode'),
            label: isRotor
                ? context.t('stepperRotorView', args: [isFull ? '5.625' : '2.81'])
                : context.t('stepperOutputShaft'),
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
            label: context.t(isFull ? 'stepperModeFullStep' : 'stepperModeHalfStep'),
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

  Widget _buildPushButtonControls(BuildContext context, Color accent) {
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
                label: context.t('stepperHalfRev'),
                compact: true,
                accentColor: AppColors.primary,
                onTap: () => controller.rotateStepperRevolutions(0.5),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: VirtualPushButton(
                key: const Key('stepper_btn_full_rev'),
                label: context.t('stepperFullRev'),
                compact: true,
                accentColor: AppColors.primary,
                onTap: () => controller.rotateStepperRevolutions(1.0),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            VirtualPushButton(
              key: const Key('stepper_btn_reset'),
              label: context.t('stepperResetZero'),
              compact: true,
              accentColor: AppColors.accent,
              onTap: controller.resetStepperPosition,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        VirtualSwitch(
          key: const Key('stepper_switch_autorun'),
          label: context.t('stepperAutoRunLabel', args: [isCw ? 'CW' : 'CCW']),
          subtitle: context.t('stepperAutoRunSubtitle'),
          value: controller.stepperAutoRun,
          onChanged: controller.setStepperAutoRun,
          accentColor: accent,
        ),
        const SizedBox(height: AppSpacing.xs),
        _buildAutoRunOptions(context, accent, isCw),
      ],
    );
  }

  Widget _buildAutoRunOptions(BuildContext context, Color accent, bool isCw) {
    final List<(SpeedPreset, String)> speeds = <(SpeedPreset, String)>[
      (SpeedPreset.slow, context.t('motorSpeedSlow')),
      (SpeedPreset.medium, context.t('motorSpeedMedium')),
      (SpeedPreset.fast, context.t('motorSpeedFast')),
    ];
    return Row(
      children: <Widget>[
        VirtualPushButton(
          key: const Key('stepper_btn_autodir'),
          label: isCw
              ? '${context.t('stepperDirCw')} ↻'
              : '${context.t('stepperDirCcw')} ↺',
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
