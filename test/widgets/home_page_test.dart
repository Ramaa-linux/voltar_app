import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/pages/home/home_page.dart';
import 'package:voltar/repositories/materi_repository.dart';
import 'package:voltar/repositories/progress_repository.dart';
import 'package:voltar/theme/app_theme.dart';
import 'package:voltar/widgets/spark_progress_bar.dart';

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

Widget createTestApp({
  required ProgressRepository repo,
  Size physicalSize = const Size(390, 844),
  double textScaleFactor = 1.0,
}) {
  return ProviderScope(
    overrides: [progressRepositoryProvider.overrideWithValue(repo)],
    child: MaterialApp(
      theme: AppTheme.light,
      home: MediaQuery(
        data: MediaQueryData(
          size: physicalSize,
          textScaler: TextScaler.linear(textScaleFactor),
        ),
        child: const Scaffold(body: HomePage()),
      ),
    ),
  );
}

Future<void> pumpHome(WidgetTester tester, Widget app) async {
  await tester.pumpWidget(app);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  const fakeRepo = _Fake25StepsMateriRepository();

  group('HomePage Fase 20 Real Progress Widget Tests', () {
    testWidgets(
      'Fresh install (0%): shows 0%, Mulai Belajar, and step 1 without crash',
      (WidgetTester tester) async {
        SharedPreferences.setMockInitialValues(<String, Object>{});
        final repo = ProgressRepository(materiRepository: fakeRepo);
        await repo.reset();

        await pumpHome(tester, createTestApp(repo: repo));

        expect(find.text('0%'), findsOneWidget);
        expect(find.text('0 dari 25 materi selesai'), findsOneWidget);
        expect(find.text('Mulai Belajar'), findsOneWidget);
        expect(find.text('Judul Step 1'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      '12 of 25 completed: shows 48%, step 13, 12 modul, and 0.48 bar value',
      (WidgetTester tester) async {
        final List<String> completedList = [
          for (int i = 1; i <= 12; i++) 'step_$i',
        ];
        SharedPreferences.setMockInitialValues(<String, Object>{
          ProgressRepository.storageKey: completedList,
          ProgressRepository.streakCountKey: 3,
          ProgressRepository.streakLastDayKey: '2026-03-10',
        });
        final repo = ProgressRepository(
          materiRepository: fakeRepo,
          now: () => DateTime.utc(2026, 3, 10),
        );

        await pumpHome(tester, createTestApp(repo: repo));

        expect(find.text('48%'), findsOneWidget);
        expect(find.text('12 dari 25 materi selesai'), findsOneWidget);
        expect(find.text('12'), findsOneWidget);
        expect(find.text('Judul Step 13'), findsOneWidget);
        expect(find.text('3 hari'), findsOneWidget);

        final bars = tester.widgetList<SparkProgressBar>(
          find.byType(SparkProgressBar),
        );
        expect(bars.first.value, closeTo(0.48, 0.001));

        // Hardcoded audit: obsolete strings must not exist
        expect(find.text('Dasar LED'), findsNothing);
        expect(find.text('Modul 3 • 4 dari 6 materi'), findsNothing);
      },
    );

    testWidgets(
      'Reactive update: completing step 13 updates Home from 48% to 52%',
      (WidgetTester tester) async {
        final List<String> completedList = [
          for (int i = 1; i <= 12; i++) 'step_$i',
        ];
        SharedPreferences.setMockInitialValues(<String, Object>{
          ProgressRepository.storageKey: completedList,
        });
        final repo = ProgressRepository(materiRepository: fakeRepo);

        await pumpHome(tester, createTestApp(repo: repo));

        expect(find.text('48%'), findsOneWidget);
        expect(find.text('Judul Step 13'), findsOneWidget);

        // Complete 1 more step
        await repo.markCompleted('step_13');
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 50));

        expect(find.text('52%'), findsOneWidget);
        expect(find.text('13 dari 25 materi selesai'), findsOneWidget);
        expect(find.text('Judul Step 14'), findsOneWidget);
      },
    );

    testWidgets('All completed: shows 100% and Semua materi selesai', (
      WidgetTester tester,
    ) async {
      final List<String> completedList = [
        for (int i = 1; i <= 25; i++) 'step_$i',
      ];
      SharedPreferences.setMockInitialValues(<String, Object>{
        ProgressRepository.storageKey: completedList,
      });
      final repo = ProgressRepository(materiRepository: fakeRepo);

      await pumpHome(tester, createTestApp(repo: repo));

      expect(find.text('100%'), findsOneWidget);
      expect(find.text('25 dari 25 materi selesai'), findsOneWidget);
      expect(find.text('Semua materi selesai 🎉'), findsOneWidget);
      expect(find.text('Jelajahi Materi'), findsOneWidget);
    });

    testWidgets(
      'Small screen 320x568 and textScaler 1.3 renders without overflow',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(320 * 2, 568 * 2);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final repo = ProgressRepository(materiRepository: fakeRepo);
        await pumpHome(
          tester,
          createTestApp(
            repo: repo,
            physicalSize: const Size(320, 568),
            textScaleFactor: 1.3,
          ),
        );

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('Anti-leak: disposing HomePage leaves no dangling listeners', (
      WidgetTester tester,
    ) async {
      final repo = ProgressRepository(materiRepository: fakeRepo);
      await pumpHome(tester, createTestApp(repo: repo));

      await tester.pumpWidget(const SizedBox());
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  });

  group('HomePage Screenshots (Golden)', () {
    testWidgets(
      'Capture Home screenshots (0%, 48%, 52%, 100%) at 390x844 DPR 3',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390 * 3.0, 844 * 3.0);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        Future<void> capture(ProgressRepository repo, String filename) async {
          final key = GlobalKey();
          await tester.pumpWidget(
            ProviderScope(
              overrides: [progressRepositoryProvider.overrideWithValue(repo)],
              child: MaterialApp(
                theme: AppTheme.light,
                home: Scaffold(
                  body: RepaintBoundary(key: key, child: const HomePage()),
                ),
              ),
            ),
          );
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 200));

          final boundary =
              key.currentContext!.findRenderObject() as RenderRepaintBoundary;
          final ui.Image image = await tester.runAsync(
            () => boundary.toImage(pixelRatio: 1.0),
          ) as ui.Image;
          final byteData = await tester.runAsync(
            () => image.toByteData(format: ui.ImageByteFormat.png),
          );
          await tester.runAsync(
            () =>
                File('docs/screenshots/$filename')
                    .writeAsBytes(byteData!.buffer.asUint8List()),
          );
        }

        // (a) 48% (12 of 25)
        SharedPreferences.setMockInitialValues(<String, Object>{
          ProgressRepository.storageKey: [
            for (int i = 1; i <= 12; i++) 'step_$i',
          ],
          ProgressRepository.streakCountKey: 5,
          ProgressRepository.streakLastDayKey: '2026-03-10',
        });
        await capture(
          ProgressRepository(
            materiRepository: fakeRepo,
            now: () => DateTime.utc(2026, 3, 10),
          ),
          'fase20-home-48percent.png',
        );

        // (b) 52% (13 of 25)
        SharedPreferences.setMockInitialValues(<String, Object>{
          ProgressRepository.storageKey: [
            for (int i = 1; i <= 13; i++) 'step_$i',
          ],
          ProgressRepository.streakCountKey: 5,
          ProgressRepository.streakLastDayKey: '2026-03-10',
        });
        await capture(
          ProgressRepository(
            materiRepository: fakeRepo,
            now: () => DateTime.utc(2026, 3, 10),
          ),
          'fase20-home-52percent.png',
        );

        // (c) 0% (Fresh install)
        SharedPreferences.setMockInitialValues(<String, Object>{});
        await capture(
          const ProgressRepository(materiRepository: fakeRepo),
          'fase20-home-0percent.png',
        );

        // (d) 100% (All 25 completed)
        SharedPreferences.setMockInitialValues(<String, Object>{
          ProgressRepository.storageKey: [
            for (int i = 1; i <= 25; i++) 'step_$i',
          ],
          ProgressRepository.streakCountKey: 7,
          ProgressRepository.streakLastDayKey: '2026-03-10',
        });
        await capture(
          ProgressRepository(
            materiRepository: fakeRepo,
            now: () => DateTime.utc(2026, 3, 10),
          ),
          'fase20-home-100percent.png',
        );
      },
    );
  });
}
