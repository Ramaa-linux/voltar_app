import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/pages/materi/detail/materi_detail_view.dart';
import 'package:voltar/pages/materi/kuis_page.dart';
import 'package:voltar/pages/materi/level_detail_page.dart';
import 'package:voltar/pages/materi/materi_page.dart';
import 'package:voltar/repositories/materi_repository.dart';
import 'package:voltar/repositories/progress_repository.dart';
import 'package:voltar/widgets/app_icon.dart';

class _FakeMateriRepository extends MateriRepository {
  const _FakeMateriRepository();

  @override
  Future<List<LevelModel>> getAllLevels() async {
    return <LevelModel>[
      LevelModel(
        levelNumber: 1,
        steps: <LearningStep>[
          const LearningStep(
            id: 'l1_pre',
            type: LearningStepType.pretest,
            title: 'Pre-Test Level 1',
            description: 'Uji kemampuan awal',
            questions: <QuizQuestion>[
              QuizQuestion(
                id: 'q1',
                question: 'Apa itu tegangan?',
                options: ['A', 'B', 'C', 'D'],
                correctAnswerIndex: 0,
              ),
            ],
          ),
          const LearningStep(
            id: 'l1_m1',
            type: LearningStepType.materi,
            title: 'Tegangan & Arus',
            description: 'Konsep dasar listrik',
            estimatedTime: '5 menit',
            content: <ContentBlock>[
              ContentBlock(type: ContentBlockType.text, data: 'Penjelasan tegangan.'),
            ],
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
                title: 'LED (Light Emitting Diode)',
                description: 'Dioda pemancar cahaya',
                estimatedTime: '5 menit',
                heroImageUrl: 'assets/images/nonexistent.png',
                videoSummary: <ContentBlock>[
                  ContentBlock(type: ContentBlockType.heading, data: 'Bab 1: Pengenalan LED'),
                  ContentBlock(type: ContentBlockType.text, data: 'Ringkasan isi video LED.'),
                ],
                content: <ContentBlock>[
                  ContentBlock(type: ContentBlockType.text, data: 'Isi bacaan LED.'),
                ],
              ),
            ],
          ),
          const LearningStep(
            id: 'l1_post',
            type: LearningStepType.posttest,
            title: 'Post-Test Level 1',
            description: 'Uji kemampuan akhir',
            questions: <QuizQuestion>[
              QuizQuestion(
                id: 'q2',
                question: 'Satuan tegangan?',
                options: ['Volt', 'Ampere', 'Ohm', 'Watt'],
                correctAnswerIndex: 0,
              ),
            ],
          ),
        ],
      ),
      const LevelModel(
        levelNumber: 2,
        steps: <LearningStep>[
          LearningStep(
            id: 'l2_pre',
            type: LearningStepType.pretest,
            title: 'Pre-Test Level 2',
            description: 'Uji awal Level 2',
          ),
          LearningStep(
            id: 'l2_m1',
            type: LearningStepType.materi,
            title: 'Materi Level 2',
            description: 'Konten Level 2',
            estimatedTime: '8 menit',
          ),
          LearningStep(
            id: 'l2_post',
            type: LearningStepType.posttest,
            title: 'Post-Test Level 2',
            description: 'Uji akhir Level 2',
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

  @override
  Future<LearningStep> getStepById(String stepId) async {
    final levels = await getAllLevels();
    for (final s in levels.first.steps) {
      if (s.id == stepId) return s;
      for (final sub in s.subMateri ?? const <LearningStep>[]) {
        if (sub.id == stepId) return sub;
      }
    }
    throw StateError('Not found');
  }
}

void main() {
  testWidgets('MateriPage merender daftar level', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          materiRepositoryProvider.overrideWithValue(const _FakeMateriRepository()),
        ],
        child: const MaterialApp(
          home: MateriPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.text('Pilih Level'), findsOneWidget);
    expect(find.text('Level 1'), findsOneWidget);
    // Caption now counts subMateri in folder: 2 materi • 10 menit
    expect(find.text('Level 2'), findsOneWidget);
    expect(find.text('2 materi • 10 menit'), findsOneWidget);
    expect(find.text('1 materi • 8 menit'), findsOneWidget);
  });

  testWidgets('LevelDetailPage merender timeline journey map', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          materiRepositoryProvider.overrideWithValue(const _FakeMateriRepository()),
        ],
        child: const MaterialApp(
          home: LevelDetailPage(levelNumber: 1),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Level 1'), findsOneWidget);
    expect(find.text('Pre-Test Level 1'), findsOneWidget);
    expect(find.text('Post-Test Level 1'), findsOneWidget);
    expect(find.text('Terkunci'), findsNWidgets(2)); // Materi 1 & Post-test terkunci sebelum Pre-Test selesai
    expect(find.text('Mulai'), findsOneWidget); // Hanya Pre-test yang aktif di awal
    // Folder ditampilkan
    expect(find.text('Pengenalan Komponen'), findsOneWidget);
    // Sub-materi belum muncul sebelum folder dibuka
    expect(find.text('LED (Light Emitting Diode)'), findsNothing);
  });


  testWidgets('LevelDetailPage expansion folder menampilkan subMateri', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          materiRepositoryProvider.overrideWithValue(const _FakeMateriRepository()),
        ],
        child: const MaterialApp(
          home: LevelDetailPage(levelNumber: 1),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap folder ExpansionTile untuk membuka
    await tester.tap(find.text('Pengenalan Komponen'));
    await tester.pumpAndSettle();

    // Sub-materi harus terlihat
    expect(find.text('LED (Light Emitting Diode)'), findsOneWidget);
  });

  testWidgets('MateriDetailView render tab bar dan video summary list', (WidgetTester tester) async {
    const repo = _FakeMateriRepository();
    final step = await repo.getStepById('l1_kom_led');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          materiRepositoryProvider.overrideWithValue(repo),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: MateriDetailView(
              step: step,
              levelNumber: 1,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Bacaan'), findsOneWidget);
    expect(find.text('Video'), findsOneWidget);
    expect(find.text('Praktik'), findsOneWidget);

    expect(find.byType(InteractiveViewer), findsOneWidget);

    // Switch ke tab Video
    await tester.tap(find.text('Video'));
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan Video'), findsOneWidget);
    expect(find.byKey(const Key('video_summary_list')), findsOneWidget);
  });

  testWidgets('KuisPage menampilkan soal dan pilihan jawaban', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          materiRepositoryProvider.overrideWithValue(const _FakeMateriRepository()),
        ],
        child: const MaterialApp(
          home: KuisPage(stepId: 'l1_pre'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Pre-Test Level 1'), findsOneWidget);
    expect(find.text('Apa itu tegangan?'), findsOneWidget);
    expect(find.text('Kirim Jawaban'), findsOneWidget);

    // Tap pilihan A (CircleAvatar dengan teks 'A')
    await tester.tap(find.byWidgetPredicate(
      (widget) =>
          widget is CircleAvatar &&
          widget.child is Text &&
          (widget.child as Text).data == 'A',
    ));
    await tester.pumpAndSettle();

    // Kirim jawaban
    await tester.tap(find.text('Kirim Jawaban'));
    await tester.pumpAndSettle();

    // Halaman hasil
    expect(find.text('Selamat!'), findsOneWidget);
    expect(find.text('Skor Kamu: 100'), findsOneWidget);
    expect(find.text('Kembali ke Level'), findsOneWidget);
  });

  group('Fase 17 - Sequential Level Unlocking UI', () {
    testWidgets('MateriPage merender Level 1 terbuka dan Level 2 terkunci di awal', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            materiRepositoryProvider.overrideWithValue(const _FakeMateriRepository()),
            completedStepsProvider.overrideWith((ref) => Future.value(<String>{})),
          ],
          child: const MaterialApp(
            home: MateriPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Level 1'), findsOneWidget);
      expect(find.text('Level 2'), findsOneWidget);

      // Level 2 memiliki label semantik terkunci dan ikon gembok
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Semantics && widget.properties.label == 'Level 2, terkunci',
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) => widget is AppIcon && widget.name == AppIconName.lock,
        ),
        findsOneWidget,
      );

      // Tap Level 2 menampilkan SnackBar pesan
      await tester.tap(find.text('Level 2'));
      await tester.pump();

      expect(find.text('Selesaikan Level sebelumnya terlebih dahulu'), findsOneWidget);
    });

    testWidgets('MateriPage membuka Level 2 ketika seluruh langkah Level 1 selesai', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            materiRepositoryProvider.overrideWithValue(const _FakeMateriRepository()),
            completedStepsProvider.overrideWith(
              (ref) => Future.value(<String>{'l1_pre', 'l1_m1', 'l1_kom_led', 'l1_post'}),
            ),
          ],
          child: const MaterialApp(
            home: MateriPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Level 2 sekarang terbuka, label semantik bukan "terkunci" dan chevron muncul
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Semantics && widget.properties.label == 'Level 2',
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Semantics && widget.properties.label == 'Level 2, terkunci',
        ),
        findsNothing,
      );
      expect(
        find.byWidgetPredicate(
          (widget) => widget is AppIcon && widget.name == AppIconName.lock,
        ),
        findsNothing,
      );
      expect(
        find.byWidgetPredicate(
          (widget) => widget is AppIcon && widget.name == AppIconName.chevronRight,
        ),
        findsNWidgets(2),
      );
    });

    testWidgets('LevelDetailPage guard menampilkan pesan terkunci saat level dikunci', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            materiRepositoryProvider.overrideWithValue(const _FakeMateriRepository()),
            completedStepsProvider.overrideWith((ref) => Future.value(<String>{})),
          ],
          child: const MaterialApp(
            home: LevelDetailPage(levelNumber: 2),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Level Terkunci'), findsOneWidget);
      expect(find.text('Selesaikan Level sebelumnya terlebih dahulu'), findsOneWidget);
      expect(find.text('Kembali ke Pilih Level'), findsOneWidget);
      // Timeline materi tidak dirender
      expect(find.text('Pre-Test Level 2'), findsNothing);
    });
  });
}
