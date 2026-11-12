import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/widgets/spark_progress_bar.dart';

void main() {
  SparkProgressBarPainter findSparkPainter(WidgetTester tester) {
    final CustomPaint paint = tester.widget<CustomPaint>(
      find.descendant(
        of: find.byType(SparkProgressBar),
        matching: find.byType(CustomPaint),
      ),
    );
    return paint.painter! as SparkProgressBarPainter;
  }

  testWidgets('SparkProgressBar menampilkan spark dan memancarkan partikel untuk 0.0 < value < 1.0', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 240,
              child: SparkProgressBar(value: 0.48, height: 8),
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 200));

    final SparkProgressBarPainter painter = findSparkPainter(tester);
    expect(painter.clampedValue, closeTo(0.48, 0.001));
    expect(painter.hasSpark, isTrue);
    expect(painter.pulse, greaterThan(0.0));
    expect(painter.particleSystem, isNotNull);
    expect(painter.particleSystem!.activeCount, greaterThan(0));
    expect(tester.takeException(), isNull);
  });

  testWidgets('SparkProgressBar menyembunyikan spark dan mereset partikel saat value == 0.0 dan 1.0', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SparkProgressBar(value: 0.0),
        ),
      ),
    );
    await tester.pump();
    expect(findSparkPainter(tester).hasSpark, isFalse);
    expect(findSparkPainter(tester).particleSystem!.activeCount, 0);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SparkProgressBar(value: 1.0),
        ),
      ),
    );
    await tester.pump();
    expect(findSparkPainter(tester).hasSpark, isFalse);
    expect(findSparkPainter(tester).clampedValue, 1.0);
    expect(findSparkPainter(tester).particleSystem!.activeCount, 0);
  });

  testWidgets('SparkProgressBar men-clamp nilai di luar batas (< 0.0, > 1.0, dan NaN)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SparkProgressBar(value: -0.5),
        ),
      ),
    );
    await tester.pump();
    expect(findSparkPainter(tester).clampedValue, 0.0);
    expect(findSparkPainter(tester).hasSpark, isFalse);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SparkProgressBar(value: 1.75),
        ),
      ),
    );
    await tester.pump();
    expect(findSparkPainter(tester).clampedValue, 1.0);
    expect(findSparkPainter(tester).hasSpark, isFalse);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SparkProgressBar(value: double.nan),
        ),
      ),
    );
    await tester.pump();
    expect(findSparkPainter(tester).clampedValue, 0.0);
    expect(findSparkPainter(tester).hasSpark, isFalse);
    expect(tester.takeException(), isNull);
  });


  testWidgets('SparkProgressBar menghormati MediaQuery.disableAnimations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Scaffold(
            body: SizedBox(
              width: 240,
              child: SparkProgressBar(value: 0.5),
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 200));
    final SparkProgressBarPainter painter = findSparkPainter(tester);
    expect(painter.pulse, 0.5);
    expect(painter.particleSystem!.activeCount, 0);
  });

  testWidgets('SparkProgressBar dispose membersihkan AnimationController tanpa leak', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SparkProgressBar(value: 0.66),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));

    // Unmount widget dan pastikan tidak ada ticker yang tertinggal
    await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Capture screenshot Fase 13B SparkProgressBar welding particles', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390 * 2.0, 260 * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final GlobalKey boundaryKey = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          backgroundColor: AppColors.background,
          body: RepaintBoundary(
            key: boundaryKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const SparkProgressBar(
                      value: 0.48,
                      height: 10,
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: AppColors.accent,
                      sparkColor: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const SparkProgressBar(
                      value: 0.66,
                      height: 8,
                      backgroundColor: AppColors.primaryLight,
                      foregroundColor: AppColors.primary,
                      sparkColor: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Pompa beberapa frame untuk membangun jejak partikel las
    for (int i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 32));
    }

    final RenderRepaintBoundary boundary =
        boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image =
        await tester.runAsync(() => boundary.toImage(pixelRatio: 2.0)) as ui.Image;
    final dynamic byteData =
        await tester.runAsync(() => image.toByteData(format: ui.ImageByteFormat.png));
    await tester.runAsync(
      () => File('docs/screenshots/fase13b-spark-progress-bar.png')
          .writeAsBytes(byteData!.buffer.asUint8List()),
    );

    expect(tester.takeException(), isNull);
  });
}

