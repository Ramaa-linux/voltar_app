import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Praktik interaktif: Animasi Rangkaian Tertutup & Simulasi Hukum Ohm (V = I x R).
class OhmLawAnimation extends StatefulWidget {
  const OhmLawAnimation({super.key});

  @override
  State<OhmLawAnimation> createState() => _OhmLawAnimationState();
}

class _OhmLawAnimationState extends State<OhmLawAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _isClosed = true;
  double _voltage = 9.0; // Volt (3.0 - 12.0)
  double _resistance = 220.0; // Ohm (100 - 1000)

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _calculateDuration(),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Menghitung kuat arus I = V / R dalam Ampere.
  double get _currentAmpere => _isClosed ? (_voltage / _resistance) : 0.0;

  /// Kuat arus dalam miliAmpere (mA).
  double get _currentMilliAmpere => _currentAmpere * 1000.0;

  /// Durasi animasi berbanding terbalik dengan arus (arus besar = partikel cepat).
  Duration _calculateDuration() {
    if (!_isClosed || _currentMilliAmpere <= 0.0) {
      return const Duration(seconds: 10);
    }
    // Arus 120 mA -> ~1.0s, Arus 10 mA -> ~5.5s
    final clampedMa = _currentMilliAmpere.clamp(5.0, 150.0);
    final ms = (55000.0 / clampedMa).clamp(800.0, 6000.0).round();
    return Duration(milliseconds: ms);
  }

  void _updateSpeed() {
    if (!_isClosed) {
      _controller.stop();
    } else {
      _controller.duration = _calculateDuration();
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    }
  }

  void _toggleSwitch() {
    setState(() {
      _isClosed = !_isClosed;
      _updateSpeed();
    });
  }

  void _onVoltageChanged(double value) {
    setState(() {
      _voltage = value;
      _updateSpeed();
    });
  }

  void _onResistanceChanged(double value) {
    setState(() {
      _resistance = value;
      _updateSpeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double currentMa = _currentMilliAmpere;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Simulasi Rangkaian Tertutup & Hukum Ohm',
                  style: AppTypography.title,
                ),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  'Amati aliran arus listrik pada rangkaian tertutup dari kutub (+) baterai, melewati hambatan dan beban, kembali ke kutub (-).',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.lg),
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(
                      color: const Color(0xFF334155),
                      width: 2,
                    ),
                    boxShadow: AppShadows.card,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.card - 2),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _CircuitLoopPainter(
                            animationProgress: _controller.value,
                            isClosed: _isClosed,
                            voltage: _voltage,
                            resistance: _resistance,
                            currentMa: currentMa,
                          ),
                          child: const SizedBox.expand(),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: _isClosed
                        ? AppColors.primaryLight
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(
                      color: _isClosed ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        _isClosed ? Icons.check_circle : Icons.power_off,
                        color: _isClosed
                            ? AppColors.primaryDark
                            : AppColors.textTertiary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          _isClosed
                              ? 'RANGKAIAN TERTUTUP: Arus Mengalir (${currentMa.toStringAsFixed(1)} mA)'
                              : 'RANGKAIAN TERBUKA: Arus Terputus (0.0 mA)',
                          style: AppTypography.label.copyWith(
                            color: _isClosed
                                ? AppColors.primaryDark
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                VoltButton(
                  label: _isClosed ? 'Buka Saklar (OFF)' : 'Tutup Saklar (ON)',
                  fullWidth: true,
                  variant: _isClosed
                      ? VoltButtonVariant.secondary
                      : VoltButtonVariant.primary,
                  onPressed: _toggleSwitch,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildParameterCard(currentMa),
          const SizedBox(height: AppSpacing.lg),
          _buildConceptCard(),
        ],
      ),
    );
  }

  Widget _buildParameterCard(double currentMa) {
    return VoltCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Pengaturan Parameter', style: AppTypography.title),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Ubah nilai tegangan atau hambatan untuk melihat pengaruhnya terhadap laju partikel dan terangnya lampu.',
            style: AppTypography.bodyMuted,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Tegangan (V)', style: AppTypography.body),
              Text(
                '${_voltage.toStringAsFixed(1)} V',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          Slider(
            value: _voltage,
            min: 3.0,
            max: 12.0,
            divisions: 18,
            label: '${_voltage.toStringAsFixed(1)} V',
            activeColor: AppColors.primary,
            inactiveColor: AppColors.border,
            onChanged: _onVoltageChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Hambatan (R)', style: AppTypography.body),
              Text(
                '${_resistance.round()} Ω',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          Slider(
            value: _resistance,
            min: 100.0,
            max: 1000.0,
            divisions: 18,
            label: '${_resistance.round()} Ω',
            activeColor: AppColors.accent,
            inactiveColor: AppColors.border,
            onChanged: _onResistanceChanged,
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Row(
              children: <Widget>[
                Expanded(child: _buildFormulaItem('Tegangan (V)', '${_voltage.toStringAsFixed(1)}V', AppColors.primaryLight)),
                const Text('÷', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
                Expanded(child: _buildFormulaItem('Hambatan (R)', '${_resistance.round()}Ω', AppColors.accentLight)),
                const Text('=', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
                Expanded(child: _buildFormulaItem('Arus (I)', '${currentMa.toStringAsFixed(1)}mA', const Color(0xFF38BDF8))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaItem(String label, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildConceptCard() {
    return const VoltCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Konsep Rangkaian Tertutup & Hukum Ohm', style: AppTypography.title),
          SizedBox(height: AppSpacing.xs),
          Text(
            '1. Rangkaian Tertutup (Closed Circuit):\n'
            '   Arus hanya mengalir bila ada lintasan konduktor tertutup dari kutub (+) baterai menuju beban dan kembali ke kutub (-).\n\n'
            '2. Hambatan Resistor (R):\n'
            '   Resistor membatasi laju partikel muatan. Semakin tinggi hambatan, semakin lambat aliran arus.\n\n'
            '3. Daya Terang Lampu:\n'
            '   Kuat arus (I = V / R) menentukan terang bohlam. Arus besar membuat lampu menyala lebih terang.',
            style: AppTypography.body,
          ),
        ],
      ),
    );
  }
}


/// CustomPainter untuk menggambar Rangkaian Tertutup (Loop), Baterai, Resistor,
/// Lampu/LED, Saklar, dan partikel muatan yang mengalir dinamis.
class _CircuitLoopPainter extends CustomPainter {
  _CircuitLoopPainter({
    required this.animationProgress,
    required this.isClosed,
    required this.voltage,
    required this.resistance,
    required this.currentMa,
  });

  final double animationProgress;
  final bool isClosed;
  final double voltage;
  final double resistance;
  final double currentMa;

  static const int _particleCount = 18;

  @override
  void paint(Canvas canvas, Size size) {
    final double left = 46.0;
    final double right = size.width - 46.0;
    final double top = 42.0;
    final double bottom = size.height - 42.0;
    final double xMid = (left + right) / 2;
    final double yMid = (top + bottom) / 2;
    const double radius = 16.0;

    // 1. Jalur Kabel Persegi Panjang (Closed Loop)
    _drawWireTrack(canvas, left, right, top, bottom, radius);

    // 2. Baterai di Sisi Kiri
    _drawBattery(canvas, left, yMid);

    // 3. Resistor di Bagian Atas Tengah
    _drawResistor(canvas, xMid, top);

    // 4. Lampu / LED di Sisi Kanan
    _drawLamp(canvas, right, yMid);

    // 5. Saklar di Bagian Bawah Tengah
    _drawSwitch(canvas, xMid, bottom);

    // 6. Partikel yang Mengalir Mengelilingi Loop
    if (isClosed && currentMa > 0.0) {
      _drawParticles(canvas, left, right, top, bottom, xMid, yMid, radius);
    }
  }

  void _drawWireTrack(
    Canvas canvas,
    double left,
    double right,
    double top,
    double bottom,
    double r,
  ) {
    final Path path = Path();
    path.moveTo(left, top + r);
    path.arcToPoint(Offset(left + r, top), radius: Radius.circular(r));
    path.lineTo(right - r, top);
    path.arcToPoint(Offset(right, top + r), radius: Radius.circular(r));
    path.lineTo(right, bottom - r);
    path.arcToPoint(Offset(right - r, bottom), radius: Radius.circular(r));
    path.lineTo(left + r, bottom);
    path.arcToPoint(Offset(left, bottom - r), radius: Radius.circular(r));
    path.close();

    final Paint trackPaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawPath(path, trackPaint);

    if (isClosed) {
      final Paint activePaint = Paint()
        ..color = const Color(0xFF0284C7).withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawPath(path, activePaint);
    }
  }

  void _drawBattery(Canvas canvas, double left, double yMid) {
    const double bodyWidth = 24.0;
    const double bodyHeight = 52.0;

    final Rect clearRect = Rect.fromCenter(
      center: Offset(left, yMid),
      width: bodyWidth + 6,
      height: bodyHeight + 10,
    );
    canvas.drawRect(clearRect, Paint()..color = const Color(0xFF0F172A));

    final Rect posNub = Rect.fromCenter(
      center: Offset(left, yMid - (bodyHeight / 2) - 3),
      width: 10,
      height: 6,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(posNub, const Radius.circular(2)),
      Paint()..color = const Color(0xFFEF4444),
    );

    final Rect bodyRect = Rect.fromCenter(
      center: Offset(left, yMid),
      width: bodyWidth,
      height: bodyHeight,
    );
    final RRect bodyRRect = RRect.fromRectAndRadius(bodyRect, const Radius.circular(4));

    final Paint bodyPaint = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[Color(0xFF065A4E), Color(0xFF0E9F8A), Color(0xFF047857)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(bodyRect);
    canvas.drawRRect(bodyRRect, bodyPaint);

    final Paint borderPaint = Paint()
      ..color = const Color(0xFF2DD4BF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(bodyRRect, borderPaint);

    _drawBadgeText(canvas, '+', Offset(left - 20, yMid - 18), const Color(0xFFEF4444));
    _drawBadgeText(canvas, '−', Offset(left - 20, yMid + 18), const Color(0xFF38BDF8));

    _drawCenterText(
      canvas,
      '${voltage.toStringAsFixed(1)}V',
      Offset(left, yMid),
      const TextStyle(
        color: Colors.white,
        fontSize: 9,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _drawResistor(Canvas canvas, double xMid, double top) {
    const double bodyWidth = 56.0;
    const double bodyHeight = 18.0;

    final Rect clearRect = Rect.fromCenter(
      center: Offset(xMid, top),
      width: bodyWidth + 8,
      height: bodyHeight + 6,
    );
    canvas.drawRect(clearRect, Paint()..color = const Color(0xFF0F172A));

    final Paint leadPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 2.5;
    canvas.drawLine(Offset(xMid - (bodyWidth / 2) - 6, top), Offset(xMid - (bodyWidth / 2), top), leadPaint);
    canvas.drawLine(Offset(xMid + (bodyWidth / 2), top), Offset(xMid + (bodyWidth / 2) + 6, top), leadPaint);

    final Rect bodyRect = Rect.fromCenter(
      center: Offset(xMid, top),
      width: bodyWidth,
      height: bodyHeight,
    );
    final RRect bodyRRect = RRect.fromRectAndRadius(bodyRect, const Radius.circular(6));
    canvas.drawRRect(bodyRRect, Paint()..color = const Color(0xFFD4B895));
    canvas.drawRRect(
      bodyRRect,
      Paint()
        ..color = const Color(0xFF8C7355)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    final List<Color> bands = <Color>[
      const Color(0xFFDC2626),
      const Color(0xFFDC2626),
      const Color(0xFFB45309),
      const Color(0xFFF59E0B),
    ];
    final double bandWidth = 4.0;
    final double startX = xMid - 16.0;
    for (int i = 0; i < bands.length; i++) {
      final double bx = startX + (i * 9.0);
      canvas.drawRect(
        Rect.fromLTWH(bx, top - (bodyHeight / 2), bandWidth, bodyHeight),
        Paint()..color = bands[i],
      );
    }

    _drawCenterText(
      canvas,
      '${resistance.round()} Ω',
      Offset(xMid, top - 18),
      const TextStyle(
        color: AppColors.accent,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _drawLamp(Canvas canvas, double right, double yMid) {
    const double bulbRadius = 18.0;

    canvas.drawCircle(
      Offset(right, yMid),
      bulbRadius + 4,
      Paint()..color = const Color(0xFF0F172A),
    );

    final double intensity = isClosed
        ? (currentMa / 50.0).clamp(0.2, 1.0)
        : 0.0;

    if (isClosed && intensity > 0.0) {
      final double glowRadius = bulbRadius * (1.5 + (intensity * 1.5));
      final Paint glowPaint = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            Color.fromRGBO(250, 204, 21, 0.7 * intensity),
            Color.fromRGBO(250, 204, 21, 0.25 * intensity),
            const Color(0x00FAC815),
          ],
        ).createShader(Rect.fromCircle(center: Offset(right, yMid), radius: glowRadius));
      canvas.drawCircle(Offset(right, yMid), glowRadius, glowPaint);
    }

    final Paint bulbPaint = Paint()
      ..color = isClosed
          ? Color.lerp(const Color(0xFF334155), const Color(0xFFFEF08A), intensity)!
          : const Color(0xFF1E293B);
    canvas.drawCircle(Offset(right, yMid), bulbRadius, bulbPaint);

    final Paint bulbOutline = Paint()
      ..color = isClosed
          ? Color.lerp(const Color(0xFF64748B), Colors.white, intensity)!
          : const Color(0xFF475569)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(Offset(right, yMid), bulbRadius, bulbOutline);

    final Paint filamentPaint = Paint()
      ..color = isClosed
          ? Color.lerp(const Color(0xFFF97316), Colors.white, intensity)!
          : const Color(0xFF64748B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isClosed ? 2.2 : 1.5;

    final Path filamentPath = Path();
    filamentPath.moveTo(right - 6, yMid + 8);
    filamentPath.lineTo(right - 3, yMid - 6);
    filamentPath.lineTo(right, yMid - 2);
    filamentPath.lineTo(right + 3, yMid - 6);
    filamentPath.lineTo(right + 6, yMid + 8);
    canvas.drawPath(filamentPath, filamentPaint);

    _drawCenterText(
      canvas,
      'Lampu',
      Offset(right, yMid + 28),
      TextStyle(
        color: isClosed ? const Color(0xFFFDE047) : const Color(0xFF94A3B8),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }

void _drawSwitch(Canvas canvas, double xMid, double bottom) {
    const double gap = 24.0;

    final Rect clearRect = Rect.fromCenter(
      center: Offset(xMid, bottom),
      width: gap + 16,
      height: 18,
    );
    canvas.drawRect(clearRect, Paint()..color = const Color(0xFF0F172A));

    final Paint contactPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(xMid - (gap / 2), bottom), 3.5, contactPaint);
    canvas.drawCircle(Offset(xMid + (gap / 2), bottom), 3.5, contactPaint);

    final Paint bladePaint = Paint()
      ..color = isClosed ? const Color(0xFF10B981) : const Color(0xFFEF4444)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    if (isClosed) {
      canvas.drawLine(
        Offset(xMid - (gap / 2), bottom),
        Offset(xMid + (gap / 2), bottom),
        bladePaint,
      );
    } else {
      canvas.drawLine(
        Offset(xMid - (gap / 2), bottom),
        Offset(xMid + (gap / 2) - 4, bottom - 14),
        bladePaint,
      );
    }

    _drawCenterText(
      canvas,
      isClosed ? 'Saklar ON' : 'Saklar OFF',
      Offset(xMid, bottom + 16),
      TextStyle(
        color: isClosed ? const Color(0xFF10B981) : const Color(0xFFEF4444),
        fontSize: 9,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _drawParticles(
    Canvas canvas,
    double left,
    double right,
    double top,
    double bottom,
    double xMid,
    double yMid,
    double r,
  ) {
    final Path loopPath = Path();

    loopPath.moveTo(left, yMid - 28);
    loopPath.lineTo(left, top + r);
    loopPath.arcToPoint(Offset(left + r, top), radius: Radius.circular(r));
    loopPath.lineTo(right - r, top);
    loopPath.arcToPoint(Offset(right, top + r), radius: Radius.circular(r));
    loopPath.lineTo(right, bottom - r);
    loopPath.arcToPoint(Offset(right - r, bottom), radius: Radius.circular(r));
    loopPath.lineTo(left + r, bottom);
    loopPath.arcToPoint(Offset(left, bottom - r), radius: Radius.circular(r));
    loopPath.lineTo(left, yMid + 28);
    loopPath.lineTo(left, yMid - 28);

    final metrics = loopPath.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;
    final double totalLength = metric.length;

    final double resMinX = xMid - 32.0;
    final double resMaxX = xMid + 32.0;

    for (int i = 0; i < _particleCount; i++) {
      final double basePhase = (animationProgress + (i / _particleCount)) % 1.0;
      final double distance = basePhase * totalLength;
      final tangent = metric.getTangentForOffset(distance);
      if (tangent == null) continue;

      Offset pos = tangent.position;

      final bool insideResistor =
          (pos.dy - top).abs() < 6.0 && pos.dx >= resMinX && pos.dx <= resMaxX;

      final Color particleColor;
      final double particleRadius;

      if (insideResistor) {
        final double jitter = math.sin((animationProgress * 30.0) + (i * 3.0)) * 2.5;
        pos = Offset(pos.dx, pos.dy + jitter);
        particleColor = const Color(0xFFF59E0B);
        particleRadius = 3.0;
      } else {
        particleColor = const Color(0xFF38BDF8);
        particleRadius = 4.0;
      }

      canvas.drawCircle(
        pos,
        particleRadius + 3.0,
        Paint()..color = particleColor.withValues(alpha: 0.35),
      );

      canvas.drawCircle(
        pos,
        particleRadius,
        Paint()..color = particleColor,
      );

      canvas.drawCircle(
        pos,
        particleRadius * 0.5,
        Paint()..color = Colors.white,
      );
    }
  }

  void _drawBadgeText(Canvas canvas, String text, Offset center, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawCenterText(Canvas canvas, String text, Offset center, TextStyle style) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _CircuitLoopPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.isClosed != isClosed ||
        oldDelegate.voltage != voltage ||
        oldDelegate.resistance != resistance ||
        oldDelegate.currentMa != currentMa;
  }
}

