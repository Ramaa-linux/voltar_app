import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/materi/detail/praktik/led_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/motor_simulation.dart';
import 'package:voltar/pages/materi/detail/praktik/ohm_law_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/push_button_sim.dart';
import 'package:voltar/pages/materi/detail/praktik/relay_simulation.dart';
import 'package:voltar/pages/materi/detail/praktik/resistor_calculator.dart';
import 'package:voltar/pages/materi/detail/praktik/sensor_simulation.dart';
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

    await capture(
      const OhmLawAnimation(),
      'fase10b-ohm-law.png',
      act: () async {
        await tester.pump(const Duration(milliseconds: 600));
      },
    );

    // Relay OFF screenshot
    await capture(
      const RelaySimulation(),
      'fase10b-relay-off.png',
      act: () async {
        await tester.pump(const Duration(milliseconds: 200));
      },
    );

    // Relay ON screenshot
    await capture(
      const RelaySimulation(),
      'fase10b-relay-on.png',
      act: () async {
        await tester.tap(find.text('Pin 7 LOW (ON)'));
        await tester.pump(const Duration(milliseconds: 300));
      },
    );

    // Fase 10C: HC-SR04 Ultrasonic Danger screenshot
    await capture(
      const SensorSimulation(),
      'fase10c-sensor-hcsr04.png',
      act: () async {
        await tester.drag(find.byKey(const Key('slider_hcsr04')), const Offset(-260, 0));
        await tester.pump(const Duration(milliseconds: 300));
      },
    );

    // Fase 10C: DHT11 Hot / Fan ON screenshot
    await capture(
      const SensorSimulation(),
      'fase10c-sensor-dht11.png',
      act: () async {
        await tester.tap(find.byKey(const Key('sensor_tab_DHT11')));
        await tester.pump(const Duration(milliseconds: 200));
        for (int i = 0; i < 6; i++) {
          await tester.tap(find.byKey(const Key('btn_temp_plus')));
          await tester.pump(const Duration(milliseconds: 60));
        }
        await tester.pump(const Duration(milliseconds: 300));
      },
    );

    // Fase 10D: 1. Servo + Potentiometer
    await capture(
      const MotorSimulation(),
      'fase10d-servo-pot.png',
      act: () async {
        await tester.drag(find.byKey(const Key('virtual_potentiometer_slider')), const Offset(110, 0));
        await tester.pump(const Duration(milliseconds: 400));
      },
    );

    // Fase 10D: 2. Servo + Push Button
    await capture(
      const MotorSimulation(),
      'fase10d-servo-button.png',
      act: () async {
        await tester.tap(find.byKey(const Key('input_device_push_button')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('servo_btn_180')));
        await tester.pump(const Duration(milliseconds: 400));
      },
    );

    // Fase 10D: 3. DC Motor + Potentiometer
    await capture(
      const MotorSimulation(),
      'fase10d-dc-pot.png',
      act: () async {
        await tester.tap(find.byKey(const Key('motor_tab_dc')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.drag(find.byKey(const Key('virtual_potentiometer_slider')), const Offset(150, 0));
        await tester.pump(const Duration(milliseconds: 400));
      },
    );

    // Fase 10D: 4. DC Motor + Push Button
    await capture(
      const MotorSimulation(),
      'fase10d-dc-button.png',
      act: () async {
        await tester.tap(find.byKey(const Key('motor_tab_dc')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('input_device_push_button')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('dc_preset_fwd200')));
        await tester.pump(const Duration(milliseconds: 500));
      },
    );

    // Fase 10D: 5. Stepper + Potentiometer
    await capture(
      const MotorSimulation(),
      'fase10d-stepper-pot.png',
      act: () async {
        await tester.tap(find.byKey(const Key('motor_tab_stepper')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.drag(find.byKey(const Key('virtual_potentiometer_slider')), const Offset(120, 0));
        await tester.pump(const Duration(milliseconds: 500));
      },
    );

    // Fase 10D: 6. Stepper + Push Button
    await capture(
      const MotorSimulation(),
      'fase10d-stepper-button.png',
      act: () async {
        await tester.tap(find.byKey(const Key('motor_tab_stepper')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('input_device_push_button')));
        await tester.pump(const Duration(milliseconds: 100));
        for (int i = 0; i < 6; i++) {
          await tester.tap(find.byKey(const Key('stepper_btn_step_plus')));
          await tester.pump(const Duration(milliseconds: 60));
        }
        await tester.pump(const Duration(milliseconds: 200));
      },
    );

    // Fase 10D: 7. Stepper Telemetry & Oscilloscope (scrolled down)
    await capture(
      const MotorSimulation(),
      'fase10d-stepper-telemetry.png',
      act: () async {
        await tester.tap(find.byKey(const Key('motor_tab_stepper')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('input_device_push_button')));
        await tester.pump(const Duration(milliseconds: 100));
        for (int i = 0; i < 6; i++) {
          await tester.tap(find.byKey(const Key('stepper_btn_step_plus')));
          await tester.pump(const Duration(milliseconds: 60));
        }
        await tester.ensureVisible(find.text('ARDUINO SKETCH LIVE PREVIEW'));
        await tester.pump(const Duration(milliseconds: 200));
      },
    );
  });
}
