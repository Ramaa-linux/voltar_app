import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/widgets/circuit_canvas.dart';

/// Ukuran tetap supaya piksel yang diperiksa stabil.
const Size _canvasSize = Size(400, 300);

int _channel(double value) => (value * 255).round();

/// Cat [painter] ke gambar RGBA lalu kembalikan warna pada [point].
Future<Color> _paintAndProbe(CircuitCanvas painter, Offset point) async {
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
  test('shouldRepaint hanya saat isLedOn berubah', () {
    const CircuitCanvas on = CircuitCanvas(isLedOn: true);
    const CircuitCanvas off = CircuitCanvas(isLedOn: false);

    expect(on.shouldRepaint(off), isTrue);
    expect(off.shouldRepaint(on), isTrue);
    expect(on.shouldRepaint(const CircuitCanvas(isLedOn: true)), isFalse);
  });

  testWidgets('LED berubah warna mengikuti isLedOn', (
    WidgetTester tester,
  ) async {
    final Offset led = CircuitCanvas.ledCenter(_canvasSize);

    final Color? on = await tester.runAsync<Color>(
      () => _paintAndProbe(const CircuitCanvas(isLedOn: true), led),
    );
    final Color? off = await tester.runAsync<Color>(
      () => _paintAndProbe(const CircuitCanvas(isLedOn: false), led),
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

  testWidgets('kabel pin 13 memakai token circuitWire', (
    WidgetTester tester,
  ) async {
    final List<Offset> points = CircuitCanvas.wirePoints(_canvasSize);
    final Offset midWire = Offset.lerp(points[0], points[1], 0.5)!;

    final Color? wire = await tester.runAsync<Color>(
      () => _paintAndProbe(const CircuitCanvas(isLedOn: false), midWire),
    );

    expect(wire, isNotNull);
    expect(_channel(wire!.r), _channel(AppColors.circuitWire.r));
    expect(_channel(wire.g), _channel(AppColors.circuitWire.g));
    expect(_channel(wire.b), _channel(AppColors.circuitWire.b));
  });
}
