import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/motor_sim_controller.dart';

void main() {
  group('MotorSimController', () {
    test('Servo: maps ADC 0..1023 to 0..180 deg, clamps, and computes pulse width', () {
      final ctrl = MotorSimController();
      expect(ctrl.servoCurrentAngle, 90.0);
      expect(ctrl.servoPulseWidthUs, 1450);

      ctrl.setServoAdc(0);
      expect(ctrl.servoTargetAngle, 0.0);
      ctrl.tick(const Duration(milliseconds: 500));
      for (int i = 0; i < 20; i++) {
        ctrl.tick(const Duration(milliseconds: 50));
      }
      expect(ctrl.servoCurrentAngle, closeTo(0.0, 0.5));
      expect(ctrl.servoPulseWidthUs, 500);

      ctrl.setServoAdc(1023);
      expect(ctrl.servoTargetAngle, 180.0);
      for (int i = 0; i < 30; i++) {
        ctrl.tick(const Duration(milliseconds: 50));
      }
      expect(ctrl.servoCurrentAngle, closeTo(180.0, 0.5));
      expect(ctrl.servoPulseWidthUs, 2400);

      // Clamp test
      ctrl.setServoTargetAngle(250.0);
      expect(ctrl.servoTargetAngle, 180.0);
      ctrl.setServoTargetAngle(-30.0);
      expect(ctrl.servoTargetAngle, 0.0);
    });

    test('DC Motor: dead-zone below 40 PWM, auto-ramp GAS/REM, and decelerates before reversing', () {
      final ctrl = MotorSimController();
      ctrl.setMotorType(MotorType.dc);

      // Dead-zone test: PWM 30 (< 40) -> stall, speed stays 0
      ctrl.setDcTargetPwm(30);
      ctrl.tick(const Duration(milliseconds: 100));
      expect(ctrl.isDcStalled, isTrue);
      expect(ctrl.dcActualSpeed, 0.0);
      expect(ctrl.dcRpm, 0);

      // Auto-ramp GAS increases PWM gradually up to 255
      ctrl.setDcTargetPwm(100);
      ctrl.startDcGas();
      for (int i = 0; i < 10; i++) {
        ctrl.tick(const Duration(milliseconds: 50));
      }
      ctrl.stopDcGas();
      expect(ctrl.dcTargetPwm, greaterThan(130));

      // Let motor spin up in forward direction (+1)
      ctrl.applyDcPreset(direction: 1, pwm: 200);
      for (int i = 0; i < 30; i++) {
        ctrl.tick(const Duration(milliseconds: 50));
      }
      expect(ctrl.dcActualDirection, 1);
      expect(ctrl.dcActualSpeed, closeTo(200.0, 1.0));

      // Reverse direction while spinning: must decelerate to 0 first, not jump to negative
      ctrl.setDcDirection(-1);
      ctrl.tick(const Duration(milliseconds: 50));
      expect(ctrl.dcActualDirection, 1); // still spinning forward while braking
      expect(ctrl.dcActualSpeed, lessThan(200.0));

      // Continue ticking until it crosses 0 and spins in reverse (-1)
      for (int i = 0; i < 40; i++) {
        ctrl.tick(const Duration(milliseconds: 50));
      }
      expect(ctrl.dcActualDirection, -1);
      expect(ctrl.dcActualSpeed, closeTo(200.0, 1.0));
    });

    test('Stepper: full-step vs half-step, coil sequence, and 1:64 gear ratio conversion', () {
      final ctrl = MotorSimController();
      ctrl.setMotorType(MotorType.stepper);

      expect(ctrl.stepperDegreesPerStep, 5.625);
      expect(ctrl.stepperActiveCoils, <bool>[true, true, false, false]); // AB

      ctrl.triggerSingleStep(1);
      expect(ctrl.stepperStepCounter, 1);
      expect(ctrl.stepperCurrentAngleDeg, 5.625);
      expect(ctrl.stepperActiveCoils, <bool>[false, true, true, false]); // BC

      // Switch to Output Shaft (1:64 gear ratio)
      ctrl.setStepperViewMode(StepperViewMode.outputShaft);
      expect(ctrl.stepperDegreesPerStep, closeTo(5.625 / 64.0, 1e-6));
      expect(ctrl.stepsPerRevolution, 64 * 64);

      // Switch to Half-step mode
      ctrl.setStepperViewMode(StepperViewMode.rotor);
      ctrl.setStepperStepMode(StepperStepMode.halfStep);
      expect(ctrl.stepperDegreesPerStep, 2.8125);
      expect(ctrl.stepsPerRevolution, 128);
    });
  });
}
