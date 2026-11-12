import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_config.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_engine.dart';
import 'package:voltar/pages/game/circuit_rush_page.dart';
import 'package:voltar/theme/app_theme.dart';

void main() {
  Widget buildTestableGame({CircuitRushEngine? engine}) {
    return MaterialApp(
      theme: AppTheme.light,
      home: CircuitRushPage(engine: engine),
    );
  }

  testWidgets('CircuitRushPage menampilkan overlay Siap Main', (
    WidgetTester tester,
  ) async {
    final CircuitRushEngine engine = CircuitRushEngine(random: math.Random(1));
    addTearDown(engine.dispose);

    await tester.pumpWidget(buildTestableGame(engine: engine));
    await tester.pump();

    expect(find.text('Sirkuit Kilat'), findsOneWidget);
    expect(find.text('Mulai Main'), findsOneWidget);
    expect(find.text('0 V'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Ketuk Mulai Main mengalihkan status ke playing', (
    WidgetTester tester,
  ) async {
    final CircuitRushEngine engine = CircuitRushEngine(random: math.Random(1));
    addTearDown(engine.dispose);

    await tester.pumpWidget(buildTestableGame(engine: engine));
    await tester.pump();

    await tester.tap(find.text('Mulai Main'));
    await tester.pump();

    expect(engine.status, CircuitRushStatus.playing);
    expect(find.text('Mulai Main'), findsNothing);
    expect(find.byKey(const Key('circuit_rush_pause_button')), findsOneWidget);
  });

  testWidgets('Tombol jeda menampilkan overlay Permainan Dijeda', (
    WidgetTester tester,
  ) async {
    final CircuitRushEngine engine = CircuitRushEngine(random: math.Random(1));
    addTearDown(engine.dispose);

    await tester.pumpWidget(buildTestableGame(engine: engine));
    await tester.pump();

    engine.tap();
    await tester.pump();

    await tester.tap(find.byKey(const Key('circuit_rush_pause_button')));
    await tester.pump();

    expect(engine.status, CircuitRushStatus.paused);
    expect(find.text('Permainan Dijeda'), findsOneWidget);
    expect(find.text('Lanjutkan'), findsOneWidget);

    await tester.tap(find.text('Lanjutkan'));
    await tester.pump();
    expect(engine.status, CircuitRushStatus.playing);
  });

  testWidgets('GameOver overlay muncul saat player menabrak', (
    WidgetTester tester,
  ) async {
    final CircuitRushEngine engine = CircuitRushEngine(random: math.Random(1));
    addTearDown(engine.dispose);

    await tester.pumpWidget(buildTestableGame(engine: engine));
    await tester.pump();

    engine.tap();
    // ignore: invalid_use_of_visible_for_testing_member
    engine.debugSetObstacles(<CircuitObstacle>[
      CircuitObstacle(
        x: engine.playerX - CircuitRushConfig.obstacleWidth / 2,
        gapCenterY: 100,
        gapHeight: 40,
        kind: ObstacleKind.resistor,
        hasCoin: false,
      ),
    ]);
    // ignore: invalid_use_of_visible_for_testing_member
    engine.debugSetPlayerState(y: 422, vy: 0);
    engine.update(0.016);
    await tester.pump();

    expect(engine.status, CircuitRushStatus.gameOver);
    expect(find.text('Arus Terputus'), findsOneWidget);
    expect(find.text('Korsleting!'), findsOneWidget);
    expect(find.text('Keluar'), findsOneWidget);
  });

  testWidgets('GameOver overlay bebas overflow pada lebar 320dp & text scale 1.5x', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320 * 2, 640 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final CircuitRushEngine engine = CircuitRushEngine(random: math.Random(1));
    addTearDown(engine.dispose);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.5),
            ),
            child: child!,
          );
        },
        home: CircuitRushPage(engine: engine),
      ),
    );
    await tester.pump();

    engine.tap();
    // ignore: invalid_use_of_visible_for_testing_member
    engine.debugSetObstacles(<CircuitObstacle>[
      CircuitObstacle(
        x: engine.playerX - CircuitRushConfig.obstacleWidth / 2,
        gapCenterY: 100,
        gapHeight: 40,
        kind: ObstacleKind.resistor,
        hasCoin: false,
      ),
    ]);
    // ignore: invalid_use_of_visible_for_testing_member
    engine.debugSetPlayerState(y: 320, vy: 0);
    engine.update(0.016);
    await tester.pump();

    final dynamic exception = tester.takeException();
    if (exception != null) {
      // ignore: avoid_print
      print('CAUGHT EXCEPTION: $exception');
    }
    expect(exception, isNull);
    final Finder keluarButton = find.widgetWithText(ElevatedButton, 'Keluar');
    expect(keluarButton, findsOneWidget);
    final Size buttonSize = tester.getSize(keluarButton);
    expect(buttonSize.height, greaterThanOrEqualTo(48.0));
  });

  testWidgets('Tombol Main Lagi mereset engine', (
    WidgetTester tester,
  ) async {
    final CircuitRushEngine engine = CircuitRushEngine(random: math.Random(1));
    addTearDown(engine.dispose);

    await tester.pumpWidget(buildTestableGame(engine: engine));
    await tester.pump();

    engine.tap();
    // ignore: invalid_use_of_visible_for_testing_member
    engine.debugSetObstacles(<CircuitObstacle>[
      CircuitObstacle(
        x: engine.playerX - CircuitRushConfig.obstacleWidth / 2,
        gapCenterY: 100,
        gapHeight: 40,
        kind: ObstacleKind.resistor,
        hasCoin: false,
      ),
    ]);
    // ignore: invalid_use_of_visible_for_testing_member
    engine.debugSetPlayerState(y: 422, vy: 0);
    engine.update(0.016);
    await tester.pump();

    await tester.tap(find.text('Main Lagi'));
    await tester.pump();

    expect(engine.status, CircuitRushStatus.playing);
    expect(engine.score, 0);
    expect(engine.coinsCollected, 0);
  });

  testWidgets('Tombol Kembali memanggil Navigator.pop', (
    WidgetTester tester,
  ) async {
    final CircuitRushEngine engine = CircuitRushEngine(random: math.Random(1));
    addTearDown(engine.dispose);

    final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        theme: AppTheme.light,
        home: const Scaffold(body: Text('Beranda Dummy')),
      ),
    );
    navKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (_) => CircuitRushPage(engine: engine),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CircuitRushPage), findsOneWidget);

    await tester.tap(find.byKey(const Key('circuit_rush_back_button')));
    await tester.pumpAndSettle();

    expect(find.byType(CircuitRushPage), findsNothing);
    expect(find.text('Beranda Dummy'), findsOneWidget);
  });

  testWidgets('Capture screenshot Sirkuit Kilat ready state', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390 * 2, 844 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final CircuitRushEngine engine = CircuitRushEngine(random: math.Random(1));
    addTearDown(engine.dispose);

    final GlobalKey boundaryKey = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: RepaintBoundary(
          key: boundaryKey,
          child: CircuitRushPage(engine: engine),
        ),
      ),
    );
    await tester.pump();

    final RenderRepaintBoundary boundary =
        boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image =
        await tester.runAsync(() => boundary.toImage(pixelRatio: 2.0)) as ui.Image;
    final dynamic byteData = await tester.runAsync(
      () => image.toByteData(format: ui.ImageByteFormat.png),
    );
    await tester.runAsync(
      () => File('docs/screenshots/fase14b-circuit-rush-ready.png')
          .writeAsBytes(byteData!.buffer.asUint8List()),
    );

    expect(tester.takeException(), isNull);
  });
}
