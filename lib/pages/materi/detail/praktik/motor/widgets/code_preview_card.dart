import 'package:flutter/material.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/motor_sim_controller.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/painters/servo_painter.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

/// Kartu preview kode Arduino yang dinamis mengikuti jenis motor dan mode input.
class CodePreviewCard extends StatelessWidget {
  const CodePreviewCard({super.key, required this.controller});

  final MotorSimController controller;

  @override
  Widget build(BuildContext context) {
    final String snippet = _buildSnippet();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: MotorPalette.benchDarkTop,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: MotorPalette.benchGrid),
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
                'ARDUINO SKETCH LIVE PREVIEW',
                style: AppTypography.overline.copyWith(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                controller.inputDevice == InputDevice.potentiometer
                    ? 'A0 → Output'
                    : 'D2/D3 → Output',
                style: AppTypography.overline.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.7),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            snippet,
            style: AppTypography.label.copyWith(
              fontFamily: 'monospace',
              color: AppColors.textOnPrimary,
              height: 1.4,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  String _buildSnippet() {
    final bool isPot = controller.inputDevice == InputDevice.potentiometer;
    switch (controller.motorType) {
      case MotorType.servo:
        final int deg = controller.servoTargetAngle.round();
        if (isPot) {
          return 'int adc = analogRead(A0); // ${controller.servoAdc}\n'
              'int angle = map(adc, 0, 1023, 0, 180);\n'
              'myServo.write($deg); // Pulsa: ${controller.servoPulseWidthUs} us';
        }
        return 'if (digitalRead(BTN_PIN) == LOW) {\n'
            '  myServo.write($deg); // Target: $deg°\n'
            '}';
      case MotorType.dc:
        final int pwm = controller.dcTargetPwm;
        final String in1 = controller.dcDirection >= 0 ? 'HIGH' : 'LOW';
        final String in2 = controller.dcDirection >= 0 ? 'LOW' : 'HIGH';
        if (isPot) {
          return 'int adc = analogRead(A0); // ${controller.dcAdc}\n'
              'int pwm = map(adc, 0, 1023, 0, 255);\n'
              'digitalWrite(IN1, $in1); digitalWrite(IN2, $in2);\n'
              'analogWrite(ENA, $pwm); // Duty: ${controller.dcDutyCyclePercent}%';
        }
        return 'digitalWrite(IN1, $in1); digitalWrite(IN2, $in2);\n'
            'analogWrite(ENA, $pwm); // Auto-ramp speed: ${controller.dcRpm} RPM';
      case MotorType.stepper:
        final int step = controller.stepperStepCounter;
        final int maxSteps =
            controller.stepperStepMode == StepperStepMode.fullStep ? 64 : 128;
        if (isPot) {
          return 'int adc = analogRead(A0); // ${controller.stepperAdc}\n'
              'int target = map(adc, 0, 1023, 0, $maxSteps);\n'
              'myStepper.step(target - currentStep); // Step: $step';
        }
        return 'myStepper.setSpeed(${controller.stepperCurrentSpeedStepsPerSec.round()});\n'
            'myStepper.step(${controller.stepperDirection >= 0 ? '+1' : '-1'}); // Posisi: $step step (${controller.stepperCurrentAngleDeg.toStringAsFixed(1)}°)';
    }
  }
}
