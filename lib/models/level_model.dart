import 'package:flutter/foundation.dart';
import 'package:voltar/models/learning_step.dart';

/// Representasi satu level pembelajaran (Level 1 - Level 5).
@immutable
class LevelModel {
  const LevelModel({
    required this.levelNumber,
    required this.steps,
  });

  final int levelNumber;
  final List<LearningStep> steps;

  /// Caption untuk tampilan daftar: "X materi • Y menit" (termasuk di dalam subMateri folder).
  String get caption {
    final List<LearningStep> allMateris = [];

    for (final LearningStep step in steps) {
      if (step.type == LearningStepType.materi) {
        allMateris.add(step);
      } else if (step.type == LearningStepType.folder) {
        allMateris.addAll(_allMaterisRecursive(step));
      }
    }

    if (allMateris.isEmpty) return '0 materi • 0 menit';

    final int totalMateri = allMateris.length;
    final int totalMinutes = allMateris.fold<int>(0, (sum, s) {
      final match = RegExp(r'(\d+)').firstMatch(s.estimatedTime ?? '');
      return sum + (int.tryParse(match?.group(1) ?? '') ?? 0);
    });

    return '$totalMateri materi • $totalMinutes menit';
  }

  /// Kumpulkan semua step materi di dalam folder secara rekursif.
  List<LearningStep> _allMaterisRecursive(LearningStep folder) {
    final List<LearningStep> result = [];
    for (final LearningStep item in folder.subMateri ?? const []) {
      if (item.type == LearningStepType.materi) {
        result.add(item);
      } else if (item.type == LearningStepType.folder) {
        result.addAll(_allMaterisRecursive(item));
      }
    }
    return result;
  }

  /// Semua status penyelesaian: pretest/selesai untuk materi, posttest untuk level.
  /// Nilai placeholder murni UI untuk Fase 2.
  bool get allPretestsDone => true;
  bool get allMaterisDone => true;
  bool get allPosttestsDone => true;
}
