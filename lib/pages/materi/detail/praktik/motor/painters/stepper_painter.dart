import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/painters/servo_painter.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_typography.dart';

/// CustomPainter detail tinggi untuk Stepper 28BYJ-48 + Driver ULN2003:
/// - Badan silinder logam perak + tab pemasangan + skala derajat melingkar (5.625°/tick)
/// - 4 kumparan (A, B, C, D) di sekitar rotor menyala sesuai urutan step
/// - Poros output bentuk D-shaft perak dengan garis penanda merah
/// - Modul driver ULN2003 di samping kanan dengan 4 LED indikator (A, B, C, D)
class StepperPainter extends CustomPainter {
  const StepperPainter({
    required this.visualAngleDeg,
    required this.targetAngleDeg,
    required this.activeCoils,
    required this.stepCounter,
  });

  final double visualAngleDeg;
  final double targetAngleDeg;
  final List<bool> activeCoils; // [A, B, C, D]
  final int stepCounter;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset motorCenter = Offset(size.width * 0.37, size.height * 0.54);
    final double motorR = math.min(size.width * 0.25, size.height * 0.37);
    final Rect driverRect = Rect.fromCenter(
      center: Offset(size.width * 0.80, size.height * 0.54),
      width: size.width * 0.26,
      height: size.height * 0.66,
    );

    _drawRibbonWires(canvas, motorCenter, motorR, driverRect);
    _drawStepperCan(canvas, motorCenter, motorR);
    _drawDegreeScale(canvas, motorCenter, motorR);
    _drawStatorCoils(canvas, motorCenter, motorR * 0.66);
    _drawDShaft(canvas, motorCenter, motorR * 0.36);
    _drawUln2003Driver(canvas, driverRect);
  }

  void _drawRibbonWires(Canvas canvas, Offset motorCenter, double motorR, Rect driverRect) {
    final List<Color> wireColors = <Color>[
      MotorPalette.servoBlue,
      AppColors.primary,
      AppColors.accent,
      MotorPalette.wireOrange,
      MotorPalette.wireRed,
    ];
    for (int i = 0; i < wireColors.length; i++) {
      final double dy = (i - 2) * 6.5;
      final Path p = Path()
        ..moveTo(motorCenter.dx + motorR * 0.75, motorCenter.dy + motorR * 0.45 + dy)
        ..cubicTo(
          motorCenter.dx + motorR * 1.1,
          motorCenter.dy + motorR * 0.55 + dy,
          driverRect.left - 18,
          driverRect.center.dy + dy,
          driverRect.left,
          driverRect.center.dy + dy,
        );
      canvas.drawPath(
        p,
        Paint()
          ..color = wireColors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4,
      );
    }
  }

  void _drawStepperCan(Canvas canvas, Offset center, double r) {
    // Drop shadow
    canvas.drawCircle(
      center + const Offset(0, 5),
      r,
      Paint()..color = AppColors.shadow.withValues(alpha: 0.45),
    );

    // Tab pemasangan kiri & kanan
    final Rect tabRect = Rect.fromCenter(center: center, width: r * 2.42, height: r * 0.42);
    canvas.drawRRect(
      RRect.fromRectAndRadius(tabRect, const Radius.circular(8)),
      Paint()..color = MotorPalette.dcMetalMid,
    );
    canvas.drawCircle(
      Offset(tabRect.left + 9, center.dy),
      4.0,
      Paint()..color = MotorPalette.benchDarkTop,
    );
    canvas.drawCircle(
      Offset(tabRect.right - 9, center.dy),
      4.0,
      Paint()..color = MotorPalette.benchDarkTop,
    );

    // Konektor plastik biru-putih di bawah
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center + Offset(0, r * 0.78), width: r * 0.85, height: r * 0.34),
        const Radius.circular(4),
      ),
      Paint()..color = MotorPalette.servoBlueDark,
    );

    // Badan silinder logam perak
    final Rect canRect = Rect.fromCircle(center: center, radius: r);
    canvas.drawCircle(
      center,
      r,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.25, -0.25),
          radius: 0.95,
          colors: <Color>[MotorPalette.stepperSilver, MotorPalette.dcMetalMid],
        ).createShader(canRect),
    );
    canvas.drawCircle(
      center,
      r,
      Paint()
        ..color = AppColors.surface.withValues(alpha: 0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );
  }

  void _drawDegreeScale(Canvas canvas, Offset center, double r) {
    for (int i = 0; i < 64; i++) {
      final double rad = -math.pi / 2 + (i / 64.0) * 2 * math.pi;
      final bool isQuarter = i % 16 == 0;
      final bool isEighth = i % 8 == 0;
      final double inner = r * (isQuarter ? 0.80 : (isEighth ? 0.85 : 0.90));
      final Offset p1 = center + Offset(math.cos(rad), math.sin(rad)) * inner;
      final Offset p2 = center + Offset(math.cos(rad), math.sin(rad)) * (r * 0.96);
      canvas.drawLine(
        p1,
        p2,
        Paint()
          ..color = isQuarter
              ? MotorPalette.benchDarkTop
              : MotorPalette.benchDarkTop.withValues(alpha: isEighth ? 0.65 : 0.32)
          ..strokeWidth = isQuarter ? 1.8 : 1.0,
      );
    }

    final double targetRad = -math.pi / 2 + (targetAngleDeg * math.pi / 180.0);
    final Offset targetPos = center + Offset(math.cos(targetRad), math.sin(targetRad)) * (r + 5);
    canvas.drawCircle(targetPos, 4.2, Paint()..color = MotorPalette.stepperGreen);
  }

  void _drawStatorCoils(Canvas canvas, Offset center, double coilRingR) {
    const List<String> names = <String>['A', 'B', 'C', 'D'];
    const List<double> angles = <double>[-math.pi / 2, 0.0, math.pi / 2, math.pi];

    for (int i = 0; i < 4; i++) {
      final bool isOn = i < activeCoils.length && activeCoils[i];
      final Offset pos = center + Offset(math.cos(angles[i]), math.sin(angles[i])) * coilRingR;

      if (isOn) {
        canvas.drawCircle(pos, 12, Paint()..color = MotorPalette.stepperGreen.withValues(alpha: 0.35));
      }
      canvas.drawCircle(
        pos,
        8.5,
        Paint()..color = isOn ? MotorPalette.stepperGreen : MotorPalette.dcMetalDark,
      );

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: names[i],
          style: AppTypography.overline.copyWith(
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 9.5,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
    }
  }

  void _drawDShaft(Canvas canvas, Offset center, double shaftR) {
    canvas.drawCircle(center, shaftR * 1.28, Paint()..color = AppColors.accent.withValues(alpha: 0.75));
    canvas.drawCircle(center, shaftR, Paint()..color = MotorPalette.benchDarkTop);

    final double rad = -math.pi / 2 + (visualAngleDeg * math.pi / 180.0);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rad);

    final double dR = shaftR * 0.78;
    canvas.drawCircle(Offset.zero, dR, Paint()..color = MotorPalette.stepperSilver);
    canvas.drawRect(
      Rect.fromLTRB(-dR, -dR, dR, -dR * 0.52),
      Paint()..color = MotorPalette.dcMetalDark,
    );

    canvas.drawLine(
      Offset.zero,
      Offset(dR * 0.92, 0),
      Paint()
        ..color = MotorPalette.wireRed
        ..strokeWidth = 3.2
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(Offset.zero, 2.8, Paint()..color = AppColors.circuitPinHeader);
    canvas.restore();
  }

  void _drawUln2003Driver(Canvas canvas, Rect rect) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8)),
      Paint()..color = AppColors.circuitBoardDark,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8)),
      Paint()
        ..color = MotorPalette.stepperGreen.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    final Rect icRect = Rect.fromLTWH(
      rect.left + 8,
      rect.top + rect.height * 0.24,
      rect.width * 0.36,
      rect.height * 0.52,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(icRect, const Radius.circular(3)),
      Paint()..color = AppColors.circuitChip,
    );

    final TextPainter titleTp = TextPainter(
      text: TextSpan(
        text: 'ULN2003',
        style: AppTypography.overline.copyWith(
          color: AppColors.textOnPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 8.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    titleTp.paint(canvas, Offset(rect.center.dx - titleTp.width / 2, rect.top + 6));

    const List<String> labels = <String>['A', 'B', 'C', 'D'];
    final double startY = rect.top + 28;
    final double gapY = (rect.height - 40) / 3.0;

    for (int i = 0; i < 4; i++) {
      final bool isOn = i < activeCoils.length && activeCoils[i];
      final Offset ledPos = Offset(rect.right - 22, startY + i * gapY);

      if (isOn) {
        canvas.drawCircle(ledPos, 7.5, Paint()..color = MotorPalette.wireRed.withValues(alpha: 0.4));
      }
      canvas.drawCircle(
        ledPos,
        4.5,
        Paint()..color = isOn ? MotorPalette.wireRed : AppColors.circuitPinHeader,
      );

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: AppTypography.overline.copyWith(
            color: AppColors.textOnPrimary.withValues(alpha: isOn ? 1.0 : 0.6),
            fontWeight: FontWeight.w700,
            fontSize: 8.5,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(ledPos.dx + 8, ledPos.dy - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant StepperPainter oldDelegate) =>
      (oldDelegate.visualAngleDeg - visualAngleDeg).abs() > 0.02 ||
      (oldDelegate.targetAngleDeg - targetAngleDeg).abs() > 0.02 ||
      oldDelegate.stepCounter != stepCounter;
}
