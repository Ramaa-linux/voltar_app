import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/repositories/materi_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const repository = MateriRepository();

  group('MateriRepository', () {
    test('getAllLevels memuat 5 level dengan data lengkap', () async {
      final List<LevelModel> levels = await repository.getAllLevels();

      expect(levels.length, 5);

      for (int i = 0; i < 5; i++) {
        final level = levels[i];
        expect(level.levelNumber, i + 1);
        expect(level.steps.isNotEmpty, isTrue);

        // Setiap level harus punya minimal 1 pretest, minimal 1 materi (termasuk di subMateri), minimal 1 posttest
        final pretests = level.steps.where((s) => s.type == LearningStepType.pretest);
        final posttests = level.steps.where((s) => s.type == LearningStepType.posttest);

        // Materi bisa berada di top-level atau di dalam folder (subMateri)
        final allMateris = level.steps
            .where((s) => s.type == LearningStepType.materi)
            .toList();
        for (final step in level.steps) {
          if (step.type == LearningStepType.folder) {
            allMateris.addAll(_collectMaterisRecursive(step));
          }
        }

        expect(pretests.isNotEmpty, isTrue, reason: 'Level ${i + 1} harus ada pretest');
        expect(allMateris.isNotEmpty, isTrue, reason: 'Level ${i + 1} harus ada materi');
        expect(posttests.isNotEmpty, isTrue, reason: 'Level ${i + 1} harus ada posttest');

        // Pretest & posttest harus punya questions
        for (final q in pretests) {
          expect(q.questions, isNotNull);
          expect(q.questions!.isNotEmpty, isTrue);
          expect(q.questions!.first.options.length, 4);
        }
        for (final q in posttests) {
          expect(q.questions, isNotNull);
          expect(q.questions!.isNotEmpty, isTrue);
          expect(q.questions!.first.options.length, 4);
        }

        // Materi harus punya content blocks
        for (final m in allMateris) {
          expect(m.content, isNotNull);
          expect(m.content!.isNotEmpty, isTrue);
        }
      }
    });

    test('getLevelByNumber mengembalikan level yang spesifik', () async {
      final LevelModel level3 = await repository.getLevelByNumber(3);
      expect(level3.levelNumber, 3);
      expect(level3.steps.isNotEmpty, isTrue);
    });

    test('getStepById berhasil menemukan step di seluruh level', () async {
      final step = await repository.getStepById('l1_pretest');
      expect(step.id, 'l1_pretest');
      expect(step.type, LearningStepType.pretest);
      expect(step.questions?.length, 4);
    });

    test('getStepById menemukan subMateri di dalam folder', () async {
      final step = await repository.getStepById('l1_kom_led');
      expect(step.id, 'l1_kom_led');
      expect(step.type, LearningStepType.materi);
      expect(step.title, 'LED (Light Emitting Diode)');
      expect(step.videoUrl, isNotNull);
      expect(step.heroImageUrl, isNotNull);
      expect(step.videoSummary, isNotNull);
      expect(step.videoSummary!.isNotEmpty, isTrue);
    });
  });
}

List<LearningStep> _collectMaterisRecursive(LearningStep folder) {
  final List<LearningStep> result = [];
  for (final LearningStep item in folder.subMateri ?? const []) {
    if (item.type == LearningStepType.materi) {
      result.add(item);
    } else if (item.type == LearningStepType.folder) {
      result.addAll(_collectMaterisRecursive(item));
    }
  }
  return result;
}
