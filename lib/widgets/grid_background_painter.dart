import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';

/// Latar sandbox editor simulasi: grid minor 20 px + garis mayor tiap 100 px.
///
/// Dipakai sebagai `CustomPaint.painter` sehingga digambar di belakang papan
/// Arduino, kabel, dan LED. Warna hanya dari [AppColors] - tidak ada hex lokal.
class GridBackgroundPainter extends CustomPainter {
  const GridBackgroundPainter({
    this.cellSize = 20,
    this.majorEvery = 5,
    this.minorColor = AppColors.border,
    this.majorColor = AppColors.borderStrong,
    this.strokeWidth = 1,
  });

  /// Jarak antar garis minor dalam piksel logis (20 px).
  final double cellSize;

  /// Satu garis mayor setiap [majorEvery] garis minor (5 sel = 100 px).
  final int majorEvery;

  /// Warna garis minor (#E5E7EB).
  final Color minorColor;

  /// Warna garis mayor, satu tingkat lebih tegas (#D1D5DB).
  final Color majorColor;

  /// Ketebalan garis; 1 px + anti-alias mati agar tetap tajam.
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || cellSize <= 0) {
      return;
    }

    final Paint minorPaint = _paintFor(minorColor);
    final Paint majorPaint = _paintFor(majorColor);

    // Indeks 0 (tepi kiri/atas) dihitung mayor supaya bingkai grid rapi.
    int index = 0;
    for (double dx = 0; dx < size.width; dx += cellSize, index++) {
      canvas.drawLine(
        Offset(dx, 0),
        Offset(dx, size.height),
        _pick(index, minorPaint, majorPaint),
      );
    }
    index = 0;
    for (double dy = 0; dy < size.height; dy += cellSize, index++) {
      canvas.drawLine(
        Offset(0, dy),
        Offset(size.width, dy),
        _pick(index, minorPaint, majorPaint),
      );
    }
  }

  Paint _paintFor(Color color) => Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..isAntiAlias = false;

  Paint _pick(int index, Paint minor, Paint major) {
    if (majorEvery <= 0) {
      return minor;
    }
    return index % majorEvery == 0 ? major : minor;
  }

  @override
  bool shouldRepaint(covariant GridBackgroundPainter oldDelegate) =>
      oldDelegate.cellSize != cellSize ||
      oldDelegate.majorEvery != majorEvery ||
      oldDelegate.minorColor != minorColor ||
      oldDelegate.majorColor != majorColor ||
      oldDelegate.strokeWidth != strokeWidth;
}
