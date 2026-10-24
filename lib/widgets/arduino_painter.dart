import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_typography.dart';

/// Satu frame rangkaian Blink: LED menyala atau mati, plus pin yang dipakai.
///
/// Nilai kecil dan immutable supaya `shouldRepaint` cukup membandingkan dua
/// field (`==`/`hashCode` diturunkan manual, tanpa paket tambahan).
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

/// Geometri papan Arduino Uno dalam koordinat kanvas.
///
/// Semua ukuran diturunkan dari [Size] (persentase bidang atau `shortestSide`)
/// supaya gambar tetap proporsional di HP maupun jendela desktop. Fungsi statis
/// dipakai juga oleh tes piksel, jadi tidak ada angka tersembunyi di `paint`.
abstract final class ArduinoGeometry {
  /// Header digital (atas): AREF, GND, lalu D13..D0.
  static const int topPinCount = 16;

  /// Header POWER di kiri bawah.
  static const int powerPinCount = 7;

  /// Header ANALOG IN di kanan bawah.
  static const int analogPinCount = 6;

  /// Label silkscreen header digital, kiri ke kanan.
  static const List<String> topPinLabels = <String>[
    'AREF',
    'GND',
    '13',
    '12',
    '11',
    '10',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2',
    'TX\u21921',
    'RX\u21900',
  ];

  /// Label silkscreen header POWER.
  static const List<String> powerPinLabels = <String>[
    'VIN',
    'GND',
    'GND',
    '5V',
    '3V3',
    'RST',
    'IOREF',
  ];

  /// Label silkscreen header ANALOG IN.
  static const List<String> analogPinLabels = <String>[
    'A0',
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
  ];

  /// Badan papan: 89% lebar kanvas, 93% tinggi, menyisakan margin tipis.
  static Rect boardBounds(Size size) {
    return Rect.fromLTWH(
      size.width * 0.085,
      size.height * 0.030,
      size.width * 0.890,
      size.height * 0.930,
    );
  }

  /// Radius sudut papan.
  static double boardRadius(Size size) {
    return math.max(3.0, size.shortestSide * 0.018);
  }

  /// Panjang potongan diagonal di sudut kanan-atas (khas Uno).
  static double boardCornerCut(Size size) => boardBounds(size).width * 0.068;

  /// Siluet papan: sudut kanan-atas dipotong diagonal.
  static Path boardPath(Size size) {
    final Rect b = boardBounds(size);
    final double r = boardRadius(size);
    final double cut = boardCornerCut(size);
    return Path()
      ..moveTo(b.left + r, b.top)
      ..lineTo(b.right - cut, b.top)
      ..lineTo(b.right, b.top + cut)
      ..lineTo(b.right, b.bottom - r)
      ..arcToPoint(Offset(b.right - r, b.bottom), radius: Radius.circular(r))
      ..lineTo(b.left + r, b.bottom)
      ..arcToPoint(Offset(b.left, b.bottom - r), radius: Radius.circular(r))
      ..lineTo(b.left, b.top + r)
      ..arcToPoint(Offset(b.left + r, b.top), radius: Radius.circular(r))
      ..close();
  }

  /// Sisi pad pin. Minimum 4 supaya header 16 pin tetap terlihat.
  static double pinSize(Size size) => math.max(4.0, size.shortestSide * 0.028);

  /// Jarak antar pusat pad pin.
  static double pinGap(Size size) => math.max(6.0, size.shortestSide * 0.045);

  /// Tinggi plastik header pin.
  static double stripHeight(Size size) => pinSize(size) * 1.30;

  /// Plastik header digital, menempel tepi atas papan.
  static Rect topHeaderRect(Size size) {
    final Rect b = boardBounds(size);
    final double width = (topPinCount - 1) * pinGap(size) + pinSize(size);
    return Rect.fromLTWH(
      b.left + b.width * 0.215,
      b.top,
      width,
      stripHeight(size),
    );
  }

  /// Plastik header POWER, menempel tepi bawah papan.
  static Rect powerHeaderRect(Size size) {
    final Rect b = boardBounds(size);
    final double width = (powerPinCount - 1) * pinGap(size) + pinSize(size);
    return Rect.fromLTWH(
      b.left + b.width * 0.255,
      b.bottom - stripHeight(size),
      width,
      stripHeight(size),
    );
  }

  /// Plastik header ANALOG IN, menempel tepi bawah papan.
  static Rect analogHeaderRect(Size size) {
    final Rect b = boardBounds(size);
    final double width = (analogPinCount - 1) * pinGap(size) + pinSize(size);
    return Rect.fromLTWH(
      b.left + b.width * 0.620,
      b.bottom - stripHeight(size),
      width,
      stripHeight(size),
    );
  }

  /// Pusat pad header digital ke-[index] (0 = AREF, 2 = pin 13).
  static Offset topPinCenter(Size size, int index) {
    final int i = index.clamp(0, topPinCount - 1).toInt();
    final Rect strip = topHeaderRect(size);
    return Offset(
      strip.left + pinSize(size) / 2 + pinGap(size) * i,
      strip.top + pinSize(size) * 0.65,
    );
  }

  /// Pusat pad header POWER ke-[index] (0 = VIN).
  static Offset powerPinCenter(Size size, int index) {
    final int i = index.clamp(0, powerPinCount - 1).toInt();
    final Rect strip = powerHeaderRect(size);
    return Offset(
      strip.left + pinSize(size) / 2 + pinGap(size) * i,
      strip.top + pinSize(size) * 0.65,
    );
  }

  /// Pusat pad header ANALOG ke-[index] (0 = A0).
  static Offset analogPinCenter(Size size, int index) {
    final int i = index.clamp(0, analogPinCount - 1).toInt();
    final Rect strip = analogHeaderRect(size);
    return Offset(
      strip.left + pinSize(size) / 2 + pinGap(size) * i,
      strip.top + pinSize(size) * 0.65,
    );
  }

  /// Indeks pad header untuk nomor pin digital; di luar rentang -> pin 13.
  static int topPinIndex(int pinNumber) {
    if (pinNumber >= 0 && pinNumber <= 13) {
      return 2 + (13 - pinNumber);
    }
    if (pinNumber == 14) {
      return 14;
    }
    if (pinNumber == 15) {
      return 15;
    }
    return 2;
  }

  /// Titik sambung kabel: tepi bawah plastik header, tepat di tengah pad.
  static Offset pinAnchor(Size size, int pinNumber) {
    final Offset pad = topPinCenter(size, topPinIndex(pinNumber));
    return Offset(pad.dx, topHeaderRect(size).bottom);
  }

  /// Badan IC ATmega328P.
  static Rect chipRect(Size size) {
    final Rect b = boardBounds(size);
    return Rect.fromLTWH(
      b.left + b.width * 0.400,
      b.top + b.height * 0.400,
      b.width * 0.260,
      b.height * 0.220,
    );
  }

  /// Port USB tipe-B di sisi kiri papan.
  static Rect usbRect(Size size) {
    final Rect b = boardBounds(size);
    return Rect.fromCenter(
      center: Offset(b.left + b.width * 0.095, b.top + b.height * 0.300),
      width: b.width * 0.150,
      height: b.height * 0.130,
    );
  }

  /// Jack DC di kiri bawah papan.
  static Rect dcJackRect(Size size) {
    final Rect b = boardBounds(size);
    return Rect.fromCenter(
      center: Offset(b.left + b.width * 0.100, b.top + b.height * 0.720),
      width: b.width * 0.130,
      height: b.height * 0.170,
    );
  }

  /// Soket ICSP 2x3; [index] 0 = atas, 1 = bawah.
  static Rect icspRect(Size size, int index) {
    final Rect b = boardBounds(size);
    final double pad = pinSize(size) * 0.72;
    final double pitch = pad * 1.30;
    final double boxPad = pad * 0.45;
    final double width = pitch + pad + boxPad * 2;
    final double height = pitch * 2 + pad + boxPad * 2;
    final double top = b.top + b.height * (index == 0 ? 0.200 : 0.475);
    return Rect.fromLTWH(b.left + b.width * 0.795, top, width, height);
  }

  /// Pusat kristal ke-[index]; 0 = osilator 16 MHz.
  static Offset crystalCenter(Size size, int index) {
    final Rect b = boardBounds(size);
    final double y = b.top + b.height * (index == 0 ? 0.420 : 0.600);
    return Offset(b.left + b.width * 0.255, y);
  }

  /// Lebar badan kristal.
  static double crystalWidth(Size size) => pinSize(size) * 2.60;

  /// Tinggi badan kristal.
  static double crystalHeight(Size size) => pinSize(size) * 1.50;

  /// Pusat LED indikator ke-[index]: 0 = L, 1 = TX, 2 = RX, 3 = ON.
  static Offset indicatorCenter(Size size, int index) {
    final Rect b = boardBounds(size);
    final int i = index.clamp(0, 3).toInt();
    return Offset(
      b.left + b.width * (0.600 + 0.035 * i),
      b.top + b.height * 0.285,
    );
  }

  /// Radius LED indikator.
  static double indicatorRadius(Size size) {
    return math.max(1.6, pinSize(size) * 0.34);
  }

  /// Pusat tombol reset di dekat sudut potong papan.
  static Offset resetCenter(Size size) {
    final Rect b = boardBounds(size);
    return Offset(b.left + b.width * 0.900, b.top + b.height * 0.135);
  }

  /// Radius tombol reset.
  static double resetRadius(Size size) => math.max(3.0, pinSize(size) * 1.10);

  /// LED eksternal di zona kosong kanan-bawah papan.
  ///
  /// Zona ini sengaja dipilih karena bebas dari IC (berakhir 0.62h), ICSP
  /// bawah (berakhir 0.58h), header bawah (mulai 0.96h), dan tepi papan kanan.
  static Offset extLedCenter(Size size) {
    final Rect b = boardBounds(size);
    return Offset(b.left + b.width * 0.885, b.top + b.height * 0.740);
  }

  /// Radius badan LED eksternal; minimum 7 supaya tetap terlihat.
  static double extLedRadius(Size size) {
    return math.max(7.0, size.shortestSide * 0.055);
  }

  /// Rute kabel pin -> LED: menyusur bawah header, turun di kanal kanan,
  /// lalu masuk LED dari samping (3 segmen, tidak melewati badan IC).
  static List<Offset> wirePoints(Size size, int pinNumber) {
    final Offset pin = pinAnchor(size, pinNumber);
    final Offset led = extLedCenter(size);
    final double r = extLedRadius(size);
    final double channelX =
        led.dx + r + math.max(4.0, size.shortestSide * 0.020);
    return <Offset>[
      pin,
      Offset(channelX, pin.dy),
      Offset(channelX, led.dy),
      Offset(led.dx + r, led.dy),
    ];
  }
}

/// Lukisan papan Arduino Uno lengkap + LED Blink memakai [CustomPainter].
///
/// Tanpa aset bitmap: seluruh bentuk memakai `drawPath`, `drawRRect`,
/// `drawCircle`, dan `drawLine`. Warna hanya dari [AppColors]; ukuran hanya dari
/// [ArduinoGeometry]. Repaint 2x/detik tetap murah karena semua `Paint`
/// di-hoist ke field.
class ArduinoPainter extends CustomPainter {
  ArduinoPainter({required this.scene});

  /// Nilai yang digambar pada frame ini.
  final ArduinoScene scene;

  /// Warna silkscreen: putih papan dengan sedikit transparansi.
  final Color _silkColor = AppColors.textOnPrimary.withValues(alpha: 0.78);

  late final Paint _boardFill = Paint()..color = AppColors.circuitBoard;
  late final Paint _boardEdge = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.circuitBoardDark;
  late final Paint _silkscreenStroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.textOnPrimary.withValues(alpha: 0.10);
  late final Paint _stripFill = Paint()..color = AppColors.circuitPinHeader;
  late final Paint _padFill = Paint()..color = AppColors.circuitPin;
  late final Paint _padActiveFill = Paint()..color = AppColors.circuitWire;
  late final Paint _padStroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.circuitChipDark.withValues(alpha: 0.55);
  late final Paint _metalFill = Paint()..color = AppColors.circuitMetal;
  late final Paint _metalStroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.circuitMetalDark;
  late final Paint _chipFill = Paint()..color = AppColors.circuitChip;
  late final Paint _chipStroke = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.circuitChipDark;
  late final Paint _chipHighlight = Paint()
    ..color = AppColors.textOnPrimary.withValues(alpha: 0.10);
  late final Paint _crystalFill = Paint()..color = AppColors.circuitCrystal;
  late final Paint _crystalHighlight = Paint()
    ..color = AppColors.textOnPrimary.withValues(alpha: 0.33);
  late final Paint _resetFill = Paint()..color = AppColors.circuitReset;
  late final Paint _resetRing = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.circuitResetDark;
  late final Paint _indicatorOff = Paint()..color = AppColors.circuitPinHeader;
  late final Paint _indicatorOn = Paint()..color = AppColors.success;
  late final Paint _indicatorTx = Paint()..color = AppColors.accent;
  late final Paint _wireStroke = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = AppColors.circuitWire;
  late final Paint _ledGlow = Paint()
    ..color = AppColors.ledOn.withValues(alpha: 0.16);
  late final Paint _ledGlowInner = Paint()
    ..color = AppColors.ledOn.withValues(alpha: 0.24);
  late final Paint _ledFillOn = Paint()..color = AppColors.ledOn;
  late final Paint _ledFillOff = Paint()..color = AppColors.ledOff;
  late final Paint _ledRingOn = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.ledOn;
  late final Paint _ledRingOff = Paint()
    ..style = PaintingStyle.stroke
    ..color = AppColors.textTertiary;
  late final Paint _ledGloss = Paint()
    ..color = AppColors.textOnPrimary.withValues(alpha: 0.55);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }
    _paintBoard(canvas, size);
    _paintTopHeader(canvas, size);
    _paintBottomHeaders(canvas, size);
    _paintUsbPort(canvas, size);
    _paintDcJack(canvas, size);
    _paintCrystals(canvas, size);
    _paintChip(canvas, size);
    _paintIcspHeaders(canvas, size);
    _paintResetButton(canvas, size);
    _paintIndicators(canvas, size);
    _paintWire(canvas, size);
    _paintExtLed(canvas, size);
  }

  @override
  bool shouldRepaint(covariant ArduinoPainter oldDelegate) =>
      oldDelegate.scene != scene;

  void _paintBoard(Canvas canvas, Size size) {
    final Rect board = ArduinoGeometry.boardBounds(size);
    final Path shape = ArduinoGeometry.boardPath(size);
    _boardEdge.strokeWidth = math.max(1.0, size.shortestSide * 0.005);
    _silkscreenStroke.strokeWidth = math.max(0.8, size.shortestSide * 0.0028);

    canvas.drawPath(shape, _boardFill);
    canvas.drawPath(shape, _boardEdge);

    // Garis silkscreen tipis di dalam tepi papan.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        board.deflate(math.max(3.0, size.shortestSide * 0.016)),
        Radius.circular(ArduinoGeometry.boardRadius(size)),
      ),
      _silkscreenStroke,
    );

    _paintCenteredText(
      canvas,
      'UNO',
      Offset(
        board.left + board.width * 0.160,
        board.top + board.height * 0.865,
      ),
      _silk(
        size: size,
        scale: 0.060,
        min: 8.0,
        weight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  void _paintUsbPort(Canvas canvas, Size size) {
    final Rect port = ArduinoGeometry.usbRect(size);
    final double ps = ArduinoGeometry.pinSize(size);
    _metalStroke.strokeWidth = math.max(0.8, size.shortestSide * 0.004);

    final RRect shell = RRect.fromRectAndRadius(
      port,
      Radius.circular(port.height * 0.18),
    );
    canvas.drawRRect(shell, _metalFill);
    canvas.drawRRect(shell, _metalStroke);

    final Rect slot = Rect.fromCenter(
      center: port.center,
      width: port.width * 0.62,
      height: port.height * 0.46,
    );
    final RRect slotShell = RRect.fromRectAndRadius(
      slot,
      Radius.circular(slot.height * 0.20),
    );
    canvas.drawRRect(slotShell, _chipFill);
    canvas.drawRRect(slotShell, _metalStroke);

    // Dua pin kontak di dalam slot.
    for (final double dx in <double>[-0.18, 0.18]) {
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(slot.center.dx + slot.width * dx, slot.center.dy),
          width: ps * 0.22,
          height: slot.height * 0.34,
        ),
        _metalFill,
      );
    }
  }

  void _paintDcJack(Canvas canvas, Size size) {
    final Rect jack = ArduinoGeometry.dcJackRect(size);
    final double ps = ArduinoGeometry.pinSize(size);
    _chipStroke.strokeWidth = math.max(0.8, size.shortestSide * 0.004);

    final RRect body = RRect.fromRectAndRadius(
      jack,
      Radius.circular(jack.width * 0.16),
    );
    canvas.drawRRect(body, _chipFill);
    canvas.drawRRect(body, _chipStroke);

    // Barrel logam di tengah jack.
    canvas.drawCircle(jack.center, jack.width * 0.30, _metalFill);
    canvas.drawCircle(jack.center, jack.width * 0.17, _chipFill);

    // Pin positif di bawah barrel.
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(jack.center.dx, jack.bottom - jack.height * 0.14),
        width: jack.width * 0.10,
        height: ps * 0.30,
      ),
      _metalFill,
    );
  }

  void _paintCrystals(Canvas canvas, Size size) {
    final double w = ArduinoGeometry.crystalWidth(size);
    final double h = ArduinoGeometry.crystalHeight(size);
    _metalStroke.strokeWidth = math.max(0.8, size.shortestSide * 0.0035);

    for (int i = 0; i < 2; i++) {
      final Offset center = ArduinoGeometry.crystalCenter(size, i);
      final Rect body = Rect.fromCenter(center: center, width: w, height: h);
      final RRect shell = RRect.fromRectAndRadius(
        body,
        Radius.circular(h * 0.38),
      );
      canvas.drawRRect(shell, _crystalFill);
      canvas.drawRRect(shell, _metalStroke);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            body.left + w * 0.10,
            body.top + h * 0.16,
            w * 0.80,
            h * 0.24,
          ),
          Radius.circular(h * 0.12),
        ),
        _crystalHighlight,
      );

      // Dua kaki di bawah badan kristal.
      for (final double dx in <double>[-0.28, 0.28]) {
        canvas.drawLine(
          Offset(center.dx + w * dx, body.bottom),
          Offset(center.dx + w * dx, body.bottom + h * 0.55),
          _metalStroke,
        );
      }
    }
  }

  void _paintChip(Canvas canvas, Size size) {
    final Rect chip = ArduinoGeometry.chipRect(size);
    final double ps = ArduinoGeometry.pinSize(size);
    final double legLength = chip.width * 0.07;
    final double legHeight = chip.height * 0.055;
    _chipStroke.strokeWidth = math.max(0.8, size.shortestSide * 0.004);

    // Kaki IC: 7 pasang, menjulur keluar badan.
    for (int i = 0; i < 7; i++) {
      final double y = chip.top + chip.height * (0.10 + 0.133 * i);
      canvas.drawRect(
        Rect.fromLTWH(
          chip.left - legLength,
          y - legHeight / 2,
          legLength,
          legHeight,
        ),
        _metalFill,
      );
      canvas.drawRect(
        Rect.fromLTWH(chip.right, y - legHeight / 2, legLength, legHeight),
        _metalFill,
      );
    }

    final RRect body = RRect.fromRectAndRadius(
      chip,
      Radius.circular(ps * 0.35),
    );
    canvas.drawRRect(body, _chipFill);
    canvas.drawRRect(body, _chipStroke);

    // Notch setengah lingkaran di kiri badan + titik pin 1.
    canvas.drawCircle(
      Offset(chip.left + chip.width * 0.10, chip.center.dy),
      chip.height * 0.10,
      _boardFill,
    );
    canvas.drawCircle(
      Offset(chip.left + chip.width * 0.16, chip.top + chip.height * 0.20),
      ps * 0.16,
      _metalFill,
    );

    // Kilau tipis di tepi atas badan.
    canvas.drawRect(
      Rect.fromLTWH(
        chip.left + chip.width * 0.06,
        chip.top + chip.height * 0.06,
        chip.width * 0.88,
        chip.height * 0.05,
      ),
      _chipHighlight,
    );

    _paintCenteredText(
      canvas,
      'ATmega328P',
      Offset(chip.center.dx, chip.center.dy - chip.height * 0.06),
      _silk(size: size, scale: 0.030, min: 5.0, letterSpacing: 0.4),
    );
    _paintCenteredText(
      canvas,
      'UNO R3',
      Offset(chip.center.dx, chip.center.dy + chip.height * 0.24),
      _silk(
        size: size,
        scale: 0.022,
        min: 4.0,
        color: AppColors.textOnPrimary.withValues(alpha: 0.55),
        letterSpacing: 0.6,
      ),
    );
  }

  void _paintIcspHeaders(Canvas canvas, Size size) {
    final double pad = ArduinoGeometry.pinSize(size) * 0.72;
    final double pitch = pad * 1.30;
    _chipStroke.strokeWidth = math.max(0.6, size.shortestSide * 0.003);

    for (int index = 0; index < 2; index++) {
      final Rect box = ArduinoGeometry.icspRect(size, index);
      final RRect shell = RRect.fromRectAndRadius(
        box,
        Radius.circular(pad * 0.60),
      );
      canvas.drawRRect(shell, _chipFill);
      canvas.drawRRect(shell, _chipStroke);

      final double originX = box.left + (box.width - (pitch + pad)) / 2;
      final double originY = box.top + (box.height - (pitch * 2 + pad)) / 2;
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 2; col++) {
          canvas.drawCircle(
            Offset(
              originX + pad / 2 + pitch * col,
              originY + pad / 2 + pitch * row,
            ),
            pad * 0.42,
            _metalFill,
          );
        }
      }
    }
  }

  void _paintResetButton(Canvas canvas, Size size) {
    final Offset center = ArduinoGeometry.resetCenter(size);
    final double r = ArduinoGeometry.resetRadius(size);
    _resetRing.strokeWidth = math.max(0.8, size.shortestSide * 0.004);

    canvas.drawCircle(center, r, _resetFill);
    canvas.drawCircle(center, r, _resetRing);
    canvas.drawCircle(center, r * 0.45, _chipFill);
  }

  void _paintIndicators(Canvas canvas, Size size) {
    const List<String> labels = <String>['L', 'TX', 'RX', 'ON'];
    final double r = ArduinoGeometry.indicatorRadius(size);
    _padStroke.strokeWidth = math.max(0.5, r * 0.25);

    for (int i = 0; i < labels.length; i++) {
      final Offset center = ArduinoGeometry.indicatorCenter(size, i);
      final bool lit = i == 3 || (i == 0 && scene.isLedOn);
      final Paint fill = lit
          ? (i == 3 ? _indicatorOn : _indicatorTx)
          : _indicatorOff;
      canvas.drawCircle(center, r, fill);
      canvas.drawCircle(center, r, _padStroke);
      _paintCenteredText(
        canvas,
        labels[i],
        Offset(center.dx, center.dy + r * 2.8),
        _silk(size: size, scale: 0.020, min: 4.0, letterSpacing: 0.2),
      );
    }
  }

  void _paintTopHeader(Canvas canvas, Size size) {
    final Rect strip = ArduinoGeometry.topHeaderRect(size);
    final Rect board = ArduinoGeometry.boardBounds(size);
    final double ps = ArduinoGeometry.pinSize(size);
    final int activeIndex = ArduinoGeometry.topPinIndex(scene.activePin);

    _paintStrip(
      canvas,
      strip,
      ArduinoGeometry.topPinCount,
      (int i) => ArduinoGeometry.topPinCenter(size, i),
      activeIndex,
      roundedTop: true,
    );

    // Label pin ditulis vertikal supaya 16 pin tetap terbaca tanpa bertabrakan.
    final double labelTop = strip.bottom + ps * 0.35;
    for (int i = 0; i < ArduinoGeometry.topPinCount; i++) {
      final bool active = i == activeIndex;
      _paintVerticalText(
        canvas,
        ArduinoGeometry.topPinLabels[i],
        ArduinoGeometry.topPinCenter(size, i).dx,
        labelTop,
        _silk(
          size: size,
          scale: 0.028,
          min: 5.0,
          color: active ? AppColors.circuitWire : _silkColor,
          weight: active ? FontWeight.w700 : FontWeight.w500,
        ),
      );
    }

    _paintCenteredText(
      canvas,
      'DIGITAL (PWM=~)',
      Offset(strip.center.dx, board.top + board.height * 0.235),
      _silk(size: size, scale: 0.026, min: 5.0, letterSpacing: 0.4),
    );
  }

  void _paintBottomHeaders(Canvas canvas, Size size) {
    final double ps = ArduinoGeometry.pinSize(size);
    final Rect power = ArduinoGeometry.powerHeaderRect(size);
    final Rect analog = ArduinoGeometry.analogHeaderRect(size);

    _paintStrip(
      canvas,
      power,
      ArduinoGeometry.powerPinCount,
      (int i) => ArduinoGeometry.powerPinCenter(size, i),
      -1,
      roundedTop: false,
    );
    _paintStrip(
      canvas,
      analog,
      ArduinoGeometry.analogPinCount,
      (int i) => ArduinoGeometry.analogPinCenter(size, i),
      -1,
      roundedTop: false,
    );

    // Label pin bawah juga vertikal: 7 pin POWER terlalu rapat untuk teks
    // horizontal di kanvas kecil.
    final double labelBottom = power.top - ps * 0.30;
    for (int i = 0; i < ArduinoGeometry.powerPinCount; i++) {
      _paintVerticalTextUp(
        canvas,
        ArduinoGeometry.powerPinLabels[i],
        ArduinoGeometry.powerPinCenter(size, i).dx,
        labelBottom,
        _silk(size: size, scale: 0.024, min: 4.6, letterSpacing: -0.2),
      );
    }
    for (int i = 0; i < ArduinoGeometry.analogPinCount; i++) {
      _paintVerticalTextUp(
        canvas,
        ArduinoGeometry.analogPinLabels[i],
        ArduinoGeometry.analogPinCenter(size, i).dx,
        labelBottom,
        _silk(size: size, scale: 0.024, min: 4.6, letterSpacing: -0.2),
      );
    }

    // Judul grup + garis pemisah di atas label pin.
    final double lineY = power.top - ps * 4.2;
    _paintCenteredText(
      canvas,
      'POWER',
      Offset(power.center.dx, lineY - ps * 1.3),
      _silk(size: size, scale: 0.026, min: 5.0, letterSpacing: 1.0),
    );
    _paintCenteredText(
      canvas,
      'ANALOG IN',
      Offset(analog.center.dx, lineY - ps * 1.3),
      _silk(size: size, scale: 0.026, min: 5.0, letterSpacing: 1.0),
    );

    _silkscreenStroke.strokeWidth = math.max(0.6, ps * 0.09);
    canvas.drawLine(
      Offset(power.left, lineY),
      Offset(power.right, lineY),
      _silkscreenStroke,
    );
    canvas.drawLine(
      Offset(analog.left, lineY),
      Offset(analog.right, lineY),
      _silkscreenStroke,
    );
  }

  /// Plastik header + pad pin; [activeIndex] < 0 berarti tanpa pin aktif.
  void _paintStrip(
    Canvas canvas,
    Rect strip,
    int count,
    Offset Function(int index) centerOf,
    int activeIndex, {
    required bool roundedTop,
  }) {
    final double ps = strip.height / 1.30;
    final Radius corner = Radius.circular(ps * 0.22);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        strip,
        topLeft: roundedTop ? corner : Radius.zero,
        topRight: roundedTop ? corner : Radius.zero,
        bottomLeft: roundedTop ? Radius.zero : corner,
        bottomRight: roundedTop ? Radius.zero : corner,
      ),
      _stripFill,
    );

    _padStroke.strokeWidth = math.max(0.5, ps * 0.10);
    for (int i = 0; i < count; i++) {
      final Rect pad = Rect.fromCenter(
        center: centerOf(i),
        width: ps,
        height: ps,
      );
      final RRect shell = RRect.fromRectAndRadius(
        pad,
        Radius.circular(ps * 0.22),
      );
      canvas.drawRRect(shell, i == activeIndex ? _padActiveFill : _padFill);
      canvas.drawRRect(shell, _padStroke);
    }
  }

  void _paintWire(Canvas canvas, Size size) {
    final List<Offset> points = ArduinoGeometry.wirePoints(
      size,
      scene.activePin,
    );
    _wireStroke.strokeWidth = math.max(2.0, size.shortestSide * 0.012);

    final Path path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, _wireStroke);
  }

  void _paintExtLed(Canvas canvas, Size size) {
    final Offset center = ArduinoGeometry.extLedCenter(size);
    final double radius = ArduinoGeometry.extLedRadius(size);
    final double legLength = radius * 0.90;

    // Kaki LED menghadap ke bawah (menuju header bawah).
    _metalStroke.strokeWidth = math.max(1.0, radius * 0.16);
    for (final double dx in <double>[-0.55, 0.55]) {
      final double x = center.dx + radius * dx;
      canvas.drawLine(
        Offset(x, center.dy + radius * 0.85),
        Offset(x, center.dy + radius + legLength),
        _metalStroke,
      );
    }

    if (scene.isLedOn) {
      canvas.drawCircle(center, radius * 2.2, _ledGlow);
      canvas.drawCircle(center, radius * 1.55, _ledGlowInner);
    }

    canvas.drawCircle(center, radius, scene.isLedOn ? _ledFillOn : _ledFillOff);
    canvas.drawCircle(center, radius, scene.isLedOn ? _ledRingOn : _ledRingOff);

    // Kilau kaca di kiri atas badan LED.
    canvas.drawCircle(
      Offset(center.dx - radius * 0.30, center.dy - radius * 0.35),
      radius * 0.26,
      _ledGloss,
    );

    _paintCenteredText(
      canvas,
      'LED',
      Offset(
        center.dx,
        center.dy +
            radius +
            legLength +
            math.max(4.0, size.shortestSide * 0.022),
      ),
      _silk(size: size, scale: 0.024, min: 4.5, letterSpacing: 0.4),
    );
  }

  /// Gaya teks silkscreen papan (Plus Jakarta Sans, ukuran mengikuti kanvas).
  TextStyle _silk({
    required Size size,
    required double scale,
    required double min,
    Color color = AppColors.textOnPrimary,
    FontWeight weight = FontWeight.w500,
    double letterSpacing = 0.0,
  }) {
    return AppTypography.overline.copyWith(
      fontSize: math.max(min, size.shortestSide * scale),
      color: color,
      fontWeight: weight,
      letterSpacing: letterSpacing,
      height: 1.0,
    );
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

  /// Teks diputar 90 derajat CCW: tumbuh ke bawah, dibaca dari bawah ke atas.
  void _paintVerticalText(
    Canvas canvas,
    String text,
    double x,
    double top,
    TextStyle style,
  ) {
    final TextPainter painter = _layoutText(text, style);
    canvas.save();
    canvas.translate(x + painter.height / 2, top + painter.width);
    canvas.rotate(-math.pi / 2);
    painter.paint(canvas, Offset.zero);
    canvas.restore();
    painter.dispose();
  }

  /// Teks vertikal yang tumbuh ke atas dari [bottom] (label header bawah).
  void _paintVerticalTextUp(
    Canvas canvas,
    String text,
    double x,
    double bottom,
    TextStyle style,
  ) {
    final TextPainter painter = _layoutText(text, style);
    canvas.save();
    canvas.translate(x + painter.height / 2, bottom);
    canvas.rotate(-math.pi / 2);
    painter.paint(canvas, Offset.zero);
    canvas.restore();
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
