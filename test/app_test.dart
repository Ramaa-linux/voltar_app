import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/app.dart';
import 'package:voltar/pages/home/home_page.dart';
import 'package:voltar/router/app_router.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_theme.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/arduino_painter.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_floating_nav_bar.dart';

void main() {
  /// Pump aplikasi nyata (router + shell + halaman) pada ukuran layar target.
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: VoltArApp()));
    await tester.pumpAndSettle();
  }

  /// Label nav bar - dibatasi ke navbar agar tidak bentrok dengan judul halaman.
  Finder navItem(String label) => find.descendant(
    of: find.byType(VoltFloatingNavBar),
    matching: find.text(label),
  );

  testWidgets('app boot ke Home tanpa exception di 390x844', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Halo, Budi!'), findsOneWidget);
    expect(find.text('Lanjutkan Belajar'), findsOneWidget);
    expect(find.text('Tantangan Harian'), findsOneWidget);
    expect(find.byType(VoltFloatingNavBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tab nav berpindah halaman dan Home tetap hidup', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(navItem('Materi'));
    await tester.pumpAndSettle();
    expect(
      find.text('Belajar bertahap, dari komponen dasar sampai Arduino.'),
      findsOneWidget,
    );
    expect(find.text('LEVEL 1'), findsOneWidget);
    // IndexedStack: Home offstage tapi tetap di widget tree (state terjaga).
    expect(find.byType(HomePage, skipOffstage: false), findsOneWidget);

    await tester.tap(navItem('Simulasi'));
    await tester.pumpAndSettle();
    expect(find.text('Buat Project Baru'), findsOneWidget);
    expect(find.text('Project Saya'), findsOneWidget);

    await tester.tap(navItem('Profil'));
    await tester.pumpAndSettle();
    expect(find.text('Budi Santoso'), findsOneWidget);

    final VoltFloatingNavBar nav = tester.widget<VoltFloatingNavBar>(
      find.byType(VoltFloatingNavBar),
    );
    expect(nav.currentIndex, 3);

    await tester.tap(navItem('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Halo, Budi!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shell memakai satu Scaffold dengan extendBody', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    expect(find.byType(Scaffold), findsOneWidget);
    final Scaffold scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.extendBody, isTrue);
  });

  testWidgets('halaman menyisakan ruang bawah untuk navbar', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    final ListView list = tester.widget<ListView>(find.byType(ListView).first);
    final EdgeInsets padding = list.padding! as EdgeInsets;
    expect(padding.bottom, AppSpacing.navBarClearance);
  });

  testWidgets('createAppRouter membuka tab lewat initialLocation', (
    WidgetTester tester,
  ) async {
    final GoRouter router = createAppRouter(initialLocation: AppRoutes.profil);
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    );
    await tester.pumpAndSettle();

    expect(find.text('Budi Santoso'), findsOneWidget);
    final VoltFloatingNavBar nav = tester.widget<VoltFloatingNavBar>(
      find.byType(VoltFloatingNavBar),
    );
    expect(nav.currentIndex, 3);
    expect(tester.takeException(), isNull);
  });

  testWidgets('AppIcon memetakan ikon Lucide ke aset svg', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: <Widget>[AppIcon.home(), AppIcon.chevronRight()],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final List<String> assets = tester
        .widgetList<SvgPicture>(find.byType(SvgPicture))
        .map((SvgPicture svg) => (svg.bytesLoader as SvgAssetLoader).assetName)
        .toList();
    expect(assets, <String>[
      'assets/icons/home.svg',
      'assets/icons/chevron-right.svg',
    ]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('VoltButton disabled saat onPressed null', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: VoltButton(label: 'Nonaktif')),
        ),
      ),
    );

    final ElevatedButton button = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('dashboard simulasi push ke editor tanpa navbar', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(navItem('Simulasi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Buat Project Baru'));
    await tester.pumpAndSettle();

    expect(find.text('Project Baru'), findsOneWidget);
    expect(
      find.text('Area WebView Wokwi akan dimuat di sini (Fase 5).'),
      findsOneWidget,
    );
    expect(find.text('Simpan'), findsOneWidget);
    // Editor tampil di atas shell: navbar tidak dirender.
    expect(find.byType(VoltFloatingNavBar), findsNothing);

    await tester.tap(find.byTooltip('Kembali'));
    await tester.pumpAndSettle();

    expect(find.text('Project Saya'), findsOneWidget);
    expect(find.byType(VoltFloatingNavBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('kartu project membuka editor dengan nama project', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(navItem('Simulasi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Blink LED'));
    await tester.pumpAndSettle();

    // Judul AppBar memakai nama project dari query `?title=`.
    expect(find.text('Blink LED'), findsOneWidget);
    expect(find.text('Buat Project Baru'), findsNothing);
    expect(find.text('Draft'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('createAppRouter bisa dibuka langsung di route editor', (
    WidgetTester tester,
  ) async {
    final GoRouter router = createAppRouter(
      initialLocation: AppRoutes.simulasiTemplateBlink,
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    );
    await tester.pumpAndSettle();

    expect(find.text('Blink LED Dasar'), findsOneWidget);
    expect(find.text('Template bawaan'), findsOneWidget);
    expect(find.byType(VoltFloatingNavBar), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('createAppRouter membuka halaman uji mesin AVR', (
    WidgetTester tester,
  ) async {
    final GoRouter router = createAppRouter(
      initialLocation: AppRoutes.avrDebug,
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pin 13: LOW'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Stop'), findsOneWidget);
    expect(find.byType(VoltFloatingNavBar), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('createAppRouter membuka halaman canvas 2D', (
    WidgetTester tester,
  ) async {
    final GoRouter router = createAppRouter(
      initialLocation: AppRoutes.canvasDebug,
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rangkaian Blink'), findsOneWidget);
    expect(find.text('Pin 13: LOW'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Stop'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is CustomPaint && widget.painter is ArduinoPainter,
      ),
      findsOneWidget,
    );
    expect(find.byType(VoltFloatingNavBar), findsNothing);
    expect(tester.takeException(), isNull);
  });

  test('theme memakai token warna dan font VoltAR', () {
    final ThemeData theme = AppTheme.light;

    expect(theme.colorScheme.primary, AppColors.primary);
    expect(theme.scaffoldBackgroundColor, AppColors.background);
    expect(theme.textTheme.bodyMedium?.fontFamily, AppTypography.fontFamily);
    expect(theme.textTheme.bodyMedium?.fontWeight, FontWeight.w400);
    expect(theme.textTheme.headlineMedium?.fontWeight, FontWeight.w700);
  });
}
