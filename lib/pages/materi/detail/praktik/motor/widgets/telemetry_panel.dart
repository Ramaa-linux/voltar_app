import 'package:flutter/material.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/motor_sim_controller.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/painters/servo_painter.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

/// Panel telemetry monospace (`tabularFigures`) + oscilloscope mini gelombang sinyal.
class TelemetryPanel extends StatelessWidget {
  const TelemetryPanel({super.key, required this.controller});

  final MotorSimController controller;

  @override
  Widget build(BuildContext context) {
    final List<(String, String)> metrics = _buildMetrics();
    final Color waveColor = switch (controller.motorType) {
      MotorType.servo => MotorPalette.servoBlueLight,
      MotorType.dc => AppColors.primaryLight,
      MotorType.stepper => MotorPalette.stepperGreen,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: MotorPalette.benchDarkTop,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: MotorPalette.benchGrid, width: 1.2),
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
                'TELEMETRY & OSCILLOSCOPE',
                style: AppTypography.overline.copyWith(
                  color: waveColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                switch (controller.motorType) {
                  MotorType.servo => 'PWM 50 Hz (Periode 20 ms)',
                  MotorType.dc => 'PWM ~490 Hz (Pin D5)',
                  MotorType.stepper => '4-Coil Step Sequence (IN1–IN4)',
                },
                style: AppTypography.overline.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.7),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: <Widget>[
              for (final (String label, String val) in metrics)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: MotorPalette.benchDarkBottom,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(color: MotorPalette.benchGrid),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: AppTypography.overline.copyWith(
                        fontFamily: 'monospace',
                        fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '$label: ',
                          style: TextStyle(
                            color: AppColors.textOnPrimary.withValues(alpha: 0.65),
                          ),
                        ),
                        TextSpan(
                          text: val,
                          style: TextStyle(
                            color: waveColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 56,
            child: CustomPaint(
              painter: _OscilloscopePainter(
                motorType: controller.motorType,
                servoPulseUs: controller.servoPulseWidthUs,
                dcDutyPercent: controller.dcDutyCyclePercent,
                stepperCoils: controller.stepperActiveCoils,
                waveColor: waveColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<(String, String)> _buildMetrics() {
    switch (controller.motorType) {
      case MotorType.servo:
        return <(String, String)>[
          ('Sudut Aktual', '${controller.servoCurrentAngle.round()}°'),
          ('Sudut Target', '${controller.servoTargetAngle.round()}°'),
          ('Lebar Pulsa', '${controller.servoPulseWidthUs} µs'),
          ('Frekuensi', '${MotorSimController.servoFrequencyHz} Hz'),
        ];
      case MotorType.dc:
        final String dirText = switch (controller.dcActualDirection) {
          1 => 'CW (Maju)',
          -1 => 'CCW (Mundur)',
          _ => controller.isDcStalled ? 'STALL' : 'STOP',
        };
        return <(String, String)>[
          ('PWM', '${controller.dcTargetPwm}/255'),
          ('Duty Cycle', '${controller.dcDutyCyclePercent}%'),
          ('RPM', '${controller.dcRpm}'),
          ('Arah', dirText),
        ];
      case MotorType.stepper:
        final List<bool> c = controller.stepperActiveCoils;
        final String coilStr =
            '${c[0] ? '1' : '0'}-${c[1] ? '1' : '0'}-${c[2] ? '1' : '0'}-${c[3] ? '1' : '0'}';
        return <(String, String)>[
          ('Step Counter', '${controller.stepperStepCounter}'),
          ('Sudut', '${controller.stepperCurrentAngleDeg.toStringAsFixed(1)}°'),
          ('Kumparan ABCD', coilStr),
          (
            'Kecepatan',
            '${controller.stepperCurrentSpeedStepsPerSec.round()} step/s',
          ),
        ];
    }
  }
}

class _OscilloscopePainter extends CustomPainter {
  const _OscilloscopePainter({
    required this.motorType,
    required this.servoPulseUs,
    required this.dcDutyPercent,
    required this.stepperCoils,
    required this.waveColor,
  });

  final MotorType motorType;
  final int servoPulseUs;
  final int dcDutyPercent;
  final List<bool> stepperCoils;
  final Color waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect box = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(box, const Radius.circular(6)),
      Paint()..color = MotorPalette.benchDarkBottom,
    );

    // Grid garis tipis oscilloscope
    final Paint gridPaint = Paint()
      ..color = MotorPalette.benchGrid.withValues(alpha: 0.65)
      ..strokeWidth = 0.8;
    for (int i = 1; i < 4; i++) {
      final double y = size.height * (i / 4.0);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (int i = 1; i < 8; i++) {
      final double x = size.width * (i / 8.0);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final Paint wavePaint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    if (motorType == MotorType.servo || motorType == MotorType.dc) {
      final double duty = motorType == MotorType.servo
          ? ((servoPulseUs - 500) / (2400 - 500) * 0.45 + 0.08).clamp(0.06, 0.60)
          : (dcDutyPercent / 100.0).clamp(0.0, 1.0);
      final int periods = motorType == MotorType.servo ? 3 : 5;
      final double periodW = size.width / periods;
      final double highY = size.height * 0.22;
      final double lowY = size.height * 0.78;

      final Path p = Path();
      for (int i = 0; i < periods; i++) {
        final double x0 = i * periodW;
        final double xHighEnd = x0 + periodW * duty;
        final double x1 = (i + 1) * periodW;
        if (i == 0) {
          p.moveTo(x0, duty > 0 ? highY : lowY);
        }
        if (duty <= 0.001) {
          p.lineTo(x1, lowY);
        } else if (duty >= 0.999) {
          p.lineTo(x1, highY);
        } else {
          p.lineTo(x0, highY);
          p.lineTo(xHighEnd, highY);
          p.lineTo(xHighEnd, lowY);
          p.lineTo(x1, lowY);
        }
      }
      canvas.drawPath(p, wavePaint);
    } else {
      // 4 channel gelombang kuadrat kumparan A, B, C, D
      const List<String> names = <String>['A', 'B', 'C', 'D'];
      final double rowH = size.height / 4.0;
      for (int ch = 0; ch < 4; ch++) {
        final bool active = ch < stepperCoils.length && stepperCoils[ch];
        final double yHigh = ch * rowH + rowH * 0.22;
        final double yLow = ch * rowH + rowH * 0.80;
        final Path p = Path()..moveTo(22, active ? yHigh : yLow);
        for (int s = 0; s < 8; s++) {
          final double sx0 = 22 + (size.width - 26) * (s / 8.0);
          final double sx1 = 22 + (size.width - 26) * ((s + 1) / 8.0);
          final bool pulse = ((s + (active ? 0 : 2)) % 4 == ch);
          final double y = (active && s < 2) || pulse ? yHigh : yLow;
          p.lineTo(sx0, y);
          p.lineTo(sx1, y);
        }
        canvas.drawPath(
          p,
          Paint()
            ..color = active ? waveColor : waveColor.withValues(alpha: 0.35)
            ..style = PaintingStyle.stroke
            ..strokeWidth = active ? 1.8 : 1.1,
        );

        final TextPainter tp = TextPainter(
          text: TextSpan(
            text: names[ch],
            style: AppTypography.overline.copyWith(
              color: active ? waveColor : AppColors.textOnPrimary.withValues(alpha: 0.5),
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, Offset(6, ch * rowH + (rowH - tp.height) / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _OscilloscopePainter oldDelegate) =>
      oldDelegate.motorType != motorType ||
      oldDelegate.servoPulseUs != servoPulseUs ||
      oldDelegate.dcDutyPercent != dcDutyPercent ||
      oldDelegate.waveColor != waveColor ||
      oldDelegate.stepperCoils != stepperCoils;
}
