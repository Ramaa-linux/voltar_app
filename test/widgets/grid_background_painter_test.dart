import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/widgets/grid_background_painter.dart';

void main() {
  test('default grid: sel 20 px, garis mayor tiap 5 sel (100 px)', () {
    const GridBackgroundPainter painter = GridBackgroundPainter();

    expect(painter.cellSize, 20);
    expect(painter.majorEvery, 5);
    expect(painter.strokeWidth, 1);
    expect(painter.minorColor, AppColors.border);
    expect(painter.majorColor, AppColors.borderStrong);
  });

  test('shouldRepaint hanya saat konfigurasi grid berubah', () {
    const GridBackgroundPainter painter = GridBackgroundPainter();

    expect(painter.shouldRepaint(const GridBackgroundPainter()), isFalse);
    expect(
      painter.shouldRepaint(const GridBackgroundPainter(cellSize: 24)),
      isTrue,
    );
    expect(
      painter.shouldRepaint(const GridBackgroundPainter(majorEvery: 4)),
      isTrue,
    );
    expect(
      painter.shouldRepaint(
        const GridBackgroundPainter(minorColor: AppColors.borderStrong),
      ),
      isTrue,
    );
    expect(
      painter.shouldRepaint(
        const GridBackgroundPainter(majorColor: AppColors.error),
      ),
      isTrue,
    );
  });

  testWidgets('grid tampil tanpa exception di panel kosong', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomPaint(
            painter: GridBackgroundPainter(),
            child: SizedBox.expand(),
          ),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is CustomPaint && widget.painter is GridBackgroundPainter,
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  test('paint aman untuk ukuran nol dan ukuran tidak bulat', () {
    const GridBackgroundPainter painter = GridBackgroundPainter();
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    painter.paint(canvas, Size.zero);
    painter.paint(canvas, const Size(370, 403));

    recorder.endRecording().dispose();
  });
}
