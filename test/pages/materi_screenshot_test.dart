import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/materi/detail/praktik/led_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/push_button_sim.dart';
import 'package:voltar/pages/materi/detail/praktik/resistor_calculator.dart';
import 'package:voltar/theme/app_colors.dart';

void main() {
  testWidgets('Capture screenshots for Fase 10A', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390 * 2.0, 844 * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Future<void> capture(Widget child, String filename, {Future<void> Function()? act}) async {
      final key = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: AppColors.background,
            body: RepaintBoundary(key: key, child: child),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));
      if (act != null) await act();
      final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await tester.runAsync(() => boundary.toImage(pixelRatio: 1.0)) as ui.Image;
      final byteData = await tester.runAsync(() => image.toByteData(format: ui.ImageByteFormat.png));
      await tester.runAsync(() => File('docs/screenshots/$filename').writeAsBytes(byteData!.buffer.asUint8List()));
    }

    await capture(const ResistorCalculator(), 'fase10a-resistor-calculator.png');

    await capture(
      const LedAnimation(),
      'fase10a-led-animation.png',
      act: () async {
        await tester.tap(find.text('Jalankan Animasi'));
        await tester.pump(const Duration(milliseconds: 400));
      },
    );
    await tester.tap(find.text('Hentikan Animasi'));
    await tester.pump();

    TestGesture? gesture;
    await capture(
      const PushButtonSim(),
      'fase10a-push-button.png',
      act: () async {
        final target = find.byIcon(Icons.touch_app);
        gesture = await tester.startGesture(tester.getCenter(target));
        await tester.pump(const Duration(milliseconds: 100));
      },
    );
    await gesture?.up();
    await tester.pump();
  });
}
