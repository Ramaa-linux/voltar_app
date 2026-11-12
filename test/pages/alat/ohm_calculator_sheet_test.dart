import 'dart:io';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/pages/alat/ohm_calculator_sheet.dart';
import 'package:voltar/pages/alat/resistor_calculator_sheet.dart';
import 'package:voltar/pages/home/home_page.dart';
import 'package:voltar/repositories/materi_repository.dart';
import 'package:voltar/repositories/progress_repository.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_theme.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';

Future<void> _loadAppFonts() async {
  final FontLoader loader = FontLoader('PlusJakartaSans')
    ..addFont(rootBundle.load('assets/fonts/PlusJakartaSans-Regular.ttf'))
    ..addFont(rootBundle.load('assets/fonts/PlusJakartaSans-Medium.ttf'))
    ..addFont(rootBundle.load('assets/fonts/PlusJakartaSans-Bold.ttf'));
  await loader.load();

  final File materialFont = File(
    r'D:\Program\Flutter\flutter\bin\cache\artifacts\material_fonts\MaterialIcons-Regular.otf',
  );
  if (materialFont.existsSync()) {
    final Uint8List bytes = materialFont.readAsBytesSync();
    final FontLoader materialLoader = FontLoader('MaterialIcons')
      ..addFont(Future<ByteData>.value(ByteData.view(bytes.buffer)));
    await materialLoader.load();
  }
}

class _FakeMateriRepo extends MateriRepository {
  const _FakeMateriRepo();

  @override
  Future<List<LevelModel>> getAllLevels() async {
    return List<LevelModel>.generate(5, (int lIdx) {
      return LevelModel(
        levelNumber: lIdx + 1,
        steps: List<LearningStep>.generate(5, (int sIdx) {
          final int num = lIdx * 5 + sIdx + 1;
          return LearningStep(
            id: 'step_$num',
            type: sIdx == 0
                ? LearningStepType.pretest
                : (sIdx == 4
                      ? LearningStepType.posttest
                      : LearningStepType.materi),
            title: 'Dasar Komponen Elektronika $num',
            description: 'Deskripsi $num',
          );
        }),
      );
    });
  }
}

class _FakeUser extends Fake implements User {
  @override
  String get uid => 'user_23';
  @override
  String? get email => 'rama@smk.sch.id';
  @override
  String? get displayName => 'Rama Pratama';
}

class _MockAuthService extends AuthService {
  @override
  User? get currentUser => _FakeUser();
}

void main() {
  setUpAll(() async {
    await _loadAppFonts();
  });

  group('OhmCalculatorSheet Widget Tests', () {
    testWidgets('Fill V and R automatically calculates I and shows badge', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(body: OhmCalculatorSheet()),
        ),
      );

      final Finder textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(3));

      // Isi V = 12 dan R = 4 -> I otomatis 3
      await tester.enterText(textFields.at(0), '12');
      await tester.pump();
      await tester.enterText(textFields.at(2), '4');
      await tester.pump();

      final TextField currentField = tester.widget<TextField>(textFields.at(1));
      expect(currentField.controller?.text, '3');
      expect(find.text('Hasil otomatis'), findsOneWidget);
    });

    testWidgets('Formatter rejects letters, spaces, and multiple decimals', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(body: OhmCalculatorSheet()),
        ),
      );

      final Finder vField = find.byType(TextField).at(0);

      await tester.enterText(vField, 'abc');
      await tester.pump();
      expect(tester.widget<TextField>(vField).controller?.text, '');

      await tester.enterText(vField, '12,5');
      await tester.pump();
      expect(tester.widget<TextField>(vField).controller?.text, '12,5');

      await tester.enterText(vField, '12,5,3');
      await tester.pump();
      // Tetap '12,5' karena dua pemisah desimal ditolak formatter
      expect(tester.widget<TextField>(vField).controller?.text, '12,5');
    });

    testWidgets(
      'Division by zero shows friendly error message andReset clears all',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light,
            home: const Scaffold(body: OhmCalculatorSheet()),
          ),
        );

        final Finder textFields = find.byType(TextField);
        await tester.enterText(textFields.at(0), '12');
        await tester.pump();
        await tester.enterText(textFields.at(2), '0');
        await tester.pump();

        expect(find.text('Hambatan (R) tidak boleh 0'), findsOneWidget);

        // Tap tombol Reset
        await tester.tap(find.widgetWithText(VoltButton, 'Reset'));
        await tester.pump();

        expect(tester.widget<TextField>(textFields.at(0)).controller?.text, '');
        expect(tester.widget<TextField>(textFields.at(1)).controller?.text, '');
        expect(tester.widget<TextField>(textFields.at(2)).controller?.text, '');
        expect(find.text('Hambatan (R) tidak boleh 0'), findsNothing);
      },
    );
  });

  group('Home Page Pintasan Cepat & Visual Proof Tests', () {
    testWidgets(
      'Two Pintasan Cepat cards are equal height, balanced, and open respective sheets',
      (WidgetTester tester) async {
        SharedPreferences.setMockInitialValues(<String, Object>{});
        final ProgressRepository repo = const ProgressRepository(
          materiRepository: _FakeMateriRepo(),
        );
        await repo.reset();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              progressRepositoryProvider.overrideWithValue(repo),
              authServiceProvider.overrideWithValue(_MockAuthService()),
            ],
            child: MaterialApp(
              theme: AppTheme.light,
              home: const Scaffold(body: HomePage()),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Pintasan Cepat'), findsOneWidget);
        expect(find.text('Kalkulator Resistor'), findsOneWidget);
        expect(find.text('Baca warna gelang'), findsOneWidget);
        expect(find.text('Kalkulator Ohm'), findsOneWidget);
        expect(find.text('Hitung V, I, R'), findsOneWidget);

        // Pastikan kedua card punya tinggi dan lebar yang sama (50:50)
        await tester.scrollUntilVisible(
          find.text('Kalkulator Resistor'),
          100,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        final Finder resistorCard = find.ancestor(
          of: find.text('Kalkulator Resistor'),
          matching: find.byType(VoltCard),
        );
        final Finder ohmCard = find.ancestor(
          of: find.text('Kalkulator Ohm'),
          matching: find.byType(VoltCard),
        );
        final Size rSize = tester.getSize(resistorCard);
        final Size oSize = tester.getSize(ohmCard);
        expect(rSize.height, equals(oSize.height));
        expect(rSize.width, closeTo(oSize.width, 0.1));

        // Tap Kalkulator Resistor -> sheet terbuka
        await tester.tap(find.text('Kalkulator Resistor'));
        await tester.pumpAndSettle();
        expect(find.byType(ResistorCalculatorSheet), findsOneWidget);
        expect(find.text('Kalkulator Kode Warna Resistor'), findsOneWidget);

        // Tutup sheet
        await tester.tap(find.byTooltip('Tutup'));
        await tester.pumpAndSettle();
        expect(find.byType(ResistorCalculatorSheet), findsNothing);

        // Tap Kalkulator Ohm -> sheet terbuka
        await tester.tap(find.text('Kalkulator Ohm'));
        await tester.pumpAndSettle();
        expect(find.byType(OhmCalculatorSheet), findsOneWidget);
        expect(find.text('Kalkulator Hukum Ohm'), findsOneWidget);
      },
    );

    testWidgets('No overflow on small 360x640 screen and 1.3x text scale', (
      WidgetTester tester,
    ) async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final ProgressRepository repo = const ProgressRepository(
        materiRepository: _FakeMateriRepo(),
      );
      await repo.reset();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            progressRepositoryProvider.overrideWithValue(repo),
            authServiceProvider.overrideWithValue(_MockAuthService()),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: MediaQuery(
              data: const MediaQueryData(
                size: Size(360, 640),
                textScaler: TextScaler.linear(1.3),
              ),
              child: const Scaffold(body: HomePage()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.scrollUntilVisible(
        find.text('Kalkulator Ohm'),
        100,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Kalkulator Ohm'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
    testWidgets(
      'Capture Fase 23 screenshots: (a) Home Pintasan Cepat, (b) Ohm Sheet open',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390 * 2.0, 844 * 2.0);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        SharedPreferences.setMockInitialValues(<String, Object>{
          ProgressRepository.storageKey: <String>[
            for (int i = 1; i <= 12; i++) 'step_$i',
          ],
          ProgressRepository.streakCountKey: 5,
          ProgressRepository.streakLastDayKey: '2026-03-10',
        });
        final ProgressRepository repo = ProgressRepository(
          materiRepository: const _FakeMateriRepo(),
          now: () => DateTime.utc(2026, 3, 10),
        );

        final GlobalKey repaintKey = GlobalKey();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              progressRepositoryProvider.overrideWithValue(repo),
              authServiceProvider.overrideWithValue(_MockAuthService()),
            ],
            child: RepaintBoundary(
              key: repaintKey,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                home: const Scaffold(body: HomePage()),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        Future<void> savePng(String filename) async {
          final RenderRepaintBoundary boundary =
              repaintKey.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary;
          final ui.Image image = await tester.runAsync(
            () => boundary.toImage(pixelRatio: 1.0),
          ) as ui.Image;
          final ByteData? byteData = await tester.runAsync<ByteData?>(
            () => image.toByteData(format: ui.ImageByteFormat.png),
          );
          await tester.runAsync(
            () =>
                File('docs/screenshots/$filename')
                    .writeAsBytes(byteData!.buffer.asUint8List()),
          );
        }

        // Scroll agar Pintasan Cepat terlihat di layar
        await tester.drag(find.byType(ListView), const Offset(0, -160));
        await tester.pumpAndSettle();
        await savePng('fase23_home_pintasan_cepat.png');

        // Buka Kalkulator Ohm dan isi 2 nilai
        await tester.tap(find.text('Kalkulator Ohm'));
        await tester.pumpAndSettle();

        final Finder fields = find.byType(TextField);
        await tester.enterText(fields.at(0), '12');
        await tester.pump();
        await tester.enterText(fields.at(2), '220');
        await tester.pumpAndSettle();

        await savePng('fase23_ohm_calculator_sheet.png');

        // Tutup Ohm Sheet
        await tester.tap(find.byTooltip('Tutup'));
        await tester.pumpAndSettle();

        // Buka Resistor Calculator
        await tester.tap(find.text('Kalkulator Resistor'));
        await tester.pumpAndSettle();
        await savePng('fase23_resistor_calculator_sheet.png');
      },
    );
  });
}
