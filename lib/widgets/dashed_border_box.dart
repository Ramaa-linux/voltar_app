import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';

/// Kotak bergaris putus-putus untuk area placeholder (canvas Simulasi).
///
/// [CustomPaint] digambar di belakang [child] sehingga isi kotak tetap bisa
/// berupa widget biasa. Garis mengikuti radius [AppRadius.card].
class DashedBorderBox extends StatelessWidget {
  const DashedBorderBox({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color = AppColors.borderStrong,
    this.dashLength = 6,
    this.gapLength = 5,
    this.strokeWidth = 1.5,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        dashLength: dashLength,
        gapLength: gapLength,
        strokeWidth: strokeWidth,
        radius: AppRadius.card,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.color,
    required this.dashLength,
    required this.gapLength,
    required this.strokeWidth,
    required this.radius,
  });

  final Color color;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Path border = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );
    final Path dashed = Path();
    for (final PathMetric metric in border.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double candidate = distance + dashLength;
        final double end = candidate > metric.length ? metric.length : candidate;
        dashed.addPath(metric.extractPath(distance, end), Offset.zero);
        distance = end + gapLength;
      }
    }

    canvas.drawPath(
      dashed,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.radius != radius;
  }
}
