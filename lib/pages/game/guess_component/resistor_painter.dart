import 'package:flutter/material.dart';

import 'resistor_code.dart';

/// CustomPainter rendering a 4-band axial through-hole resistor.
class ResistorPainter extends CustomPainter {
  const ResistorPainter({required this.bands});

  /// Exactly 4 bands: [band1, band2, multiplier, tolerance].
  final List<ResistorBand> bands;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || bands.length < 4) return;

    final double w = size.width;
    final double h = size.height;
    final double centerY = h / 2;

    // 1. Draw metal leads (left & right wires)
    final Paint leadPaint = Paint()
      ..color = const Color(0xFF9CA3AF)
      ..strokeWidth = (h * 0.08).clamp(3.0, 6.0)
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(w * 0.04, centerY),
      Offset(w * 0.22, centerY),
      leadPaint,
    );
    canvas.drawLine(
      Offset(w * 0.78, centerY),
      Offset(w * 0.96, centerY),
      leadPaint,
    );

    // 2. Draw resistor body (ceramic beige/tan color with shading)
    final double bodyLeft = w * 0.20;
    final double bodyRight = w * 0.80;
    final double bodyWidth = bodyRight - bodyLeft;
    final double bodyTop = h * 0.22;
    final double bodyBottom = h * 0.78;
    final double bodyHeight = bodyBottom - bodyTop;

    final RRect bodyRRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(bodyLeft, bodyTop, bodyRight, bodyBottom),
      Radius.circular(bodyHeight * 0.35),
    );

    // Body fill with subtle 3D cylindrical gradient
    final Paint bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFE5D5BA), // Highlight
          Color(0xFFD4B996), // Main tan body
          Color(0xFFB5936B), // Bottom shadow
        ],
        stops: <double>[0.0, 0.45, 1.0],
      ).createShader(bodyRRect.outerRect);

    canvas.drawRRect(bodyRRect, bodyPaint);

    // Body outline
    final Paint borderPaint = Paint()
      ..color = const Color(0xFF8C6D4F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(bodyRRect, borderPaint);

    // 3. Draw 4 color bands
    // Standard axial resistor spacing: bands 1, 2, 3 on left cluster;
    // band 4 (tolerance) on the right with a wider gap.
    final List<double> bandXPositions = <double>[
      bodyLeft + bodyWidth * 0.20,
      bodyLeft + bodyWidth * 0.36,
      bodyLeft + bodyWidth * 0.52,
      bodyLeft + bodyWidth * 0.80, // tolerance band
    ];
    final double bandWidth = (bodyWidth * 0.075).clamp(6.0, 14.0);

    // Clip bands inside body RRect so they don't poke out
    canvas.save();
    canvas.clipRRect(bodyRRect);

    for (int i = 0; i < 4; i++) {
      final ResistorBand band = bands[i];
      final double xCenter = bandXPositions[i];
      final Rect bandRect = Rect.fromCenter(
        center: Offset(xCenter, centerY),
        width: bandWidth,
        height: bodyHeight * 1.05,
      );

      final Paint bandPaint = Paint()
        ..color = Color(band.argb)
        ..style = PaintingStyle.fill;

      canvas.drawRect(bandRect, bandPaint);

      // Contrast border for very light colors (white, gold, silver) or black
      if (band == ResistorBand.white ||
          band == ResistorBand.gold ||
          band == ResistorBand.silver ||
          band == ResistorBand.black) {
        final Paint bandStroke = Paint()
          ..color = Colors.black.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        canvas.drawRect(bandRect, bandStroke);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ResistorPainter oldDelegate) {
    if (oldDelegate.bands.length != bands.length) return true;
    for (int i = 0; i < bands.length; i++) {
      if (oldDelegate.bands[i] != bands[i]) return true;
    }
    return false;
  }
}

/// A container widget that hosts [ResistorPainter] with semantic accessibility label.
class ResistorVisual extends StatelessWidget {
  const ResistorVisual({
    super.key,
    required this.bands,
    this.height = 100,
    this.width = double.infinity,
  });

  final List<ResistorBand> bands;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final String bandSummary = bands.map((ResistorBand b) => b.labelId).join(', ');

    return Semantics(
      label: 'Resistor dengan 4 gelang warna: $bandSummary',
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          painter: ResistorPainter(bands: bands),
        ),
      ),
    );
  }
}
