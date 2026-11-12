import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/guess_component/component_data.dart';
import 'package:voltar/pages/game/guess_component/guess_controller.dart';

List<ComponentQuestion> _makeQuestions(int count) {
  return List<ComponentQuestion>.generate(
    count,
    (int i) => ComponentQuestion(
      id: 'q_$i',
      question: 'Question $i?',
      options: const <String>['Right', 'Wrong 1', 'Wrong 2', 'Wrong 3'],
      correctIndex: 0,
      hint: 'Hint $i',
      explanation: 'Explanation $i',
      difficulty: i < 2 ? 'A' : 'B',
    ),
  );
}

void main() {
  group('GuessController State Machine & Scoring', () {
    test('starts in asking phase at index 0 with 0 score and 0 streak', () {
      final GuessController controller = GuessController(
        customQuestions: _makeQuestions(3),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      expect(controller.phase, equals(GuessPhase.asking));
      expect(controller.currentIndex, equals(0));
      expect(controller.score, equals(0));
      expect(controller.streak, equals(0));
      expect(controller.isPaused, isFalse);
    });

    test('correct answers increase score with streak bonus', () {
      final GuessController controller = GuessController(
        customQuestions: _makeQuestions(3),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      // Q0 correct: base 10 + streak(0)*5 = 10
      controller.selectOption(0);
      expect(controller.phase, equals(GuessPhase.feedback));
      expect(controller.isCurrentAnswerCorrect, isTrue);
      expect(controller.score, equals(10));
      expect(controller.streak, equals(1));

      controller.advanceQuestion();
      expect(controller.phase, equals(GuessPhase.asking));
      expect(controller.currentIndex, equals(1));

      // Q1 correct: base 10 + streak(1)*5 = 15 -> total 25
      controller.selectOption(0);
      expect(controller.score, equals(25));
      expect(controller.streak, equals(2));
      expect(controller.bestStreak, equals(2));
    });

    test('hint penalty deducts points on correct answer', () {
      final GuessController controller = GuessController(
        customQuestions: _makeQuestions(2),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      controller.useHint();
      expect(controller.hintUsedForCurrent, isTrue);

      // Q0 correct with hint: 10 - 5 = 5
      controller.selectOption(0);
      expect(controller.score, equals(5));
    });

    test('wrong answer or timeout resets streak and awards 0 points', () {
      final GuessController controller = GuessController(
        customQuestions: _makeQuestions(3),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      controller.selectOption(0); // +10, streak 1
      controller.advanceQuestion();

      controller.selectOption(2); // wrong
      expect(controller.isCurrentAnswerCorrect, isFalse);
      expect(controller.score, equals(10));
      expect(controller.streak, equals(0));

      controller.advanceQuestion();
      controller.handleTimeout();
      expect(controller.timedOutForCurrent, isTrue);
      expect(controller.phase, equals(GuessPhase.feedback));
      expect(controller.score, equals(10));

      controller.advanceQuestion();
      expect(controller.phase, equals(GuessPhase.finished));
    });

    test('centralized pause reasons only unpause when all reasons cleared', () {
      final GuessController controller = GuessController(
        customQuestions: _makeQuestions(2),
        autoAdvance: false,
      );
      addTearDown(controller.dispose);

      controller.pause(PauseReason.hintSheet);
      controller.pause(PauseReason.lifecycle);
      expect(controller.isPaused, isTrue);

      controller.resume(PauseReason.hintSheet);
      expect(controller.isPaused, isTrue);

      controller.resume(PauseReason.lifecycle);
      expect(controller.isPaused, isFalse);
    });

    test('restartGame resets all counters and starts fresh', () {
      final GuessController controller = GuessController(
        customQuestions: _makeQuestions(2),
        autoAdvance: false,
        random: math.Random(7),
      );
      addTearDown(controller.dispose);

      controller.selectOption(0);
      controller.advanceQuestion();
      controller.selectOption(0);
      controller.advanceQuestion();
      expect(controller.phase, equals(GuessPhase.finished));
      expect(controller.score, greaterThan(0));

      controller.restartGame();
      expect(controller.phase, equals(GuessPhase.asking));
      expect(controller.currentIndex, equals(0));
      expect(controller.score, equals(0));
      expect(controller.streak, equals(0));
      expect(controller.correctCount, equals(0));
    });
  });
}