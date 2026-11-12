import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/guess_component/component_data.dart';
import 'package:voltar/pages/game/guess_component/guess_widgets.dart';
import 'package:voltar/pages/game/guess_component/resistor_code.dart';
import 'package:voltar/pages/game/guess_component/resistor_painter.dart';
import 'package:voltar/pages/game/guess_component_page.dart';
import 'package:voltar/theme/app_theme.dart';

List<ComponentQuestion> _testQuestions() {
  return <ComponentQuestion>[
    ComponentQuestion.resistor(
      id: 'test_res_220',
      band1: ResistorBand.red,
      band2: ResistorBand.red,
      multiplier: ResistorBand.brown,
      tolerance: ResistorBand.gold,
    ),
    const ComponentQuestion(
      id: 'test_concept',
      question: 'Apa fungsi simbol Ground (GND)?',
      options: <String>['0 Volt', '5 Volt', 'Sekring', 'Filter'],
      correctIndex: 0,
      hint: 'Titik referensi nol.',
      explanation: 'GND berpotensial 0V.',
      difficulty: 'C',
    ),
  ];
}

Widget _wrap(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: child,
    );

void main() {
  group('GuessComponentPage Widget Tests', () {
    testWidgets('renders question, timer ring, resistor visual, and 4 options', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(_wrap(GuessComponentPage(controller: controller)));
      await tester.pump();

      expect(find.byType(GuessGameHeader), findsOneWidget);
      expect(find.byType(GuessTimerRing), findsOneWidget);
      expect(find.byType(ResistorVisual), findsOneWidget);
      expect(find.byType(GuessOptionTile), findsNWidgets(4));
      expect(find.text('Soal 1/2'), findsOneWidget);
      expect(find.text('0 V'), findsOneWidget);
    });

    testWidgets('selecting option displays feedback banner and updates score', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(_wrap(GuessComponentPage(controller: controller)));
      await tester.pump();

      final int correctIdx = controller.currentQuestion.correctIndex;
      await tester.tap(find.byKey(Key('guess_option_$correctIdx')));
      await tester.pump();

      expect(find.byKey(const Key('guess_feedback_banner')), findsOneWidget);
      expect(find.text('Jawaban Benar!'), findsOneWidget);
      expect(controller.score, equals(10));
      expect(find.text('10 V'), findsOneWidget);
    });

    testWidgets('shows hint sheet when hint button tapped and deducts penalty', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(_wrap(GuessComponentPage(controller: controller)));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_hint_button')));
      await tester.pumpAndSettle();

      expect(find.byType(GuessHintSheet), findsOneWidget);
      expect(controller.isPaused, isTrue);
      expect(controller.hintUsedForCurrent, isTrue);

      await tester.tap(find.text('Lanjutkan Kuis'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));

      expect(find.byType(GuessHintSheet), findsNothing);
      expect(controller.isPaused, isFalse);

      final int correctIdx = controller.currentQuestion.correctIndex;
      await tester.tap(find.byKey(Key('guess_option_$correctIdx')));
      await tester.pump();

      expect(controller.score, equals(5));
      expect(find.text('5 V'), findsOneWidget);
    });

    testWidgets('completing session displays game over overlay with retry button', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(_wrap(GuessComponentPage(controller: controller)));
      await tester.pump();

      controller.selectOption(controller.currentQuestion.correctIndex);
      await tester.pump();
      controller.advanceQuestion();
      await tester.pump();

      controller.selectOption(controller.currentQuestion.correctIndex);
      await tester.pump();
      controller.advanceQuestion();
      await tester.pump();

      expect(find.byKey(const Key('guess_gameover_overlay')), findsOneWidget);
      expect(find.text('Sesi Selesai!'), findsOneWidget);
      expect(find.text('Akurasi: 2 / 2 Soal'), findsOneWidget);

      await tester.tap(find.byKey(const Key('guess_retry_button')));
      await tester.pump();

      expect(find.byKey(const Key('guess_gameover_overlay')), findsNothing);
      expect(find.text('Soal 1/2'), findsOneWidget);
      expect(find.text('0 V'), findsOneWidget);
    });
  });
}
