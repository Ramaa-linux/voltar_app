import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/pages/materi/detail/materi_detail_view.dart';
import 'package:voltar/pages/materi/detail/praktik/led_animation.dart';
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
}
