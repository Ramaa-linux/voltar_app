import 'dart:math' as math;
import 'package:flutter/foundation.dart';

enum MotorType { servo, dc, stepper }

enum InputDevice { potentiometer, pushButton }

enum SpeedPreset { slow, medium, fast }

enum DcAttachment { fan, wheel }

enum StepperViewMode { rotor, outputShaft }

enum StepperStepMode { fullStep, halfStep }

/// Controller logika & fisika simulasi 3 motor (Servo SG90, Motor DC, Stepper 28BYJ-48).
class MotorSimController extends ChangeNotifier {
  MotorType _motorType = MotorType.servo;
  InputDevice _inputDevice = InputDevice.potentiometer;

  MotorType get motorType => _motorType;
  InputDevice get inputDevice => _inputDevice;

  // --- SERVO STATE ---
  static const double servoMaxSpeedDegPerSec = 600.0;
  static const int servoMinPulseUs = 500;
  static const int servoMaxPulseUs = 2400;
  static const int servoFrequencyHz = 50;

  int _servoAdc = 512;
  double _servoTargetAngle = 90.0;
  double _servoCurrentAngle = 90.0;
  double _servoVelocity = 0.0;
  bool _servoSweepEnabled = false;
  int _servoSweepDir = 1;
  SpeedPreset _servoSweepSpeed = SpeedPreset.medium;
  double _servoHoldDelta = 0.0;
  double _servoHoldTimer = 0.0;

  int get servoAdc => _servoAdc;
  double get servoTargetAngle => _servoTargetAngle;
  double get servoCurrentAngle => _servoCurrentAngle;
  bool get servoSweepEnabled => _servoSweepEnabled;
  SpeedPreset get servoSweepSpeed => _servoSweepSpeed;

  int get servoPulseWidthUs =>
      (servoMinPulseUs + (_servoCurrentAngle.clamp(0.0, 180.0) / 180.0) * (servoMaxPulseUs - servoMinPulseUs))
          .round();

  static double mapAdcToServoAngle(int adc) => (adc.clamp(0, 1023) * 180.0) / 1023.0;

  // --- MOTOR DC STATE ---
  static const int dcDeadZonePwm = 40;
  static const int dcMaxRpm = 3000;
  static const double _dcAccelPwmPerSec = 180.0;
  static const double _dcDecelPwmPerSec = 240.0;
  static const double _dcRampUpPerSec = 85.0;
  static const double _dcRampDownPerSec = 120.0;
  static const double _dcAutoBrakePerSec = 65.0;

  int _dcAdc = 0;
  int _dcTargetPwm = 0;
  double _dcSoftTargetPwm = 0.0;
  int _dcDirection = 1; // 1 = Maju (CW), -1 = Mundur (CCW)
  bool _dcPowerOn = true;
  int _dcSavedPwmBeforeOff = 180;
  bool _dcAutoBrake = false;
  bool _isGasPressed = false;
  bool _isBrakePressed = false;
  double _dcRampAccumulator = 0.0;
  double _dcSignedSpeed = 0.0; // -255..255
  double _dcRotationRad = 0.0;
  DcAttachment _dcAttachment = DcAttachment.fan;

  int get dcAdc => _dcAdc;
  int get dcTargetPwm => _dcPowerOn ? _dcTargetPwm : 0;
  int get dcRawTargetPwm => _dcTargetPwm;
  int get dcDirection => _dcDirection;
  bool get dcPowerOn => _dcPowerOn;
  bool get dcAutoBrake => _dcAutoBrake;
  bool get isGasPressed => _isGasPressed;
  bool get isBrakePressed => _isBrakePressed;
  DcAttachment get dcAttachment => _dcAttachment;
  double get dcRotationRad => _dcRotationRad;
  double get dcActualSpeed => _dcSignedSpeed.abs();

  int get dcActualDirection {
    if (_dcSignedSpeed > 0.5) return 1;
    if (_dcSignedSpeed < -0.5) return -1;
    return 0;
  }

  bool get isDcStalled =>
      _dcPowerOn && _dcTargetPwm > 0 && _dcTargetPwm < dcDeadZonePwm && dcActualSpeed < 0.5;

  int get dcDutyCyclePercent => ((dcTargetPwm / 255.0) * 100.0).round();
  int get dcRpm => ((dcActualSpeed / 255.0) * dcMaxRpm).round();

  static int mapAdcToPwm(int adc) => ((adc.clamp(0, 1023) * 255) / 1023).round();

  // --- STEPPER STATE (28BYJ-48) ---
  static const double stepperRotorFullStepDeg = 5.625;
  static const double stepperGearRatio = 64.0;
  static const int stepperMaxStepsPerSec = 50;

  int _stepperAdc = 0;
  int _stepperStepCounter = 0;
  int _stepperTargetStep = 0;
  int _stepperPrevStep = 0;
  double _stepperClickProgress = 1.0;
  double _stepperStepAccumulator = 0.0;
  int _stepperHoldDir = 0;
  double _stepperHoldDuration = 0.0;
  bool _stepperAutoRun = false;
  int _stepperAutoRunDir = 1;
  SpeedPreset _stepperSpeedPreset = SpeedPreset.medium;
  StepperViewMode _stepperViewMode = StepperViewMode.rotor;
  StepperStepMode _stepperStepMode = StepperStepMode.fullStep;

  int get stepperAdc => _stepperAdc;
  int get stepperStepCounter => _stepperStepCounter;
  int get stepperTargetStep => _stepperTargetStep;
  bool get stepperAutoRun => _stepperAutoRun;
  int get stepperAutoRunDir => _stepperAutoRunDir;
  SpeedPreset get stepperSpeedPreset => _stepperSpeedPreset;
  StepperViewMode get stepperViewMode => _stepperViewMode;
  StepperStepMode get stepperStepMode => _stepperStepMode;

  double get stepperDegreesPerStep {
    final double rotorDeg = _stepperStepMode == StepperStepMode.fullStep
        ? stepperRotorFullStepDeg
        : stepperRotorFullStepDeg / 2.0;
    return _stepperViewMode == StepperViewMode.rotor
        ? rotorDeg
        : rotorDeg / stepperGearRatio;
  }

  int get stepsPerRevolution {
    final int rotorSteps = _stepperStepMode == StepperStepMode.fullStep ? 64 : 128;
    return _stepperViewMode == StepperViewMode.rotor
        ? rotorSteps
        : rotorSteps * 64;
  }

  double get stepperCurrentAngleDeg => _stepperStepCounter * stepperDegreesPerStep;

  double get stepperVisualAngleDeg {
    if (_stepperClickProgress >= 1.0) return stepperCurrentAngleDeg;
    final double t = _stepperClickProgress.clamp(0.0, 1.0);
    final double ease = 1.0 - math.pow(1.0 - t, 3).toDouble();
    final double jitter = math.sin(t * math.pi * 3.0) * 0.08 * (1.0 - t);
    final double interp = _stepperPrevStep + (_stepperStepCounter - _stepperPrevStep) * (ease + jitter);
    return interp * stepperDegreesPerStep;
  }

  double get stepperTargetAngleDeg => _stepperTargetStep * stepperDegreesPerStep;

  int get stepperDirection {
    if (_stepperAutoRun) return _stepperAutoRunDir;
    if (_stepperTargetStep > _stepperStepCounter) return 1;
    if (_stepperTargetStep < _stepperStepCounter) return -1;
    return _stepperStepCounter >= _stepperPrevStep ? 1 : -1;
  }

  int get stepperCoilPhaseIndex {
    final int mod = _stepperStepMode == StepperStepMode.fullStep ? 4 : 8;
    return ((_stepperStepCounter % mod) + mod) % mod;
  }

  List<bool> get stepperActiveCoils {
    final int idx = stepperCoilPhaseIndex;
    if (_stepperStepMode == StepperStepMode.fullStep) {
      return switch (idx) {
        0 => const <bool>[true, true, false, false],
        1 => const <bool>[false, true, true, false],
        2 => const <bool>[false, false, true, true],
        _ => const <bool>[true, false, false, true],
      };
    }
    return switch (idx) {
      0 => const <bool>[true, false, false, false],
      1 => const <bool>[true, true, false, false],
      2 => const <bool>[false, true, false, false],
      3 => const <bool>[false, true, true, false],
      4 => const <bool>[false, false, true, false],
      5 => const <bool>[false, false, true, true],
      6 => const <bool>[false, false, false, true],
      _ => const <bool>[true, false, false, true],
    };
  }

  double get stepperCurrentSpeedStepsPerSec => switch (_stepperSpeedPreset) {
        SpeedPreset.slow => 8.0,
        SpeedPreset.medium => 20.0,
        SpeedPreset.fast => 45.0,
      };

  // --- GENERAL MUTATORS ---
  void setMotorType(MotorType type) {
    if (_motorType == type) return;
    stopAllHolds();
    _motorType = type;
    notifyListeners();
  }

  void setInputDevice(InputDevice device) {
    if (_inputDevice == device) return;
    stopAllHolds();
    _inputDevice = device;
    if (device == InputDevice.potentiometer) {
      _servoSweepEnabled = false;
      _servoAdc = ((_servoTargetAngle / 180.0) * 1023.0).round().clamp(0, 1023);
      _dcAdc = ((_dcTargetPwm / 255.0) * 1023.0).round().clamp(0, 1023);
      _stepperAutoRun = false;
      final int revSteps = _stepperStepMode == StepperStepMode.fullStep ? 64 : 128;
      final int modStep = ((_stepperStepCounter % revSteps) + revSteps) % revSteps;
      _stepperAdc = ((modStep / revSteps) * 1023.0).round().clamp(0, 1023);
      _stepperTargetStep = _stepperStepCounter;
    }
    notifyListeners();
  }

  void stopAllHolds() {
    _servoHoldDelta = 0.0;
    _servoHoldTimer = 0.0;
    _isGasPressed = false;
    _isBrakePressed = false;
    _stepperHoldDir = 0;
    _stepperHoldDuration = 0.0;
  }

  // --- SERVO MUTATORS ---
  void setServoAdc(int adc) {
    _servoAdc = adc.clamp(0, 1023);
    _servoSweepEnabled = false;
    _servoTargetAngle = mapAdcToServoAngle(_servoAdc);
    notifyListeners();
  }

  void setServoTargetAngle(double angle) {
    _servoSweepEnabled = false;
    _servoTargetAngle = angle.clamp(0.0, 180.0);
    _servoAdc = ((_servoTargetAngle / 180.0) * 1023.0).round().clamp(0, 1023);
    notifyListeners();
  }

  void stepServoAngle(double delta) => setServoTargetAngle(_servoTargetAngle + delta);

  void startServoHold(double deltaDeg) {
    _servoSweepEnabled = false;
    _servoHoldDelta = deltaDeg;
    _servoHoldTimer = 0.0;
    stepServoAngle(deltaDeg);
  }

  void stopServoHold() {
    if (_servoHoldDelta == 0.0) return;
    _servoHoldDelta = 0.0;
    _servoHoldTimer = 0.0;
    notifyListeners();
  }

  void setServoSweepEnabled(bool enabled) {
    if (_servoSweepEnabled == enabled) return;
    _servoSweepEnabled = enabled;
    _servoTargetAngle = enabled ? (_servoSweepDir > 0 ? 180.0 : 0.0) : _servoCurrentAngle.clamp(0.0, 180.0);
    notifyListeners();
  }

  void setServoSweepSpeed(SpeedPreset preset) {
    if (_servoSweepSpeed == preset) return;
    _servoSweepSpeed = preset;
    notifyListeners();
  }

  // --- DC MOTOR MUTATORS ---
  void setDcAdc(int adc) {
    _dcAdc = adc.clamp(0, 1023);
    _dcPowerOn = true;
    _dcTargetPwm = mapAdcToPwm(_dcAdc);
    _dcSoftTargetPwm = _dcTargetPwm.toDouble();
    notifyListeners();
  }

  void setDcTargetPwm(int pwm) {
    _dcTargetPwm = pwm.clamp(0, 255);
    _dcSoftTargetPwm = _dcTargetPwm.toDouble();
    _dcAdc = ((_dcTargetPwm / 255.0) * 1023.0).round().clamp(0, 1023);
    if (_dcTargetPwm > 0) _dcSavedPwmBeforeOff = _dcTargetPwm;
    notifyListeners();
  }

  void setDcDirection(int dir) {
    final int normalized = dir >= 0 ? 1 : -1;
    if (_dcDirection == normalized) return;
    _dcDirection = normalized;
    notifyListeners();
  }

  void setDcPowerOn(bool on) {
    if (_dcPowerOn == on) return;
    _dcPowerOn = on;
    if (on) {
      if (_dcTargetPwm == 0) {
        _dcTargetPwm = _dcSavedPwmBeforeOff > 0 ? _dcSavedPwmBeforeOff : 180;
      }
      _dcSoftTargetPwm = dcActualSpeed;
    } else {
      if (_dcTargetPwm > 0) _dcSavedPwmBeforeOff = _dcTargetPwm;
      _isGasPressed = false;
      _isBrakePressed = false;
    }
    notifyListeners();
  }

  void setDcAutoBrake(bool enabled) {
    if (_dcAutoBrake == enabled) return;
    _dcAutoBrake = enabled;
    notifyListeners();
  }

  void setDcAttachment(DcAttachment attachment) {
    if (_dcAttachment == attachment) return;
    _dcAttachment = attachment;
    notifyListeners();
  }

  void startDcGas() {
    _dcPowerOn = true;
    _isGasPressed = true;
    _isBrakePressed = false;
    _dcRampAccumulator = 0.0;
    _dcTargetPwm = (_dcTargetPwm + 4).clamp(0, 255);
    _dcSoftTargetPwm = _dcTargetPwm.toDouble();
    notifyListeners();
  }

  void stopDcGas() {
    if (!_isGasPressed) return;
    _isGasPressed = false;
    notifyListeners();
  }

  void startDcBrake() {
    _isBrakePressed = true;
    _isGasPressed = false;
    _dcRampAccumulator = 0.0;
    _dcTargetPwm = (_dcTargetPwm - 6).clamp(0, 255);
    _dcSoftTargetPwm = _dcTargetPwm.toDouble();
    notifyListeners();
  }

  void stopDcBrake() {
    if (!_isBrakePressed) return;
    _isBrakePressed = false;
    notifyListeners();
  }

  void stopDcMotor() {
    _isGasPressed = false;
    _isBrakePressed = false;
    _dcTargetPwm = 0;
    _dcSoftTargetPwm = 0.0;
    _dcAdc = 0;
    notifyListeners();
  }

  void applyDcPreset({required int direction, required int pwm}) {
    _dcPowerOn = true;
    _isGasPressed = false;
    _isBrakePressed = false;
    _dcDirection = direction >= 0 ? 1 : -1;
    _dcTargetPwm = pwm.clamp(0, 255);
    _dcSoftTargetPwm = _dcTargetPwm.toDouble();
    _dcSavedPwmBeforeOff = _dcTargetPwm;
    notifyListeners();
  }

  // --- STEPPER MUTATORS ---
  void setStepperAdc(int adc) {
    _stepperAdc = adc.clamp(0, 1023);
    _stepperAutoRun = false;
    final int maxSteps = _stepperStepMode == StepperStepMode.fullStep ? 64 : 128;
    _stepperTargetStep = ((_stepperAdc / 1023.0) * maxSteps).round();
    notifyListeners();
  }

  void stepStepperBy(int deltaSteps) {
    _stepperAutoRun = false;
    _stepperTargetStep += deltaSteps;
    notifyListeners();
  }

  void triggerSingleStep(int dir) {
    _stepperAutoRun = false;
    final int d = dir >= 0 ? 1 : -1;
    _advanceStepperOneStep(d);
    _stepperTargetStep = _stepperStepCounter;
    notifyListeners();
  }

  void startStepperHold(int dir) {
    _stepperAutoRun = false;
    _stepperHoldDir = dir >= 0 ? 1 : -1;
    _stepperHoldDuration = 0.0;
    _stepperStepAccumulator = 0.0;
    triggerSingleStep(_stepperHoldDir);
  }

  void stopStepperHold() {
    if (_stepperHoldDir == 0) return;
    _stepperHoldDir = 0;
    _stepperHoldDuration = 0.0;
    notifyListeners();
  }

  void rotateStepperRevolutions(double revolutions) {
    _stepperAutoRun = false;
    final int delta = (revolutions * stepsPerRevolution).round();
    _stepperTargetStep = _stepperStepCounter + delta;
    notifyListeners();
  }

  void resetStepperPosition() {
    _stepperAutoRun = false;
    _stepperHoldDir = 0;
    _stepperStepCounter = 0;
    _stepperTargetStep = 0;
    _stepperPrevStep = 0;
    _stepperClickProgress = 1.0;
    _stepperAdc = 0;
    notifyListeners();
  }

  void setStepperAutoRun(bool enabled) {
    if (_stepperAutoRun == enabled) return;
    _stepperAutoRun = enabled;
    if (!enabled) _stepperTargetStep = _stepperStepCounter;
    notifyListeners();
  }

  void setStepperAutoRunDir(int dir) {
    final int normalized = dir >= 0 ? 1 : -1;
    if (_stepperAutoRunDir == normalized) return;
    _stepperAutoRunDir = normalized;
    notifyListeners();
  }

  void setStepperSpeedPreset(SpeedPreset preset) {
    if (_stepperSpeedPreset == preset) return;
    _stepperSpeedPreset = preset;
    notifyListeners();
  }

  void setStepperViewMode(StepperViewMode mode) {
    if (_stepperViewMode == mode) return;
    _stepperViewMode = mode;
    notifyListeners();
  }

  void setStepperStepMode(StepperStepMode mode) {
    if (_stepperStepMode == mode) return;
    if (mode == StepperStepMode.halfStep && _stepperStepMode == StepperStepMode.fullStep) {
      _stepperStepCounter *= 2;
      _stepperTargetStep *= 2;
      _stepperPrevStep = _stepperStepCounter;
    } else if (mode == StepperStepMode.fullStep && _stepperStepMode == StepperStepMode.halfStep) {
      _stepperStepCounter = (_stepperStepCounter / 2).round();
      _stepperTargetStep = (_stepperTargetStep / 2).round();
      _stepperPrevStep = _stepperStepCounter;
    }
    _stepperStepMode = mode;
    notifyListeners();
  }

  void _advanceStepperOneStep(int dir) {
    _stepperPrevStep = _stepperStepCounter;
    _stepperStepCounter += (dir >= 0 ? 1 : -1);
    _stepperClickProgress = 0.0;
  }

  // --- PHYSICS TICK ---
  bool tick(Duration dt, {bool instant = false}) {
    final double dtSec = (dt.inMicroseconds / 1e6).clamp(0.0, 0.1);
    if (dtSec <= 0.0 && !instant) return false;

    bool changed = false;
    changed |= _tickServo(dtSec, instant: instant);
    changed |= _tickDc(dtSec, instant: instant);
    changed |= _tickStepper(dtSec, instant: instant);

    if (changed) notifyListeners();
    return changed;
  }

  bool _tickServo(double dtSec, {required bool instant}) {
    bool changed = false;

    if (_servoHoldDelta != 0.0) {
      _servoHoldTimer += dtSec;
      while (_servoHoldTimer >= 0.12) {
        _servoHoldTimer -= 0.12;
        _servoTargetAngle = (_servoTargetAngle + _servoHoldDelta).clamp(0.0, 180.0);
        changed = true;
      }
    }

    if (_servoSweepEnabled) {
      final double sweepRate = switch (_servoSweepSpeed) {
        SpeedPreset.slow => 90.0,
        SpeedPreset.medium => 180.0,
        SpeedPreset.fast => 320.0,
      };
      _servoTargetAngle += _servoSweepDir * sweepRate * dtSec;
      if (_servoTargetAngle >= 180.0) {
        _servoTargetAngle = 180.0;
        _servoSweepDir = -1;
      } else if (_servoTargetAngle <= 0.0) {
        _servoTargetAngle = 0.0;
        _servoSweepDir = 1;
      }
      changed = true;
    }

    if (instant) {
      if ((_servoCurrentAngle - _servoTargetAngle).abs() > 0.01) {
        _servoCurrentAngle = _servoTargetAngle;
        _servoVelocity = 0.0;
        return true;
      }
      return changed;
    }

    final double diff = _servoTargetAngle - _servoCurrentAngle;
    if (diff.abs() > 0.02 || _servoVelocity.abs() > 0.5) {
      const double springK = 140.0;
      const double damping = 19.5;
      final double accel = (diff * springK) - (_servoVelocity * damping);
      _servoVelocity = (_servoVelocity + accel * dtSec)
          .clamp(-servoMaxSpeedDegPerSec, servoMaxSpeedDegPerSec);
      _servoCurrentAngle = (_servoCurrentAngle + _servoVelocity * dtSec).clamp(0.0, 180.0);

      if ((_servoTargetAngle - _servoCurrentAngle).abs() < 0.05 && _servoVelocity.abs() < 2.0) {
        _servoCurrentAngle = _servoTargetAngle;
        _servoVelocity = 0.0;
      }
      changed = true;
    }

    return changed;
  }

  bool _tickDc(double dtSec, {required bool instant}) {
    bool changed = false;

    if (_isGasPressed && _dcPowerOn) {
      _dcRampAccumulator += _dcRampUpPerSec * dtSec;
      if (_dcRampAccumulator >= 1.0) {
        final int step = _dcRampAccumulator.floor();
        _dcRampAccumulator -= step;
        final int next = (_dcTargetPwm + step).clamp(0, 255);
        if (next != _dcTargetPwm) {
          _dcTargetPwm = next;
          _dcSoftTargetPwm = _dcTargetPwm.toDouble();
          _dcSavedPwmBeforeOff = _dcTargetPwm;
          changed = true;
        }
      }
    } else if (_isBrakePressed) {
      _dcRampAccumulator += _dcRampDownPerSec * dtSec;
      if (_dcRampAccumulator >= 1.0) {
        final int step = _dcRampAccumulator.floor();
        _dcRampAccumulator -= step;
        final int next = (_dcTargetPwm - step).clamp(0, 255);
        if (next != _dcTargetPwm) {
          _dcTargetPwm = next;
          _dcSoftTargetPwm = _dcTargetPwm.toDouble();
          changed = true;
        }
      }
    } else if (_dcAutoBrake &&
        _inputDevice == InputDevice.pushButton &&
        _dcPowerOn &&
        _dcTargetPwm > 0) {
      _dcRampAccumulator += _dcAutoBrakePerSec * dtSec;
      if (_dcRampAccumulator >= 1.0) {
        final int step = _dcRampAccumulator.floor();
        _dcRampAccumulator -= step;
        final int next = (_dcTargetPwm - step).clamp(0, 255);
        if (next != _dcTargetPwm) {
          _dcTargetPwm = next;
          _dcSoftTargetPwm = _dcTargetPwm.toDouble();
          changed = true;
        }
      }
    }

    if (_dcPowerOn && _dcSoftTargetPwm < _dcTargetPwm) {
      _dcSoftTargetPwm =
          (_dcSoftTargetPwm + _dcAccelPwmPerSec * dtSec).clamp(0.0, _dcTargetPwm.toDouble());
      changed = true;
    } else {
      _dcSoftTargetPwm = _dcTargetPwm.toDouble();
    }

    final double effectiveTargetMag =
        (!_dcPowerOn || _dcTargetPwm < dcDeadZonePwm) ? 0.0 : _dcSoftTargetPwm;
    final double desiredSignedSpeed = _dcDirection * effectiveTargetMag;

    if (instant) {
      if ((_dcSignedSpeed - desiredSignedSpeed).abs() > 0.01) {
        _dcSignedSpeed = desiredSignedSpeed;
        changed = true;
      }
      return changed;
    }

    if ((_dcSignedSpeed - desiredSignedSpeed).abs() > 0.1) {
      final bool reversingDirection =
          (_dcSignedSpeed > 0.1 && desiredSignedSpeed < -0.1) ||
          (_dcSignedSpeed < -0.1 && desiredSignedSpeed > 0.1);
      final bool decelerating =
          reversingDirection || desiredSignedSpeed.abs() < _dcSignedSpeed.abs();
      final double rate = decelerating ? _dcDecelPwmPerSec : _dcAccelPwmPerSec;

      if (reversingDirection) {
        if (_dcSignedSpeed > 0) {
          _dcSignedSpeed = math.max(0.0, _dcSignedSpeed - rate * dtSec);
        } else {
          _dcSignedSpeed = math.min(0.0, _dcSignedSpeed + rate * dtSec);
        }
      } else {
        final double delta = desiredSignedSpeed - _dcSignedSpeed;
        final double maxDelta = rate * dtSec;
        if (delta.abs() <= maxDelta) {
          _dcSignedSpeed = desiredSignedSpeed;
        } else {
          _dcSignedSpeed += delta.sign * maxDelta;
        }
      }
      changed = true;
    } else if (_dcSignedSpeed != desiredSignedSpeed) {
      _dcSignedSpeed = desiredSignedSpeed;
      changed = true;
    }

    if (_dcSignedSpeed.abs() > 0.2) {
      const double maxOmegaRadPerSec = 28.0;
      final double omega = (_dcSignedSpeed / 255.0) * maxOmegaRadPerSec;
      _dcRotationRad = (_dcRotationRad + omega * dtSec) % (2 * math.pi);
      if (_dcRotationRad < 0) _dcRotationRad += 2 * math.pi;
      changed = true;
    }

    return changed;
  }

  bool _tickStepper(double dtSec, {required bool instant}) {
    bool changed = false;

    if (_stepperClickProgress < 1.0) {
      _stepperClickProgress = (_stepperClickProgress + dtSec / 0.08).clamp(0.0, 1.0);
      changed = true;
    }

    if (_stepperHoldDir != 0) {
      _stepperHoldDuration += dtSec;
      final double holdRate = _stepperHoldDuration < 0.6
          ? 6.0
          : (_stepperHoldDuration < 1.5 ? 16.0 : 35.0);
      _stepperStepAccumulator += holdRate * dtSec;
      while (_stepperStepAccumulator >= 1.0) {
        _stepperStepAccumulator -= 1.0;
        _advanceStepperOneStep(_stepperHoldDir);
        _stepperTargetStep = _stepperStepCounter;
        changed = true;
      }
      return changed;
    }

    if (_stepperAutoRun) {
      final double rate = stepperCurrentSpeedStepsPerSec;
      _stepperStepAccumulator += rate * dtSec;
      while (_stepperStepAccumulator >= 1.0) {
        _stepperStepAccumulator -= 1.0;
        _advanceStepperOneStep(_stepperAutoRunDir);
        _stepperTargetStep = _stepperStepCounter;
        changed = true;
      }
      return changed;
    }

    if (_stepperStepCounter != _stepperTargetStep) {
      if (instant) {
        _stepperPrevStep = _stepperTargetStep;
        _stepperStepCounter = _stepperTargetStep;
        _stepperClickProgress = 1.0;
        return true;
      }
      final double chaseRate = math.max(24.0, stepperCurrentSpeedStepsPerSec);
      _stepperStepAccumulator += chaseRate * dtSec;
      while (_stepperStepAccumulator >= 1.0 && _stepperStepCounter != _stepperTargetStep) {
        _stepperStepAccumulator -= 1.0;
        final int dir = _stepperTargetStep > _stepperStepCounter ? 1 : -1;
        _advanceStepperOneStep(dir);
        changed = true;
      }
    } else {
      _stepperStepAccumulator = 0.0;
    }

    return changed;
  }
}
