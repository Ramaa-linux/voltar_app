import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/widgets/arduino_painter.dart';

/// Ukuran tetap supaya piksel yang diperiksa stabil (rasio 4:3 seperti halaman).
const Size _canvasSize = Size(400, 300);

int _channel(double value) => (value * 255).round();

void _expectColor(Color? actual, Color expected) {
  expect(actual, isNotNull);
  expect(_channel(actual!.r), _channel(expected.r));
  expect(_channel(actual.g), _channel(expected.g));
  expect(_channel(actual.b), _channel(expected.b));
}

/// Cat [painter] ke gambar RGBA lalu kembalikan warna pada [point].
Future<Color> _paintAndProbe(ArduinoPainter painter, Offset point) async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder, Offset.zero & _canvasSize);
  canvas.drawRect(
    Offset.zero & _canvasSize,
    Paint()..color = AppColors.background,
  );
  painter.paint(canvas, _canvasSize);

  final ui.Picture picture = recorder.endRecording();
  final ui.Image image = await picture.toImage(
    _canvasSize.width.round(),
    _canvasSize.height.round(),
  );
  final ByteData? data = await image.toByteData(
    format: ui.ImageByteFormat.rawRgba,
  );
  image.dispose();
  picture.dispose();

  final int width = _canvasSize.width.round();
  final int index = (point.dy.round() * width + point.dx.round()) * 4;
  final Uint8List bytes = data!.buffer.asUint8List();
  return Color.fromARGB(
    bytes[index + 3],
    bytes[index],
    bytes[index + 1],
    bytes[index + 2],
  );
}

void main() {
  test('shouldRepaint hanya saat scene berubah', () {
    final ArduinoPainter on = ArduinoPainter(
      scene: const ArduinoScene(isLedOn: true, activePin: 13),
    );
    final ArduinoPainter off = ArduinoPainter(
      scene: const ArduinoScene(isLedOn: false, activePin: 13),
    );
    final ArduinoPainter otherPin = ArduinoPainter(
      scene: const ArduinoScene(isLedOn: true, activePin: 12),
    );

    expect(on.shouldRepaint(off), isTrue);
    expect(off.shouldRepaint(on), isTrue);
    expect(on.shouldRepaint(otherPin), isTrue);
    expect(
      on.shouldRepaint(
        ArduinoPainter(scene: const ArduinoScene(isLedOn: true, activePin: 13)),
      ),
      isFalse,
    );
  });

  test('scene dibandingkan berdasarkan nilai', () {
    const ArduinoScene a = ArduinoScene(isLedOn: true, activePin: 13);
    const ArduinoScene b = ArduinoScene(isLedOn: true, activePin: 13);
    const ArduinoScene c = ArduinoScene(isLedOn: true, activePin: 7);

    expect(a, b);
    expect(a.hashCode, b.hashCode);
    expect(a, isNot(c));
  });

  test('pin 13 punya anchor di header atas, pin asing jatuh ke pin 13', () {
    final Size size = _canvasSize;
    final Rect board = ArduinoGeometry.boardBounds(size);
    final Rect strip = ArduinoGeometry.topHeaderRect(size);
    final Offset pad13 = ArduinoGeometry.topPinCenter(size, 2);
    final Offset anchor = ArduinoGeometry.pinAnchor(size, 13);

    expect(ArduinoGeometry.topPinIndex(13), 2);
    expect(ArduinoGeometry.topPinIndex(0), 15);
    expect(anchor.dx, closeTo(pad13.dx, 1e-9));
    expect(anchor.dy, closeTo(strip.bottom, 1e-9));
    expect(strip.top, closeTo(board.top, 1e-9));
    expect(strip.right, lessThan(board.right));

    // Nomor pin di luar rentang tetap aman (fallback ke pin 13).
    expect(ArduinoGeometry.pinAnchor(size, 99), anchor);
    expect(ArduinoGeometry.pinAnchor(size, -3), anchor);
  });

  test('label header mengikuti silkscreen Uno', () {
    expect(ArduinoGeometry.topPinLabels.length, ArduinoGeometry.topPinCount);
    expect(
      ArduinoGeometry.powerPinLabels.length,
      ArduinoGeometry.powerPinCount,
    );
    expect(
      ArduinoGeometry.analogPinLabels.length,
      ArduinoGeometry.analogPinCount,
    );
    expect(ArduinoGeometry.topPinLabels.first, 'AREF');
    expect(ArduinoGeometry.topPinLabels[2], '13');
    expect(ArduinoGeometry.topPinLabels.last, 'RX\u21900');
    expect(ArduinoGeometry.powerPinLabels.first, 'VIN');
    expect(ArduinoGeometry.powerPinLabels.last, 'IOREF');
    expect(ArduinoGeometry.analogPinLabels.last, 'A5');
  });

  test('LED eksternal tidak menimpa IC, ICSP, maupun tepi papan', () {
    final Size size = _canvasSize;
    final Rect led = Rect.fromCircle(
      center: ArduinoGeometry.extLedCenter(size),
      radius: ArduinoGeometry.extLedRadius(size),
    );

    expect(led.overlaps(ArduinoGeometry.chipRect(size)), isFalse);
    for (int i = 0; i < 2; i++) {
      expect(led.overlaps(ArduinoGeometry.icspRect(size, i)), isFalse);
    }
    expect(ArduinoGeometry.boardBounds(size).contains(led.center), isTrue);
    expect(ArduinoGeometry.boardBounds(size).contains(led.bottomRight), isTrue);
  });

  test('rute kabel tidak melewati badan IC', () {
    final List<Offset> points = ArduinoGeometry.wirePoints(_canvasSize, 13);
    final Rect chip = ArduinoGeometry.chipRect(_canvasSize).inflate(1);

    expect(points.length, 4);
    for (int i = 0; i < points.length - 1; i++) {
      for (int step = 0; step <= 50; step++) {
        final Offset point = Offset.lerp(points[i], points[i + 1], step / 50)!;
        expect(
          chip.contains(point),
          isFalse,
          reason: 'segmen $i langkah $step di $point',
        );
      }
    }
  });

  testWidgets('LED berubah warna mengikuti isLedOn', (
    WidgetTester tester,
  ) async {
    final Offset led = ArduinoGeometry.extLedCenter(_canvasSize);

    final Color? on = await tester.runAsync<Color>(
      () => _paintAndProbe(
        ArduinoPainter(scene: const ArduinoScene(isLedOn: true, activePin: 13)),
        led,
      ),
    );
    final Color? off = await tester.runAsync<Color>(
      () => _paintAndProbe(
        ArduinoPainter(
          scene: const ArduinoScene(isLedOn: false, activePin: 13),
        ),
        led,
      ),
    );

    _expectColor(on, AppColors.ledOn);
    _expectColor(off, AppColors.ledOff);
  });

  testWidgets('kabel dari pin aktif memakai token circuitWire', (
    WidgetTester tester,
  ) async {
    final List<Offset> points = ArduinoGeometry.wirePoints(_canvasSize, 13);
    final Offset midWire = Offset.lerp(points[1], points[2], 0.5)!;

    final Color? wire = await tester.runAsync<Color>(
      () => _paintAndProbe(
        ArduinoPainter(
          scene: const ArduinoScene(isLedOn: false, activePin: 13),
        ),
        midWire,
      ),
    );

    _expectColor(wire, AppColors.circuitWire);
  });
}
