import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/widgets/arduino_painter.dart';

/// Ukuran tetap supaya piksel yang diperiksa stabil (rasio 4:3 seperti halaman).
const Size _canvasSize = Size(400, 300);

int _channel(double value) => (value * 255).round();

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

  test('geometri pin aktif menempel di tepi kanan papan', () {
    final Rect board = ArduinoGeometry.boardRect(_canvasSize);
    final Offset anchor = ArduinoGeometry.pinAnchor(_canvasSize, 13);

    expect(anchor.dx, closeTo(board.right, 1e-9));
    expect(anchor.dy, greaterThan(board.top));
    expect(anchor.dy, lessThan(board.bottom));
    // Di luar rentang tetap aman (di-clamp ke pin terakhir).
    expect(
      ArduinoGeometry.pinAnchor(_canvasSize, 99),
      ArduinoGeometry.pinAnchor(
        _canvasSize,
        ArduinoGeometry.digitalPinCount - 1,
      ),
    );
  });

  test('label pin digital D0-D13 lalu TX/RX', () {
    expect(ArduinoGeometry.digitalPinLabel(0), 'D0');
    expect(ArduinoGeometry.digitalPinLabel(13), 'D13');
    expect(ArduinoGeometry.digitalPinLabel(14), 'TX');
    expect(ArduinoGeometry.digitalPinLabel(15), 'RX');
  });

  testWidgets('LED berubah warna mengikuti isLedOn', (
    WidgetTester tester,
  ) async {
    final Offset led = ArduinoGeometry.ledCenter(_canvasSize);

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

    expect(on, isNotNull);
    expect(off, isNotNull);

    // LED nyala: tepat di pusat memakai token ledOn.
    expect(_channel(on!.r), _channel(AppColors.ledOn.r));
    expect(_channel(on.g), _channel(AppColors.ledOn.g));
    expect(_channel(on.b), _channel(AppColors.ledOn.b));

    // LED mati: memakai token ledOff.
    expect(_channel(off!.r), _channel(AppColors.ledOff.r));
    expect(_channel(off.g), _channel(AppColors.ledOff.g));
    expect(_channel(off.b), _channel(AppColors.ledOff.b));
  });

  testWidgets('kabel dari pin aktif memakai token circuitWire', (
    WidgetTester tester,
  ) async {
    final List<Offset> points = ArduinoGeometry.wirePoints(_canvasSize, 13);
    final Offset midWire = Offset.lerp(points[0], points[1], 0.5)!;

    final Color? wire = await tester.runAsync<Color>(
      () => _paintAndProbe(
        ArduinoPainter(
          scene: const ArduinoScene(isLedOn: false, activePin: 13),
        ),
        midWire,
      ),
    );

    expect(wire, isNotNull);
    expect(_channel(wire!.r), _channel(AppColors.circuitWire.r));
    expect(_channel(wire.g), _channel(AppColors.circuitWire.g));
    expect(_channel(wire.b), _channel(AppColors.circuitWire.b));
  });
}
