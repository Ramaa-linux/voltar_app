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

  /// Konversi snake_case id ke CamelCase (mis. `l1_kom_led` -> `L1KomLed`).
  static String _camelCase(String s) {
    return s.split('_').map((p) {
      if (p.isEmpty) return p;
      return p[0].toUpperCase() + p.substring(1);
    }).join();
  }

  /// Hasilkan ARB key untuk sebuah field materi.
  ///
  /// Format level: `materiL{level}{StepIdCamel}{Field}`
  /// Format komponen: `materiKomponen{StepIdCamel}{Field}`
  static String _materiKey(String? levelNum, String stepId, String field) {
    final idCamel = _camelCase(stepId);
    final prefix = levelNum != null
        ? 'materiL$levelNum$idCamel'
        : 'materiKomponen$idCamel';
    return '$prefix$field';
  }

  /// Tempel kunci lokalisasi pada satu [LearningStep] (rekursif untuk subMateri).
  LearningStep _localizeStep(String? levelNum, LearningStep step) {
    final contentKeys = <String>[];
    if (step.content != null) {
      for (var i = 0; i < step.content!.length; i++) {
        final block = step.content![i];
        final typeCamel = _camelCase(block.type.name);
        contentKeys.add(_materiKey(levelNum, step.id, 'Content$i$typeCamel'));
      }
    }

    final videoSummaryKeys = <String>[];
    if (step.videoSummary != null) {
      for (var i = 0; i < step.videoSummary!.length; i++) {
        final block = step.videoSummary![i];
        final typeCamel = _camelCase(block.type.name);
        videoSummaryKeys.add(
          _materiKey(levelNum, step.id, 'VideoSummary$i$typeCamel'),
        );
      }
    }

    final questionKeys = <int, String>{};
    final optionKeys = <int, List<String>>{};
    if (step.questions != null) {
      for (var qi = 0; qi < step.questions!.length; qi++) {
        final q = step.questions![qi];
        final qCamel = _camelCase(q.id);
        questionKeys[qi] =
            _materiKey(levelNum, step.id, 'Q${qCamel}Question');
        optionKeys[qi] = List.generate(
          q.options.length,
          (oi) => _materiKey(levelNum, step.id, 'Q${qCamel}Option$oi'),
        );
      }
    }

    return step.copyWith(
      localizedTitleKey: _materiKey(levelNum, step.id, 'Title'),
      localizedDescriptionKey: _materiKey(levelNum, step.id, 'Description'),
      localizedEstimatedTimeKey: step.estimatedTime != null
          ? _materiKey(levelNum, step.id, 'EstimatedTime')
          : null,
      localizedContentKeys: contentKeys.isNotEmpty ? contentKeys : null,
      localizedVideoSummaryKeys:
          videoSummaryKeys.isNotEmpty ? videoSummaryKeys : null,
      localizedQuestionKeys: questionKeys.isNotEmpty ? questionKeys : null,
      localizedOptionKeys: optionKeys.isNotEmpty ? optionKeys : null,
    ).copyWith(
      subMateri: step.subMateri != null
          ? _localizeSteps(levelNum, step.subMateri!)
          : null,
    );
  }

  /// Tempel kunci lokalisasi pada daftar [steps] (termasuk subMateri folder).
  List<LearningStep> _localizeSteps(String? levelNum, List<LearningStep> steps) {
    return steps
        .map((s) => _localizeStep(levelNum, s))
        .toList();
  }

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
      final levelNum = (i + 1).toString();
      final List<dynamic> jsonList =
          jsonDecode(jsonStrings[i]) as List<dynamic>;
      final List<LearningStep> steps = jsonList
          .map((e) => LearningStep.fromJson(e as Map<String, dynamic>))
          .toList();
      final localizedSteps = _localizeSteps(levelNum, steps);
      return LevelModel(levelNumber: i + 1, steps: localizedSteps);
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
    final localizedSteps = _localizeSteps(levelNumber.toString(), steps);
    return LevelModel(levelNumber: levelNumber, steps: localizedSteps);
  }

  /// Mencari satu [LearningStep] berdasarkan ID di seluruh level.
  Future<LearningStep> getStepById(String stepId) async {
    final List<LevelModel> levels = await getAllLevels();
    for (final LevelModel level in levels) {
      final LearningStep? found = _findStepInList(level.steps, stepId);
      if (found != null) return found;
    }
    throw StateError('Step dengan id "$stepId" tidak ditemukan');
  }

  /// Cari rekursif di daftar step (termasuk subMateri folder).
  LearningStep? _findStepInList(List<LearningStep> steps, String stepId) {
    for (final LearningStep step in steps) {
      if (step.id == stepId) return step;
      if (step.subMateri != null) {
        final LearningStep? nested = _findStepInList(step.subMateri!, stepId);
        if (nested != null) return nested;
      }
    }
    return null;
  }
}