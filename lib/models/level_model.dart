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

  /// Caption untuk tampilan daftar: "X materi • Y menit"
  String get caption {
    final materiCount = steps.where((s) => s.type == LearningStepType.materi).length;
    final totalMinutes = steps.fold<int>(0, (sum, s) {
      if (s.estimatedTime == null) return sum;
      final match = RegExp(r'(\d+)').firstMatch(s.estimatedTime!);
      if (match != null) {
        return sum + (int.tryParse(match.group(1)!) ?? 0);
      }
      return sum;
    });
    return '$materiCount materi • $totalMinutes menit';
  }

  /// Semua status penyelesaian: pretest/selesai untuk materi, posttest untuk level.
  /// Nilai placeholder murni UI untuk Fase 2.
  bool get allPretestsDone => true;
  bool get allMaterisDone => true;
  bool get allPosttestsDone => true;
}
