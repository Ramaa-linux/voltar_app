import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/pages/materi/detail/materi_detail_view.dart';
import 'package:voltar/pages/materi/detail/praktik/led_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/motor_simulation.dart';
import 'package:voltar/pages/materi/detail/praktik/ohm_law_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/push_button_sim.dart';
import 'package:voltar/pages/materi/detail/praktik/relay_simulation.dart';
import 'package:voltar/pages/materi/detail/praktik/resistor_calculator.dart';
import 'package:voltar/pages/materi/detail/praktik/sensor_simulation.dart';

void main() {
  testWidgets('ResistorCalculator calculates 220 Ohm by default and toggles bands', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResistorCalculator(),
        ),
      ),
    );

    expect(find.text('Kalkulator Kode Warna Resistor'), findsOneWidget);
    expect(find.text('220 Ω'), findsOneWidget);
    expect(find.text('Toleransi: ±5%'), findsOneWidget);

    // Switch to 5 bands
    await tester.tap(find.text('5 Gelang'));
    await tester.pumpAndSettle();

    expect(find.text('Nilai Hambatan'), findsOneWidget);
  });

  testWidgets('LedAnimation starts and stops animation correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LedAnimation(),
        ),
      ),
    );

    expect(find.text('Simulasi Running LED'), findsOneWidget);
    expect(find.text('Jalankan Animasi'), findsOneWidget);
    expect(find.text('Status: Standby (Semua Pin LOW)'), findsOneWidget);

    // Start
    await tester.tap(find.text('Jalankan Animasi'));
    await tester.pump();

    expect(find.text('Hentikan Animasi'), findsOneWidget);
    expect(find.text('Aktif: Pin D8 HIGH'), findsOneWidget);

    // Advance timer
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Aktif: Pin D9 HIGH'), findsOneWidget);

    // Stop
    await tester.tap(find.text('Hentikan Animasi'));
    await tester.pump();
    expect(find.text('Status: Standby (Semua Pin LOW)'), findsOneWidget);
  });

  testWidgets('PushButtonSim updates state on press down and up', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PushButtonSim(),
        ),
      ),
    );

    expect(find.text('Simulasi Push Button'), findsOneWidget);
    expect(find.text('LED OFF'), findsOneWidget);
    expect(find.text('RANGKAIAN TERBUKA: STANDBY'), findsOneWidget);

    final touchTarget = find.byIcon(Icons.touch_app);
    expect(touchTarget, findsOneWidget);

    // Hold down
    final gesture = await tester.startGesture(tester.getCenter(touchTarget));
    await tester.pump();

    expect(find.text('LED ON'), findsOneWidget);
    expect(find.text('RANGKAIAN TERTUTUP: ARUS MENGALIR'), findsOneWidget);

    // Release
    await gesture.up();
    await tester.pump();

    expect(find.text('LED OFF'), findsOneWidget);
    expect(find.text('RANGKAIAN TERBUKA: STANDBY'), findsOneWidget);
  });

  testWidgets('MateriDetailView switches to practice widget for level 1 components', (WidgetTester tester) async {
    const resistorStep = LearningStep(
      id: 'l1_kom_resistor',
      type: LearningStepType.materi,
      title: 'Resistor',
      description: 'Hambatan listrik',
      estimatedTime: '10 menit',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: MateriDetailView(step: resistorStep, levelNumber: 1),
      ),
    );

    // Switch to tab Praktik
    await tester.tap(find.text('Praktik'));
    await tester.pumpAndSettle();

    expect(find.byType(ResistorCalculator), findsOneWidget);
  });

  testWidgets('OhmLawAnimation renders closed circuit, calculates current, and toggles switch', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OhmLawAnimation(),
        ),
      ),
    );

    expect(find.text('Simulasi Rangkaian Tertutup & Hukum Ohm'), findsOneWidget);
    // Default V=9.0V, R=220 Ohm -> I = 40.9 mA
    expect(find.textContaining('RANGKAIAN TERTUTUP: Arus Mengalir (40.9 mA)'), findsOneWidget);
    expect(find.text('Buka Saklar (OFF)'), findsOneWidget);

    // Advance animation
    await tester.pump(const Duration(milliseconds: 500));

    // Open switch
    await tester.tap(find.text('Buka Saklar (OFF)'));
    await tester.pump();

    expect(find.text('RANGKAIAN TERBUKA: Arus Terputus (0.0 mA)'), findsOneWidget);
    expect(find.text('Tutup Saklar (ON)'), findsOneWidget);

    // Close switch again
    await tester.tap(find.text('Tutup Saklar (ON)'));
    await tester.pump();

    expect(find.textContaining('RANGKAIAN TERTUTUP: Arus Mengalir (40.9 mA)'), findsOneWidget);
  });

  testWidgets('MateriDetailView switches to OhmLawAnimation for l1_kom_hukum_ohm', (WidgetTester tester) async {
    const ohmStep = LearningStep(
      id: 'l1_kom_hukum_ohm',
      type: LearningStepType.materi,
      title: 'Hukum Ohm',
      description: 'Hubungan tegangan, arus, dan hambatan',
      estimatedTime: '15 menit',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: MateriDetailView(step: ohmStep, levelNumber: 1),
      ),
    );

    await tester.tap(find.text('Praktik'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(OhmLawAnimation), findsOneWidget);
  });

  testWidgets('RelaySimulation renders OFF state, toggles to ON with active-low logic', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: RelaySimulation()),
      ),
    );

    expect(find.text('Simulasi Modul Relay 5V'), findsOneWidget);
    expect(find.text('Pin D7'), findsOneWidget);
    expect(find.text('HIGH (5V)'), findsOneWidget); // Initial: Pin HIGH
    expect(find.text('OFF'), findsOneWidget);
    expect(find.text('COM - NC'), findsOneWidget);
    expect(find.text('Pin 7 LOW (ON)'), findsOneWidget);

    // Toggle to ON (Active LOW)
    await tester.tap(find.text('Pin 7 LOW (ON)'));
    await tester.pump(const Duration(milliseconds: 300)); // allow animation

    expect(find.text('LOW (0V)'), findsOneWidget); // Pin goes LOW
    expect(find.text('ON'), findsOneWidget);
    expect(find.text('COM - NO'), findsOneWidget);
    expect(find.text('MENYALA'), findsOneWidget);
    expect(find.text('Pin 7 HIGH (OFF)'), findsOneWidget);

    // Toggle back to OFF
    await tester.tap(find.text('Pin 7 HIGH (OFF)'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('HIGH (5V)'), findsOneWidget);
    expect(find.text('OFF'), findsOneWidget);
    expect(find.text('COM - NC'), findsOneWidget);
  });

  testWidgets('MateriDetailView switches to RelaySimulation for l2_relay', (WidgetTester tester) async {
    const relayStep = LearningStep(
      id: 'l2_relay',
      type: LearningStepType.materi,
      title: 'Relay',
      description: 'Saklar elektromagnetik',
      estimatedTime: '8 menit',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: MateriDetailView(step: relayStep, levelNumber: 2),
      ),
    );

    await tester.tap(find.text('Praktik'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(RelaySimulation), findsOneWidget);
  });

  testWidgets('SensorSimulation tabs and interactions work for HC-SR04, LDR, DHT11, MQ-135', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SensorSimulation()),
      ),
    );

    // 1. Default tab: HC-SR04
    expect(find.text('Sensor Ultrasonik HC-SR04'), findsOneWidget);
    expect(find.text('Jarak: 50 cm (Aman)'), findsOneWidget);

    // Drag slider to < 20 cm
    await tester.drag(find.byKey(const Key('slider_hcsr04')), const Offset(-300, 0));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.textContaining('(Bahaya!)'), findsOneWidget);
    expect(find.text('LED ON'), findsOneWidget);

    // 2. Switch to LDR tab
    await tester.tap(find.byKey(const Key('sensor_tab_LDR')));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Sensor Cahaya LDR'), findsOneWidget);
    expect(find.text('Kondisi: Terang -> Lampu OFF'), findsOneWidget);

    // Drag light slider to < 30%
    await tester.drag(find.byKey(const Key('slider_ldr')), const Offset(-300, 0));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Kondisi: Gelap -> Lampu ON'), findsOneWidget);

    // 3. Switch to DHT11 tab
    await tester.tap(find.byKey(const Key('sensor_tab_DHT11')));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Sensor Suhu & Kelembapan DHT11'), findsOneWidget);
    expect(find.text('Suhu: 26°C | Kelembapan: 55%'), findsOneWidget);
    expect(find.text('KIPAS OFF'), findsOneWidget);

    // Tap + 5 times to reach 31°C (> 30°C)
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.byKey(const Key('btn_temp_plus')));
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('Suhu: 31°C | Kelembapan: 55%'), findsOneWidget);
    expect(find.text('KIPAS ON'), findsOneWidget);

    // 4. Switch to MQ-135 tab
    await tester.tap(find.byKey(const Key('sensor_tab_MQ-135')));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Sensor Kualitas Udara MQ-135'), findsOneWidget);
    expect(find.text('Kualitas Udara: BAIK'), findsOneWidget);

    // Drag gas slider to > 500 ppm
    await tester.drag(find.byKey(const Key('slider_mq135')), const Offset(300, 0));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Kualitas Udara: BURUK'), findsOneWidget);
  });

  testWidgets('MateriDetailView switches to SensorSimulation for l3_jenis_prinsip_kerja_sensor', (WidgetTester tester) async {
    const sensorStep = LearningStep(
      id: 'l3_jenis_prinsip_kerja_sensor',
      type: LearningStepType.materi,
      title: 'Jenis & Prinsip Kerja Sensor',
      description: 'Mengenal berbagai jenis sensor',
      estimatedTime: '8 menit',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: MateriDetailView(step: sensorStep, levelNumber: 3),
      ),
    );

    await tester.tap(find.text('Praktik'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(SensorSimulation), findsOneWidget);
  });

  testWidgets('MotorSimulation tabs, potentiometer, and push buttons work for Servo, DC, and Stepper', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: MotorSimulation()),
      ),
    );

    // 1. Default tab: Servo + Potentiometer
    expect(find.text('Simulasi Motor Servo SG90'), findsOneWidget);
    expect(find.textContaining('ADC: 512 → Sudut: 90°'), findsOneWidget);

    // Switch input to Push Button
    await tester.ensureVisible(find.byKey(const Key('input_device_push_button')));
    await tester.tap(find.byKey(const Key('input_device_push_button')));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.ensureVisible(find.byKey(const Key('servo_btn_180')));
    await tester.tap(find.byKey(const Key('servo_btn_180')));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.textContaining('Target: 180°'), findsWidgets);

    // 2. Switch to DC Motor tab
    await tester.ensureVisible(find.byKey(const Key('motor_tab_dc')));
    await tester.tap(find.byKey(const Key('motor_tab_dc')));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Simulasi Motor DC & Kontrol PWM'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('dc_preset_fwd200')));
    await tester.tap(find.byKey(const Key('dc_preset_fwd200')));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('200 / 255 (78%)'), findsOneWidget);

    // 3. Switch to Stepper tab
    await tester.ensureVisible(find.byKey(const Key('motor_tab_stepper')));
    await tester.tap(find.byKey(const Key('motor_tab_stepper')));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Simulasi Stepper 28BYJ-48 + ULN2003'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('stepper_btn_step_plus')));
    await tester.tap(find.byKey(const Key('stepper_btn_step_plus')));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.textContaining('Step: 1 | Sudut: 5.6°'), findsOneWidget);
  });

  testWidgets('MateriDetailView switches to MotorSimulation for l4_jenis_motor', (WidgetTester tester) async {
    const motorStep = LearningStep(
      id: 'l4_jenis_motor',
      type: LearningStepType.materi,
      title: 'Jenis-jenis Motor',
      description: 'Mengenal motor DC, servo, dan stepper',
      estimatedTime: '8 menit',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: MateriDetailView(step: motorStep, levelNumber: 4),
      ),
    );

    await tester.tap(find.text('Praktik'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(MotorSimulation), findsOneWidget);
  });
}
