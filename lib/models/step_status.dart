import 'package:voltar/models/learning_step.dart';

/// Status penyelesaian dan akses satu [LearningStep] pada peta level.
enum StepStatus {
  /// Langkah telah diselesaikan oleh pengguna.
  completed,

  /// Langkah sudah terbuka dan siap dipelajari/dikerjakan.
  unlocked,

  /// Langkah masih terkunci karena langkah sebelumnya belum selesai.
  locked,
}

/// Menentukan [StepStatus] sebuah [step] secara murni (pure function)
/// berdasarkan urutan [allSteps] pada level dan himpunan [completedIds].
///
/// Aturan:
/// 1. Langkah pertama (biasanya Pre-Test) selalu terbuka ([StepStatus.unlocked])
///    atau [StepStatus.completed] jika sudah ada di [completedIds].
/// 2. Materi ke-N terbuka hanya jika seluruh langkah sebelumnya telah selesai.
/// 3. Folder terbuka jika langkah sebelum folder selesai, dan menjadi
///    [StepStatus.completed] jika seluruh `subMateri` di dalamnya selesai.
/// 4. Post-Test terbuka hanya jika seluruh langkah materi dan pre-test
///    sebelumnya telah selesai.
StepStatus resolveStepStatus(
  LearningStep step,
  List<LearningStep> allSteps,
  Set<String> completedIds,
) {
  if (step.type == LearningStepType.folder) {
    final List<LearningStep> sub = step.subMateri ?? const <LearningStep>[];
    if (completedIds.contains(step.id) ||
        (sub.isNotEmpty && sub.every((s) => completedIds.contains(s.id)))) {
      return StepStatus.completed;
    }

    final int folderIndex = allSteps.indexWhere((s) => s.id == step.id);
    if (folderIndex == -1) return StepStatus.locked;
    if (folderIndex == 0) return StepStatus.unlocked;

    final List<LearningStep> preceding = _flattenCompletableSteps(
      allSteps.sublist(0, folderIndex),
      completedIds,
    );
    final bool allPrecedingDone = preceding.every(
      (s) => completedIds.contains(s.id),
    );
    return allPrecedingDone ? StepStatus.unlocked : StepStatus.locked;
  }

  if (completedIds.contains(step.id)) {
    return StepStatus.completed;
  }

  final List<LearningStep> flatSteps = _flattenCompletableSteps(
    allSteps,
    completedIds,
  );
  final int index = flatSteps.indexWhere((s) => s.id == step.id);
  if (index == -1) return StepStatus.locked;
  if (index == 0) return StepStatus.unlocked;

  for (int i = 0; i < index; i++) {
    if (!completedIds.contains(flatSteps[i].id)) {
      return StepStatus.locked;
    }
  }
  return StepStatus.unlocked;
}

List<LearningStep> _flattenCompletableSteps(
  List<LearningStep> steps,
  Set<String> completedIds,
) {
  final List<LearningStep> result = <LearningStep>[];
  for (final LearningStep s in steps) {
    if (s.type == LearningStepType.folder) {
      final List<LearningStep> sub = s.subMateri ?? const <LearningStep>[];
      if (sub.isNotEmpty && !completedIds.contains(s.id)) {
        result.addAll(sub);
      } else if (sub.isEmpty) {
        result.add(s);
      }
    } else {
      result.add(s);
    }
  }
  return result;
}
