import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Simulasi Relay Level 2: Active LOW logic & NO/NC mechanical switch.
class RelaySimulation extends StatefulWidget {
  const RelaySimulation({super.key});

  @override
  State<RelaySimulation> createState() => _RelaySimulationState();
}

class _RelaySimulationState extends State<RelaySimulation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  bool _isPinLow = false; // Active LOW: LOW = Relay ON

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _togglePin() {
    setState(() {
      _isPinLow = !_isPinLow;
      if (_isPinLow) {
        _ctrl.forward();
      } else {
        _ctrl.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isRelayOn = _isPinLow;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text('Simulasi Modul Relay 5V', style: AppTypography.title),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    VoltChip(
                      label: isRelayOn ? 'ON' : 'OFF',
                      status: isRelayOn ? VoltChipStatus.done : VoltChipStatus.locked,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  'Logika Active LOW: Beri sinyal LOW (0V) di Pin D7 untuk mengalirkan arus ke koil relay.',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xFF161A23),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    child: AnimatedBuilder(
                      animation: _anim,
                      builder: (context, _) => CustomPaint(
                        painter: _RelayPainter(isPinLow: _isPinLow, progress: _anim.value),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildStatusRow(isRelayOn),
                const SizedBox(height: AppSpacing.md),
                VoltButton(
                  label: _isPinLow
                      ? 'Pin 7 HIGH (OFF)'
                      : 'Pin 7 LOW (ON)',
                  variant: _isPinLow ? VoltButtonVariant.secondary : VoltButtonVariant.primary,
                  fullWidth: true,
                  onPressed: _togglePin,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const _RelayInfoCard(),
        ],
      ),
    );
  }

  Widget _buildStatusRow(bool isRelayOn) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _col('Pin D7', _isPinLow ? 'LOW (0V)' : 'HIGH (5V)', _isPinLow ? AppColors.success : AppColors.error),
          _col('Koil', isRelayOn ? 'AKTIF' : 'MATI', isRelayOn ? AppColors.accent : AppColors.textSecondary),
          _col('Kontak', isRelayOn ? 'COM - NO' : 'COM - NC', isRelayOn ? AppColors.primary : AppColors.textPrimary),
          _col('Beban', isRelayOn ? 'MENYALA' : 'MATI', isRelayOn ? const Color(0xFFFFB300) : AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _col(String k, String v, Color c) => Expanded(
        child: Column(
          children: <Widget>[
            Text(k, style: AppTypography.caption.copyWith(color: AppColors.textTertiary, fontSize: 10), maxLines: 1),
            const SizedBox(height: 2),
            Text(v, style: AppTypography.caption.copyWith(color: c, fontWeight: FontWeight.bold, fontSize: 11), maxLines: 1),
          ],
        ),
      );
}
class _RelayInfoCard extends StatelessWidget {
  const _RelayInfoCard();

  @override
  Widget build(BuildContext context) {
    return const VoltCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Prinsip Active LOW', style: AppTypography.title),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Modul relay Arduino umumnya memakai transistor driver PNP/optocoupler. Memberi logika LOW (0V) menyedot arus (current sinking) dari 5V ke pin mikro, mengaktifkan transistor dan memberi daya ke koil.',
            style: AppTypography.body,
          ),
          SizedBox(height: AppSpacing.md),
          Text('Terminal Kontak Saklar:', style: AppTypography.title),
          SizedBox(height: AppSpacing.xs),
          Text('• COM (Common): Jalur masukan utama catu daya beban.', style: AppTypography.body),
          Text('• NC (Normally Closed): Kontak tersambung ke COM saat koil mati.', style: AppTypography.body),
          Text('• NO (Normally Open): Kontak tersambung ke COM saat koil aktif.', style: AppTypography.body),
        ],
      ),
    );
  }
}

class _RelayPainter extends CustomPainter {
  _RelayPainter({required this.isPinLow, required this.progress});

  final bool isPinLow;
  final double progress; // 0.0 = touches NC, 1.0 = touches NO

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final ardRect = Rect.fromLTWH(8, 20, math.max(64.0, w * 0.20), h - 40);
    final relayRect = Rect.fromLTWH(w * 0.28, 22, w * 0.40, h - 44);
    final loadCenter = Offset(w * 0.86, h * 0.45);

    _drawArduino(canvas, ardRect);
    _drawRelay(canvas, relayRect);
    _drawWires(canvas, ardRect, relayRect);
    _drawLoad(canvas, relayRect, loadCenter);
  }

  void _drawArduino(Canvas canvas, Rect r) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(6)),
      Paint()..color = const Color(0xFF0D47A1),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(6)),
      Paint()..color = const Color(0xFF1E88E5)..style = PaintingStyle.stroke..strokeWidth = 2,
    );
    _text(canvas, 'ARDUINO', Offset(r.center.dx, r.top + 10), 9, Colors.white, bold: true);

    final yD7 = r.top + r.height * 0.35;
    final yVcc = r.top + r.height * 0.60;
    final yGnd = r.top + r.height * 0.82;

    _pin(canvas, Offset(r.right - 10, yD7), 'D7', isPinLow ? const Color(0xFF00E676) : const Color(0xFFFF5252));
    _pin(canvas, Offset(r.right - 10, yVcc), '5V', const Color(0xFFFF5252));
    _pin(canvas, Offset(r.right - 10, yGnd), 'GND', const Color(0xFF9E9E9E));
  }

  void _pin(Canvas canvas, Offset pos, String lbl, Color c) {
    canvas.drawCircle(pos, 3.5, Paint()..color = c);
    _text(canvas, lbl, Offset(pos.dx - 14, pos.dy), 8, c, bold: true);
  }

  void _drawWires(Canvas canvas, Rect a, Rect r) {
    final yD7 = a.top + a.height * 0.35;
    final yVcc = a.top + a.height * 0.60;
    final yGnd = a.top + a.height * 0.82;

    final inColor = isPinLow ? const Color(0xFF00E676) : const Color(0xFFFF9800);
    _wire(canvas, Offset(a.right - 8, yD7), Offset(r.left, yD7), inColor);
    _wire(canvas, Offset(a.right - 8, yVcc), Offset(r.left, yVcc), const Color(0xFFE53935));
    _wire(canvas, Offset(a.right - 8, yGnd), Offset(r.left, yGnd), const Color(0xFF424242));
  }

  void _wire(Canvas canvas, Offset p1, Offset p2, Color c) {
    final paint = Paint()..color = c..strokeWidth = 2..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..cubicTo((p1.dx + p2.dx) / 2, p1.dy, (p1.dx + p2.dx) / 2, p2.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paint);
  }

  void _drawRelay(Canvas canvas, Rect r) {
    canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(8)), Paint()..color = const Color(0xFF1B5E20));

    final box = Rect.fromLTWH(r.left + r.width * 0.22, r.top + 12, r.width * 0.56, r.height - 24);
    canvas.drawRRect(RRect.fromRectAndRadius(box, const Radius.circular(5)), Paint()..color = const Color(0xFF0277BD));
    _text(canvas, 'SRD-05VDC', Offset(box.center.dx, box.top + 10), 8, Colors.white, bold: true);
    _text(canvas, '10A 250VAC', Offset(box.center.dx, box.top + 20), 7, const Color(0xFFB3E5FC));

    final yIn = r.top + r.height * 0.35;
    final yVcc = r.top + r.height * 0.60;
    final yGnd = r.top + r.height * 0.82;
    _relayPin(canvas, Offset(r.left + 10, yIn), 'IN');
    _relayPin(canvas, Offset(r.left + 10, yVcc), 'VCC');
    _relayPin(canvas, Offset(r.left + 10, yGnd), 'GND');

    final ledPos = Offset(r.left + 14, r.top + 18);
    canvas.drawCircle(ledPos, 3.5, Paint()..color = isPinLow ? const Color(0xFF00E676) : const Color(0xFF2E7D32));
    if (isPinLow) canvas.drawCircle(ledPos, 6, Paint()..color = const Color(0x6600E676)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));

    final tx = box.right - 8;
    final yNC = box.top + box.height * 0.28;
    final yCOM = box.top + box.height * 0.54;
    final yNO = box.top + box.height * 0.80;

    final cp = Paint()..color = const Color(0xFFFFD54F);
    canvas.drawCircle(Offset(tx, yNC), 3, cp);
    canvas.drawCircle(Offset(tx - 20, yCOM), 3, cp);
    canvas.drawCircle(Offset(tx, yNO), 3, cp);

    _text(canvas, 'NC', Offset(tx - 10, yNC - 6), 7, Colors.white70);
    _text(canvas, 'COM', Offset(tx - 30, yCOM), 7, Colors.white70);
    _text(canvas, 'NO', Offset(tx - 10, yNO + 6), 7, Colors.white70);

    final armY = yNC + (yNO - yNC) * progress;
    final armPaint = Paint()..color = const Color(0xFFFFC107)..strokeWidth = 2.2..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(tx - 20, yCOM), Offset(tx - 1, armY), armPaint);

    _screw(canvas, Offset(r.right - 6, yNC), 'NC');
    _screw(canvas, Offset(r.right - 6, yCOM), 'COM');
    _screw(canvas, Offset(r.right - 6, yNO), 'NO');

    _comOut = Offset(r.right - 6, yCOM);
    _noOut = Offset(r.right - 6, yNO);
  }
  void _relayPin(Canvas canvas, Offset pos, String lbl) {
    canvas.drawCircle(pos, 3, Paint()..color = const Color(0xFFFFD54F));
    _text(canvas, lbl, Offset(pos.dx + 10, pos.dy), 7, Colors.white, bold: true);
  }

  void _screw(Canvas canvas, Offset pos, String lbl) {
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: pos, width: 12, height: 12), const Radius.circular(2)), Paint()..color = const Color(0xFF455A64));
    canvas.drawCircle(pos, 3.5, Paint()..color = const Color(0xFFCFD8DC)..style = PaintingStyle.stroke..strokeWidth = 1.2);
    _text(canvas, lbl, Offset(pos.dx + 16, pos.dy), 7, Colors.white70);
  }

  void _drawLoad(Canvas canvas, Rect r, Offset bulbCenter) {
    final active = isPinLow;
    final wireColor = active ? const Color(0xFFFFD54F) : const Color(0xFF616161);

    _wire(canvas, _comOut, Offset(bulbCenter.dx - 20, bulbCenter.dy + 30), wireColor);
    _wire(canvas, _noOut, Offset(bulbCenter.dx - 20, bulbCenter.dy - 10), wireColor);

    final psu = Rect.fromCenter(center: Offset(bulbCenter.dx + 6, bulbCenter.dy + 50), width: 44, height: 18);
    canvas.drawRRect(RRect.fromRectAndRadius(psu, const Radius.circular(3)), Paint()..color = const Color(0xFF263238));
    _text(canvas, 'DC 12V', psu.center, 7, Colors.white70, bold: true);

    _wire(canvas, Offset(psu.left, psu.center.dy), Offset(bulbCenter.dx - 20, bulbCenter.dy + 30), wireColor);
    _wire(canvas, Offset(psu.right, psu.center.dy), Offset(bulbCenter.dx + 16, bulbCenter.dy + 12), wireColor);

    _drawBulb(canvas, bulbCenter, active);
  }

  void _drawBulb(Canvas canvas, Offset c, bool on) {
    if (on) {
      canvas.drawCircle(c, 24, Paint()..color = const Color(0x66FFC107)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18));
      final rp = Paint()..color = const Color(0xAAFFE082)..strokeWidth = 1.3;
      for (int i = 0; i < 8; i++) {
        final a = i * math.pi / 4;
        final p1 = Offset(c.dx + math.cos(a) * 20, c.dy + math.sin(a) * 20);
        final p2 = Offset(c.dx + math.cos(a) * 26, c.dy + math.sin(a) * 26);
        canvas.drawLine(p1, p2, rp);
      }
    }
    canvas.drawCircle(c, 14, Paint()..color = on ? const Color(0xFFFFEB3B) : const Color(0xFF424242));
    canvas.drawCircle(c, 14, Paint()..color = on ? const Color(0xFFFFF59D) : const Color(0xFF757575)..style = PaintingStyle.stroke..strokeWidth = 1.3);
    final fp = Paint()..color = on ? const Color(0xFFE65100) : const Color(0xFF9E9E9E)..style = PaintingStyle.stroke..strokeWidth = 1.2;
    final path = Path()..moveTo(c.dx - 4, c.dy + 5)..lineTo(c.dx - 1, c.dy - 3)..lineTo(c.dx + 1, c.dy - 3)..lineTo(c.dx + 4, c.dy + 5);
    canvas.drawPath(path, fp);
    canvas.drawRect(Rect.fromCenter(center: Offset(c.dx, c.dy + 16), width: 10, height: 5), Paint()..color = const Color(0xFF90A4AE));
    _text(canvas, on ? 'BEBAN (ON)' : 'BEBAN (OFF)', Offset(c.dx, c.dy - 22), 7, on ? const Color(0xFFFFD54F) : Colors.white60, bold: true);
  }

  late final Offset _comOut;
  late final Offset _noOut;

  void _text(Canvas canvas, String s, Offset pos, double sz, Color c, {bool bold = false}) {
    final tp = TextPainter(text: TextSpan(text: s, style: TextStyle(color: c, fontSize: sz, fontWeight: bold ? FontWeight.bold : FontWeight.normal)), textDirection: TextDirection.ltr)..layout();
    tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _RelayPainter old) => old.isPinLow != isPinLow || old.progress != progress;
}


