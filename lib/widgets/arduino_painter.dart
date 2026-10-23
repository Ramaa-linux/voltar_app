import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_typography.dart';

/// Satu frame rangkaian Blink: LED menyala atau mati, plus pin yang dipakai.
///
/// Nilai kecil dan immutable supaya `shouldRepaint` cukup membandingkan dua
/// field (`==`/`hashCode` diturunkan secara manual, tanpa paket tambahan).
@immutable
class ArduinoScene {
  const ArduinoScene({required this.isLedOn, required this.activePin});

  /// `true` = pin [activePin] berlogika HIGH, LED menyala.
  final bool isLedOn;

  /// Nomor pin digital Arduino (0-13, 14 = TX, 15 = RX).
  final int activePin;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArduinoScene &&
            other.isLedOn == isLedOn &&
            other.activePin == activePin;
  }

  @override
  int get hashCode => Object.hash(isLedOn, activePin);

  @override
  String toString() => 'ArduinoScene(isLedOn: $isLedOn, activePin: $activePin)';
}

/// Geometri papan Arduino dalam koordinat kanvas.
///
/// Semua ukuran diturunkan dari [Size] (persentase atau `shortestSide`) supaya
/// gambar tetap proporsional di HP maupun jendela desktop. Fungsi statis
/// dipakai juga oleh tes piksel, jadi tidak ada angka yang tersembunyi di
/// dalam `paint`.
abstract final class ArduinoGeometry {
  /// Pin digital Uno: D0-D13 + TX/RX = 16 pad di tepi kanan.
  static const int digitalPinCount = 16;

  /// Pin analog A0-A5 di tepi kiri bawah.
  static const int analogPinCount = 6;

  /// Radius sudut papan.
  static const double boardRadius = 8;

  /// Badan papan: 40% lebar kanvas, 68% tinggi, sisanya ruang untuk LED.
  static Rect boardRect(Size size) {
    return Rect.fromLTWH(
      size.width * 0.06,
      size.height * 0.16,
      size.width * 0.40,
      size.height * 0.68,
    );
  }

  /// Sisi pad pin. Minimum 6.5 supaya header 16 pin tetap terbaca di layar HP.
  static double pinSize(Size size) => math.max(6.5, size.shortestSide * 0.024);

  /// Jarak antar pusat pad pin.
  static double pinGap(Size size) => pinSize(size) * 1.35;

  /// Y pusat pad digital pertama.
  static double digitalPinTop(Size size) {
    final Rect board = boardRect(size);
    return board.top + board.height * 0.10;
  }

  /// Pusat pad digital ke-[pinNumber]; di luar rentang otomatis di-clamp.
  static Offset digitalPinCenter(Size size, int pinNumber) {
    final Rect board = boardRect(size);
    final double side = pinSize(size);
    final int index = pinNumber.clamp(0, digitalPinCount - 1).toInt();
    return Offset(
      board.right - side / 2,
      digitalPinTop(size) + pinGap(size) * index,
    );
  }

  /// Kotak pad digital ke-[pinNumber].
  static Rect digitalPinRect(Size size, int pinNumber) {
    final double side = pinSize(size);
    return Rect.fromCenter(
      center: digitalPinCenter(size, pinNumber),
      width: side,
      height: side,
    );
  }

  /// Titik sambung kabel: tepi kanan pad, tepat di `board.right`.
  static Offset pinAnchor(Size size, int pinNumber) {
    final Offset center = digitalPinCenter(size, pinNumber);
    return Offset(center.dx + pinSize(size) / 2, center.dy);
  }

  /// Label silkscreen pin digital (`D0`, `D13`, `TX`, `RX`).
  static String digitalPinLabel(int pinNumber) {
    final int index = pinNumber.clamp(0, digitalPinCount - 1).toInt();
    const List<String> uart = <String>['TX', 'RX'];
    final int uartStart = digitalPinCount - uart.length;
    if (index >= uartStart) {
      return uart[index - uartStart];
    }
    return 'D$index';
  }

  /// Pusat pad analog ke-[index] (0 = A0).
  static Offset analogPinCenter(Size size, int index) {
    final Rect board = boardRect(size);
    final double side = pinSize(size);
    final int clamped = index.clamp(0, analogPinCount - 1).toInt();
    return Offset(
      board.left + side / 2,
      board.bottom - board.height * 0.35 + pinGap(size) * clamped,
    );
  }

  /// Pusat LED di area kanan papan.
  static Offset ledCenter(Size size) =>
      Offset(size.width * 0.81, size.height * 0.62);

  /// Radius badan LED; minimum 8 supaya tetap kelihatan di layar kecil.
  static double ledRadius(Size size) =>
      math.max(8.0, size.shortestSide * 0.062);

  /// Rute kabel pin -> LED: turun/naik lewat satu elbow (3 segmen).
  static List<Offset> wirePoints(Size size, int pinNumber) {
    final Offset pin = pinAnchor(size, pinNumber);
    final Offset led = ledCenter(size);
    final double ledEdgeX = led.dx - ledRadius(size);
    final double elbowX = pin.dx + (ledEdgeX - pin.dx) * 0.45;
    return <Offset>[
      pin,
      Offset(elbowX, pin.dy),
      Offset(elbowX, led.dy),
      Offset(ledEdgeX, led.dy),
    ];
  }
}

/// Lukisan papan Arduino + LED Blink memakai [CustomPainter].
///
/// Tanpa aset bitmap: seluruh bentuk memakai `drawRRect`, `drawCircle`, dan
/// `drawLine`. Warna hanya dari [AppColors]; ukuran hanya dari
/// [ArduinoGeometry]. Repaint 2x/detik tetap murah karena `Paint` di-hoist.
class ArduinoPainter extends CustomPainter {
  ArduinoPainter({required this.scene});

  /// Nilai yang digambar pada frame ini.
  final ArduinoScene scene;

  late final Paint _boardFill = Paint()..color = AppColors.circuitBoard;
  late final Paint _boardStroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.textPrimary.withValues(alpha: 0.20);
  late final Paint _chipFill = Paint()..color = AppColors.textPrimary;
  late final Paint _chipStroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.textOnPrimary.withValues(alpha: 0.35);
  late final Paint _legStroke = Paint()
    ..strokeCap = StrokeCap.round
    ..color = AppColors.textTertiary;
  late final Paint _notchFill = Paint()..color = AppColors.circuitBoard;
  late final Paint _metalFill = Paint()..color = AppColors.borderStrong;
  late final Paint _metalStroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.textSecondary;
  late final Paint _resetFill = Paint()..color = AppColors.accent;
  late final Paint _padFill = Paint()..color = AppColors.textTertiary;
  late final Paint _padActiveFill = Paint()..color = AppColors.circuitWire;
  late final Paint _padStroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.textPrimary.withValues(alpha: 0.35);
  late final Paint _analogFill = Paint()..color = AppColors.ledOff;
  late final Paint _wireStroke = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = AppColors.circuitWire;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }
    _paintBoard(canvas, size);
    _paintUsbPort(canvas, size);
    _paintResetButton(canvas, size);
    _paintCrystal(canvas, size);
    _paintChip(canvas, size);
    _paintDigitalPins(canvas, size);
    _paintAnalogPins(canvas, size);
    _paintWire(canvas, size);
    _paintLed(canvas, size);
  }

  @override
  bool shouldRepaint(covariant ArduinoPainter oldDelegate) =>
      oldDelegate.scene != scene;

  void _paintBoard(Canvas canvas, Size size) {
    final Rect board = ArduinoGeometry.boardRect(size);
    final RRect body = RRect.fromRectAndRadius(
      board,
      const Radius.circular(ArduinoGeometry.boardRadius),
    );
    _boardStroke.strokeWidth = math.max(1.0, size.shortestSide * 0.004);

    canvas.drawRRect(body, _boardFill);
    canvas.drawRRect(body, _boardStroke);

    final double inset = math.max(8.0, size.shortestSide * 0.04);
    _paintText(
      canvas,
      'Arduino',
      Offset(board.left + inset, board.top + inset),
      AppTypography.label.copyWith(
        color: AppColors.textOnPrimary,
        fontWeight: FontWeight.w700,
      ),
    );

    // Di bawah chip dan di atas tepi bawah papan, jadi tidak tertutup IC.
    _paintCenteredText(
      canvas,
      'UNO',
      Offset(board.center.dx, board.top + board.height * 0.86),
      AppTypography.label.copyWith(
        color: AppColors.textOnPrimary.withValues(alpha: 0.70),
        fontSize: math.max(9.0, size.shortestSide * 0.045),
        fontWeight: FontWeight.w700,
        letterSpacing: 4,
      ),
    );
  }

  void _paintUsbPort(Canvas canvas, Size size) {
    final Rect board = ArduinoGeometry.boardRect(size);
    final double width = board.width * 0.18;
    final double height = board.height * 0.10;
    final Rect port = Rect.fromCenter(
      center: Offset(
        board.left - width * 0.30,
        board.top + board.height * 0.12,
      ),
      width: width,
      height: height,
    );
    final RRect shell = RRect.fromRectAndRadius(
      port,
      Radius.circular(port.height * 0.18),
    );
    _metalStroke.strokeWidth = math.max(0.8, size.shortestSide * 0.003);
    _padStroke.strokeWidth = math.max(1.0, port.height * 0.16);

    canvas.drawRRect(shell, _metalFill);
    canvas.drawRRect(shell, _metalStroke);
    canvas.drawLine(
      Offset(port.left + port.width * 0.22, port.center.dy),
      Offset(port.right - port.width * 0.22, port.center.dy),
      _padStroke,
    );
  }

  void _paintResetButton(Canvas canvas, Size size) {
    final Rect board = ArduinoGeometry.boardRect(size);
    final Offset center = Offset(
      board.left + board.width * 0.18,
      board.top + board.height * 0.14,
    );
    final double radius = math.max(4.0, size.shortestSide * 0.022);
    _padStroke.strokeWidth = math.max(0.8, radius * 0.22);

    canvas.drawCircle(center, radius, _resetFill);
    canvas.drawCircle(center, radius, _padStroke);
  }

  void _paintCrystal(Canvas canvas, Size size) {
    final Rect board = ArduinoGeometry.boardRect(size);
    final Rect can = Rect.fromCenter(
      center: Offset(
        board.left + board.width * 0.30,
        board.top + board.height * 0.30,
      ),
      width: board.width * 0.18,
      height: board.height * 0.09,
    );
    final RRect body = RRect.fromRectAndRadius(
      can,
      Radius.circular(can.height * 0.35),
    );
    _metalStroke.strokeWidth = math.max(0.8, size.shortestSide * 0.003);
    _legStroke.strokeWidth = math.max(1.0, can.height * 0.16);

    canvas.drawRRect(body, _metalFill);
    canvas.drawRRect(body, _metalStroke);

    // Dua kaki kristal ke arah chip.
    for (final double factor in <double>[0.30, 0.70]) {
      final double x = can.left + can.width * factor;
      canvas.drawLine(
        Offset(x, can.bottom),
        Offset(x, can.bottom + can.height * 0.45),
        _legStroke,
      );
    }
  }

  void _paintChip(Canvas canvas, Size size) {
    final Rect board = ArduinoGeometry.boardRect(size);
    final Rect chip = Rect.fromCenter(
      center: Offset(
        board.left + board.width * 0.44,
        board.top + board.height * 0.52,
      ),
      width: board.width * 0.40,
      height: board.height * 0.22,
    );
    final RRect body = RRect.fromRectAndRadius(
      chip,
      Radius.circular(chip.width * 0.06),
    );

    // Kaki IC di dua sisi, digambar lebih dulu supaya tertutup badan chip.
    _legStroke.strokeWidth = math.max(1.0, chip.width * 0.03);
    for (final bool leftSide in <bool>[true, false]) {
      final double edgeX = leftSide ? chip.left : chip.right;
      final double direction = leftSide ? -1 : 1;
      for (int i = 1; i <= 4; i++) {
        final double y = chip.top + chip.height * (i / 5);
        canvas.drawLine(
          Offset(edgeX, y),
          Offset(edgeX + direction * chip.width * 0.14, y),
          _legStroke,
        );
      }
    }

    _chipStroke.strokeWidth = math.max(0.8, size.shortestSide * 0.003);
    canvas.drawRRect(body, _chipFill);
    canvas.drawRRect(body, _chipStroke);

    // Notch setengah lingkaran di tepi atas sebagai penanda orientasi.
    canvas.drawCircle(
      Offset(chip.left + chip.width * 0.22, chip.top),
      chip.height * 0.14,
      _notchFill,
    );

    _paintCenteredText(
      canvas,
      'ATmega328P',
      chip.center,
      AppTypography.label.copyWith(
        color: AppColors.textOnPrimary,
        fontSize: math.max(6.0, size.shortestSide * 0.020),
      ),
    );
  }

  void _paintDigitalPins(Canvas canvas, Size size) {
    final double labelSize = math.max(
      7.0,
      ArduinoGeometry.pinSize(size) * 0.85,
    );
    _padStroke.strokeWidth = 0.8;

    for (int i = 0; i < ArduinoGeometry.digitalPinCount; i++) {
      final Rect pad = ArduinoGeometry.digitalPinRect(size, i);
      final bool isActive = i == scene.activePin;
      final RRect shape = RRect.fromRectAndRadius(
        pad,
        Radius.circular(pad.width * 0.20),
      );

      canvas.drawRRect(shape, isActive ? _padActiveFill : _padFill);
      canvas.drawRRect(shape, _padStroke);

      // Label hanya di pin 0, 1, dan pin aktif agar header tidak penuh teks.
      if (i > 1 && !isActive) {
        continue;
      }
      final TextPainter label = _layoutText(
        ArduinoGeometry.digitalPinLabel(i),
        AppTypography.label.copyWith(
          color: isActive
              ? AppColors.textOnPrimary
              : AppColors.textOnPrimary.withValues(alpha: 0.70),
          fontSize: labelSize,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
        ),
      );
      label.paint(
        canvas,
        Offset(
          pad.left - labelSize * 0.7 - label.width,
          pad.center.dy - label.height / 2,
        ),
      );
      label.dispose();
    }
  }

  void _paintAnalogPins(Canvas canvas, Size size) {
    final double side = ArduinoGeometry.pinSize(size);
    final double labelSize = math.max(6.0, side * 0.62);
    _padStroke.strokeWidth = 0.8;

    for (int i = 0; i < ArduinoGeometry.analogPinCount; i++) {
      final Offset center = ArduinoGeometry.analogPinCenter(size, i);
      final Rect pad = Rect.fromCenter(
        center: center,
        width: side,
        height: side,
      );
      final RRect shape = RRect.fromRectAndRadius(
        pad,
        Radius.circular(side * 0.20),
      );

      canvas.drawRRect(shape, _analogFill);
      canvas.drawRRect(shape, _padStroke);

      final TextPainter label = _layoutText(
        'A$i',
        AppTypography.label.copyWith(
          color: AppColors.textOnPrimary.withValues(alpha: 0.70),
          fontSize: labelSize,
        ),
      );
      label.paint(
        canvas,
        Offset(pad.right + labelSize * 0.5, pad.center.dy - label.height / 2),
      );
      label.dispose();
    }
  }

  void _paintWire(Canvas canvas, Size size) {
    final List<Offset> points = ArduinoGeometry.wirePoints(
      size,
      scene.activePin,
    );
    _wireStroke.strokeWidth = math.max(3.0, size.shortestSide * 0.014);

    final Path path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, _wireStroke);
  }

  void _paintLed(Canvas canvas, Size size) {
    final Offset center = ArduinoGeometry.ledCenter(size);
    final double radius = ArduinoGeometry.ledRadius(size);
    final double legLength = radius * 0.9;

    _legStroke.strokeWidth = math.max(1.5, radius * 0.16);
    for (final double offset in <double>[-0.55, 0.55]) {
      final double x = center.dx + radius * offset;
      canvas.drawLine(
        Offset(x, center.dy + radius * 0.85),
        Offset(x, center.dy + radius + legLength),
        _legStroke,
      );
    }

    if (scene.isLedOn) {
      // Glow dua lapis, alpha rendah supaya tetap lembut di latar terang.
      canvas.drawCircle(
        center,
        radius * 2.2,
        Paint()..color = AppColors.ledOn.withValues(alpha: 0.16),
      );
      canvas.drawCircle(
        center,
        radius * 1.55,
        Paint()..color = AppColors.ledOn.withValues(alpha: 0.24),
      );
    }

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = scene.isLedOn ? AppColors.ledOn : AppColors.ledOff,
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1.0, radius * 0.12)
        ..color = scene.isLedOn ? AppColors.ledOn : AppColors.textTertiary,
    );

    // Kilau kaca di kiri atas badan LED.
    canvas.drawCircle(
      Offset(center.dx - radius * 0.30, center.dy - radius * 0.35),
      radius * 0.26,
      Paint()..color = AppColors.textOnPrimary.withValues(alpha: 0.55),
    );

    _paintCenteredText(
      canvas,
      'LED',
      Offset(
        center.dx,
        center.dy +
            radius +
            legLength +
            math.max(6.0, size.shortestSide * 0.03),
      ),
      AppTypography.caption.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _paintText(Canvas canvas, String text, Offset topLeft, TextStyle style) {
    final TextPainter painter = _layoutText(text, style);
    painter.paint(canvas, topLeft);
    painter.dispose();
  }

  void _paintCenteredText(
    Canvas canvas,
    String text,
    Offset center,
    TextStyle style,
  ) {
    final TextPainter painter = _layoutText(text, style);
    painter.paint(
      canvas,
      Offset(center.dx - painter.width / 2, center.dy - painter.height / 2),
    );
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
