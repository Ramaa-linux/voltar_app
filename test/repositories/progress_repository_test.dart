import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/models/step_status.dart';
import 'package:voltar/repositories/materi_repository.dart';
import 'package:voltar/repositories/progress_repository.dart';

class _FakeMateriRepository extends MateriRepository {
  const _FakeMateriRepository();

  @override
  Future<List<LevelModel>> getAllLevels() async {
    return <LevelModel>[
      LevelModel(
        levelNumber: 1,
        steps: <LearningStep>[
          const LearningStep(
            id: 'l1_pretest',
            type: LearningStepType.pretest,
            title: 'Pre-Test Level 1',
            description: 'Uji kemampuan awal',
          ),
          const LearningStep(
            id: 'l1_m1',
            type: LearningStepType.materi,
            title: 'Tegangan & Arus',
            description: 'Konsep dasar listrik',
          ),
          const LearningStep(
            id: 'l1_folder',
            type: LearningStepType.folder,
            title: 'Pengenalan Komponen',
            description: 'Pelajari komponen dasar',
            subMateri: <LearningStep>[
              LearningStep(
                id: 'l1_kom_led',
                type: LearningStepType.materi,
                title: 'LED',
                description: 'LED',
              ),
            ],
          ),
          const LearningStep(
            id: 'l1_posttest',
            type: LearningStepType.posttest,
            title: 'Post-Test Level 1',
            description: 'Uji kemampuan akhir',
          ),
        ],
      ),
      const LevelModel(
        levelNumber: 2,
        steps: <LearningStep>[
          LearningStep(
            id: 'l2_pretest',
            type: LearningStepType.pretest,
            title: 'Pre-Test Level 2',
            description: 'Pre-test',
          ),
          LearningStep(
            id: 'l2_m1',
            type: LearningStepType.materi,
            title: 'Materi 1',
            description: 'M1',
          ),
          LearningStep(
            id: 'l2_m2',
            type: LearningStepType.materi,
            title: 'Materi 2',
            description: 'M2',
          ),
          LearningStep(
            id: 'l2_posttest',
            type: LearningStepType.posttest,
            title: 'Post-Test Level 2',
            description: 'Post-test',
          ),
        ],
      ),
      const LevelModel(
        levelNumber: 3,
        steps: <LearningStep>[
          LearningStep(
            id: 'l3_pretest',
            type: LearningStepType.pretest,
            title: 'Pre-Test Level 3',
            description: 'Pre-test',
          ),
          LearningStep(
            id: 'l3_m1',
            type: LearningStepType.materi,
            title: 'Materi 1',
            description: 'M1',
          ),
          LearningStep(
            id: 'l3_posttest',
            type: LearningStepType.posttest,
            title: 'Post-Test Level 3',
            description: 'Post-test',
          ),
        ],
      ),
      const LevelModel(
        levelNumber: 4,
        steps: <LearningStep>[
          LearningStep(
            id: 'l4_pretest',
            type: LearningStepType.pretest,
            title: 'Pre-Test Level 4',
            description: 'Pre-test',
          ),
          LearningStep(
            id: 'l4_m1',
            type: LearningStepType.materi,
            title: 'Materi 1',
            description: 'M1',
          ),
          LearningStep(
            id: 'l4_posttest',
            type: LearningStepType.posttest,
            title: 'Post-Test Level 4',
            description: 'Post-test',
          ),
        ],
      ),
      const LevelModel(
        levelNumber: 5,
        steps: <LearningStep>[
          LearningStep(
            id: 'l5_pretest',
            type: LearningStepType.pretest,
            title: 'Pre-Test Level 5',
            description: 'Pre-test',
          ),
          LearningStep(
            id: 'l5_m1',
            type: LearningStepType.materi,
            title: 'Materi 1',
            description: 'M1',
          ),
          LearningStep(
            id: 'l5_posttest',
            type: LearningStepType.posttest,
            title: 'Post-Test Level 5',
            description: 'Post-test',
          ),
        ],
      ),
    ];
  }

  @override
  Future<LevelModel> getLevelByNumber(int levelNumber) async {
    final levels = await getAllLevels();
    return levels.firstWhere((l) => l.levelNumber == levelNumber);
  }
}

class _Fake25StepsMateriRepository extends MateriRepository {
  const _Fake25StepsMateriRepository();

  @override
  Future<List<LevelModel>> getAllLevels() async {
    return List<LevelModel>.generate(5, (int lIdx) {
      final int lvl = lIdx + 1;
      return LevelModel(
        levelNumber: lvl,
        steps: List<LearningStep>.generate(5, (int sIdx) {
          final int num = lIdx * 5 + sIdx + 1;
          final LearningStepType type = sIdx == 0
              ? LearningStepType.pretest
              : (sIdx == 4
                    ? LearningStepType.posttest
                    : LearningStepType.materi);
          return LearningStep(
            id: 'step_$num',
            type: type,
            title: 'Judul Step $num',
            description: 'Deskripsi Step $num',
          );
        }),
      );
    });
  }
}

class _EmptyMateriRepository extends MateriRepository {
  const _EmptyMateriRepository();

  @override
  Future<List<LevelModel>> getAllLevels() async => const <LevelModel>[];
}

const List<LearningStep> flatSteps = <LearningStep>[
  LearningStep(
    id: 'l2_pretest',
    type: LearningStepType.pretest,
    title: 'Pre-Test Level 2',
    description: 'Pre-test',
  ),
  LearningStep(
    id: 'l2_m1',
    type: LearningStepType.materi,
    title: 'Materi 1',
    description: 'M1',
  ),
  LearningStep(
    id: 'l2_m2',
    type: LearningStepType.materi,
    title: 'Materi 2',
    description: 'M2',
  ),
  LearningStep(
    id: 'l2_posttest',
    type: LearningStepType.posttest,
    title: 'Post-Test Level 2',
    description: 'Post-test',
  ),
];

void main() {
  group('resolveStepStatus (pure function)', () {
    test('Pre-Test selalu unlocked di awal, materi & post-test locked', () {
      const Set<String> completed = <String>{};
      expect(
        resolveStepStatus(flatSteps[0], flatSteps, completed),
        StepStatus.unlocked,
      );
      expect(
        resolveStepStatus(flatSteps[1], flatSteps, completed),
        StepStatus.locked,
      );
      expect(
        resolveStepStatus(flatSteps[2], flatSteps, completed),
        StepStatus.locked,
      );
      expect(
        resolveStepStatus(flatSteps[3], flatSteps, completed),
        StepStatus.locked,
      );
    });

    test(
      'Materi 1 terbuka setelah Pre-Test selesai, Materi 2 tetap terkunci',
      () {
        const Set<String> completed = <String>{'l2_pretest'};
        expect(
          resolveStepStatus(flatSteps[0], flatSteps, completed),
          StepStatus.completed,
        );
        expect(
          resolveStepStatus(flatSteps[1], flatSteps, completed),
          StepStatus.unlocked,
        );
        expect(
          resolveStepStatus(flatSteps[2], flatSteps, completed),
          StepStatus.locked,
        );
        expect(
          resolveStepStatus(flatSteps[3], flatSteps, completed),
          StepStatus.locked,
        );
      },
    );

    test('Post-Test tetap terkunci jika belum semua materi selesai', () {
      const Set<String> completed = <String>{'l2_pretest', 'l2_m2'};
      expect(
        resolveStepStatus(flatSteps[1], flatSteps, completed),
        StepStatus.unlocked,
      );
      expect(
        resolveStepStatus(flatSteps[2], flatSteps, completed),
        StepStatus.completed,
      );
      expect(
        resolveStepStatus(flatSteps[3], flatSteps, completed),
        StepStatus.locked,
      );
    });

    test(
      'Post-Test terbuka hanya setelah Pre-Test dan seluruh materi selesai',
      () {
        const Set<String> completed = <String>{'l2_pretest', 'l2_m1', 'l2_m2'};
        expect(
          resolveStepStatus(flatSteps[3], flatSteps, completed),
          StepStatus.unlocked,
        );

        const Set<String> allDone = <String>{
          'l2_pretest',
          'l2_m1',
          'l2_m2',
          'l2_posttest',
        };
        expect(
          resolveStepStatus(flatSteps[3], flatSteps, allDone),
          StepStatus.completed,
        );
      },
    );

    test('Folder dan subMateri membuka secara berurutan hingga Post-Test', () {
      const LearningStep sub1 = LearningStep(
        id: 'sub_1',
        type: LearningStepType.materi,
        title: 'Sub 1',
        description: 'S1',
      );
      const LearningStep sub2 = LearningStep(
        id: 'sub_2',
        type: LearningStepType.materi,
        title: 'Sub 2',
        description: 'S2',
      );
      const List<LearningStep> stepsWithFolder = <LearningStep>[
        LearningStep(
          id: 'pre',
          type: LearningStepType.pretest,
          title: 'Pre',
          description: '',
        ),
        LearningStep(
          id: 'folder',
          type: LearningStepType.folder,
          title: 'Folder',
          description: '',
          subMateri: <LearningStep>[sub1, sub2],
        ),
        LearningStep(
          id: 'post',
          type: LearningStepType.posttest,
          title: 'Post',
          description: '',
        ),
      ];

      expect(
        resolveStepStatus(
          stepsWithFolder[1],
          stepsWithFolder,
          const <String>{},
        ),
        StepStatus.locked,
      );
      expect(
        resolveStepStatus(sub1, stepsWithFolder, const <String>{}),
        StepStatus.locked,
      );

      const Set<String> afterPre = <String>{'pre'};
      expect(
        resolveStepStatus(stepsWithFolder[1], stepsWithFolder, afterPre),
        StepStatus.unlocked,
      );
      expect(
        resolveStepStatus(sub1, stepsWithFolder, afterPre),
        StepStatus.unlocked,
      );
      expect(
        resolveStepStatus(sub2, stepsWithFolder, afterPre),
        StepStatus.locked,
      );
      expect(
        resolveStepStatus(stepsWithFolder[2], stepsWithFolder, afterPre),
        StepStatus.locked,
      );

      const Set<String> afterAllSub = <String>{'pre', 'sub_1', 'sub_2'};
      expect(
        resolveStepStatus(stepsWithFolder[1], stepsWithFolder, afterAllSub),
        StepStatus.completed,
      );
      expect(
        resolveStepStatus(stepsWithFolder[2], stepsWithFolder, afterAllSub),
        StepStatus.unlocked,
      );
    });
  });

  group('ProgressRepository persistence', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await const ProgressRepository().reset();
    });

    test(
      'getCompletedSteps mengembalikan set kosong saat belum ada data',
      () async {
        const ProgressRepository repo = ProgressRepository();
        expect(await repo.getCompletedSteps(), isEmpty);
      },
    );

    test(
      'markCompleted menyimpan ID secara persisten dan idempotent',
      () async {
        const ProgressRepository repo = ProgressRepository();
        await repo.markCompleted('l1_pretest');
        await repo.markCompleted('l1_kom_led');
        await repo.markCompleted('l1_pretest');

        expect(
          await repo.getCompletedSteps(),
          equals(<String>{'l1_pretest', 'l1_kom_led'}),
        );
      },
    );

    test('reset menghapus seluruh progres yang tersimpan', () async {
      const ProgressRepository repo = ProgressRepository();
      await repo.markCompleted('l1_pretest');
      expect(await repo.getCompletedSteps(), isNotEmpty);

      await repo.reset();
      expect(await repo.getCompletedSteps(), isEmpty);
    });
  });

  group('ProgressRepository sequential level unlocking (Fase 17)', () {
    const fakeRepo = _FakeMateriRepository();
    const ProgressRepository repo = ProgressRepository(
      materiRepository: fakeRepo,
    );

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await repo.reset();
    });

    test(
      '1. Progress kosong: isLevelUnlocked(1)=true, level 2-5=false',
      () async {
        expect(await repo.isLevelUnlocked(1), isTrue);
        for (int i = 2; i <= 5; i++) {
          expect(
            await repo.isLevelUnlocked(i),
            isFalse,
            reason: 'Level $i harus terkunci',
          );
        }
      },
    );

    test('2. Level 1 baru sebagian selesai (Post-Test belum): isLevelCompleted(1)=false, isLevelUnlocked(2)=false', () async {
      await repo.markCompleted('l1_pretest');
      await repo.markCompleted('l1_m1');
      await repo.markCompleted('l1_kom_led');

      expect(await repo.isLevelCompleted(1), isFalse);
      expect(await repo.isLevelUnlocked(2), isFalse);
    });

    test('3. Semua langkah Level 1 selesai: isLevelCompleted(1)=true, isLevelUnlocked(2)=true, isLevelUnlocked(3)=false', () async {
      await repo.markCompleted('l1_pretest');
      await repo.markCompleted('l1_m1');
      await repo.markCompleted('l1_kom_led');
      await repo.markCompleted('l1_posttest');

      expect(await repo.isLevelCompleted(1), isTrue);
      expect(await repo.isLevelUnlocked(2), isTrue);
      expect(await repo.isLevelUnlocked(3), isFalse);
    });

    test('4. Level 1 & 2 selesai: Level 3 terbuka, Level 4 terkunci', () async {
      // Level 1
      await repo.markCompleted('l1_pretest');
      await repo.markCompleted('l1_m1');
      await repo.markCompleted('l1_kom_led');
      await repo.markCompleted('l1_posttest');

      // Level 2
      await repo.markCompleted('l2_pretest');
      await repo.markCompleted('l2_m1');
      await repo.markCompleted('l2_m2');
      await repo.markCompleted('l2_posttest');

      expect(await repo.isLevelCompleted(1), isTrue);
      expect(await repo.isLevelCompleted(2), isTrue);
      expect(await repo.isLevelUnlocked(3), isTrue);
      expect(await repo.isLevelUnlocked(4), isFalse);
    });

    test('5. ID Level 3 ada di progress tapi Level 2 belum selesai: Level 3 tetap terkunci (tidak ada jalan pintas)', () async {
      // Level 1 selesai
      await repo.markCompleted('l1_pretest');
      await repo.markCompleted('l1_m1');
      await repo.markCompleted('l1_kom_led');
      await repo.markCompleted('l1_posttest');

      // Level 2 belum selesai, tetapi ID Level 3 dimasukkan
      await repo.markCompleted('l3_pretest');
      await repo.markCompleted('l3_m1');
      await repo.markCompleted('l3_posttest');

      expect(await repo.isLevelCompleted(2), isFalse);
      expect(
        await repo.isLevelUnlocked(3),
        isFalse,
        reason: 'Level 3 harus terkunci karena Level 2 belum tuntas',
      );
    });

    test('6. levelNumber di luar rentang: 0, -1, 6, 99 mengembalikan false tanpa exception', () async {
      for (final invalidNumber in const <int>[0, -1, 6, 99]) {
        expect(await repo.isLevelCompleted(invalidNumber), isFalse);
        expect(await repo.isLevelUnlocked(invalidNumber), isFalse);
      }
    });

    test('7. Persistensi: simpan progress, buat instance repository baru -> status level tetap sama', () async {
      final ProgressRepository repo1 = ProgressRepository(
        materiRepository: fakeRepo,
      );
      await repo1.markCompleted('l1_pretest');
      await repo1.markCompleted('l1_m1');
      await repo1.markCompleted('l1_kom_led');
      await repo1.markCompleted('l1_posttest');

      final ProgressRepository repo2 = ProgressRepository(
        materiRepository: fakeRepo,
      );
      expect(await repo2.isLevelCompleted(1), isTrue);
      expect(await repo2.isLevelUnlocked(2), isTrue);
      expect(await repo2.isLevelUnlocked(3), isFalse);
    });
  });

  group('ProgressRepository Fase 20 contract & math', () {
    test('computePercentLabel strict clamping and rounding', () {
      expect(
        ProgressRepository.computePercentLabel(
          completedCount: 0,
          totalSteps: 250,
        ),
        0,
      );
      expect(
        ProgressRepository.computePercentLabel(
          completedCount: 1,
          totalSteps: 250,
        ),
        1,
      );
      expect(
        ProgressRepository.computePercentLabel(
          completedCount: 249,
          totalSteps: 250,
        ),
        99,
      );
      expect(
        ProgressRepository.computePercentLabel(
          completedCount: 250,
          totalSteps: 250,
        ),
        100,
      );
      expect(
        ProgressRepository.computePercentLabel(
          completedCount: 12,
          totalSteps: 25,
        ),
        48,
      );
    });

    test('HomeProgressSummary value equality', () {
      const a = HomeProgressSummary(
        completedCount: 5,
        totalSteps: 20,
        overallPercent: 25.0,
        percentLabel: 25,
        currentLevel: 2,
        nextStepId: 'step_6',
        nextStepTitle: 'Step 6',
        nextStepLevel: 2,
        allCompleted: false,
        streakDays: 3,
        coins: 240,
      );
      const b = HomeProgressSummary(
        completedCount: 5,
        totalSteps: 20,
        overallPercent: 25.0,
        percentLabel: 25,
        currentLevel: 2,
        nextStepId: 'step_6',
        nextStepTitle: 'Step 6',
        nextStepLevel: 2,
        allCompleted: false,
        streakDays: 3,
        coins: 240,
      );
      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('Streak pure calendar math daysBetween & computeStreak', () {
      final d1 = DateTime.utc(2026, 3, 10);
      final d2 = DateTime.utc(2026, 3, 11);
      final d3 = DateTime.utc(2026, 3, 13);
      expect(ProgressRepository.daysBetween(d1, d2), 1);
      expect(ProgressRepository.daysBetween(d1, d3), 3);
      expect(ProgressRepository.daysBetween(d2, d1), -1);

      // Same day activity -> idempotent
      final nextSame = ProgressRepository.computeNextStreak(
        storedCount: 2,
        lastDayStr: '2026-03-10',
        today: d1,
      );
      expect(nextSame.count, 2);

      // Next day activity -> +1
      final nextDay = ProgressRepository.computeNextStreak(
        storedCount: 2,
        lastDayStr: '2026-03-10',
        today: d2,
      );
      expect(nextDay.count, 3);

      // Jump 2 days -> reset to 1
      final nextJump = ProgressRepository.computeNextStreak(
        storedCount: 5,
        lastDayStr: '2026-03-10',
        today: d3,
      );
      expect(nextJump.count, 1);

      // Display streak: yesterday is still alive
      expect(
        ProgressRepository.computeDisplayStreak(
          storedCount: 4,
          lastDayStr: '2026-03-10',
          today: d2,
        ),
        4,
      );

      // Display streak: 2 days ago broke
      expect(
        ProgressRepository.computeDisplayStreak(
          storedCount: 4,
          lastDayStr: '2026-03-10',
          today: d3,
        ),
        0,
      );
    });

    test('25-step curriculum: 0, 1, 12, 25 steps progress table', () async {
      const fake25 = _Fake25StepsMateriRepository();
      final repo = ProgressRepository(materiRepository: fake25);
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await repo.reset();

      // 0 steps
      var summary = await repo.buildHomeSummary();
      expect(summary.totalSteps, 25);
      expect(summary.completedCount, 0);
      expect(summary.overallPercent, 0.0);
      expect(summary.percentLabel, 0);
      expect(summary.currentLevel, 1);
      expect(summary.nextStepId, 'step_1');
      expect(summary.allCompleted, isFalse);

      // 1 step completed
      await repo.markCompleted('step_1');
      summary = await repo.buildHomeSummary();
      expect(summary.completedCount, 1);
      expect(summary.overallPercent, 4.0);
      expect(summary.percentLabel, 4);
      expect(summary.nextStepId, 'step_2');

      // 12 steps completed: all of lvl 1 (5), all of lvl 2 (5), and 2 of lvl 3
      for (int i = 2; i <= 12; i++) {
        await repo.markCompleted('step_$i');
      }
      summary = await repo.buildHomeSummary();
      expect(summary.completedCount, 12);
      expect(summary.overallPercent, 48.0);
      expect(summary.percentLabel, 48);
      expect(summary.currentLevel, 3);
      expect(summary.nextStepId, 'step_13');
      expect(summary.allCompleted, isFalse);

      // Complete all 25 steps
      for (int i = 13; i <= 25; i++) {
        await repo.markCompleted('step_$i');
      }
      summary = await repo.buildHomeSummary();
      expect(summary.completedCount, 25);
      expect(summary.overallPercent, 100.0);
      expect(summary.percentLabel, 100);
      expect(summary.currentLevel, 5);
      expect(summary.nextStepId, isNull);
      expect(summary.allCompleted, isTrue);
    });

    test(
      'Stale & duplicate IDs ignored, empty curriculum does not throw NaN',
      () async {
        const fake25 = _Fake25StepsMateriRepository();
        final repo = ProgressRepository(materiRepository: fake25);
        SharedPreferences.setMockInitialValues(<String, Object>{
          'voltar_completed_steps': <String>[
            'step_1',
            'step_1',
            'stale_unknown_id',
            'old_deprecated_step',
          ],
        });

        final summary = await repo.buildHomeSummary();
        expect(summary.completedCount, 1);
        expect(summary.overallPercent, 4.0);
        expect(summary.percentLabel, 4);

        // Empty curriculum
        const emptyRepo = _EmptyMateriRepository();
        final repoEmpty = ProgressRepository(materiRepository: emptyRepo);
        final emptySummary = await repoEmpty.buildHomeSummary();
        expect(emptySummary.totalSteps, 0);
        expect(emptySummary.overallPercent, 0.0);
        expect(emptySummary.percentLabel, 0);
        expect(emptySummary.overallPercent.isNaN, isFalse);
      },
    );

    test('Concurrent unawaited markCompleted calls are serialized without lost updates', () async {
      const fake25 = _Fake25StepsMateriRepository();
      final repo = ProgressRepository(materiRepository: fake25);
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await repo.reset();

      // Launch multiple writes concurrently without awaiting each
      await Future.wait(<Future<void>>[
        repo.markCompleted('step_1'),
        repo.markCompleted('step_2'),
        repo.markCompleted('step_3'),
        repo.markCompleted('step_4'),
        repo.markCompleted('step_5'),
      ]);

      final completed = await repo.getCompletedSteps();
      expect(completed.length, 5);
      expect(
        completed,
        containsAll(<String>['step_1', 'step_2', 'step_3', 'step_4', 'step_5']),
      );
    });
  });
}
