import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/pages/materi/detail/materi_detail_view.dart';
import 'package:voltar/pages/materi/detail/praktik/led_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/ohm_law_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/push_button_sim.dart';
import 'package:voltar/pages/materi/detail/praktik/resistor_calculator.dart';

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
}
