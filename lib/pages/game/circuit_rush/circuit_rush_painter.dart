import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_config.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_engine.dart';
import 'package:voltar/theme/app_colors.dart';

class CircuitRushPainter extends CustomPainter {
  CircuitRushPainter({required this.engine}) : super(repaint: engine);

  final CircuitRushEngine engine;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    _drawPcbBackground(canvas, size);
    _drawObstacles(canvas, size);
    _drawPlayerTrail(canvas);
    _drawPlayerElectron(canvas);
    _drawBoardRails(canvas, size);
  }

  void _drawPcbBackground(Canvas canvas, Size size) {
    final Rect fullRect = Offset.zero & size;
    final Paint bgPaint = Paint()..color = AppColors.circuitBoardDark;
    canvas.drawRect(fullRect, bgPaint);

    final Paint gridPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.10)
      ..strokeWidth = 1.0;
    const double gridStep = 36.0;
    final double scrollOffset = (engine.elapsedTime * 40.0) % gridStep;

    for (double x = -scrollOffset; x < size.width; x += gridStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = gridStep; y < size.height; y += gridStep) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final Paint padPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.16)
      ..style = PaintingStyle.fill;
    for (double x = -scrollOffset + gridStep; x < size.width; x += gridStep * 2) {
      for (double y = gridStep * 2; y < size.height; y += gridStep * 3) {
        canvas.drawCircle(Offset(x, y), 2.2, padPaint);
      }
    }
  }

  void _drawObstacles(Canvas canvas, Size size) {
    const double width = CircuitRushConfig.obstacleWidth;
    for (final CircuitObstacle obs in engine.obstacles) {
      if (obs.x > size.width + 20 || obs.x + width < -20) continue;

      if (obs.topBottomY > 0) {
        _drawComponentPillar(
          canvas,
          Rect.fromLTWH(obs.x, 0, width, obs.topBottomY),
          obs.kind,
          isTop: true,
        );
      }
      final double bottomHeight = size.height - obs.bottomTopY;
      if (bottomHeight > 0) {
        _drawComponentPillar(
          canvas,
          Rect.fromLTWH(obs.x, obs.bottomTopY, width, bottomHeight),
          obs.kind,
          isTop: false,
        );
      }
      if (obs.hasCoin && !obs.coinCollected) {
        _drawVoltageCoin(canvas, Offset(obs.centerX, obs.gapCenterY));
      }
    }
  }

  void _drawComponentPillar(
    Canvas canvas,
    Rect rect,
    ObstacleKind kind, {
    required bool isTop,
  }) {
    final Paint leadPaint = Paint()
      ..color = AppColors.circuitMetalLight
      ..strokeWidth = 6.0;
    canvas.drawLine(
      Offset(rect.center.dx, rect.top),
      Offset(rect.center.dx, rect.bottom),
      leadPaint,
    );

    final RRect bodyRRect = RRect.fromRectAndRadius(
      rect.deflate(4.0),
      const Radius.circular(10),
    );
    final Paint bodyPaint = Paint()
      ..color = kind == ObstacleKind.resistor
          ? AppColors.surface
          : AppColors.primaryDark;
    canvas.drawRRect(bodyRRect, bodyPaint);

    final Paint bandPaint = Paint()..style = PaintingStyle.fill;
    final List<Color> bandColors = kind == ObstacleKind.resistor
        ? <Color>[AppColors.error, AppColors.accent, AppColors.primaryDark]
        : <Color>[AppColors.primaryLight, AppColors.accent];

    const double bandHeight = 8.0;
    const double bandGap = 18.0;
    final double startY = isTop ? rect.bottom - 28.0 : rect.top + 20.0;
    final double dir = isTop ? -1.0 : 1.0;

    canvas.save();
    canvas.clipRRect(bodyRRect);
    for (int i = 0; i < bandColors.length; i++) {
      final double y = startY + dir * i * bandGap;
      if (y >= rect.top + 8 && y + bandHeight <= rect.bottom - 8) {
        bandPaint.color = bandColors[i];
        canvas.drawRect(
          Rect.fromLTWH(rect.left + 4, y, rect.width - 8, bandHeight),
          bandPaint,
        );
      }
    }
    canvas.restore();

    final Paint borderPaint = Paint()
      ..color = AppColors.borderStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(bodyRRect, borderPaint);

    final double capY = isTop ? rect.bottom - 10.0 : rect.top;
    final RRect capRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect.left, capY, rect.width, 10.0),
      const Radius.circular(4),
    );
    final Paint capPaint = Paint()..color = AppColors.circuitMetal;
    canvas.drawRRect(capRRect, capPaint);
  }

  void _drawVoltageCoin(Canvas canvas, Offset center) {
    final double pulse = 1.0 + 0.12 * math.sin(engine.elapsedTime * 6.0);
    final double r = CircuitRushConfig.coinRadius * pulse;

    final Paint glowPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.30);
    canvas.drawCircle(center, r * 1.5, glowPaint);

    final Paint coinPaint = Paint()..color = AppColors.accent;
    canvas.drawCircle(center, r, coinPaint);

    final Paint corePaint = Paint()..color = AppColors.accentLight;
    canvas.drawCircle(center, r * 0.45, corePaint);
  }

  void _drawPlayerTrail(Canvas canvas) {
    final List<Offset> points = engine.trail;
    if (points.length < 2) return;

    final Paint trailPaint = Paint()..style = PaintingStyle.fill;
    for (int i = 1; i < points.length; i++) {
      final double t = 1.0 - (i / points.length);
      trailPaint.color = AppColors.accent.withValues(alpha: 0.45 * t);
      final double radius = CircuitRushConfig.playerRadius * 0.65 * t;
      canvas.drawCircle(points[i], radius, trailPaint);
    }
  }

  void _drawPlayerElectron(Canvas canvas) {
    final Offset center = Offset(engine.playerX, engine.playerY);
    const double r = CircuitRushConfig.playerRadius;

    final Paint outerGlow = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.32);
    canvas.drawCircle(center, r * 1.65, outerGlow);

    final Paint bodyPaint = Paint()..color = AppColors.accent;
    canvas.drawCircle(center, r, bodyPaint);

    final Paint corePaint = Paint()..color = AppColors.surface;
    canvas.drawCircle(center.translate(-r * 0.2, -r * 0.2), r * 0.45, corePaint);
  }

  void _drawBoardRails(Canvas canvas, Size size) {
    final Paint railPaint = Paint()
      ..color = AppColors.error.withValues(alpha: 0.75)
      ..strokeWidth = 4.0;
    canvas.drawLine(Offset.zero, Offset(size.width, 0), railPaint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), railPaint);
  }

  @override
  bool shouldRepaint(covariant CircuitRushPainter oldDelegate) =>
      oldDelegate.engine != engine;
}
