import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'component_data.dart';
import 'guess_balance.dart';

enum GuessPhase { asking, feedback, finished }

enum PauseReason { hintSheet, lifecycle }

class GuessController extends ChangeNotifier {
  GuessController({
    this.customQuestions,
    this.autoAdvance = true,
    this.random,
  }) {
    _initSession();
  }

  final List<ComponentQuestion>? customQuestions;
  final math.Random? random;
  final bool autoAdvance;

  late List<ComponentQuestion> _questions;
  int _currentIndex = 0;
  GuessPhase _phase = GuessPhase.asking;
  int _score = 0;
  int _streak = 0;
  int _bestStreak = 0;
  int _correctCount = 0;
  int? _selectedOption;
  bool _hintUsedForCurrent = false;
  bool _timedOutForCurrent = false;
  final Set<PauseReason> _pauseReasons = <PauseReason>{};
  Timer? _feedbackTimer;
  int _generationToken = 0;
  bool _disposed = false;

  List<ComponentQuestion> get questions =>
      List<ComponentQuestion>.unmodifiable(_questions);
  int get totalQuestions => _questions.length;
  int get currentIndex => _currentIndex;
  ComponentQuestion get currentQuestion => _questions[_currentIndex];
  GuessPhase get phase => _phase;
  int get score => _score;
  int get streak => _streak;
  int get bestStreak => _bestStreak;
  int get correctCount => _correctCount;
  int? get selectedOption => _selectedOption;
  bool get hintUsedForCurrent => _hintUsedForCurrent;
  bool get timedOutForCurrent => _timedOutForCurrent;
  bool get isPaused => _pauseReasons.isNotEmpty;
  Set<PauseReason> get pauseReasons =>
      Set<PauseReason>.unmodifiable(_pauseReasons);

  bool get isLastQuestion => _currentIndex >= _questions.length - 1;
  bool get isCurrentAnswerCorrect =>
      _selectedOption != null &&
      _selectedOption == currentQuestion.correctIndex;

  String? get nextQuestionImagePath {
    if (isLastQuestion) return null;
    final String path = _questions[_currentIndex + 1].imagePath;
    return path.isEmpty ? null : path;
  }

  int get starRating {
    if (_questions.isEmpty) return 1;
    final double ratio = _correctCount / _questions.length;
    if (ratio >= 0.8) return 3;
    if (ratio >= 0.5) return 2;
    return 1;
  }

  void _initSession() {
    _cancelFeedbackTimer();
    _generationToken++;
    _questions = customQuestions != null
        ? List<ComponentQuestion>.of(customQuestions!)
        : sampleSessionQuestions(random: random);
    _currentIndex = 0;
    _phase = GuessPhase.asking;
    _score = 0;
    _streak = 0;
    _bestStreak = 0;
    _correctCount = 0;
    _selectedOption = null;
    _hintUsedForCurrent = false;
    _timedOutForCurrent = false;
    _pauseReasons.clear();
  }

  void pause(PauseReason reason) {
    if (_disposed || _phase != GuessPhase.asking) return;
    if (_pauseReasons.add(reason)) {
      notifyListeners();
    }
  }

  void resume(PauseReason reason) {
    if (_disposed) return;
    if (_pauseReasons.remove(reason)) {
      notifyListeners();
    }
  }

  void useHint() {
    if (_disposed || _phase != GuessPhase.asking) return;
    if (!_hintUsedForCurrent) {
      _hintUsedForCurrent = true;
      notifyListeners();
    }
  }

  void selectOption(int index) {
    if (_disposed || _phase != GuessPhase.asking) return;
    if (index < 0 || index >= currentQuestion.options.length) return;

    _selectedOption = index;
    _timedOutForCurrent = false;
    _phase = GuessPhase.feedback;
    _pauseReasons.clear();

    final bool correct = index == currentQuestion.correctIndex;
    if (correct) {
      _correctCount++;
      final int streakBonus = _streak * GuessBalance.streakBonusPerLevel;
      final int penalty = _hintUsedForCurrent ? GuessBalance.hintPenalty : 0;
      final int rawPoints = GuessBalance.basePoints + streakBonus - penalty;
      _score += math.max(GuessBalance.minPointsPerQuestion, rawPoints);
      _streak++;
      if (_streak > _bestStreak) {
        _bestStreak = _streak;
      }
    } else {
      _streak = 0;
    }

    notifyListeners();
    _scheduleAutoAdvance(correct: correct);
  }

  void handleTimeout() {
    if (_disposed || _phase != GuessPhase.asking) return;
    _selectedOption = null;
    _timedOutForCurrent = true;
    _streak = 0;
    _phase = GuessPhase.feedback;
    _pauseReasons.clear();

    notifyListeners();
    _scheduleAutoAdvance(correct: false);
  }

  void _scheduleAutoAdvance({required bool correct}) {
    _cancelFeedbackTimer();
    if (!autoAdvance) return;

    final int token = ++_generationToken;
    final int delayMs = correct
        ? GuessBalance.feedbackDurationCorrectMs
        : GuessBalance.feedbackDurationWrongMs;

    _feedbackTimer = Timer(Duration(milliseconds: delayMs), () {
      if (_disposed || token != _generationToken) return;
      advanceQuestion();
    });
  }

  void advanceQuestion() {
    if (_disposed || _phase != GuessPhase.feedback) return;
    _cancelFeedbackTimer();
    _generationToken++;

    if (isLastQuestion) {
      _phase = GuessPhase.finished;
      notifyListeners();
      return;
    }

    _currentIndex++;
    _selectedOption = null;
    _hintUsedForCurrent = false;
    _timedOutForCurrent = false;
    _pauseReasons.clear();
    _phase = GuessPhase.asking;
    notifyListeners();
  }

  void restartGame() {
    if (_disposed) return;
    _initSession();
    notifyListeners();
  }

  void _cancelFeedbackTimer() {
    _feedbackTimer?.cancel();
    _feedbackTimer = null;
  }

  @override
  void dispose() {
    _disposed = true;
    _cancelFeedbackTimer();
    super.dispose();
  }
}
