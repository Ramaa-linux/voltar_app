import 'dart:io';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/pages/home/home_page.dart';
import 'package:voltar/pages/profil/edit_profil_page.dart';
import 'package:voltar/pages/profil/profil_page.dart';
import 'package:voltar/router/app_router.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_theme.dart';

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

class FakeProfilUser extends Fake implements User {
  FakeProfilUser({
    this.uid = 'user_profil_1',
    this.email = 'rama@smk.sch.id',
    this.displayName = 'Rama Pratama',
  });

  @override
  final String uid;

  @override
  final String? email;

  @override
  final String? displayName;
}

class MockProfilAuthService extends AuthService {
  MockProfilAuthService({User? user}) : _user = user ?? FakeProfilUser();

  final User? _user;
  String? updatedName;
  bool loggedOut = false;
  bool throwOnUpdate = false;
  String updateErrorMessage = 'Gagal memperbarui profil.';

  @override
  User? get currentUser => _user;

  @override
  Future<void> updateProfile({required String name}) async {
    if (throwOnUpdate) {
      throw AuthException(updateErrorMessage);
    }
    updatedName = name;
  }

  @override
  Future<void> logout() async {
    loggedOut = true;
  }
}

void main() {
  group('initialsFromName', () {
    test('returns ? for null or empty string', () {
      expect(initialsFromName(null), '?');
      expect(initialsFromName(''), '?');
      expect(initialsFromName('   '), '?');
    });

    test('returns single initial for one-word name', () {
      expect(initialsFromName('rama'), 'R');
      expect(initialsFromName('  Budi  '), 'B');
    });

    test('returns first and last initials for multi-word name', () {
      expect(initialsFromName('Rama Pratama'), 'RP');
      expect(initialsFromName('Ahmad Budi Santoso'), 'AS');
    });
  });

  group('ProfilPage & EditProfilPage Widget Tests', () {
    late MockProfilAuthService authService;

    setUp(() {
      authService = MockProfilAuthService();
    });

    testWidgets('ProfilPage displays dynamic user data and EduVolt branding', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(authService),
            userProfileProvider.overrideWith(
              (Ref ref) => Stream<Map<String, dynamic>?>.value(<String, dynamic>{
                'name': 'Rama Pratama',
                'email': 'rama@smk.sch.id',
                'role': 'siswa',
              }),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const Scaffold(body: ProfilPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('RP'), findsOneWidget);
      expect(find.text('Rama Pratama'), findsOneWidget);
      expect(find.text('rama@smk.sch.id'), findsOneWidget);
      expect(find.text('Siswa'), findsOneWidget);
      expect(find.text('Edit Profil'), findsOneWidget);
      expect(find.text('Keluar'), findsOneWidget);
      expect(find.text('EduVolt v1.0.0'), findsOneWidget);
    });

    testWidgets('Tapping Edit Profil navigates to EditProfilPage and saves', (
      WidgetTester tester,
    ) async {
      final GoRouter router = createAppRouter(
        initialLocation: AppRoutes.profil,
        isLoggedIn: () => true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(authService),
            userProfileProvider.overrideWith(
              (Ref ref) => Stream<Map<String, dynamic>?>.value(<String, dynamic>{
                'name': 'Rama Pratama',
                'email': 'rama@smk.sch.id',
                'role': 'siswa',
              }),
            ),
          ],
          child: MaterialApp.router(
            theme: AppTheme.light,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Edit Profil'));
      await tester.pumpAndSettle();

      expect(find.byType(EditProfilPage), findsOneWidget);
      expect(find.text('Simpan Perubahan'), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key('edit_name_field')),
        'Rama Wijaya',
      );
      await tester.tap(find.byKey(const Key('edit_save_button')));
      await tester.pumpAndSettle();

      expect(authService.updatedName, 'Rama Wijaya');
      expect(find.text('Profil berhasil diperbarui'), findsOneWidget);
    });

    testWidgets('EditProfilPage shows error banner when updateProfile throws', (
      WidgetTester tester,
    ) async {
      authService.throwOnUpdate = true;
      authService.updateErrorMessage = 'Tidak ada koneksi internet.';

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(authService),
            userProfileProvider.overrideWith(
              (Ref ref) => Stream<Map<String, dynamic>?>.value(<String, dynamic>{
                'name': 'Rama Pratama',
                'email': 'rama@smk.sch.id',
                'role': 'siswa',
              }),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const EditProfilPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('edit_name_field')),
        'Rama Baru',
      );
      await tester.tap(find.byKey(const Key('edit_save_button')));
      await tester.pumpAndSettle();

      expect(find.text('Tidak ada koneksi internet.'), findsOneWidget);
    });

    testWidgets('Tapping Notifikasi displays notification dialog', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(authService),
            userProfileProvider.overrideWith(
              (Ref ref) => Stream<Map<String, dynamic>?>.value(<String, dynamic>{
                'name': 'Rama Pratama',
                'email': 'rama@smk.sch.id',
                'role': 'siswa',
              }),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: ProfilPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final Finder notifRow = find.text('Notifikasi');
      await tester.ensureVisible(notifRow);
      await tester.tap(notifRow);
      await tester.pumpAndSettle();

      expect(find.text('Belum ada notifikasi baru.'), findsOneWidget);
      expect(find.text('Tutup'), findsOneWidget);

      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();
      expect(find.text('Belum ada notifikasi baru.'), findsNothing);
    });

    testWidgets('Tapping Tentang Aplikasi displays EduVolt about dialog', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(authService),
            userProfileProvider.overrideWith(
              (Ref ref) => Stream<Map<String, dynamic>?>.value(<String, dynamic>{
                'name': 'Rama Pratama',
                'email': 'rama@smk.sch.id',
                'role': 'siswa',
              }),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: ProfilPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final Finder aboutRow = find.text('Tentang Aplikasi');
      await tester.ensureVisible(aboutRow);
      await tester.tap(aboutRow);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('about_dialog')), findsOneWidget);
      expect(
        find.text(
          'EduVolt v1.0.0 - Platform Pembelajaran Elektronika untuk SMK.',
        ),
        findsOneWidget,
      );
      expect(find.text('Dibuat oleh: Tim EduVolt'), findsOneWidget);

      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('about_dialog')), findsNothing);
    });

    testWidgets('HomePage displays dynamic name Rama when profile exists', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(authService),
            userProfileProvider.overrideWith(
              (Ref ref) => Stream<Map<String, dynamic>?>.value(<String, dynamic>{
                'name': 'Rama Pratama',
              }),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: HomePage()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Halo, Rama!'), findsOneWidget);
    });

    testWidgets('HomePage falls back to Halo, Siswa! when profile is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(MockProfilAuthService(user: null)),
            userProfileProvider.overrideWith(
              (Ref ref) => Stream<Map<String, dynamic>?>.value(null),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: HomePage()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Halo, Siswa!'), findsOneWidget);
    });

    testWidgets('Tapping Keluar calls logout and redirects to /login', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final GoRouter router = createAppRouter(
        initialLocation: AppRoutes.profil,
        isLoggedIn: () => !authService.loggedOut,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(authService),
            userProfileProvider.overrideWith(
              (Ref ref) => Stream<Map<String, dynamic>?>.value(<String, dynamic>{
                'name': 'Rama Pratama',
                'email': 'rama@smk.sch.id',
                'role': 'siswa',
              }),
            ),
          ],
          child: MaterialApp.router(
            theme: AppTheme.light,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final Finder logoutBtn = find.text('Keluar');
      await tester.ensureVisible(logoutBtn);
      await tester.pumpAndSettle();
      await tester.tap(logoutBtn, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(authService.loggedOut, isTrue);
      expect(find.text('Masuk'), findsOneWidget);
    });
  });

  group('Profil Screenshots', () {
    testWidgets(
      'Capture Fase 22B Home, EditProfil, and Tentang Dialog screenshots at 390x844 DPR 3',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390 * 3.0, 844 * 3.0);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await _loadAppFonts();

        final MockProfilAuthService authService = MockProfilAuthService();

        Future<void> capture(
          Widget child,
          String filename, {
          Future<void> Function(WidgetTester tester)? onReady,
        }) async {
          final GlobalKey key = GlobalKey();
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authServiceProvider.overrideWithValue(authService),
                userProfileProvider.overrideWith(
                  (Ref ref) =>
                      Stream<Map<String, dynamic>?>.value(<String, dynamic>{
                        'name': 'Rama Pratama',
                        'email': 'rama@smk.sch.id',
                        'role': 'siswa',
                      }),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                builder: (BuildContext context, Widget? navigatorChild) {
                  return RepaintBoundary(
                    key: key,
                    child: navigatorChild!,
                  );
                },
                home: Scaffold(
                  backgroundColor: AppTheme.light.scaffoldBackgroundColor,
                  body: child,
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          if (onReady != null) {
            await onReady(tester);
            await tester.pumpAndSettle();
          }

          final RenderRepaintBoundary boundary =
              key.currentContext!.findRenderObject() as RenderRepaintBoundary;
          final ui.Image image = await tester.runAsync(
            () => boundary.toImage(pixelRatio: 1.0),
          ) as ui.Image;
          final dynamic byteData = await tester.runAsync(
            () => image.toByteData(format: ui.ImageByteFormat.png),
          );
          await tester.runAsync(
            () => File('docs/screenshots/$filename')
                .writeAsBytes(byteData.buffer.asUint8List()),
          );
        }

        await capture(const HomePage(), 'fase22b_home.png');
        await capture(const EditProfilPage(), 'fase22b_edit_profil.png');
        await capture(
          const ProfilPage(),
          'fase22b_tentang_dialog.png',
          onReady: (WidgetTester t) async {
            final Finder aboutBtn = find.text('Tentang Aplikasi');
            await t.ensureVisible(aboutBtn);
            await t.tap(aboutBtn);
          },
        );
        // Pertahankan juga fase22_profil.png & fase22_edit_profil.png
        await capture(const ProfilPage(), 'fase22_profil.png');
        await capture(const EditProfilPage(), 'fase22_edit_profil.png');
      },
    );
  });
}
