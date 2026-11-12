import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/guess_component/component_data.dart';
import 'package:voltar/pages/game/guess_component_page.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_theme.dart';

class FakeGuessSfx implements GuessSfx {
  FakeGuessSfx({this.throwOnError = false});

  final bool throwOnError;
  int preloadCalls = 0;
  int playCorrectCalls = 0;
  int playWrongCalls = 0;
  int stopCalls = 0;
  int disposeCalls = 0;

  @override
  Future<void> preload() async {
    preloadCalls++;
    if (throwOnError) throw Exception('Simulated SFX preload failure');
  }

  @override
  Future<void> playCorrect() async {
    playCorrectCalls++;
    if (throwOnError) throw Exception('Simulated SFX play failure');
  }

  @override
  Future<void> playWrong() async {
    playWrongCalls++;
    if (throwOnError) throw Exception('Simulated SFX play failure');
  }

  @override
  Future<void> stop() async {
    stopCalls++;
    if (throwOnError) throw Exception('Simulated SFX stop failure');
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
    if (throwOnError) throw Exception('Simulated SFX dispose failure');
  }
}

class FakeGuessHaptics implements GuessHaptics {
  FakeGuessHaptics({this.throwOnError = false});

  final bool throwOnError;
  int wrongVibrationCalls = 0;
  int correctTickCalls = 0;

  @override
  Future<void> correctTick() async {
    correctTickCalls++;
    if (throwOnError) throw Exception('Simulated Haptics tick failure');
  }

  @override
  Future<void> wrongVibration() async {
    wrongVibrationCalls++;
    if (throwOnError) throw Exception('Simulated Haptics vibration failure');
  }
}

List<ComponentQuestion> _testQuestions() {
  return <ComponentQuestion>[
    const ComponentQuestion(
      id: 'q0',
      question: 'Apa fungsi resistor?',
      options: <String>['Menahan arus', 'Menyimpan muatan', 'Konektor', 'Saklar'],
      correctIndex: 0,
      hint: 'Hambatan listrik.',
      explanation: 'Resistor menahan laju arus listrik.',
      difficulty: 'A',
    ),
    const ComponentQuestion(
      id: 'q1',
      question: 'Apa fungsi kapasitor?',
      options: <String>['Induktor', 'Menyimpan muatan', 'Sumber tegangan', 'Sekring'],
      correctIndex: 1,
      hint: 'Penyimpan muatan sementara.',
      explanation: 'Kapasitor menyimpan energi dalam medan listrik.',
      difficulty: 'B',
    ),
  ];
}

Widget _wrap(
  Widget child, {
  bool disableAnimations = false,
}) {
  return MediaQuery(
    data: MediaQueryData(
      disableAnimations: disableAnimations,
      size: const Size(390, 844),
      devicePixelRatio: 3.0,
    ),
    child: MaterialApp(
      theme: AppTheme.light,
      home: child,
    ),
  );
}

void main() {
  group('GuessFxConfig & Math Tests', () {
    test('constants meet specification', () {
      expect(GuessFxConfig.flashDuration, const Duration(milliseconds: 300));
      expect(GuessFxConfig.flashAlpha, 0.2);
      expect(GuessFxConfig.shakeDuration, const Duration(milliseconds: 300));
      expect(GuessFxConfig.shakeAmplitude, 10.0);
      expect(GuessFxConfig.shakeCycles, 3);
      expect(GuessFxConfig.vibrateMillis, 200);
      expect(GuessFxConfig.fxOnTimeout, isTrue);
    });

    test('computeShakeDx deterministic and boundary conditions', () {
      expect(GuessFxConfig.computeShakeDx(0.0), 0.0);
      expect(GuessFxConfig.computeShakeDx(-0.1), 0.0);
      expect(GuessFxConfig.computeShakeDx(1.0), 0.0);
      expect(GuessFxConfig.computeShakeDx(1.2), 0.0);

      final double dx25 = GuessFxConfig.computeShakeDx(25 / 300);
      expect(dx25, closeTo(9.167, 0.01));
      expect(dx25.abs(), lessThanOrEqualTo(10.0));
      expect(GuessFxConfig.computeShakeDx(0.25), GuessFxConfig.computeShakeDx(0.25));
    });
  });

  group('Pubspec Assets & Dependencies Config', () {
    test('pubspec declares audioplayers, vibration, and assets/audio/', () {
      final File pubspecFile = File('pubspec.yaml');
      expect(pubspecFile.existsSync(), isTrue);
      final String content = pubspecFile.readAsStringSync();
      expect(content.contains('audioplayers:'), isTrue);
      expect(content.contains('vibration:'), isTrue);
      expect(content.contains('- assets/audio/'), isTrue);
    });

    test('audio files exist on disk', () {
      final File benar = File('assets/audio/benar.mp3');
      final File salah = File('assets/audio/salah.mp3');
      expect(benar.existsSync(), isTrue, reason: 'assets/audio/benar.mp3');
      expect(salah.existsSync(), isTrue, reason: 'assets/audio/salah.mp3');
    });
  });

  group('SFX & Haptics Trigger Tests', () {
    testWidgets('correct answer triggers playCorrect exactly 1x and correctTick 1x', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      expect(sfx.preloadCalls, 1);
      expect(sfx.playCorrectCalls, 0);
      expect(sfx.playWrongCalls, 0);
      expect(haptics.correctTickCalls, 0);
      expect(haptics.wrongVibrationCalls, 0);

      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pump();

      expect(sfx.playCorrectCalls, 1);
      expect(sfx.playWrongCalls, 0);
      expect(haptics.correctTickCalls, 1);
      expect(haptics.wrongVibrationCalls, 0);

      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pump();

      expect(sfx.playCorrectCalls, 1);
      expect(haptics.correctTickCalls, 1);
    });

    testWidgets('wrong answer triggers playWrong exactly 1x and wrongVibration 1x', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_1')));
      await tester.pump();

      expect(sfx.playCorrectCalls, 0);
      expect(sfx.playWrongCalls, 1);
      expect(haptics.correctTickCalls, 0);
      expect(haptics.wrongVibrationCalls, 1);
    });

    testWidgets('timeout triggers wrong SFX and vibration when fxOnTimeout is true', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      controller.handleTimeout();
      await tester.pump();

      expect(sfx.playWrongCalls, 1);
      expect(haptics.wrongVibrationCalls, 1);
      expect(sfx.playCorrectCalls, 0);
      expect(haptics.correctTickCalls, 0);
    });

    testWidgets('advancing question calls sfx.stop()', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pump();
      expect(sfx.playCorrectCalls, 1);

      controller.advanceQuestion();
      await tester.pump();
      expect(sfx.stopCalls, greaterThanOrEqualTo(1));
    });

    testWidgets('errors in SFX and Haptics are swallowed without crashing UI', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx faultySfx = FakeGuessSfx(throwOnError: true);
      final FakeGuessHaptics faultyHaptics = FakeGuessHaptics(throwOnError: true);
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: faultySfx,
        haptics: faultyHaptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_1')));
      await tester.pump();

      expect(controller.phase, GuessPhase.feedback);
      expect(faultySfx.playWrongCalls, 1);
      expect(faultyHaptics.wrongVibrationCalls, 1);
    });
  });

  group('Screen Flash Tests', () {
    testWidgets('flash shows green with opacity > 0 at 100ms, opacity 0 at 300ms for correct', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pump(const Duration(milliseconds: 100));

      final Finder flashFinder = find.byKey(const Key('guess_fx_flash'));
      expect(flashFinder, findsOneWidget);
      final FadeTransition fade = tester.widget<FadeTransition>(flashFinder);
      expect(fade.opacity.value, greaterThan(0.0));

      final ColoredBox coloredBox = tester.widget<ColoredBox>(
        find.descendant(of: flashFinder, matching: find.byType(ColoredBox)),
      );
      expect(coloredBox.color, AppColors.success.withValues(alpha: GuessFxConfig.flashAlpha));

      await tester.pump(const Duration(milliseconds: 200));
      expect(fade.opacity.value, 0.0);
    });

    testWidgets('flash shows red for wrong answer', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_1')));
      await tester.pump(const Duration(milliseconds: 50));

      final Finder flashFinder = find.byKey(const Key('guess_fx_flash'));
      final ColoredBox coloredBox = tester.widget<ColoredBox>(
        find.descendant(of: flashFinder, matching: find.byType(ColoredBox)),
      );
      expect(coloredBox.color, AppColors.error.withValues(alpha: GuessFxConfig.flashAlpha));
    });

    testWidgets('flash does not block touches (IgnorePointer)', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pump(const Duration(milliseconds: 50));

      final Finder exitButton = find.byKey(const Key('guess_game_header_exit'));
      expect(exitButton, findsOneWidget);
      await tester.tap(exitButton);
      await tester.pump();
    });

    testWidgets('no flash at idle or initial render', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      final Finder flashFinder = find.byKey(const Key('guess_fx_flash'));
      final FadeTransition fade = tester.widget<FadeTransition>(flashFinder);
      expect(fade.opacity.value, 0.0);
    });

    testWidgets('disableAnimations disables flash but SFX and haptics still fire', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(
        GuessComponentPage(
          controller: controller,
          sfx: sfx,
          haptics: haptics,
        ),
        disableAnimations: true,
      ));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pump(const Duration(milliseconds: 100));

      final Finder flashFinder = find.byKey(const Key('guess_fx_flash'));
      final FadeTransition fade = tester.widget<FadeTransition>(flashFinder);
      expect(fade.opacity.value, 0.0);
      expect(sfx.playCorrectCalls, 1);
      expect(haptics.correctTickCalls, 1);
    });
  });

  group('Screen Shake Tests', () {
    testWidgets('shake shifts dx != 0 at ~25ms, dx == 0 at 300ms for wrong answer', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_1')));
      await tester.pump(const Duration(milliseconds: 25));

      final Finder shakeFinder = find.byKey(const Key('guess_fx_shake_transform'));
      expect(shakeFinder, findsOneWidget);
      final Transform transform = tester.widget<Transform>(shakeFinder);
      final double dx = transform.transform.getTranslation().x;
      expect(dx, isNot(0.0));
      expect(dx.abs(), lessThanOrEqualTo(10.0));

      await tester.pump(const Duration(milliseconds: 275));
      final Transform transformEnd = tester.widget<Transform>(shakeFinder);
      final double dxEnd = transformEnd.transform.getTranslation().x;
      expect(dxEnd, 0.0);
    });

    testWidgets('correct answer does not shake', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pump(const Duration(milliseconds: 25));

      final Finder shakeFinder = find.byKey(const Key('guess_fx_shake_transform'));
      final Transform transform = tester.widget<Transform>(shakeFinder);
      final double dx = transform.transform.getTranslation().x;
      expect(dx, 0.0);
    });

    testWidgets('disableAnimations disables shake but SFX and haptics still fire', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(
        GuessComponentPage(
          controller: controller,
          sfx: sfx,
          haptics: haptics,
        ),
        disableAnimations: true,
      ));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_1')));
      await tester.pump(const Duration(milliseconds: 25));

      final Finder shakeFinder = find.byKey(const Key('guess_fx_shake_transform'));
      final Transform transform = tester.widget<Transform>(shakeFinder);
      expect(transform.transform.getTranslation().x, 0.0);
      expect(sfx.playWrongCalls, 1);
      expect(haptics.wrongVibrationCalls, 1);
    });
  });

  group('Lifecycle & Anti-Leak Tests', () {
    testWidgets('dispose during active FX cleans up without exception', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_1')));
      await tester.pump(const Duration(milliseconds: 50));

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();

      expect(sfx.disposeCalls, 1);
      expect(haptics.correctTickCalls + haptics.wrongVibrationCalls, 1);
    });

    testWidgets('dispose during feedback phase cleans up', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: false,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pump();

      expect(controller.phase, GuessPhase.feedback);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();

      expect(sfx.disposeCalls, 1);
    });

    testWidgets('dispose at Game Over cleans up', (
      WidgetTester tester,
    ) async {
      final FakeGuessSfx sfx = FakeGuessSfx();
      final FakeGuessHaptics haptics = FakeGuessHaptics();
      final GuessController controller = GuessController(
        customQuestions: _testQuestions(),
        autoAdvance: true,
      );

      await tester.pumpWidget(_wrap(GuessComponentPage(
        controller: controller,
        sfx: sfx,
        haptics: haptics,
      )));
      await tester.pump();

      // Complete all questions
      await tester.tap(find.byKey(const Key('guess_option_0')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('guess_option_1')));
      await tester.pumpAndSettle();

      expect(controller.phase, GuessPhase.finished);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();

      expect(sfx.disposeCalls, 1);
    });
  });
}
