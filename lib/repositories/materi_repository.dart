import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';

/// Repository untuk mengakses data level & materi dari asset JSON.
///
/// Data tersebar di 5 file: `assets/data/level_1.json` s.d. `level_5.json`.
class MateriRepository {
  const MateriRepository();

  static const int _totalLevels = 5;

  /// Memuat seluruh level (1-5) secara paralel.
  ///
  /// Melempar [FlutterError] jika salah satu file tidak ditemukan atau format
  /// JSON salah.
  Future<List<LevelModel>> getAllLevels() async {
    final List<String> jsonStrings = await Future.wait(
      List<Future<String>>.generate(
        _totalLevels,
        (i) => rootBundle.loadString('assets/data/level_${i + 1}.json'),
      ),
    );

    return List<LevelModel>.generate(_totalLevels, (i) {
      final List<dynamic> jsonList =
          jsonDecode(jsonStrings[i]) as List<dynamic>;
      final List<LearningStep> steps = jsonList
          .map((e) => LearningStep.fromJson(e as Map<String, dynamic>))
          .toList();
      return LevelModel(levelNumber: i + 1, steps: steps);
    });
  }

  /// Memuat satu level berdasarkan nomor (1-based).
  Future<LevelModel> getLevelByNumber(int levelNumber) async {
    assert(
      levelNumber >= 1 && levelNumber <= _totalLevels,
      'levelNumber harus antara 1 dan $_totalLevels',
    );
    final String jsonString = await rootBundle.loadString(
      'assets/data/level_$levelNumber.json',
    );
    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
    final List<LearningStep> steps = jsonList
        .map((e) => LearningStep.fromJson(e as Map<String, dynamic>))
        .toList();
    return LevelModel(levelNumber: levelNumber, steps: steps);
  }

  /// Mencari satu [LearningStep] berdasarkan ID di seluruh level.
  Future<LearningStep> getStepById(String stepId) async {
    final List<LevelModel> levels = await getAllLevels();
    for (final LevelModel level in levels) {
      for (final LearningStep step in level.steps) {
        if (step.id == stepId) return step;
      }
    }
    throw StateError('Step dengan id "$stepId" tidak ditemukan');
  }
}