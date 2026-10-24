import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/widgets/arduino_painter.dart';

/// Kanvas desain 1860x1210 di-skala 0.5 = 930x605 supaya titik probe bulat.
const Size _canvasSize = Size(930, 605);

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

Widget _host(ArduinoPainter painter) {
  return MaterialApp(
    home: Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AspectRatio(
          aspectRatio: ArduinoGeometry.canvasAspect,
          child: CustomPaint(painter: painter, child: const SizedBox.expand()),
        ),
      ),
    ),
  );
}

void main() {
  test('shouldRepaint hanya saat ledOn berubah', () {
    final ArduinoPainter on = ArduinoPainter(ledOn: true);
    final ArduinoPainter off = ArduinoPainter(ledOn: false);

    expect(on.shouldRepaint(off), isTrue);
    expect(off.shouldRepaint(on), isTrue);
    expect(on.shouldRepaint(ArduinoPainter(ledOn: true)), isFalse);
  });

  test('geometri desain konsisten di dalam kanvas', () {
    expect(ArduinoGeometry.canvasAspect, closeTo(1860 / 1210, 1e-9));
    expect(ArduinoGeometry.canvasAspect, greaterThan(1.4));
    expect(ArduinoGeometry.canvasAspect, lessThan(1.7));

    final Rect canvas = Offset.zero & _canvasSize;
    final Rect board = ArduinoGeometry.boardRect(_canvasSize);
    expect(canvas.contains(board.topLeft), isTrue);
    expect(canvas.contains(board.bottomRight - const Offset(1, 1)), isTrue);
    expect(
      board.width / board.height,
      closeTo(ArduinoGeometry.boardWidth / ArduinoGeometry.boardHeight, 1e-9),
    );

    // LED eksternal di margin kanan, tidak menimpa IC.
    final Offset led = ArduinoGeometry.ledCenter(_canvasSize);
    final Rect chip = ArduinoGeometry.chipRect(_canvasSize);
    expect(canvas.contains(led), isTrue);
    expect(led.dx, greaterThan(chip.right));
    expect(led.dy, lessThan(chip.top));

    // Pin D13 masih berada di papan.
    final Offset pin = ArduinoGeometry.pinCenter(_canvasSize, 13);
    expect(board.contains(pin), isTrue);
    expect(
      ArduinoGeometry.digitalPinX(13),
      greaterThan(ArduinoGeometry.digitalPinX(12)),
    );
  });

  testWidgets('render ArduinoPainter tanpa exception di dua ukuran', (
    WidgetTester tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.devicePixelRatio = 1.0;

    for (final Size size in <Size>[
      const Size(390, 844),
      const Size(800, 600),
    ]) {
      tester.view.physicalSize = size;

      await tester.pumpWidget(_host(ArduinoPainter(ledOn: true)));
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is CustomPaint && widget.painter is ArduinoPainter,
        ),
        findsOneWidget,
      );

      await tester.pumpWidget(_host(ArduinoPainter(ledOn: false)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('ukuran CustomPaint mengikuti ArduinoGeometry.canvasAspect', (
    WidgetTester tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(_host(ArduinoPainter(ledOn: false)));
    await tester.pump();

    final Size painted = tester.getSize(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is CustomPaint && widget.painter is ArduinoPainter,
      ),
    );
    expect(
      painted.width / painted.height,
      closeTo(ArduinoGeometry.canvasAspect, 1e-3),
    );
  });

  test('piksel LED eksternal mengikuti ledOn', () async {
    final Offset led = ArduinoGeometry.ledCenter(_canvasSize);

    _expectColor(
      await _paintAndProbe(ArduinoPainter(ledOn: true), led),
      AppColors.ledOn,
    );
    _expectColor(
      await _paintAndProbe(ArduinoPainter(ledOn: false), led),
      AppColors.ledOff,
    );
  });
}
