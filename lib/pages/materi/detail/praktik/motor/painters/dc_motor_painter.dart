import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/motor_sim_controller.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/painters/servo_painter.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_typography.dart';

/// CustomPainter detail tinggi untuk Motor DC:
/// - Silinder logam metalik bergradient + end-cap + terminal +/- dengan kabel
/// - Poros + Kipas 4 bilah atau Roda berjari-jari
/// - Motion blur disc proporsional RPM + panah arah CW/CCW + garis aliran angin
class DcMotorPainter extends CustomPainter {
  const DcMotorPainter({
    required this.rotationRad,
    required this.actualSpeedPwm,
    required this.actualDirection,
    required this.attachment,
    required this.isStalled,
  });

  final double rotationRad;
  final double actualSpeedPwm;
  final int actualDirection;
  final DcAttachment attachment;
  final bool isStalled;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset bodyCenter = Offset(size.width * 0.30, size.height * 0.54);
    final Offset rotorCenter = Offset(size.width * 0.68, size.height * 0.54);
    final double rotorR = math.min(size.width * 0.21, size.height * 0.35);
    final double speedNorm = (actualSpeedPwm / 255.0).clamp(0.0, 1.0);

    _drawMotorBody(canvas, bodyCenter, rotorCenter, size);
    _drawWindLines(canvas, rotorCenter, rotorR, speedNorm);
    _drawRotor(canvas, rotorCenter, rotorR, speedNorm);
    _drawDirectionRing(canvas, rotorCenter, rotorR * 1.16, speedNorm);
  }

  void _drawMotorBody(Canvas canvas, Offset bodyCenter, Offset rotorCenter, Size size) {
    final double bodyW = size.width * 0.34;
    final double bodyH = size.height * 0.40;
    final Rect bodyRect = Rect.fromCenter(center: bodyCenter, width: bodyW, height: bodyH);

    // Drop shadow
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(bodyCenter.dx, bodyRect.bottom + 10),
        width: bodyW * 0.95,
        height: 14,
      ),
      Paint()..color = AppColors.shadow.withValues(alpha: 0.45),
    );

    // Kabel terminal belakang (+ merah, - hitam)
    final Offset backLeft = Offset(bodyRect.left - 8, bodyCenter.dy);
    canvas.drawLine(
      Offset(backLeft.dx - 24, backLeft.dy - 14),
      Offset(backLeft.dx, backLeft.dy - 14),
      Paint()
        ..color = MotorPalette.wireRed
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(backLeft.dx - 24, backLeft.dy + 14),
      Offset(backLeft.dx, backLeft.dy + 14),
      Paint()
        ..color = AppColors.circuitPinHeader
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );

    // Terminal lug (+ / -)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(bodyRect.left - 4, bodyCenter.dy - 14), width: 10, height: 8),
        const Radius.circular(2),
      ),
      Paint()..color = MotorPalette.wireRed,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(bodyRect.left - 4, bodyCenter.dy + 14), width: 10, height: 8),
        const Radius.circular(2),
      ),
      Paint()..color = AppColors.circuitMetal,
    );

    // Poros penghubung motor ke kipas/roda
    canvas.drawRect(
      Rect.fromLTRB(bodyRect.right - 2, bodyCenter.dy - 4, rotorCenter.dx, bodyCenter.dy + 4),
      Paint()..color = MotorPalette.dcMetalLight,
    );

    // End-cap belakang & depan
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(bodyRect.left - 4, bodyRect.top + 6, 10, bodyH - 12),
        const Radius.circular(4),
      ),
      Paint()..color = AppColors.circuitPinHeader,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(bodyRect.right - 6, bodyRect.top + 8, 12, bodyH - 16),
        const Radius.circular(4),
      ),
      Paint()..color = MotorPalette.dcMetalDark,
    );

    // Silinder logam utama dengan specular highlight
    final Paint cylinderPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          MotorPalette.dcMetalDark,
          MotorPalette.dcMetalLight,
          MotorPalette.dcMetalMid,
          MotorPalette.dcMetalDark,
        ],
        stops: <double>[0.0, 0.32, 0.68, 1.0],
      ).createShader(bodyRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(10)),
      cylinderPaint,
    );

    // Lubang ventilasi motor
    for (int i = -1; i <= 1; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(bodyCenter.dx + bodyW * 0.16, bodyCenter.dy + i * 13.0),
            width: 14,
            height: 4,
          ),
          const Radius.circular(2),
        ),
        Paint()..color = MotorPalette.benchDarkTop.withValues(alpha: 0.7),
      );
    }

    // Label DC 3-6V
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: isStalled ? 'STALL (<40)' : 'DC MOTOR',
        style: AppTypography.overline.copyWith(
          color: isStalled ? AppColors.accent : AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 9.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(bodyCenter.dx - tp.width / 2 - 4, bodyCenter.dy - tp.height / 2));
  }

  void _drawWindLines(Canvas canvas, Offset rotorCenter, double r, double speedNorm) {
    if (speedNorm < 0.25 || attachment != DcAttachment.fan) return;
    final double alpha = ((speedNorm - 0.25) / 0.75).clamp(0.0, 1.0) * 0.45;
    final Paint windPaint = Paint()
      ..color = AppColors.primaryLight.withValues(alpha: alpha)
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    for (int i = -2; i <= 2; i++) {
      final double y = rotorCenter.dy + i * (r * 0.34);
      final double phase = ((rotationRad * 1.5 + i * 0.7) % (2 * math.pi)) / (2 * math.pi);
      final double xStart = rotorCenter.dx + r * 0.4 + phase * (r * 0.55);
      canvas.drawLine(Offset(xStart, y), Offset(xStart + 14 * speedNorm, y), windPaint);
    }
  }

  void _drawRotor(Canvas canvas, Offset center, double r, double speedNorm) {
    // Motion blur disc saat RPM tinggi
    if (speedNorm > 0.12) {
      final double blurAlpha = (speedNorm * 0.42).clamp(0.0, 0.42);
      canvas.drawCircle(
        center,
        r * 0.96,
        Paint()..color = MotorPalette.dcMetalLight.withValues(alpha: blurAlpha),
      );
      canvas.drawCircle(
        center,
        r * 0.68,
        Paint()
          ..color = AppColors.primary.withValues(alpha: blurAlpha * 0.55)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6,
      );
    }

    final double bladeAlpha = (1.0 - speedNorm * 0.62).clamp(0.28, 1.0);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationRad);

    if (attachment == DcAttachment.fan) {
      // Kipas 4 bilah
      final Paint bladePaint = Paint()
        ..color = AppColors.primary.withValues(alpha: bladeAlpha);
      for (int i = 0; i < 4; i++) {
        canvas.save();
        canvas.rotate(i * (math.pi / 2));
        final Path blade = Path()
          ..moveTo(0, -5)
          ..quadraticBezierTo(r * 0.55, -r * 0.36, r * 0.94, -r * 0.12)
          ..quadraticBezierTo(r * 0.98, r * 0.18, r * 0.45, r * 0.16)
          ..lineTo(0, 5)
          ..close();
        canvas.drawPath(blade, bladePaint);
        canvas.restore();
      }
    } else {
      // Roda berjari-jari
      canvas.drawCircle(
        Offset.zero,
        r * 0.92,
        Paint()
          ..color = AppColors.circuitPinHeader.withValues(alpha: 0.92)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 9,
      );
      canvas.drawCircle(
        Offset.zero,
        r * 0.78,
        Paint()
          ..color = MotorPalette.dcMetalLight.withValues(alpha: bladeAlpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
      for (int i = 0; i < 6; i++) {
        final double a = i * (math.pi / 3);
        canvas.drawLine(
          Offset.zero,
          Offset(math.cos(a) * r * 0.78, math.sin(a) * r * 0.78),
          Paint()
            ..color = MotorPalette.dcMetalLight.withValues(alpha: bladeAlpha)
            ..strokeWidth = 3.2,
        );
      }
    }

    // Hub poros tengah
    canvas.drawCircle(Offset.zero, r * 0.22, Paint()..color = MotorPalette.dcMetalDark);
    canvas.drawCircle(Offset.zero, r * 0.11, Paint()..color = MotorPalette.dcMetalLight);
    canvas.restore();
  }

  void _drawDirectionRing(Canvas canvas, Offset center, double ringR, double speedNorm) {
    final Color ringColor = switch (actualDirection) {
      1 => AppColors.success,
      -1 => AppColors.accent,
      _ => AppColors.textTertiary.withValues(alpha: 0.45),
    };

    final double startAngle = actualDirection == 0 ? -math.pi / 2 : rotationRad * 0.5;
    final Paint arcPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: ringR),
      startAngle,
      math.pi * 0.65,
      false,
      arcPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: ringR),
      startAngle + math.pi,
      math.pi * 0.65,
      false,
      arcPaint,
    );

    if (actualDirection != 0) {
      // Kepala panah arah putaran
      final double tipAngle = actualDirection > 0
          ? startAngle + math.pi * 0.65
          : startAngle;
      final Offset tip = center + Offset(math.cos(tipAngle), math.sin(tipAngle)) * ringR;
      canvas.drawCircle(tip, 4.0, Paint()..color = ringColor);
    }
  }

  @override
  bool shouldRepaint(covariant DcMotorPainter oldDelegate) =>
      (oldDelegate.rotationRad - rotationRad).abs() > 0.005 ||
      (oldDelegate.actualSpeedPwm - actualSpeedPwm).abs() > 0.2 ||
      oldDelegate.actualDirection != actualDirection ||
      oldDelegate.attachment != attachment ||
      oldDelegate.isStalled != isStalled;
}
