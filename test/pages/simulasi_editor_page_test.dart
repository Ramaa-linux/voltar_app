import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/simulasi/simulasi_editor_page.dart';
import 'package:voltar/pages/simulasi/simulasi_page.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_theme.dart';

Future<void> _loadAppFonts() async {
  final FontLoader loader = FontLoader('PlusJakartaSans')
    ..addFont(rootBundle.load('assets/fonts/PlusJakartaSans-Regular.ttf'))
    ..addFont(rootBundle.load('assets/fonts/PlusJakartaSans-Medium.ttf'))
    ..addFont(rootBundle.load('assets/fonts/PlusJakartaSans-Bold.ttf'));
  await loader.load();
}

void main() {
  testWidgets('SimulasiPage menampilkan header dan tombol Buka Simulator Velxio', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          backgroundColor: AppColors.background,
          body: SimulasiPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Simulasi'), findsOneWidget);
    expect(
      find.text('Rancang dan uji sirkuit virtual langsung di browser.'),
      findsOneWidget,
    );
    expect(find.text('Buka Project Baru'), findsOneWidget);
    expect(find.text('Project yang sudah ada'), findsOneWidget);
    expect(find.text('LED Blinker'), findsOneWidget);
    expect(find.text('4-Way Traffic Light'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('SimulasiEditorPage menerima parameter initialUrl', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const SimulasiEditorPage(
          initialUrl: 'https://velxio.dev/ramaa-linux/arduino-uno',
          projectName: 'LED Blinker',
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Simulator Velxio'), findsOneWidget);
    expect(find.byKey(const Key('velxio_loading_indicator')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('SimulasiEditorPage menampilkan AppBar dan indikator loading', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const SimulasiEditorPage(),
      ),
    );
    await tester.pump();

    expect(
      SimulasiEditorPage.velxioUrl,
      'https://velxio.dev/project/0ccf9202-1d4b-4a26-b9d8-ea8d1a100c91',
    );
    expect(find.text('Simulator Velxio'), findsOneWidget);
    expect(find.byTooltip('Kembali'), findsOneWidget);
    expect(find.text('Muat Ulang'), findsOneWidget);
    expect(find.byKey(const Key('velxio_loading_indicator')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Capture screenshots for Fase 11 Simulasi & Velxio WebView', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(_loadAppFonts);
    tester.view.physicalSize = const Size(390 * 2.0, 844 * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Future<void> capture(Widget child, String filename) async {
      final GlobalKey key = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: RepaintBoundary(key: key, child: child),
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));
      final RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image =
          await tester.runAsync(() => boundary.toImage(pixelRatio: 1.0))
              as ui.Image;
      final byteData = await tester.runAsync(
        () => image.toByteData(format: ui.ImageByteFormat.png),
      );
      await tester.runAsync(
        () => File(
          'docs/screenshots/$filename',
        ).writeAsBytes(byteData!.buffer.asUint8List()),
      );
    }

    await capture(
      const Scaffold(
        backgroundColor: AppColors.background,
        body: SimulasiPage(),
      ),
      'fase11-simulasi-page.png',
    );

    await capture(
      const SimulasiEditorPage(),
      'fase11-velxio-webview.png',
    );
  });
}
