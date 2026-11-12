import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/guess_component/component_data.dart';
import 'package:voltar/pages/game/guess_component/guess_balance.dart';

void main() {
  group('ComponentQuestionBank Integrity', () {
    test('contains at least 24 total questions', () {
      expect(componentQuestionBank.length, greaterThanOrEqualTo(24));
    });

    test('every question has valid structure and 4 distinct options', () {
      for (final ComponentQuestion q in componentQuestionBank) {
        expect(q.id.isNotEmpty, isTrue, reason: 'ID must not be empty');
        expect(q.question.isNotEmpty, isTrue, reason: 'Question empty: ${q.id}');
        expect(q.options.length, equals(4), reason: 'Options count: ${q.id}');
        expect(
          q.options.toSet().length,
          equals(4),
          reason: 'Duplicate options in ${q.id}',
        );
        expect(
          q.correctIndex,
          inInclusiveRange(0, 3),
          reason: 'Invalid correctIndex: ${q.id}',
        );
        expect(q.hint.isNotEmpty, isTrue, reason: 'Hint empty: ${q.id}');
        expect(
          q.explanation.isNotEmpty,
          isTrue,
          reason: 'Explanation empty: ${q.id}',
        );
        expect(<String>['A', 'B', 'C'].contains(q.difficulty), isTrue);

        if (q.isResistor) {
          expect(q.resistorBands!.length, equals(4));
        }
      }
    });

    test('Tier counts meet minimum balance (A>=10, B>=10, C>=8)', () {
      final int countA =
          componentQuestionBank.where((q) => q.difficulty == 'A').length;
      final int countB =
          componentQuestionBank.where((q) => q.difficulty == 'B').length;
      final int countC =
          componentQuestionBank.where((q) => q.difficulty == 'C').length;

      expect(countA, greaterThanOrEqualTo(10));
      expect(countB, greaterThanOrEqualTo(10));
      expect(countC, greaterThanOrEqualTo(8));
    });
  });

  group('SampleSessionQuestions', () {
    test('samples exactly 15 questions sorted by difficulty A -> B -> C', () {
      final List<ComponentQuestion> session = sampleSessionQuestions(
        random: math.Random(42),
      );

      expect(session.length, equals(GuessBalance.totalQuestions));

      for (int i = 0; i < session.length - 1; i++) {
        expect(
          session[i].difficulty.compareTo(session[i + 1].difficulty),
          lessThanOrEqualTo(0),
        );
      }

      final int countA = session.where((q) => q.difficulty == 'A').length;
      final int countB = session.where((q) => q.difficulty == 'B').length;
      final int countC = session.where((q) => q.difficulty == 'C').length;

      expect(countA, equals(7));
      expect(countB, equals(5));
      expect(countC, equals(3));
    });

    test('shuffles options while preserving correct answer mapping', () {
      const ComponentQuestion original = ComponentQuestion(
        id: 'test_q',
        question: 'Sample question?',
        options: <String>['Option A', 'Option B', 'Option C', 'Option D'],
        correctIndex: 1,
        hint: 'Hint',
        explanation: 'Exp',
        difficulty: 'A',
      );

      final ComponentQuestion shuffled = shuffleQuestionOptions(
        original,
        math.Random(123),
      );

      expect(shuffled.options.length, equals(4));
      expect(shuffled.options.toSet(), equals(original.options.toSet()));
      expect(shuffled.options[shuffled.correctIndex], equals('Option B'));
    });
  });
}