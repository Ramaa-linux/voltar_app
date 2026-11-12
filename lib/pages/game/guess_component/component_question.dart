import 'resistor_code.dart';

/// Single quiz question for "Tebak Komponen".
class ComponentQuestion {
  const ComponentQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.hint,
    required this.explanation,
    required this.difficulty,
    this.imagePath = '',
    this.resistorBands,
  });

  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String hint;
  final String explanation;

  /// 'A' = easy (component visuals),
  /// 'B' = medium (resistor color codes),
  /// 'C' = hard (electronic concepts/calculations).
  final String difficulty;

  /// Asset path if visual question; empty string if none or resistor painter.
  final String imagePath;

  /// 4 bands for ResistorBand questions, or null.
  final List<ResistorBand>? resistorBands;

  bool get isResistor => resistorBands != null && resistorBands!.length == 4;
  bool get hasImage => imagePath.isNotEmpty;
  String get correctAnswer => options[correctIndex];

  /// Factory helper to build a deterministic 4-band resistor question.
  factory ComponentQuestion.resistor({
    required String id,
    required ResistorBand band1,
    required ResistorBand band2,
    required ResistorBand multiplier,
    ResistorBand tolerance = ResistorBand.gold,
    String? customHint,
  }) {
    final double ohms = resistorOhms(band1, band2, multiplier);
    final String correctStr = formatOhm(ohms);
    final List<String> distractors = buildResistorDistractors(ohms);

    final List<String> opts = <String>[correctStr, ...distractors];
    final int targetIndex = id.hashCode.abs() % 4;
    final String tmp = opts[targetIndex];
    opts[targetIndex] = correctStr;
    opts[0] = tmp;

    final String bandNames =
        '${band1.labelId} - ${band2.labelId} - ${multiplier.labelId} - ${tolerance.labelId}';
    final String hintText = customHint ??
        'Gelang 1 (${band1.digit}) & 2 (${band2.digit}), pengali x10^${multiplier.digit >= 0 ? multiplier.digit : -1}.';

    return ComponentQuestion(
      id: id,
      question: 'Berapakah nilai resistansi resistor dengan gelang:\n$bandNames?',
      options: opts,
      correctIndex: targetIndex,
      hint: hintText,
      explanation:
          'Gelang 1=${band1.digit}, Gelang 2=${band2.digit}, Pengali=x${multiplier.multiplier >= 1 ? multiplier.multiplier.toInt() : multiplier.multiplier}. Nilai = $correctStr.',
      difficulty: 'B',
      resistorBands: <ResistorBand>[band1, band2, multiplier, tolerance],
    );
  }
}
