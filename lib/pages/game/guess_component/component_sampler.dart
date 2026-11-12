import 'dart:math' as math;
import 'component_data.dart';
import 'guess_balance.dart';

List<ComponentQuestion> sampleSessionQuestions({math.Random? random}) {
  final math.Random rng = random ?? math.Random();
  final List<ComponentQuestion> poolA = List<ComponentQuestion>.of(tierAQuestions)..shuffle(rng);
  final List<ComponentQuestion> poolB = List<ComponentQuestion>.of(tierBQuestions)..shuffle(rng);
  final List<ComponentQuestion> poolC = List<ComponentQuestion>.of(tierCQuestions)..shuffle(rng);

  final List<ComponentQuestion> picked = <ComponentQuestion>[
    ...poolA.take(GuessBalance.tierCounts['A']!),
    ...poolB.take(GuessBalance.tierCounts['B']!),
    ...poolC.take(GuessBalance.tierCounts['C']!),
  ];

  picked.sort((a, b) => a.difficulty.compareTo(b.difficulty));
  return picked.map((q) => shuffleQuestionOptions(q, rng)).toList();
}

ComponentQuestion shuffleQuestionOptions(ComponentQuestion q, math.Random rng) {
  final String correct = q.correctAnswer;
  final List<String> shuffled = List<String>.of(q.options)..shuffle(rng);
  final int newIdx = shuffled.indexOf(correct);
  return ComponentQuestion(
    id: q.id,
    question: q.question,
    options: shuffled,
    correctIndex: newIdx,
    hint: q.hint,
    explanation: q.explanation,
    difficulty: q.difficulty,
    imagePath: q.imagePath,
    resistorBands: q.resistorBands,
  );
}
