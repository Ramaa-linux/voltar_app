import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/pages/materi/kuis_page.dart';
import 'package:voltar/pages/materi/level_detail_page.dart';
import 'package:voltar/pages/materi/materi_page.dart';
import 'package:voltar/repositories/materi_repository.dart';

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
    ];
  }

  @override
  Future<LevelModel> getLevelByNumber(int levelNumber) async {
    final levels = await getAllLevels();
    return levels.first;
  }

  @override
  Future<LearningStep> getStepById(String stepId) async {
    final levels = await getAllLevels();
    return levels.first.steps.firstWhere((s) => s.id == stepId);
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
    expect(find.text('1 materi • 5 menit'), findsOneWidget);
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
    expect(find.text('Tegangan & Arus'), findsOneWidget);
    expect(find.text('Post-Test Level 1'), findsOneWidget);
    expect(find.text('Terkunci'), findsOneWidget); // Post-test terkunci
    expect(find.text('Mulai'), findsNWidgets(2)); // Pre-test & materi aktif
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
}
