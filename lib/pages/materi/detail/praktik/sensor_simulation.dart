import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Lab Virtual Sensor Level 3: HC-SR04, LDR, DHT11, dan MQ-135.
class SensorSimulation extends StatefulWidget {
  const SensorSimulation({super.key});

  @override
  State<SensorSimulation> createState() => _SensorSimulationState();
}

class _SensorSimulationState extends State<SensorSimulation>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final AnimationController _loopCtrl;

  double _distanceCm = 50.0; // 2 - 400 cm
  double _lightPercent = 60.0; // 0 - 100 %
  int _tempCelsius = 26; // 20 - 40 °C
  double _humidityPercent = 55.0; // 0 - 100 %
  double _gasPpm = 220.0; // 0 - 1000 ppm

  @override
  void initState() {
    super.initState();
    // ponytail: single ticker drives all 4 sensor animations; split only if independent speeds needed.
    _loopCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _loopCtrl.dispose();
    super.dispose();
  }

  static const List<String> _tabs = <String>['HC-SR04', 'LDR', 'DHT11', 'MQ-135'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTabSelector(),
          const SizedBox(height: AppSpacing.md),
          VoltCard(
            child: switch (_selectedIndex) {
              0 => _buildHcsr04(),
              1 => _buildLdr(),
              2 => _buildDht11(),
              _ => _buildMq135(),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List<Widget>.generate(_tabs.length, (int i) {
          final bool active = _selectedIndex == i;
          return Expanded(
            child: GestureDetector(
              key: Key('sensor_tab_${_tabs[i]}'),
              onTap: () => setState(() => _selectedIndex = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                alignment: Alignment.center,
                child: Text(
                  _tabs[i],
                  style: AppTypography.label.copyWith(
                    color: active ? AppColors.textOnPrimary : AppColors.textSecondary,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHcsr04() {
    final bool isDanger = _distanceCm < 20.0;
    final String statusText = isDanger
        ? 'Jarak: ${_distanceCm.round()} cm (Bahaya!)'
        : 'Jarak: ${_distanceCm.round()} cm (Aman)';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _header('Sensor Ultrasonik HC-SR04', isDanger ? 'LED ON' : 'STANDBY', isDanger),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Gelombang suara keluar dari Transmitter (T), memantul di objek, dan masuk ke Receiver (R).',
          style: AppTypography.bodyMuted,
        ),
        const SizedBox(height: AppSpacing.md),
        _canvasBox(
          color: AppColors.surface,
          child: AnimatedBuilder(
            animation: _loopCtrl,
            builder: (context, _) => CustomPaint(
              painter: _Hcsr04Painter(
                distanceCm: _distanceCm,
                wavePhase: _loopCtrl.value,
                isLedOn: isDanger,
              ),
              size: Size.infinite,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _controlPanel(
          title: 'Jarak Objek (2 cm - 400 cm)',
          trailing: '${_distanceCm.round()} cm',
          child: Slider(
            key: const Key('slider_hcsr04'),
            value: _distanceCm,
            min: 2.0,
            max: 400.0,
            activeColor: isDanger ? AppColors.success : AppColors.primary,
            onChanged: (double v) => setState(() => _distanceCm = v),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _outputPanel(
          mainText: statusText,
          subText: isDanger ? 'Jarak < 20 cm -> LED Indikator Hijau MENYALA' : 'Jarak >= 20 cm -> LED MATI',
          dotColor: isDanger ? AppColors.success : AppColors.borderStrong,
          glow: isDanger,
          badge: isDanger ? 'LED: ON' : 'LED: OFF',
        ),
      ],
    );
  }

  Widget _buildLdr() {
    final bool isDark = _lightPercent < 30.0;
    final String statusText = isDark ? 'Kondisi: Gelap -> Lampu ON' : 'Kondisi: Terang -> Lampu OFF';
    final Color bg = Color.lerp(AppColors.codeBackground, AppColors.accentLight, _lightPercent / 100.0)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _header('Sensor Cahaya LDR', isDark ? 'LAMPU ON' : 'LAMPU OFF', isDark),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Saat cahaya < 30%, resistansi LDR naik sehingga lampu menyala otomatis.',
          style: AppTypography.bodyMuted,
        ),
        const SizedBox(height: AppSpacing.md),
        _canvasBox(
          color: bg,
          child: CustomPaint(
            painter: _LdrPainter(lightPercent: _lightPercent, isLampOn: isDark),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _controlPanel(
          title: 'Intensitas Cahaya (0% - 100%)',
          trailing: '${_lightPercent.round()}%',
          child: Slider(
            key: const Key('slider_ldr'),
            value: _lightPercent,
            min: 0.0,
            max: 100.0,
            activeColor: AppColors.accent,
            onChanged: (double v) => setState(() => _lightPercent = v),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _outputPanel(
          mainText: statusText,
          subText: 'Intensitas: ${_lightPercent.round()}% (Ambang gelap < 30%)',
          dotColor: isDark ? AppColors.accent : AppColors.borderStrong,
          glow: isDark,
          badge: isDark ? 'GLOW: ON' : 'GLOW: OFF',
        ),
      ],
    );
  }

  Widget _buildDht11() {
    final bool isHot = _tempCelsius > 30;
    final String statusText =
        'Suhu: $_tempCelsius°C | Kelembapan: ${_humidityPercent.round()}%';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _header('Sensor Suhu & Kelembapan DHT11', isHot ? 'KIPAS ON' : 'KIPAS OFF', isHot),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Mengukur suhu & kelembapan udara. Jika suhu > 30°C, kipas pendingin menyala.',
          style: AppTypography.bodyMuted,
        ),
        const SizedBox(height: AppSpacing.md),
        _canvasBox(
          color: AppColors.surface,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: _tempCelsius.toDouble()),
            duration: const Duration(milliseconds: 260),
            builder: (context, animTemp, _) => AnimatedBuilder(
              animation: _loopCtrl,
              builder: (context, _) => CustomPaint(
                painter: _Dht11Painter(
                  temperature: animTemp,
                  humidity: _humidityPercent,
                  fanPhase: isHot ? _loopCtrl.value : 0.0,
                  isFanOn: isHot,
                ),
                size: Size.infinite,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _controlPanel(
          title: 'Suhu (20°C - 40°C) & Kelembapan (0% - 100%)',
          trailing: '$_tempCelsius°C / ${_humidityPercent.round()}%',
          child: Column(
            children: <Widget>[
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton.filledTonal(
                    key: const Key('btn_temp_minus'),
                    onPressed: _tempCelsius > 20 ? () => setState(() => _tempCelsius--) : null,
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    '$_tempCelsius°C',
                    style: AppTypography.title.copyWith(
                      fontFamily: 'monospace',
                      color: isHot ? AppColors.error : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  IconButton.filledTonal(
                    key: const Key('btn_temp_plus'),
                    onPressed: _tempCelsius < 40 ? () => setState(() => _tempCelsius++) : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Slider(
                key: const Key('slider_dht11_humidity'),
                value: _humidityPercent,
                min: 0.0,
                max: 100.0,
                activeColor: AppColors.primary,
                onChanged: (double v) => setState(() => _humidityPercent = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _outputPanel(
          mainText: statusText,
          subText: isHot ? 'Suhu > 30°C -> Kipas Pendingin AKTIF' : 'Suhu <= 30°C -> Kipas MATI',
          dotColor: isHot ? AppColors.error : AppColors.primary,
          glow: isHot,
          badge: isHot ? 'KIPAS: ON' : 'KIPAS: OFF',
        ),
      ],
    );
  }

  Widget _buildMq135() {
    final bool isBadAir = _gasPpm > 500.0;
    final String statusText = isBadAir ? 'Kualitas Udara: BURUK' : 'Kualitas Udara: BAIK';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _header('Sensor Kualitas Udara MQ-135', isBadAir ? 'BAHAYA' : 'AMAN', isBadAir),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Mendeteksi gas berbahaya & asap. Jika level > 500 ppm, LED Peringatan Merah berkedip.',
          style: AppTypography.bodyMuted,
        ),
        const SizedBox(height: AppSpacing.md),
        _canvasBox(
          color: AppColors.surface,
          child: AnimatedBuilder(
            animation: _loopCtrl,
            builder: (context, _) {
              final bool blinkOn = isBadAir && (_loopCtrl.value < 0.5);
              return CustomPaint(
                painter: _Mq135Painter(
                  gasPpm: _gasPpm,
                  phase: _loopCtrl.value,
                  isBlinkOn: blinkOn,
                  isAlert: isBadAir,
                ),
                size: Size.infinite,
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _controlPanel(
          title: 'Level Gas (0 - 1000 ppm)',
          trailing: '${_gasPpm.round()} ppm',
          child: Slider(
            key: const Key('slider_mq135'),
            value: _gasPpm,
            min: 0.0,
            max: 1000.0,
            activeColor: isBadAir ? AppColors.error : AppColors.primary,
            onChanged: (double v) => setState(() => _gasPpm = v),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AnimatedBuilder(
          animation: _loopCtrl,
          builder: (context, _) {
            final bool blinkOn = isBadAir && (_loopCtrl.value < 0.5);
            return _outputPanel(
              mainText: statusText,
              subText: 'Level Gas: ${_gasPpm.round()} ppm (Ambang > 500 ppm)',
              dotColor: blinkOn ? AppColors.error : (isBadAir ? AppColors.errorLight : AppColors.success),
              glow: blinkOn,
              badge: isBadAir ? 'LED: BLINK' : 'LED: AMAN',
            );
          },
        ),
      ],
    );
  }

  Widget _header(String title, String chipLabel, bool active) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(title, style: AppTypography.title)),
        VoltChip(
          label: chipLabel,
          status: active ? VoltChipStatus.done : VoltChipStatus.active,
        ),
      ],
    );
  }

  Widget _canvasBox({required Color color, required Widget child}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: child,
      ),
    );
  }

  Widget _controlPanel({
    required String title,
    required String trailing,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.label.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                trailing,
                style: AppTypography.label.copyWith(
                  fontFamily: 'monospace',
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }

  Widget _outputPanel({
    required String mainText,
    required String subText,
    required Color dotColor,
    required bool glow,
    required String badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.codeBackground,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dotColor,
              boxShadow: glow
                  ? <BoxShadow>[
                      BoxShadow(
                        color: dotColor.withValues(alpha: 0.8),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  mainText,
                  style: AppTypography.body.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: AppColors.textOnPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subText,
                  style: AppTypography.caption.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.border,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Text(
              badge,
              style: AppTypography.overline.copyWith(
                fontFamily: 'monospace',
                color: AppColors.textOnPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _paintSensorLabel(Canvas canvas, String text, Offset center, Color color) {
  final TextPainter tp = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
}

class _Hcsr04Painter extends CustomPainter {
  _Hcsr04Painter({
    required this.distanceCm,
    required this.wavePhase,
    required this.isLedOn,
  });

  final double distanceCm;
  final double wavePhase;
  final bool isLedOn;

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height * 0.52;
    const double sensorX = 50.0;

    final Rect pcb = Rect.fromCenter(center: Offset(sensorX, cy), width: 34, height: 110);
    canvas.drawRRect(RRect.fromRectAndRadius(pcb, const Radius.circular(6)), Paint()..color = AppColors.circuitBoard);

    final Offset txCenter = Offset(sensorX + 10, cy - 26);
    final Offset rxCenter = Offset(sensorX + 10, cy + 26);
    _drawEye(canvas, txCenter, 'T');
    _drawEye(canvas, rxCenter, 'R');

    final double minObjX = sensorX + 52;
    final double maxObjX = size.width - 52;
    final double normDist = ((distanceCm - 2.0) / 398.0).clamp(0.0, 1.0);
    final double objX = minObjX + normDist * (maxObjX - minObjX);

    final double span = (objX - 18) - (sensorX + 24);
    for (int i = 0; i < 3; i++) {
      final double p = (wavePhase + i / 3.0) % 1.0;
      final double outX = (sensorX + 24) + p * span;
      final double alpha = (1.0 - p * 0.6).clamp(0.15, 0.9);
      canvas.drawArc(
        Rect.fromCircle(center: Offset(outX - 10, txCenter.dy), radius: 13 + p * 12),
        -math.pi / 3,
        2 * math.pi / 3,
        false,
        Paint()
          ..color = AppColors.primary.withValues(alpha: alpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );

      final double retX = (objX - 18) - p * span;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(retX + 10, rxCenter.dy), radius: 13 + p * 12),
        2 * math.pi / 3,
        2 * math.pi / 3,
        false,
        Paint()
          ..color = AppColors.accent.withValues(alpha: alpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );
    }

    final Rect objRect = Rect.fromCenter(center: Offset(objX, cy), width: 34, height: 84);
    canvas.drawRRect(RRect.fromRectAndRadius(objRect, const Radius.circular(6)), Paint()..color = AppColors.circuitMetal);
    _paintSensorLabel(canvas, 'OBJEK', objRect.center, AppColors.textPrimary);

    final Offset ledCenter = Offset(size.width - 38, 26);
    if (isLedOn) {
      canvas.drawCircle(
        ledCenter,
        15,
        Paint()
          ..color = AppColors.success.withValues(alpha: 0.45)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
      );
    }
    canvas.drawCircle(ledCenter, 8, Paint()..color = isLedOn ? AppColors.success : AppColors.ledOff);
  }

  void _drawEye(Canvas canvas, Offset center, String label) {
    canvas.drawCircle(center, 15, Paint()..color = AppColors.circuitMetalLight);
    canvas.drawCircle(center, 11, Paint()..color = AppColors.circuitPinHeader);
    _paintSensorLabel(canvas, label, center, AppColors.textOnPrimary);
  }

  @override
  bool shouldRepaint(covariant _Hcsr04Painter old) =>
      old.distanceCm != distanceCm || old.wavePhase != wavePhase || old.isLedOn != isLedOn;
}

class _LdrPainter extends CustomPainter {
  _LdrPainter({required this.lightPercent, required this.isLampOn});

  final double lightPercent;
  final bool isLampOn;

  @override
  void paint(Canvas canvas, Size size) {
    final double norm = (lightPercent / 100.0).clamp(0.0, 1.0);
    final Color fg = norm < 0.45 ? AppColors.textOnPrimary : AppColors.textPrimary;

    final Offset sun = Offset(size.width * 0.22, size.height * 0.44);
    final double r = 11.0 + norm * 16.0;
    canvas.drawCircle(sun, r, Paint()..color = Color.lerp(AppColors.circuitPin, AppColors.accent, norm)!);
    for (int i = 0; i < 8; i++) {
      final double a = i * math.pi / 4;
      canvas.drawLine(
        Offset(sun.dx + math.cos(a) * (r + 4), sun.dy + math.sin(a) * (r + 4)),
        Offset(sun.dx + math.cos(a) * (r + 6 + 7 * norm), sun.dy + math.sin(a) * (r + 6 + 7 * norm)),
        Paint()..color = AppColors.accent..strokeWidth = 2.0,
      );
    }

    final Offset ldr = Offset(size.width * 0.52, size.height * 0.52);
    canvas.drawCircle(ldr, 26, Paint()..color = AppColors.surface);
    canvas.drawCircle(ldr, 26, Paint()..color = AppColors.error..style = PaintingStyle.stroke..strokeWidth = 2.8);
    final Path zig = Path()..moveTo(ldr.dx - 14, ldr.dy - 10);
    for (int i = 0; i < 5; i++) {
      zig.lineTo(i.isEven ? ldr.dx + 12 : ldr.dx - 12, ldr.dy - 8 + i * 4.5);
    }
    canvas.drawPath(zig, Paint()..color = AppColors.error..style = PaintingStyle.stroke..strokeWidth = 2.0);
    _paintSensorLabel(canvas, 'LDR', Offset(ldr.dx, ldr.dy + 38), fg);

    final Offset lamp = Offset(size.width * 0.82, size.height * 0.50);
    if (isLampOn) {
      canvas.drawCircle(
        lamp,
        32,
        Paint()..color = AppColors.accent.withValues(alpha: 0.65)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
      );
    }
    canvas.drawCircle(lamp, 16, Paint()..color = isLampOn ? AppColors.circuitLedAmber : AppColors.ledOff);
    _paintSensorLabel(canvas, isLampOn ? 'LAMPU ON' : 'LAMPU OFF', Offset(lamp.dx, lamp.dy + 36), fg);
  }

  @override
  bool shouldRepaint(covariant _LdrPainter old) =>
      old.lightPercent != lightPercent || old.isLampOn != isLampOn;
}

class _Dht11Painter extends CustomPainter {
  _Dht11Painter({
    required this.temperature,
    required this.humidity,
    required this.fanPhase,
    required this.isFanOn,
  });

  final double temperature;
  final double humidity;
  final double fanPhase;
  final bool isFanOn;

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height * 0.48;

    // 1. Modul Sensor DHT11
    final Rect dht = Rect.fromCenter(center: Offset(size.width * 0.22, cy), width: 54, height: 70);
    canvas.drawRRect(RRect.fromRectAndRadius(dht, const Radius.circular(8)), Paint()..color = AppColors.primary);
    for (int r = 1; r <= 4; r++) {
      final double y = dht.top + r * 12;
      canvas.drawLine(
        Offset(dht.left + 8, y),
        Offset(dht.right - 8, y),
        Paint()..color = AppColors.primaryDark..strokeWidth = 1.5,
      );
    }
    _paintSensorLabel(canvas, 'DHT11', Offset(dht.center.dx, dht.bottom + 14), AppColors.textPrimary);

    // 2. Termometer (Air raksa naik/turun & warna Biru ke Merah)
    final double normTemp = ((temperature - 20.0) / 20.0).clamp(0.0, 1.0);
    final Color mercury = Color.lerp(AppColors.primary, AppColors.error, normTemp)!;
    final Offset therm = Offset(size.width * 0.50, cy - 6);
    final Rect tube = Rect.fromCenter(center: therm, width: 16, height: 92);
    canvas.drawRRect(RRect.fromRectAndRadius(tube, const Radius.circular(8)), Paint()..color = AppColors.background);
    canvas.drawRRect(
      RRect.fromRectAndRadius(tube, const Radius.circular(8)),
      Paint()..color = AppColors.borderStrong..style = PaintingStyle.stroke..strokeWidth = 1.8,
    );

    final double fillH = 14.0 + normTemp * 70.0;
    final Rect fill = Rect.fromLTWH(tube.left + 3, tube.bottom - fillH, tube.width - 6, fillH);
    canvas.drawRRect(RRect.fromRectAndRadius(fill, const Radius.circular(5)), Paint()..color = mercury);
    canvas.drawCircle(Offset(therm.dx, tube.bottom + 4), 12, Paint()..color = mercury);

    // 3. Kipas Berputar
    final Offset fan = Offset(size.width * 0.78, cy);
    canvas.drawCircle(fan, 34, Paint()..color = isFanOn ? AppColors.primaryLight : AppColors.background);
    canvas.drawCircle(
      fan,
      34,
      Paint()..color = isFanOn ? AppColors.primary : AppColors.borderStrong..style = PaintingStyle.stroke..strokeWidth = 1.8,
    );
    canvas.save();
    canvas.translate(fan.dx, fan.dy);
    canvas.rotate(fanPhase * 2 * math.pi);
    final Paint blade = Paint()..color = isFanOn ? AppColors.primaryDark : AppColors.circuitMetal;
    for (int i = 0; i < 4; i++) {
      canvas.rotate(math.pi / 2);
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(-4.5, -26, 9, 20), const Radius.circular(4)),
        blade,
      );
    }
    canvas.restore();
    canvas.drawCircle(fan, 6, Paint()..color = AppColors.circuitPinHeader);
    _paintSensorLabel(canvas, isFanOn ? 'KIPAS ON' : 'KIPAS OFF', Offset(fan.dx, fan.dy + 46), AppColors.textPrimary);
  }

  @override
  bool shouldRepaint(covariant _Dht11Painter old) =>
      old.temperature != temperature ||
      old.humidity != humidity ||
      old.fanPhase != fanPhase ||
      old.isFanOn != isFanOn;
}

class _Mq135Painter extends CustomPainter {
  _Mq135Painter({
    required this.gasPpm,
    required this.phase,
    required this.isBlinkOn,
    required this.isAlert,
  });

  final double gasPpm;
  final double phase;
  final bool isBlinkOn;
  final bool isAlert;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset sensor = Offset(size.width * 0.34, size.height * 0.54);

    // 1. Partikel asap abu-abu beterbangan
    final int count = (gasPpm / 45.0).round().clamp(2, 22);
    for (int i = 0; i < count; i++) {
      final double progress = (phase + (i * 0.37) % 1.0) % 1.0;
      final double px = size.width * 0.16 + ((i * 29) % (size.width * 0.50)) + math.sin((progress + i) * 2 * math.pi) * 8;
      final double py = (size.height - 20) - progress * (size.height - 44);
      canvas.drawCircle(
        Offset(px, py),
        4.0 + (i % 4) * 2.2,
        Paint()..color = AppColors.circuitPin.withValues(alpha: (1.0 - progress) * 0.45),
      );
    }

    // 2. Sensor MQ-135
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(sensor.dx, sensor.dy + 24), width: 64, height: 20),
        const Radius.circular(4),
      ),
      Paint()..color = AppColors.error,
    );
    canvas.drawCircle(sensor, 28, Paint()..color = AppColors.circuitMetalLight);
    canvas.drawCircle(sensor, 21, Paint()..color = AppColors.circuitPin);
    _paintSensorLabel(canvas, 'MQ-135', Offset(sensor.dx, sensor.dy + 46), AppColors.textPrimary);

    // 3. LED Peringatan Merah Berkedip
    final Offset led = Offset(size.width * 0.76, size.height * 0.50);
    if (isBlinkOn) {
      canvas.drawCircle(
        led,
        26,
        Paint()..color = AppColors.error.withValues(alpha: 0.55)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
      );
    }
    canvas.drawCircle(
      led,
      15,
      Paint()..color = isAlert ? (isBlinkOn ? AppColors.error : AppColors.circuitResetDark) : AppColors.ledOff,
    );
    _paintSensorLabel(canvas, isAlert ? 'ALARM BLINK' : 'STANDBY', Offset(led.dx, led.dy + 32), AppColors.textPrimary);
  }

  @override
  bool shouldRepaint(covariant _Mq135Painter old) =>
      old.gasPpm != gasPpm || old.phase != phase || old.isBlinkOn != isBlinkOn || old.isAlert != isAlert;
}
