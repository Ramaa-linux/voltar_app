import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_typography.dart';

/// Palet warna khusus komponen motor (terpusat di satu tempat sesuai aturan).
abstract final class MotorPalette {
  static const Color benchDarkTop = Color(0xFF0E1726);
  static const Color benchDarkBottom = Color(0xFF162235);
  static const Color benchGrid = Color(0xFF283A52);

  static const Color servoBlue = Color(0xFF2979FF);
  static const Color servoBlueDark = Color(0xFF1554C0);
  static const Color servoBlueLight = Color(0xFF82B1FF);
  static const Color wireOrange = Color(0xFFFF8F00);
  static const Color wireRed = Color(0xFFE53935);
  static const Color wireBrown = Color(0xFF5D4037);

  static const Color dcMetalLight = Color(0xFFCFD8DC);
  static const Color dcMetalMid = Color(0xFF78909C);
  static const Color dcMetalDark = Color(0xFF455A64);

  static const Color stepperGreen = Color(0xFF2ECC71);
  static const Color stepperGreenDark = Color(0xFF1E8449);
  static const Color stepperSilver = Color(0xFFECEFF1);
}

/// CustomPainter detail tinggi untuk Servo SG90:
/// - Busur derajat 0°-180° + progress arc biru
/// - Badan biru SG90 + mounting ears berlubang + label SG90 + 3 kabel Bezier
/// - Ghost horn transparan di posisi target
/// - Horn putih berlubang dengan skrup perak di poros
class ServoPainter extends CustomPainter {
  const ServoPainter({
    required this.currentAngleDeg,
    required this.targetAngleDeg,
    required this.pulseWidthUs,
  });

  final double currentAngleDeg;
  final double targetAngleDeg;
  final int pulseWidthUs;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset pivot = Offset(size.width * 0.5, size.height * 0.58);
    final double protractorR = math.min(size.width * 0.37, size.height * 0.45);

    _drawWires(canvas, pivot, protractorR);
    _drawServoBody(canvas, pivot, protractorR);
    _drawProtractor(canvas, pivot, protractorR);

    // Ghost target horn (jika sedang bergerak menuju target)
    if ((targetAngleDeg - currentAngleDeg).abs() > 1.2) {
      _drawHorn(canvas, pivot, protractorR * 0.84, targetAngleDeg, isGhost: true);
    }

    // Actual horn
    _drawHorn(canvas, pivot, protractorR * 0.84, currentAngleDeg, isGhost: false);
  }

  void _drawWires(Canvas canvas, Offset pivot, double r) {
    final Offset basePoint = pivot + Offset(0, r * 0.72);
    final List<(Color, double)> wires = <(Color, double)>[
      (MotorPalette.wireOrange, -8),
      (MotorPalette.wireRed, 0),
      (MotorPalette.wireBrown, 8),
    ];

    for (final (Color c, double dy) in wires) {
      final Path p = Path()
        ..moveTo(basePoint.dx - r * 0.32, basePoint.dy + dy)
        ..cubicTo(
          basePoint.dx - r * 0.75,
          basePoint.dy + dy + 8,
          basePoint.dx - r * 0.95,
          basePoint.dy + dy + 28,
          basePoint.dx - r * 1.25,
          basePoint.dy + dy + 22,
        );
      canvas.drawPath(
        p,
        Paint()
          ..color = c
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _drawServoBody(Canvas canvas, Offset pivot, double r) {
    final double bodyW = r * 0.92;
    final double bodyH = r * 0.85;
    final Rect bodyRect = Rect.fromCenter(
      center: pivot + Offset(0, bodyH * 0.36),
      width: bodyW,
      height: bodyH,
    );

    // Drop shadow
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect.shift(const Offset(0, 6)), const Radius.circular(10)),
      Paint()..color = AppColors.shadow.withValues(alpha: 0.45),
    );

    // Mounting ears (kiri-kanan)
    final Rect earsRect = Rect.fromCenter(
      center: pivot + Offset(0, bodyH * 0.16),
      width: bodyW * 1.38,
      height: bodyH * 0.22,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(earsRect, const Radius.circular(4)),
      Paint()..color = MotorPalette.servoBlueDark,
    );
    // Lubang baut mounting
    final Paint holePaint = Paint()..color = MotorPalette.benchDarkTop;
    canvas.drawCircle(Offset(earsRect.left + 10, earsRect.center.dy), 3.8, holePaint);
    canvas.drawCircle(Offset(earsRect.right - 10, earsRect.center.dy), 3.8, holePaint);

    // Badan utama biru bergradient
    final Paint bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[MotorPalette.servoBlue, MotorPalette.servoBlueDark],
      ).createShader(bodyRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(9)),
      bodyPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(9)),
      Paint()
        ..color = MotorPalette.servoBlueLight.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // Tonjolan gearbox bundar di sekitar poros
    canvas.drawCircle(pivot, r * 0.26, Paint()..color = MotorPalette.servoBlueDark);
    canvas.drawCircle(pivot, r * 0.21, Paint()..color = MotorPalette.servoBlue);

    // Label SG90
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: 'SG90 MICRO SERVO',
        style: AppTypography.overline.copyWith(
          color: AppColors.textOnPrimary.withValues(alpha: 0.9),
          fontWeight: FontWeight.w700,
          fontSize: 9.5,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(pivot.dx - tp.width / 2, bodyRect.bottom - tp.height - 10),
    );
  }

  void _drawProtractor(Canvas canvas, Offset pivot, double r) {
    final Rect arcRect = Rect.fromCircle(center: pivot, radius: r);
    final double clampedCur = currentAngleDeg.clamp(0.0, 180.0);

    // Area progress dari 0° (kiri = pi) searah jarum jam ke sudut saat ini
    final double sweepRad = (clampedCur / 180.0) * math.pi;
    canvas.drawArc(
      arcRect,
      math.pi,
      sweepRad,
      true,
      Paint()..color = MotorPalette.servoBlue.withValues(alpha: 0.16),
    );

    // Garis busur utama
    canvas.drawArc(
      arcRect,
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = AppColors.borderStrong.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    // Arc progress tebal di tepi luar
    canvas.drawArc(
      arcRect,
      math.pi,
      sweepRad,
      false,
      Paint()
        ..color = MotorPalette.servoBlueLight
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round,
    );

    // Tick marks tiap 10°, besar tiap 30°
    for (int deg = 0; deg <= 180; deg += 10) {
      final double rad = math.pi + (deg / 180.0) * math.pi;
      final bool isMajor = deg % 30 == 0;
      final double inner = r - (isMajor ? 10.0 : 5.0);
      final Offset p1 = pivot + Offset(math.cos(rad), math.sin(rad)) * inner;
      final Offset p2 = pivot + Offset(math.cos(rad), math.sin(rad)) * r;
      canvas.drawLine(
        p1,
        p2,
        Paint()
          ..color = isMajor
              ? AppColors.surface.withValues(alpha: 0.85)
              : AppColors.surface.withValues(alpha: 0.38)
          ..strokeWidth = isMajor ? 1.8 : 1.0,
      );

      if (deg == 0 || deg == 90 || deg == 180) {
        final TextPainter labelTp = TextPainter(
          text: TextSpan(
            text: '$deg°',
            style: AppTypography.overline.copyWith(
              color: AppColors.surface.withValues(alpha: 0.85),
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        final Offset labelPos =
            pivot + Offset(math.cos(rad), math.sin(rad)) * (r + 14) -
            Offset(labelTp.width / 2, labelTp.height / 2);
        labelTp.paint(canvas, labelPos);
      }
    }
  }

  void _drawHorn(
    Canvas canvas,
    Offset pivot,
    double hornLen,
    double angleDeg, {
    required bool isGhost,
  }) {
    final double rad = math.pi + (angleDeg.clamp(0.0, 180.0) / 180.0) * math.pi;
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(rad);

    final double alpha = isGhost ? 0.28 : 1.0;
    final Path hornPath = Path()
      ..moveTo(0, -10)
      ..lineTo(hornLen, -4.5)
      ..arcToPoint(
        Offset(hornLen, 4.5),
        radius: const Radius.circular(4.5),
      )
      ..lineTo(0, 10)
      ..arcToPoint(
        const Offset(0, -10),
        radius: const Radius.circular(10),
      )
      ..close();

    if (!isGhost) {
      canvas.drawPath(
        hornPath.shift(const Offset(0, 3)),
        Paint()..color = AppColors.shadow.withValues(alpha: 0.38),
      );
    }

    canvas.drawPath(
      hornPath,
      Paint()
        ..color = (isGhost ? MotorPalette.servoBlueLight : AppColors.surface)
            .withValues(alpha: alpha),
    );
    canvas.drawPath(
      hornPath,
      Paint()
        ..color = (isGhost ? MotorPalette.servoBlueLight : AppColors.borderStrong)
            .withValues(alpha: isGhost ? 0.65 : 1.0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );

    // Lubang-lubang kecil di sepanjang lengan horn
    for (int i = 1; i <= 4; i++) {
      final double hx = hornLen * (0.24 + i * 0.16);
      canvas.drawCircle(
        Offset(hx, 0),
        2.1,
        Paint()
          ..color = (isGhost ? MotorPalette.benchDarkTop : AppColors.textSecondary)
              .withValues(alpha: alpha),
      );
    }

    // Skrup perak pusat
    if (!isGhost) {
      canvas.drawCircle(Offset.zero, 6.0, Paint()..color = AppColors.circuitMetal);
      canvas.drawLine(
        const Offset(-3.5, 0),
        const Offset(3.5, 0),
        Paint()
          ..color = AppColors.circuitPinHeader
          ..strokeWidth = 1.4,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ServoPainter oldDelegate) =>
      (oldDelegate.currentAngleDeg - currentAngleDeg).abs() > 0.05 ||
      (oldDelegate.targetAngleDeg - targetAngleDeg).abs() > 0.05 ||
      oldDelegate.pulseWidthUs != pulseWidthUs;
}
