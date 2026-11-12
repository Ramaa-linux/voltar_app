/// Balance constants for Fase 19 "Tebak Komponen" mini-game.
///
/// Single source of truth for timing, scoring, and round counts.
/// Avoids magic numbers scattered across widgets/controller.
abstract final class GuessBalance {
  /// Total questions per session.
  static const int totalQuestions = 15;

  /// Seconds per question.
  static const int questionSeconds = 5;

  /// Base points awarded for a correct answer.
  static const int basePoints = 10;

  /// Extra points per streak level (applied on top of base).
  static const int streakBonusPerLevel = 5;

  /// Points deducted when a hint is used for the current question.
  static const int hintPenalty = 5;

  /// Minimum points per question (floor after penalties).
  static const int minPointsPerQuestion = 1;

  /// Feedback duration when answer is correct (ms).
  static const int feedbackDurationCorrectMs = 1500;

  /// Feedback duration when answer is wrong (ms).
  static const int feedbackDurationWrongMs = 2500;

  /// Delay before next question auto-advances (ms).
  static const int interQuestionDelayMs = 500;

  /// Difficulty tier distribution for 15 questions: A=7, B=5, C=3.
  /// A = easy (component image), B = medium (resistor bands), C = hard (concept).
  static const Map<String, int> tierCounts = <String, int>{
    'A': 7,
    'B': 5,
    'C': 3,
  };
}