import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_typography.dart';

/// Papan Arduino Uno 2D untuk canvas Simulator.
///
/// Semua koordinat memakai satuan desain 1400x1000 (lebar x tinggi papan)
/// dengan margin kiri 130, atas 170, kanan 330 (kabel + LED), bawah 40.
/// [ArduinoPainter.paint] menghitung skala "contain" dari
/// [ArduinoGeometry.canvasAspect] lalu menggambar seluruh komponen di ruang
/// desain itu, jadi proporsi papan tidak pernah gepeng di ukuran layar apa pun.
///
/// Pemakaian:
/// ```dart
/// AspectRatio(
///   aspectRatio: ArduinoGeometry.canvasAspect,
///   child: CustomPaint(painter: ArduinoPainter(ledOn: isHigh)),
/// )
/// ```
abstract final class ArduinoGeometry {
  static const double boardWidth = 1400;
  static const double boardHeight = 1000;
  static const double marginLeft = 130;
  static const double marginTop = 170;
  static const double marginRight = 330;
  static const double marginBottom = 40;

  /// Lebar kanvas desain termasuk margin kabel/LED.
  static const double canvasWidth = marginLeft + boardWidth + marginRight;

  /// Tinggi kanvas desain termasuk margin kabel/LED.
  static const double canvasHeight = marginTop + boardHeight + marginBottom;

  /// Rasio kanvas untuk [AspectRatio] halaman simulator (1860 / 1210).
  static const double canvasAspect = canvasWidth / canvasHeight;

  /// Jarak antar pin header (satuan desain).
  static const double pinPitch = 54;

  /// Pin digital yang dipantau demo blink (D13 = LED bawaan papan).
  static const int watchedPin = 13;

  /// Posisi LED eksternal di margin kanan.
  static const double ledX = 1625;
  static const double ledY = 340;

  /// Jari-jari cincin LED eksternal.
  static const double ledRim = 46;

  /// Skala "contain" untuk [size].
  static double scale(Size size) {
    if (size.isEmpty) {
      return 0;
    }
    return math.min(size.width / canvasWidth, size.height / canvasHeight);
  }

  /// Titik kiri-atas kanvas desain setelah di-scale.
  static Offset canvasOrigin(Size size) {
    final double k = scale(size);
    return Offset(
      (size.width - canvasWidth * k) / 2,
      (size.height - canvasHeight * k) / 2,
    );
  }

  /// Titik kiri-atas papan (tanpa margin) dalam piksel kanvas.
  static Offset boardOrigin(Size size) {
    final double k = scale(size);
    return canvasOrigin(size) + Offset(marginLeft * k, marginTop * k);
  }

  /// Persegi papan di kanvas fisik.
  static Rect boardRect(Size size) {
    final double k = scale(size);
    return boardOrigin(size) & Size(boardWidth * k, boardHeight * k);
  }

  /// Persegi badan IC ATmega328P di kanvas fisik.
  static Rect chipRect(Size size) {
    final Offset origin = boardOrigin(size);
    final double k = scale(size);
    return Rect.fromLTWH(
      origin.dx + 609 * k,
      origin.dy + 582 * k,
      721 * k,
      95 * k,
    );
  }

  /// Titik tengah LED eksternal di kanvas fisik.
  static Offset ledCenter(Size size) {
    final double k = scale(size);
    return boardOrigin(size) + Offset(ledX * k, ledY * k);
  }

  /// Koordinat-x pin digital D0..D13 pada baris header atas (satuan desain).
  static double digitalPinX(int pin) {
    final int index = pin.clamp(0, 13);
    return index <= 7 ? 236 + index * pinPitch : 690 + (index - 8) * pinPitch;
  }

  /// Titik tengah pin digital pada kanvas fisik (untuk uji kabel).
  static Offset pinCenter(Size size, int pin) {
    final double k = scale(size);
    final Offset origin = boardOrigin(size);
    return Offset(origin.dx + digitalPinX(pin) * k, origin.dy + 50 * k);
  }
}

/// Menggambar papan Arduino Uno lengkap (USB, jack DC, header pin, IC,
/// kristal, tombol reset) plus kabel jumper dan LED eksternal di margin kanan.
///
/// Warna hanya lewat [AppColors] - tidak ada `Color(0x...)` di widget ini.
class ArduinoPainter extends CustomPainter {
  ArduinoPainter({this.ledOn = false});

  /// Status pin [ArduinoGeometry.watchedPin]: `true` = LED menyala.
  final bool ledOn;

  // --- Warna teks silkscreen ---
  final Color _silkColor = AppColors.textOnPrimary.withValues(alpha: 0.92);
  final Color _outsideText = AppColors.circuitPinHeader;
  final Color _outsideMuted = AppColors.circuitPinHeader.withValues(
    alpha: 0.62,
  );

  // --- Papan ---
  final Paint _shadow = _fill(AppColors.shadow.withValues(alpha: 0.34))
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
  final Paint _boardFill = _fill(AppColors.circuitBoard);
  final Paint _boardEdge = _line(AppColors.circuitBoardDark, 8);
  final Paint _silkLine = _line(
    AppColors.textOnPrimary.withValues(alpha: 0.30),
    3,
  );

  // --- Komponen ---
  final Paint _usbBody = _fill(AppColors.circuitUsbBody);
  final Paint _usbBand = _fill(AppColors.circuitUsbBand);
  final Paint _usbRecess = _fill(AppColors.circuitUsbRecess);
  final Paint _usbShade = _fill(AppColors.circuitUsbShade);
  final Paint _usbHi = _fill(AppColors.textOnPrimary.withValues(alpha: 0.38));
  final Paint _usbFlange = _fill(AppColors.circuitUsbFlange);
  final Paint _dark = _fill(AppColors.circuitPinHeader);
  final Paint _darker = _fill(AppColors.circuitChip);
  final Paint _padFill = _fill(AppColors.circuitPinBox);
  final Paint _holeFill = _fill(AppColors.circuitPin);
  final Paint _metal = _fill(AppColors.circuitMetalLight);
  final Paint _metalRing = _fill(AppColors.circuitMetal);
  final Paint _silver = _fill(AppColors.circuitCrystal);
  final Paint _silverRing = _line(AppColors.circuitMetal, 5);
  final Paint _jack = _fill(AppColors.circuitJack);
  final Paint _jackLip = _fill(AppColors.circuitJackLip);
  final Paint _smdOff = _fill(AppColors.circuitPinHeader);

  // --- Reset ---
  final Paint _resetBase = _fill(AppColors.circuitMetal);
  final Paint _resetBody = _fill(AppColors.circuitReset);
  final Paint _resetRing = _line(AppColors.circuitResetDark, 7);
  final Paint _resetHi = _fill(AppColors.textOnPrimary.withValues(alpha: 0.34));

  // --- Kabel & LED ---
  final Paint _wireEdge = _line(
    AppColors.circuitWireDark,
    26,
    cap: StrokeCap.round,
  );
  final Paint _wire = _line(AppColors.circuitWire, 19, cap: StrokeCap.round);
  final Paint _ledOffFill = _fill(AppColors.ledOff);
  final Paint _ledOnFill = _fill(AppColors.ledOn);
  final Paint _ledRimOff = _fill(AppColors.circuitMetal);
  final Paint _ledRimOn = _fill(AppColors.circuitLedRimOn);
  final Paint _ledHi = _fill(AppColors.textOnPrimary.withValues(alpha: 0.5));
  final Paint _ledGlowOuter = _fill(AppColors.ledOn.withValues(alpha: 0.26))
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 46);
  final Paint _ledGlowInner = _fill(AppColors.ledOn.withValues(alpha: 0.5))
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
  final Paint _statusGlow = _fill(AppColors.ledOn.withValues(alpha: 0.45))
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);

  // --- Nama pin ---
  static const List<String> _leftPins = <String>[
    'D0',
    'D1',
    'D2',
    'D3',
    'D4',
    'D5',
    'D6',
    'D7',
  ];
  static const List<String> _rightPins = <String>[
    'D8',
    'D9',
    'D10',
    'D11',
    'D12',
    'D13',
    'GND',
    'AREF',
  ];
  static const List<String> _powerPins = <String>[
    'IOREF',
    'RESET',
    '3V3',
    '5V',
    'GND',
    'GND',
    'VIN',
    'NC',
  ];
  static const List<String> _analogPins = <String>[
    'A0',
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double k = ArduinoGeometry.scale(size);
    if (size.isEmpty || k <= 0) {
      return;
    }
    final Offset origin = ArduinoGeometry.boardOrigin(size);
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.scale(k);

    _paintBoard(canvas);
    _paintSilk(canvas);
    _paintUsb(canvas);
    _paintJack(canvas);
    _paintRegulator(canvas);
    _paintReset(canvas);
    _paintStatusLeds(canvas);
    _paintHeaders(canvas);
    _paintIcsp(canvas);
    _paintChip(canvas);
    _paintCrystal(canvas);
    _paintLabels(canvas);
    _paintWire(canvas);
    _paintLed(canvas);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ArduinoPainter oldDelegate) =>
      oldDelegate.ledOn != ledOn;

  void _paintBoard(Canvas canvas) {
    const double w = ArduinoGeometry.boardWidth;
    const double h = ArduinoGeometry.boardHeight;
    const double r = 26;
    const double cut = 58;
    final Path path = Path()
      ..moveTo(r, 0)
      ..lineTo(w - r, 0)
      ..quadraticBezierTo(w, 0, w, r)
      ..lineTo(w, h - cut)
      ..lineTo(w - cut, h)
      ..lineTo(r, h)
      ..quadraticBezierTo(0, h, 0, h - r)
      ..lineTo(0, r)
      ..quadraticBezierTo(0, 0, r, 0)
      ..close();

    canvas.drawPath(path.shift(const Offset(0, 14)), _shadow);
    canvas.drawPath(path, _boardFill);
    canvas.drawPath(path, _boardEdge);
  }

  void _paintSilk(Canvas canvas) {
    const double w = ArduinoGeometry.boardWidth;
    canvas.drawLine(const Offset(70, 206), Offset(w - 70, 206), _silkLine);
    canvas.drawLine(const Offset(70, 706), Offset(w - 70, 706), _silkLine);
  }

  void _paintUsb(Canvas canvas) {
    // Flens dudukan yang menempel ke papan.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-4, 172, 42, 222),
        const Radius.circular(8),
      ),
      _usbFlange,
    );
    // Badan konektor menjorok keluar tepi kiri papan.
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        const Rect.fromLTWH(-112, 194, 308, 178),
        topLeft: const Radius.circular(18),
        bottomLeft: const Radius.circular(18),
        topRight: const Radius.circular(10),
        bottomRight: const Radius.circular(10),
      ),
      _usbBody,
    );
    // Pita logam melintang.
    canvas.drawRect(const Rect.fromLTWH(-112, 232, 308, 20), _usbBand);
    canvas.drawRect(const Rect.fromLTWH(-112, 318, 308, 14), _usbBand);
    // Cekungan mulut konektor.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-98, 214, 120, 138),
        const Radius.circular(10),
      ),
      _usbRecess,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-86, 230, 96, 106),
        const Radius.circular(7),
      ),
      _usbShade,
    );
    // Kilau atas.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-52, 202, 226, 9),
        const Radius.circular(5),
      ),
      _usbHi,
    );
    _text(
      canvas,
      'USB',
      const Offset(132, 276),
      size: 26,
      color: _usbShade.color,
      align: TextAlign.center,
      weight: FontWeight.w700,
    );
  }

  void _paintJack(Canvas canvas) {
    const Offset hub = Offset(96, 825);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-40, 744, 136, 162),
        const Radius.circular(16),
      ),
      _jack,
    );
    canvas.drawCircle(hub, 84, _jack);
    canvas.drawCircle(hub, 84, _line(AppColors.circuitJackLip, 9));
    canvas.drawCircle(hub, 58, _jackLip);
    canvas.drawCircle(hub, 30, _darker);
    // Pin tengah jack.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-40, 806, 78, 38),
        const Radius.circular(10),
      ),
      _metal,
    );
    _text(
      canvas,
      'DC IN',
      const Offset(30, 940),
      size: 24,
      color: _silkColor,
      align: TextAlign.center,
      weight: FontWeight.w700,
    );
  }

  void _paintRegulator(Canvas canvas) {
    // Tab logam regulator 5V.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(118, 536, 96, 158),
        const Radius.circular(8),
      ),
      _metal,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(136, 560, 60, 110),
        const Radius.circular(5),
      ),
      _darker,
    );
    for (int i = 0; i < 3; i++) {
      canvas.drawRect(Rect.fromLTWH(141 + i * 26, 694, 12, 40), _metal);
    }
    _text(
      canvas,
      'NCP1117',
      const Offset(166, 500),
      size: 20,
      color: _silkColor.withValues(alpha: 0.75),
      align: TextAlign.center,
    );
  }

  void _paintReset(Canvas canvas) {
    const Offset center = Offset(131, 80);
    canvas.drawCircle(center, 56, _resetBase);
    canvas.drawCircle(center, 46, _resetBody);
    canvas.drawCircle(center, 46, _resetRing);
    canvas.drawCircle(center.translate(-13, -13), 12, _resetHi);
    _text(
      canvas,
      'RESET',
      const Offset(131, 154),
      size: 24,
      color: _silkColor,
      align: TextAlign.center,
      weight: FontWeight.w700,
    );
  }

  void _paintStatusLeds(Canvas canvas) {
    const List<String> names = <String>['L', 'TX', 'RX'];
    for (int i = 0; i < names.length; i++) {
      final Offset center = Offset(246, 258 + i * 60.0);
      canvas.drawCircle(center, 25, _metalRing);
      if (i == 0) {
        if (ledOn) {
          canvas.drawCircle(center, 26, _statusGlow);
        }
        canvas.drawCircle(center, 19, ledOn ? _ledOnFill : _smdOff);
      } else {
        canvas.drawCircle(
          center,
          19,
          _fill(AppColors.circuitLedAmber.withValues(alpha: 0.36)),
        );
      }
      _text(
        canvas,
        names[i],
        center.translate(40, 0),
        size: 24,
        color: _silkColor,
        weight: FontWeight.w700,
      );
    }
  }

  void _paintHeaders(Canvas canvas) {
    _headerStrip(canvas, const Rect.fromLTWH(209, 26, 432, 48), 8, 236, 54);
    _headerStrip(canvas, const Rect.fromLTWH(663, 26, 432, 48), 8, 690, 54);
    _headerStrip(canvas, const Rect.fromLTWH(613, 800, 426, 48), 8, 640, 54);
    _headerStrip(canvas, const Rect.fromLTWH(1043, 800, 324, 48), 6, 1070, 54);

    for (int i = 0; i < _leftPins.length; i++) {
      _verticalText(
        canvas,
        _leftPins[i],
        Offset(236 + i * 54, 88),
        size: 26,
        downward: true,
      );
      _verticalText(
        canvas,
        _rightPins[i],
        Offset(690 + i * 54, 88),
        size: 26,
        downward: true,
      );
    }
    for (int i = 0; i < _powerPins.length; i++) {
      _verticalText(
        canvas,
        _powerPins[i],
        Offset(640 + i * 54, 792),
        size: 26,
        downward: false,
      );
    }
    for (int i = 0; i < _analogPins.length; i++) {
      _verticalText(
        canvas,
        _analogPins[i],
        Offset(1070 + i * 54, 792),
        size: 26,
        downward: false,
      );
    }
  }

  void _headerStrip(
    Canvas canvas,
    Rect strip,
    int count,
    double firstX,
    double pitch,
  ) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(strip, const Radius.circular(6)),
      _dark,
    );
    for (int i = 0; i < count; i++) {
      final Offset center = Offset(firstX + i * pitch, strip.center.dy);
      canvas.drawRect(
        Rect.fromCenter(center: center, width: 30, height: 30),
        _padFill,
      );
      canvas.drawRect(
        Rect.fromCenter(center: center, width: 14, height: 14),
        _holeFill,
      );
    }
  }

  void _paintIcsp(Canvas canvas) {
    _icsp(canvas, const Rect.fromLTWH(330, 430, 130, 90));
    _icsp(canvas, const Rect.fromLTWH(1185, 455, 130, 90));
  }

  void _icsp(Canvas canvas, Rect box) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(box, const Radius.circular(6)),
      _dark,
    );
    for (int row = 0; row < 2; row++) {
      for (int col = 0; col < 3; col++) {
        final Offset center = Offset(
          box.left + 32 + col * 33,
          box.top + 28 + row * 36,
        );
        canvas.drawRect(
          Rect.fromCenter(center: center, width: 26, height: 26),
          _padFill,
        );
        canvas.drawRect(
          Rect.fromCenter(center: center, width: 12, height: 12),
          _holeFill,
        );
      }
    }
  }

  void _paintChip(Canvas canvas) {
    const Rect body = Rect.fromLTWH(609, 582, 721, 95);
    for (int i = 0; i < 14; i++) {
      final double x = body.left + 22 + i * 50;
      canvas.drawRect(Rect.fromLTWH(x, body.top - 16, 16, 22), _metal);
      canvas.drawRect(Rect.fromLTWH(x, body.bottom - 6, 16, 22), _metal);
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(body, const Radius.circular(9)),
      _darker,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(body, const Radius.circular(9)),
      _silverRing,
    );
    // Lekuk penanda pin 1 di ujung kiri.
    canvas.drawCircle(Offset(body.left + 34, body.center.dy), 16, _boardFill);
    canvas.drawCircle(
      Offset(body.left + 34, body.center.dy),
      16,
      _line(AppColors.circuitBoardDark, 4),
    );
    canvas.drawCircle(Offset(body.left + 74, body.center.dy), 7, _metalRing);
    _text(
      canvas,
      'ATMEGA328P-PU',
      Offset(body.center.dx + 26, body.center.dy),
      size: 28,
      color: AppColors.borderStrong,
      align: TextAlign.center,
      weight: FontWeight.w700,
      letterSpacing: 2,
    );
    _text(
      canvas,
      'ATMEL',
      Offset(body.center.dx + 26, body.top + 21),
      size: 18,
      color: AppColors.borderStrong,
      align: TextAlign.center,
      letterSpacing: 3,
    );
  }

  void _paintCrystal(Canvas canvas) {
    for (final double x in <double>[344, 486]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, 806), width: 118, height: 118),
          const Radius.circular(24),
        ),
        _metal,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, 800), width: 92, height: 104),
          const Radius.circular(18),
        ),
        _silver,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, 800), width: 92, height: 104),
          const Radius.circular(18),
        ),
        _silverRing,
      );
      canvas.drawRect(Rect.fromLTWH(x - 30, 858, 12, 40), _metal);
      canvas.drawRect(Rect.fromLTWH(x + 18, 858, 12, 40), _metal);
    }
    _text(
      canvas,
      '16MHz',
      const Offset(415, 690),
      size: 24,
      color: _silkColor,
      align: TextAlign.center,
      weight: FontWeight.w700,
    );
  }

  void _paintLabels(Canvas canvas) {
    // Merek papan.
    _text(
      canvas,
      'ARDUINO',
      const Offset(600, 320),
      size: 58,
      color: _silkColor,
      align: TextAlign.center,
      weight: FontWeight.w700,
      letterSpacing: 8,
    );
    canvas.drawRect(
      const Rect.fromLTWH(470, 356, 260, 4),
      _fill(AppColors.textOnPrimary.withValues(alpha: 0.55)),
    );
    _text(
      canvas,
      'UNO R3',
      const Offset(600, 392),
      size: 28,
      color: _silkColor.withValues(alpha: 0.8),
      align: TextAlign.center,
      letterSpacing: 6,
    );
    // Judul grup header.
    _text(
      canvas,
      'DIGITAL (PWM~)',
      const Offset(209, 178),
      size: 28,
      color: _silkColor,
      letterSpacing: 2,
    );
    _text(
      canvas,
      'POWER',
      const Offset(826, 900),
      size: 28,
      color: _silkColor,
      align: TextAlign.center,
      letterSpacing: 2,
    );
    _text(
      canvas,
      'ANALOG IN',
      const Offset(1205, 900),
      size: 28,
      color: _silkColor,
      align: TextAlign.center,
      letterSpacing: 2,
    );
  }

  void _paintWire(Canvas canvas) {
    final double startX = ArduinoGeometry.digitalPinX(
      ArduinoGeometry.watchedPin,
    );
    const double cruiseY = -118;
    const double ledTop = ArduinoGeometry.ledY - ArduinoGeometry.ledRim;
    final Path path = Path()
      ..moveTo(startX, 50)
      ..lineTo(startX, -20)
      ..cubicTo(startX, cruiseY, startX + 60, cruiseY, startX + 150, cruiseY)
      ..lineTo(1520, cruiseY)
      ..cubicTo(
        1600,
        cruiseY,
        ArduinoGeometry.ledX,
        40,
        ArduinoGeometry.ledX,
        ledTop,
      );
    canvas.drawPath(path, _wireEdge);
    canvas.drawPath(path, _wire);
  }

  void _paintLed(Canvas canvas) {
    const Offset center = Offset(ArduinoGeometry.ledX, ArduinoGeometry.ledY);
    if (ledOn) {
      canvas.drawCircle(center, 92, _ledGlowOuter);
      canvas.drawCircle(center, 64, _ledGlowInner);
    }
    // Kaki LED.
    canvas.drawRect(
      Rect.fromLTWH(center.dx - 26, center.dy + 24, 12, 96),
      _metal,
    );
    canvas.drawRect(
      Rect.fromLTWH(center.dx + 14, center.dy + 24, 12, 96),
      _metal,
    );
    // Badan LED.
    canvas.drawCircle(
      center,
      ArduinoGeometry.ledRim,
      ledOn ? _ledRimOn : _ledRimOff,
    );
    canvas.drawCircle(center, 38, ledOn ? _ledOnFill : _ledOffFill);
    canvas.drawCircle(center.translate(-13, -15), 11, _ledHi);
    _text(
      canvas,
      ledOn ? 'LED ON' : 'LED OFF',
      center.translate(0, 136),
      size: 30,
      color: _outsideText,
      align: TextAlign.center,
      weight: FontWeight.w700,
    );
    _text(
      canvas,
      'D13 / 220R',
      center.translate(0, 176),
      size: 24,
      color: _outsideMuted,
      align: TextAlign.center,
    );
  }

  // --- Helper teks ---

  TextPainter _layoutText(
    String text, {
    required double size,
    required Color color,
    TextAlign align = TextAlign.left,
    FontWeight weight = FontWeight.w500,
    double letterSpacing = 0,
  }) {
    return TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: size,
          height: 1.1,
          fontWeight: weight,
          letterSpacing: letterSpacing,
          color: color,
        ),
      ),
      textAlign: align,
      textDirection: TextDirection.ltr,
    )..layout();
  }

  /// Teks horizontal. [anchor] = titik kiri/tengah/kanan pada garis tengah.
  void _text(
    Canvas canvas,
    String text,
    Offset anchor, {
    required double size,
    required Color color,
    TextAlign align = TextAlign.left,
    FontWeight weight = FontWeight.w500,
    double letterSpacing = 0,
  }) {
    final TextPainter painter = _layoutText(
      text,
      size: size,
      color: color,
      align: align,
      weight: weight,
      letterSpacing: letterSpacing,
    );
    final double dx = switch (align) {
      TextAlign.center => anchor.dx - painter.width / 2,
      TextAlign.right => anchor.dx - painter.width,
      _ => anchor.dx,
    };
    painter.paint(canvas, Offset(dx, anchor.dy - painter.height / 2));
    painter.dispose();
  }

  /// Teks silkscreen diputar 90 derajat, tetap dirapatkan ke [anchor].
  void _verticalText(
    Canvas canvas,
    String text,
    Offset anchor, {
    required double size,
    required bool downward,
  }) {
    final TextPainter painter = _layoutText(
      text,
      size: size,
      color: _silkColor,
      weight: FontWeight.w700,
      letterSpacing: 1,
    );
    canvas.save();
    canvas.translate(anchor.dx, anchor.dy);
    canvas.rotate(downward ? math.pi / 2 : -math.pi / 2);
    painter.paint(canvas, Offset(0, -painter.height / 2));
    canvas.restore();
    painter.dispose();
  }

  static Paint _fill(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  static Paint _line(
    Color color,
    double width, {
    StrokeCap cap = StrokeCap.butt,
  }) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..strokeCap = cap
    ..isAntiAlias = true;

  @override
  bool shouldRebuildSemantics(covariant ArduinoPainter oldDelegate) => false;
}
