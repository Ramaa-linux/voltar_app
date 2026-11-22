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

  /// Daftar semua step materi di level ini, termasuk di dalam folder.
  List<LearningStep> get materiList {
    final List<LearningStep> result = [];
    for (final LearningStep step in steps) {
      if (step.type == LearningStepType.materi) {
        result.add(step);
      } else if (step.type == LearningStepType.folder) {
        result.addAll(_allMaterisRecursive(step));
      }
    }
    return result;
  }

  /// Total estimasi waktu (menit) dari seluruh materi di level ini.
  int get totalMinutes {
    return materiList.fold<int>(0, (sum, s) {
      final match = RegExp(r'(\d+)').firstMatch(s.estimatedTime ?? '');
      return sum + (int.tryParse(match?.group(1) ?? '') ?? 0);
    });
  }

  /// Caption untuk tampilan daftar: "X materi • Y menit" (termasuk di dalam subMateri folder).
  String get caption {
    if (materiList.isEmpty) return '0 materi • 0 menit';
    return '${materiList.length} materi • $totalMinutes menit';
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

  /// Seluruh ID langkah yang dapat diselesaikan pengguna di level ini
  /// (pretest, materi reguler, sub-materi di dalam folder, dan posttest).
  List<String> get completableStepIds {
    final List<String> ids = <String>[];
    void collect(LearningStep step) {
      if (step.type == LearningStepType.folder) {
        final List<LearningStep> sub = step.subMateri ?? const <LearningStep>[];
        if (sub.isNotEmpty) {
          for (final LearningStep item in sub) {
            collect(item);
          }
        } else {
          ids.add(step.id);
        }
      } else {
        ids.add(step.id);
      }
    }

    for (final LearningStep step in steps) {
      collect(step);
    }
    return ids;
  }

  /// Semua status penyelesaian: pretest/selesai untuk materi, posttest untuk level.
  /// Nilai placeholder murni UI untuk Fase 2.
  bool get allPretestsDone => true;
  bool get allMaterisDone => true;
  bool get allPosttestsDone => true;
}
