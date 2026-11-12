import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:voltar/pages/game/cable_connect/cable_models.dart';
import 'package:voltar/theme/app_colors.dart';

/// Painter papan sirkuit PCB (grid, tembok berarsir, terminal, dan komponen).
class CableBoardPainter extends CustomPainter {
  CableBoardPainter({
    required this.level,
    required this.visitedComponents,
    required this.isComplete,
  });

  final CableLevel level;
  final Set<Pos> visitedComponents;
  final bool isComplete;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final double cellW = size.width / level.width;
    final double cellH = size.height / level.height;

    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = AppColors.circuitBoardDark,
    );

    final Paint gridLine = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.12)
      ..strokeWidth = 1.0;
    for (int r = 0; r <= level.height; r++) {
      final double y = r * cellH;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridLine);
    }
    for (int c = 0; c <= level.width; c++) {
      final double x = c * cellW;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridLine);
    }

    for (final Pos wall in level.walls) {
      _drawWallCell(canvas, wall, cellW, cellH);
    }

    level.components.forEach((Pos pos, CellType type) {
      final bool isVisited = visitedComponents.contains(pos);
      if (type == CellType.resistor) {
        _drawResistor(canvas, pos, cellW, cellH, isVisited);
      } else if (type == CellType.led) {
        _drawLed(canvas, pos, cellW, cellH, isVisited);
      }
    });

    _drawTerminal(canvas, level.startPos, cellW, cellH, '+', AppColors.accent);
    _drawTerminal(
      canvas,
      level.endPos,
      cellW,
      cellH,
      '-',
      isComplete ? AppColors.circuitWire : AppColors.circuitMetal,
    );
  }

  void _drawWallCell(Canvas canvas, Pos pos, double cellW, double cellH) {
    final Rect rect = Rect.fromLTWH(
      pos.c * cellW + 1.5,
      pos.r * cellH + 1.5,
      cellW - 3.0,
      cellH - 3.0,
    );
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
    canvas.drawRRect(rrect, Paint()..color = AppColors.circuitChip);

    final Paint hatchPaint = Paint()
      ..color = AppColors.borderStrong.withValues(alpha: 0.22)
      ..strokeWidth = 1.5;

    canvas.save();
    canvas.clipRRect(rrect);
    for (double d = -rect.height; d < rect.width + rect.height; d += 8.0) {
      canvas.drawLine(
        Offset(rect.left + d, rect.top),
        Offset(rect.left + d + rect.height, rect.bottom),
        hatchPaint,
      );
    }
    canvas.restore();
  }

  void _drawTerminal(
    Canvas canvas,
    Pos pos,
    double cellW,
    double cellH,
    String label,
    Color color,
  ) {
    final Offset center = Offset((pos.c + 0.5) * cellW, (pos.r + 0.5) * cellH);
    final double radius = math.min(cellW, cellH) * 0.38;

    canvas.drawCircle(
      center,
      radius * 1.35,
      Paint()..color = color.withValues(alpha: 0.28),
    );
    canvas.drawCircle(center, radius, Paint()..color = color);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.surface
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: AppColors.surface,
          fontSize: radius * 1.25,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawResistor(
    Canvas canvas,
    Pos pos,
    double cellW,
    double cellH,
    bool isVisited,
  ) {
    final Offset center = Offset((pos.c + 0.5) * cellW, (pos.r + 0.5) * cellH);
    final double w = cellW * 0.72;
    final double h = cellH * 0.34;
    final Rect rect = Rect.fromCenter(center: center, width: w, height: h);

    canvas.drawLine(
      Offset(pos.c * cellW + 2, center.dy),
      Offset((pos.c + 1) * cellW - 2, center.dy),
      Paint()
        ..color =
            isVisited ? AppColors.circuitWire : AppColors.circuitMetalLight
        ..strokeWidth = 3.0,
    );

    final RRect body = RRect.fromRectAndRadius(rect, const Radius.circular(6));
    canvas.drawRRect(
      body,
      Paint()..color = isVisited ? AppColors.accentLight : AppColors.surface,
    );

    final List<Color> colors = <Color>[
      AppColors.error,
      AppColors.accent,
      AppColors.primaryDark,
    ];
    for (int i = 0; i < 3; i++) {
      final double bx = rect.left + (i + 1) * (w / 4) - 2;
      canvas.drawRect(
        Rect.fromLTWH(bx, rect.top, 4, h),
        Paint()..color = colors[i],
      );
    }

    canvas.drawRRect(
      body,
      Paint()
        ..color = isVisited ? AppColors.circuitWireDark : AppColors.borderStrong
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  void _drawLed(
    Canvas canvas,
    Pos pos,
    double cellW,
    double cellH,
    bool isVisited,
  ) {
    final Offset center = Offset((pos.c + 0.5) * cellW, (pos.r + 0.5) * cellH);
    final double radius = math.min(cellW, cellH) * 0.30;

    if (isVisited) {
      canvas.drawCircle(
        center,
        radius * 1.7,
        Paint()..color = AppColors.error.withValues(alpha: 0.38),
      );
    }
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = isVisited ? AppColors.ledOn : AppColors.ledOff,
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = isVisited ? AppColors.circuitLedRimOn : AppColors.circuitPin
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
    canvas.drawCircle(
      center.translate(-radius * 0.3, -radius * 0.3),
      radius * 0.3,
      Paint()..color = AppColors.surface.withValues(alpha: 0.7),
    );
  }

  @override
  bool shouldRepaint(covariant CableBoardPainter oldDelegate) =>
      oldDelegate.visitedComponents != visitedComponents ||
      oldDelegate.isComplete != isComplete ||
      oldDelegate.level != level;
}

/// Painter jalur kabel arus listrik yang ditarik pemain.
class CablePathPainter extends CustomPainter {
  CablePathPainter({
    required this.path,
    required this.gridWidth,
    required this.gridHeight,
    required this.isComplete,
    this.dragTipOffset,
    this.pulseProgress = 0.0,
  });

  final List<Pos> path;
  final int gridWidth;
  final int gridHeight;
  final bool isComplete;
  final Offset? dragTipOffset;
  final double pulseProgress;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || path.isEmpty) return;

    final double cellW = size.width / gridWidth;
    final double cellH = size.height / gridHeight;
    final double wireWidth = math.min(cellW, cellH) * 0.28;

    final List<Offset> points = <Offset>[
      for (final Pos p in path)
        Offset((p.c + 0.5) * cellW, (p.r + 0.5) * cellH),
    ];

    if (dragTipOffset != null) {
      points.add(dragTipOffset!);
    }

    if (points.length < 2) {
      // Hanya terminal awal - gambar kepala kabel aktif
      _drawHeadOrb(canvas, points.first, wireWidth * 1.2);
      return;
    }

    final Path wirePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      wirePath.lineTo(points[i].dx, points[i].dy);
    }

    // Glow kawat luar.
    final Paint glowPaint = Paint()
      ..color = (isComplete ? AppColors.accent : AppColors.circuitWire)
          .withValues(alpha: isComplete ? 0.45 : 0.25)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = wireWidth * 1.8;
    canvas.drawPath(wirePath, glowPaint);

    // Inti kawat tembaga/kabel hijau.
    final Paint corePaint = Paint()
      ..color = isComplete ? AppColors.accent : AppColors.circuitWire
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = wireWidth;
    canvas.drawPath(wirePath, corePaint);

    // Kilau terang di bagian tengah kawat.
    final Paint highlightPaint = Paint()
      ..color = AppColors.surface.withValues(alpha: isComplete ? 0.75 : 0.40)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = wireWidth * 0.35;
    canvas.drawPath(wirePath, highlightPaint);

    // Gambar kepala kawat (ujung aktif yang ditarik jari).
    _drawHeadOrb(canvas, points.last, wireWidth * 1.3);
  }

  void _drawHeadOrb(Canvas canvas, Offset center, double radius) {
    final Paint outer = Paint()
      ..color = (isComplete ? AppColors.accent : AppColors.circuitWire)
          .withValues(alpha: 0.40);
    canvas.drawCircle(center, radius * 1.6, outer);

    final Paint body = Paint()
      ..color = isComplete ? AppColors.accent : AppColors.circuitWire;
    canvas.drawCircle(center, radius, body);

    final Paint core = Paint()..color = AppColors.surface;
    canvas.drawCircle(center, radius * 0.45, core);
  }

  @override
  bool shouldRepaint(covariant CablePathPainter oldDelegate) =>
      oldDelegate.path != path ||
      oldDelegate.isComplete != isComplete ||
      oldDelegate.dragTipOffset != dragTipOffset ||
      oldDelegate.pulseProgress != pulseProgress;
}

