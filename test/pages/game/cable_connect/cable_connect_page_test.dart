import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/app.dart';
import 'package:voltar/pages/game/cable_connect/cable_levels.dart';
import 'package:voltar/pages/game/cable_connect/cable_models.dart';
import 'package:voltar/pages/game/cable_connect_page.dart';
import 'package:voltar/theme/app_theme.dart';
import 'package:voltar/widgets/volt_floating_nav_bar.dart';

void main() {
  Widget buildTestPage(CableConnectController controller) {
    return MaterialApp(
      theme: AppTheme.light,
      home: CableConnectPage(controller: controller),
    );
  }

  testWidgets('renders Level 1 HUD, checklist, and board without error', (
    WidgetTester tester,
  ) async {
    final CableConnectController controller = CableConnectController(
      autoStartTimer: false,
    );
    addTearDown(controller.dispose);

    await tester.pumpWidget(buildTestPage(controller));

    expect(find.text('Level 1'), findsOneWidget);
    expect(find.text('60s'), findsOneWidget);
    expect(find.text('0 V'), findsOneWidget);
    expect(find.text('Resistor: 0/1'), findsOneWidget);
    expect(find.text('LED: 0/1'), findsOneWidget);
    expect(
      find.byKey(const Key('cable_connect_board_gesture')),
      findsOneWidget,
    );
  });

  testWidgets('completing witness path triggers Win Overlay and +10s bonus', (
    WidgetTester tester,
  ) async {
    final CableConnectController controller = CableConnectController(
      autoStartTimer: false,
      initialSeconds: 45,
    );
    addTearDown(controller.dispose);

    await tester.pumpWidget(buildTestPage(controller));

    final List<Pos> witness = CableLevels.level1.witnessPath!;
    for (int i = 1; i < witness.length; i++) {
      controller.stepTo(witness[i]);
    }
    await tester.pump();

    expect(controller.status, CableGameStatus.won);
    expect(controller.secondsLeft, 55); // 45 + 10 bonus
    expect(controller.score, greaterThan(0));
    expect(find.text('Rangkaian Tertutup'), findsOneWidget);
    expect(find.text('Arus Mengalir!'), findsOneWidget);

    // Advance to Level 2
    await tester.tap(find.byKey(const Key('cable_connect_next_button')));
    await tester.pump();

    expect(controller.levelNumber, 2);
    expect(controller.status, CableGameStatus.playing);
    expect(find.text('Level 2'), findsOneWidget);
  });

  testWidgets('timer reaching 0 triggers Game Over overlay and retry works', (
    WidgetTester tester,
  ) async {
    final CableConnectController controller = CableConnectController(
      autoStartTimer: false,
      initialSeconds: 2,
    );
    addTearDown(controller.dispose);

    await tester.pumpWidget(buildTestPage(controller));

    controller.tickSecond();
    await tester.pump();
    expect(controller.secondsLeft, 1);

    controller.tickSecond();
    await tester.pump();
    expect(controller.secondsLeft, 0);
    expect(controller.status, CableGameStatus.gameOver);
    expect(find.text('Waktu Habis'), findsOneWidget);

    await tester.tap(find.byKey(const Key('cable_connect_retry_button')));
    await tester.pump();

    expect(controller.status, CableGameStatus.playing);
    expect(controller.secondsLeft, 2);
  });

  testWidgets('lifecycle pause/resume and disposal cleans up timer', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const CableConnectPage(),
      ),
    );

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    // Unmount widget tree to verify clean dispose with no active timer leak.
    await tester.pumpWidget(const SizedBox.shrink());
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tombol Kembali memanggil pop dan kembali ke halaman sebelumnya', (
    WidgetTester tester,
  ) async {
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
        builder: (_) => const CableConnectPage(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CableConnectPage), findsOneWidget);

    await tester.tap(find.byKey(const Key('cable_connect_back_button')));
    await tester.pumpAndSettle();

    expect(find.byType(CableConnectPage), findsNothing);
    expect(find.text('Beranda Dummy'), findsOneWidget);
  });

  testWidgets('HomePage menampilkan kartu Sambung Kabel', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: VoltArApp()));
    await tester.pumpAndSettle();

    expect(find.text('Sambung Kabel'), findsOneWidget);
    expect(find.byType(VoltFloatingNavBar), findsOneWidget);
  });
}
