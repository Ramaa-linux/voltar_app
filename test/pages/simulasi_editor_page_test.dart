import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/simulasi/simulasi_editor_page.dart';
import 'package:voltar/theme/app_theme.dart';
import 'package:voltar/widgets/arduino_painter.dart';
import 'package:voltar/widgets/grid_background_painter.dart';

void main() {
  /// Pump editor langsung (tanpa router) pada ukuran layar target.
  Future<void> pumpEditor(
    WidgetTester tester, {
    bool isTemplate = false,
  }) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: SimulasiEditorPage(
          projectName: 'Blink LED',
          isTemplate: isTemplate,
        ),
      ),
    );
    await tester.pump();
  }

  /// IconButton AppBar dicari lewat tooltip-nya (Run/Stop).
  IconButton buttonWithTooltip(WidgetTester tester, String tooltip) {
    return tester
        .widgetList<IconButton>(find.byType(IconButton))
        .firstWhere((IconButton button) => button.tooltip == tooltip);
  }

  testWidgets('editor menampilkan kanvas, sketch, dan tombol Run/Stop', (
    WidgetTester tester,
  ) async {
    await pumpEditor(tester);

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is CustomPaint && widget.painter is ArduinoPainter,
      ),
      findsOneWidget,
    );

    final TextField code = tester.widget<TextField>(find.byType(TextField));
    expect(code.controller!.text, contains('void setup()'));
    expect(code.controller!.text, contains('digitalWrite(LED, HIGH)'));
    expect(code.controller!.text, contains('delay(1000)'));

    expect(find.text('blink.ino'), findsOneWidget);
    expect(find.text('Berhenti'), findsOneWidget);
    expect(find.text('Pin 13: LOW'), findsOneWidget);

    // Mesin belum jalan: Run aktif, Stop nonaktif.
    expect(buttonWithTooltip(tester, 'Run').onPressed, isNotNull);
    expect(buttonWithTooltip(tester, 'Stop').onPressed, isNull);
    expect(tester.takeException(), isNull);

    // Lepas widget agar AvrService.dispose() menutup stream.
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });

  testWidgets('grid sandbox digambar di belakang papan Arduino', (
    WidgetTester tester,
  ) async {
    await pumpEditor(tester);

    final Finder gridPaint = find.byWidgetPredicate(
      (Widget widget) =>
          widget is CustomPaint && widget.painter is GridBackgroundPainter,
    );
    final Finder boardPaint = find.byWidgetPredicate(
      (Widget widget) =>
          widget is CustomPaint && widget.painter is ArduinoPainter,
    );

    expect(gridPaint, findsOneWidget);
    // CustomPaint.painter digambar sebelum child, jadi grid harus ancestor
    // dari papan. Kalau urutan ini terbalik, papan menutupi grid.
    expect(find.ancestor(of: boardPaint, matching: gridPaint), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });

  testWidgets('keyboard muncul tanpa overflow di 390x844', (
    WidgetTester tester,
  ) async {
    await pumpEditor(tester);

    // Tinggi papan ketik Android umum (~300 px) dipotong dari viewport.
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(tester.view.resetViewInsets);
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byType(TextField)).height, greaterThan(0));
    // Kanvas tetap ada saat panel kode menyusut.
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is CustomPaint && widget.painter is ArduinoPainter,
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });

  testWidgets('Run menjalankan mesin AVR dan Stop menghentikannya', (
    WidgetTester tester,
  ) async {
    await pumpEditor(tester);

    await tester.tap(find.byTooltip('Run'));

    // Tunggu start() selesai (muat aset hex + spawn isolate). runAsync memberi
    // waktu nyata untuk I/O aset dan isolate, pump merangkai frame + microtask.
    // Jangan pakai pumpAndSettle: stream pin terus mengalir selama mesin hidup.
    for (int i = 0; i < 100; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump();
      if (buttonWithTooltip(tester, 'Stop').onPressed != null) {
        break;
      }
    }

    expect(buttonWithTooltip(tester, 'Stop').onPressed, isNotNull);
    expect(buttonWithTooltip(tester, 'Run').onPressed, isNull);
    expect(find.text('Berhenti'), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Stop'));
    await tester.pump();

    expect(buttonWithTooltip(tester, 'Stop').onPressed, isNull);
    expect(buttonWithTooltip(tester, 'Run').onPressed, isNotNull);
    expect(find.text('Berhenti'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}
