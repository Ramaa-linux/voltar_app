import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_typography.dart';

/// Lukisan rangkaian Blink LED: papan Arduino kiri, LED kanan, kabel pin 13.
///
/// Seluruh koordinat diturunkan dari [size] (persentase lebar/tinggi), jadi
/// gambar tetap proporsional di layar sempit maupun lebar. Tidak ada aset
/// bitmap: semua bentuk memakai `drawRRect`, `drawCircle`, dan `drawLine`.
class CircuitCanvas extends CustomPainter {
  const CircuitCanvas({required this.isLedOn});

  /// `true` = pin 13 HIGH, LED menyala.
  final bool isLedOn;

  /// Radius sudut papan Arduino.
  static const double boardRadius = 8;

  /// Papan: 42% lebar kanvas, sisi kiri, tinggi 64%.
  static Rect boardRect(Size size) {
    return Rect.fromLTWH(
      size.width * 0.06,
      size.height * 0.18,
      size.width * 0.42,
      size.height * 0.64,
    );
  }

  /// Titik sambung pin 13 di tepi kanan papan.
  static Offset pinAnchor(Size size) {
    final Rect board = boardRect(size);
    return Offset(board.right, board.top + board.height * 0.18);
  }

  /// Pusat LED di area kanan.
  static Offset ledCenter(Size size) =>
      Offset(size.width * 0.82, size.height * 0.66);

  /// Radius LED ikut sisi terpendek, minimum 6 supaya tetap kelihatan.
  static double ledRadius(Size size) =>
      math.max(6.0, math.min(size.width, size.height) * 0.06);

  /// Rute kabel: pin 13 -> belok -> LED (3 segmen, ujung membulat).
  static List<Offset> wirePoints(Size size) {
    final Offset pin = pinAnchor(size);
    final Offset led = ledCenter(size);
    final double ledEdgeX = led.dx - ledRadius(size);
    final double elbowX = (pin.dx + ledEdgeX) / 2;
    return <Offset>[
      pin,
      Offset(elbowX, pin.dy),
      Offset(elbowX, led.dy),
      Offset(ledEdgeX, led.dy),
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }
    _paintBoard(canvas, size);
    _paintWire(canvas, size);
    _paintLed(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CircuitCanvas oldDelegate) =>
      oldDelegate.isLedOn != isLedOn;

  void _paintBoard(Canvas canvas, Size size) {
    final Rect board = boardRect(size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(board, const Radius.circular(boardRadius)),
      Paint()..color = AppColors.circuitBoard,
    );

    // Label kecil di atas papan.
    final double inset = math.max(8.0, size.shortestSide * 0.04);
    _paintText(
      canvas,
      'Arduino Uno',
      Offset(board.left + inset, board.top + inset),
      AppTypography.label.copyWith(color: AppColors.textOnPrimary),
    );

    // Penanda pin 13 di tepi kanan papan.
    final Offset pin = pinAnchor(size);
    canvas.drawCircle(
      pin,
      math.max(2.0, size.shortestSide * 0.012),
      Paint()..color = AppColors.textOnPrimary,
    );
    final TextPainter pinLabel = _layoutText(
      '13',
      AppTypography.caption.copyWith(color: AppColors.textSecondary),
    );
    pinLabel.paint(canvas, Offset(pin.dx + 4, pin.dy - pinLabel.height - 2));
    pinLabel.dispose();
  }

  void _paintWire(Canvas canvas, Size size) {
    final Paint wire = Paint()
      ..color = AppColors.circuitWire
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(2.0, size.shortestSide * 0.014)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final List<Offset> points = wirePoints(size);
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], wire);
    }
  }

  void _paintLed(Canvas canvas, Size size) {
    final Offset center = ledCenter(size);
    final double radius = ledRadius(size);

    if (isLedOn) {
      // Glow dua lapis, alpha rendah supaya tetap lembut di latar terang.
      canvas.drawCircle(
        center,
        radius * 1.9,
        Paint()..color = AppColors.ledOn.withValues(alpha: 0.16),
      );
      canvas.drawCircle(
        center,
        radius * 1.35,
        Paint()..color = AppColors.ledOn.withValues(alpha: 0.24),
      );
    }

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = isLedOn ? AppColors.ledOn : AppColors.ledOff,
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1.0, radius * 0.12)
        ..color = isLedOn ? AppColors.ledOn : AppColors.textTertiary,
    );

    final TextPainter label = _layoutText(
      'LED',
      AppTypography.caption.copyWith(color: AppColors.textSecondary),
    );
    label.paint(
      canvas,
      Offset(center.dx - label.width / 2, center.dy + radius + 6),
    );
    label.dispose();
  }

  void _paintText(Canvas canvas, String text, Offset topLeft, TextStyle style) {
    final TextPainter painter = _layoutText(text, style);
    painter.paint(canvas, topLeft);
    painter.dispose();
  }

  static TextPainter _layoutText(String text, TextStyle style) {
    return TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
  }
}
