import 'dart:io';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltar/pages/auth/login_page.dart';
import 'package:voltar/pages/auth/register_page.dart';
import 'package:voltar/pages/auth/verification_pending_page.dart';
import 'package:voltar/pages/guru/guru_dashboard_page.dart';
import 'package:voltar/router/app_router.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_theme.dart';

class FakeUser extends Fake implements User {
  @override
  final String uid = 'mock_uid_123';
}

class FakeUserCredential extends Fake implements UserCredential {
  FakeUserCredential(this._user);

  final User _user;

  @override
  User get user => _user;
}

class MockAuthService extends AuthService {
  String? loginEmail;
  String? loginPassword;
  String? regName;
  String? regEmail;
  String? regPassword;
  String? regRole;
  String? regTeacherCode;

  bool throwOnLogin = false;
  String loginErrorMessage = 'Email atau password salah.';
  bool throwOnRegister = false;
  String registerErrorMessage = 'Gagal menyimpan profil.';
  String registerErrorCode = 'unknown';

  @override
  Future<UserCredential> login(String email, String password) async {
    loginEmail = email;
    loginPassword = password;
    if (throwOnLogin) {
      throw AuthException(loginErrorMessage);
    }
    return FakeUserCredential(FakeUser());
  }

  @override
  Future<UserCredential> register(
    String name,
    String email,
    String password,
    String role, {
    String? teacherCode,
  }) async {
    regName = name;
    regEmail = email;
    regPassword = password;
    regRole = role;
    regTeacherCode = teacherCode;
    if (throwOnRegister) {
      throw AuthException(registerErrorMessage, code: registerErrorCode);
    }
    return FakeUserCredential(FakeUser());
  }
}

Widget createAuthApp({
  required Widget child,
  required MockAuthService authService,
}) {
  return ProviderScope(
    overrides: [authServiceProvider.overrideWithValue(authService)],
    child: MaterialApp(theme: AppTheme.light, home: child),
  );
}

void main() {
  group('LoginPage Widget Tests', () {
    late MockAuthService authService;

    setUp(() {
      authService = MockAuthService();
    });

    testWidgets('renders brand title, inputs, button and register link', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createAuthApp(child: const LoginPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      expect(find.text('EduVolt'), findsOneWidget);
      expect(find.text('Belajar listrik jadi seru ⚡'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Masuk'), findsOneWidget);
      expect(find.text('Belum punya akun? '), findsOneWidget);
      expect(find.text('Daftar'), findsOneWidget);
    });

    testWidgets('validates required fields on empty submit', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createAuthApp(child: const LoginPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('Email wajib diisi'), findsOneWidget);
      expect(find.text('Password wajib diisi'), findsOneWidget);
      expect(authService.loginEmail, isNull);
    });

    testWidgets('validates email format', (WidgetTester tester) async {
      await tester.pumpWidget(
        createAuthApp(child: const LoginPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('login_email_field')),
        'invalidemail',
      );
      await tester.enterText(
        find.byKey(const Key('login_password_field')),
        '123456',
      );
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('Format email tidak valid'), findsOneWidget);
      expect(authService.loginEmail, isNull);
    });

    testWidgets('toggles password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        createAuthApp(child: const LoginPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      final Finder visibilityBtn = find.byTooltip('Tampilkan password');
      expect(visibilityBtn, findsOneWidget);

      await tester.tap(visibilityBtn);
      await tester.pumpAndSettle();

      expect(find.byTooltip('Sembunyikan password'), findsOneWidget);
    });

    testWidgets('successful login submits credentials and navigates to /', (
      WidgetTester tester,
    ) async {
      final GoRouter testRouter = GoRouter(
        initialLocation: '/login',
        routes: <RouteBase>[
          GoRoute(
            path: '/login',
            builder: (BuildContext context, GoRouterState state) =>
                const LoginPage(),
          ),
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) =>
                const Scaffold(body: Text('Home Mock')),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [authServiceProvider.overrideWithValue(authService)],
          child: MaterialApp.router(
            theme: AppTheme.light,
            routerConfig: testRouter,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('login_email_field')),
        'budi@smk.sch.id',
      );
      await tester.enterText(
        find.byKey(const Key('login_password_field')),
        'password123',
      );
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(authService.loginEmail, 'budi@smk.sch.id');
      expect(authService.loginPassword, 'password123');
      expect(find.text('Home Mock'), findsOneWidget);
    });

    testWidgets('displays error banner when login fails', (
      WidgetTester tester,
    ) async {
      authService.throwOnLogin = true;
      authService.loginErrorMessage = 'Email atau password salah.';

      await tester.pumpWidget(
        createAuthApp(child: const LoginPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('login_email_field')),
        'budi@smk.sch.id',
      );
      await tester.enterText(
        find.byKey(const Key('login_password_field')),
        'wrongpassword',
      );
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('Email atau password salah.'), findsOneWidget);
    });
  });

  group('RegisterPage Widget Tests', () {
    late MockAuthService authService;

    setUp(() {
      authService = MockAuthService();
    });

    testWidgets('renders brand title, inputs, strength bar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createAuthApp(child: const RegisterPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      expect(find.text('Buat Akun EduVolt'), findsOneWidget);
      expect(
        find.text('Mulai petualangan elektronika dan raih koinmu!'),
        findsOneWidget,
      );
      expect(find.text('Nama Lengkap'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Konfirmasi Password'), findsOneWidget);
      expect(find.text('Daftar'), findsOneWidget);
    });

    testWidgets('validates required fields and password matching', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createAuthApp(child: const RegisterPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      final Finder submitBtn = find.byKey(const Key('register_submit_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.text('Nama lengkap wajib diisi'), findsOneWidget);
      expect(find.text('Email wajib diisi'), findsOneWidget);
      expect(find.text('Password wajib diisi'), findsOneWidget);
      expect(find.text('Konfirmasi password wajib diisi'), findsOneWidget);
      expect(authService.regName, isNull);

      await tester.enterText(
        find.byKey(const Key('register_name_field')),
        'Budi',
      );
      await tester.enterText(
        find.byKey(const Key('register_email_field')),
        'budi@smk.sch.id',
      );
      await tester.enterText(
        find.byKey(const Key('register_password_field')),
        'pass123',
      );
      await tester.enterText(
        find.byKey(const Key('register_confirm_field')),
        'pass456',
      );
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.text('Konfirmasi password tidak cocok'), findsOneWidget);
    });

    testWidgets('evaluates password strength indicator dynamically', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createAuthApp(child: const RegisterPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('register_password_field')),
        '123',
      );
      await tester.pumpAndSettle();
      expect(find.text('Lemah'), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key('register_password_field')),
        'Rahasia123!',
      );
      await tester.pumpAndSettle();
      expect(find.text('Kuat'), findsOneWidget);
    });

    testWidgets('submits registration with role siswa', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createAuthApp(child: const RegisterPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('register_name_field')),
        'Siswa Baru',
      );
      await tester.enterText(
        find.byKey(const Key('register_email_field')),
        'siswa@smk.sch.id',
      );
      await tester.enterText(
        find.byKey(const Key('register_password_field')),
        'password123',
      );
      await tester.enterText(
        find.byKey(const Key('register_confirm_field')),
        'password123',
      );
      final Finder submitBtn = find.byKey(const Key('register_submit_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(authService.regRole, 'siswa');
    });

    testWidgets('successful registration submits credentials and navigates', (
      WidgetTester tester,
    ) async {
      final GoRouter testRouter = GoRouter(
        initialLocation: '/register',
        routes: <RouteBase>[
          GoRoute(
            path: '/register',
            builder: (BuildContext context, GoRouterState state) =>
                const RegisterPage(),
          ),
          GoRoute(
            path: '/verification-pending',
            builder: (BuildContext context, GoRouterState state) => Scaffold(
              body: Text(
                'Verification Pending: ${state.uri.queryParameters['email']}',
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [authServiceProvider.overrideWithValue(authService)],
          child: MaterialApp.router(
            theme: AppTheme.light,
            routerConfig: testRouter,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('register_name_field')),
        'Siswa Hebat',
      );
      await tester.enterText(
        find.byKey(const Key('register_email_field')),
        'siswa@smk.sch.id',
      );
      await tester.enterText(
        find.byKey(const Key('register_password_field')),
        'password123',
      );
      await tester.enterText(
        find.byKey(const Key('register_confirm_field')),
        'password123',
      );
      final Finder submitBtn = find.byKey(const Key('register_submit_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(authService.regName, 'Siswa Hebat');
      expect(authService.regEmail, 'siswa@smk.sch.id');
      expect(authService.regRole, 'siswa');
      expect(
        find.textContaining('Verification Pending: siswa@smk.sch.id'),
        findsOneWidget,
      );
    });

    testWidgets('displays error banner when register fails', (
      WidgetTester tester,
    ) async {
      authService.throwOnRegister = true;
      authService.registerErrorMessage =
          'Email sudah terdaftar. Silakan masuk.';

      await tester.pumpWidget(
        createAuthApp(child: const RegisterPage(), authService: authService),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('register_name_field')),
        'Budi',
      );
      await tester.enterText(
        find.byKey(const Key('register_email_field')),
        'budi@smk.sch.id',
      );
      await tester.enterText(
        find.byKey(const Key('register_password_field')),
        'password123',
      );
      await tester.enterText(
        find.byKey(const Key('register_confirm_field')),
        'password123',
      );
      final Finder submitBtn = find.byKey(const Key('register_submit_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(
        find.text('Email sudah terdaftar. Silakan masuk.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'role selector toggles teacher code field and clears value when switching back to Siswa',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          createAuthApp(child: const RegisterPage(), authService: authService),
        );
        await tester.pumpAndSettle();

        // Initially Siswa is selected -> teacher code field is NOT in widget tree
        expect(
          find.byKey(const Key('register_teacher_code_field')),
          findsNothing,
        );

        // Select Guru
        await tester.ensureVisible(find.byKey(const Key('role_option_guru')));
        await tester.tap(find.byKey(const Key('role_option_guru')));
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key('register_teacher_code_field')),
          findsOneWidget,
        );
        expect(
          find.text(
            'Kode verifikasi diberikan oleh pihak Admin. Jangan bagikan kode kepada siswa.',
          ),
          findsOneWidget,
        );

        // Enter code
        await tester.enterText(
          find.byKey(const Key('register_teacher_code_field')),
          'guru-123',
        );
        await tester.pump();

        // Switch back to Siswa -> field disappears
        await tester.ensureVisible(find.byKey(const Key('role_option_siswa')));
        await tester.tap(find.byKey(const Key('role_option_siswa')));
        await tester.pumpAndSettle();
        expect(
          find.byKey(const Key('register_teacher_code_field')),
          findsNothing,
        );

        // Switch to Guru again -> value must be empty
        await tester.ensureVisible(find.byKey(const Key('role_option_guru')));
        await tester.tap(find.byKey(const Key('role_option_guru')));
        await tester.pumpAndSettle();
        final TextFormField codeField = tester.widget<TextFormField>(
          find.byKey(const Key('register_teacher_code_field')),
        );
        expect(codeField.controller?.text, isEmpty);
      },
    );

    testWidgets(
      'submitting Guru with empty code shows Kode Verifikasi wajib diisi',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          createAuthApp(child: const RegisterPage(), authService: authService),
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const Key('register_name_field')),
          'Pak Budi',
        );
        await tester.enterText(
          find.byKey(const Key('register_email_field')),
          'budi@guru.sch.id',
        );
        await tester.enterText(
          find.byKey(const Key('register_password_field')),
          'password123',
        );
        await tester.enterText(
          find.byKey(const Key('register_confirm_field')),
          'password123',
        );

        // Select Guru
        await tester.ensureVisible(find.byKey(const Key('role_option_guru')));
        await tester.tap(find.byKey(const Key('role_option_guru')));
        await tester.pumpAndSettle();

        // Tap Daftar without filling teacher code
        final Finder submitBtn = find.byKey(
          const Key('register_submit_button'),
        );
        await tester.ensureVisible(submitBtn);
        await tester.tap(submitBtn);
        await tester.pumpAndSettle();

        expect(find.text('Kode Verifikasi wajib diisi'), findsOneWidget);
        expect(authService.regName, isNull);
      },
    );

    testWidgets(
      'teacher code normalizes symbols and lowercase to uppercase on submit (Fase 25B)',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          createAuthApp(child: const RegisterPage(), authService: authService),
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const Key('register_name_field')),
          'Bu Guru',
        );
        await tester.enterText(
          find.byKey(const Key('register_email_field')),
          'guru@smk.sch.id',
        );
        await tester.enterText(
          find.byKey(const Key('register_password_field')),
          'password123',
        );
        await tester.enterText(
          find.byKey(const Key('register_confirm_field')),
          'password123',
        );

        // Select Guru
        await tester.ensureVisible(find.byKey(const Key('role_option_guru')));
        await tester.tap(find.byKey(const Key('role_option_guru')));
        await tester.pumpAndSettle();

        // Enter code with symbols and lowercase (e.g., guru_2026! -> GURU_2026!)
        await tester.enterText(
          find.byKey(const Key('register_teacher_code_field')),
          'guru_2026!',
        );
        await tester.pump();

        // Submit
        final Finder submitBtn = find.byKey(
          const Key('register_submit_button'),
        );
        await tester.ensureVisible(submitBtn);
        await tester.tap(submitBtn);
        await tester.pumpAndSettle();

        // Verify normalized code is submitted (uppercase, trimmed)
        expect(authService.regTeacherCode, 'GURU_2026!');
      },
    );
  });

  group('Router Auth Guard Widget Tests', () {
    testWidgets('unauthenticated user is redirected to /login', (
      WidgetTester tester,
    ) async {
      final GoRouter router = createAppRouter(
        initialLocation: '/',
        isLoggedIn: () => false,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [authServiceProvider.overrideWithValue(MockAuthService())],
          child: MaterialApp.router(
            theme: AppTheme.light,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('EduVolt'), findsOneWidget);
      expect(find.text('Masuk'), findsOneWidget);
    });

    testWidgets('authenticated user on /login is redirected to /', (
      WidgetTester tester,
    ) async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final GoRouter router = createAppRouter(
        initialLocation: '/login',
        isLoggedIn: () => true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [authServiceProvider.overrideWithValue(MockAuthService())],
          child: MaterialApp.router(
            theme: AppTheme.light,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Halo, Siswa!'), findsOneWidget);
    });
  });

  group('Auth Pages Screenshots', () {
    testWidgets('Capture Login and Register screenshots at 390x844 DPR 3', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390 * 3.0, 844 * 3.0);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      Future<void> capture(Widget child, String filename) async {
        final GlobalKey key = GlobalKey();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authServiceProvider.overrideWithValue(MockAuthService()),
            ],
            child: MaterialApp(
              theme: AppTheme.light,
              home: Scaffold(
                body: RepaintBoundary(key: key, child: child),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final RenderRepaintBoundary boundary =
            key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final ui.Image image = await tester.runAsync(
          () => boundary.toImage(pixelRatio: 1.0),
        ) as ui.Image;
        final dynamic byteData = await tester.runAsync(
          () => image.toByteData(format: ui.ImageByteFormat.png),
        );
        await tester.runAsync(
          () =>
              File('docs/screenshots/$filename')
                  .writeAsBytes(byteData.buffer.asUint8List()),
        );
      }

      await capture(const LoginPage(), 'fase21_login.png');
      await capture(const RegisterPage(), 'fase21_register.png');
    });

    testWidgets('Capture Fase 25A screenshots at 390x844 DPR 3', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390 * 3.0, 844 * 3.0);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      Future<void> capture(
        Widget child,
        String filename, {
        Future<void> Function(WidgetTester)? afterPump,
        bool settle = true,
      }) async {
        final GlobalKey key = GlobalKey();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authServiceProvider.overrideWithValue(MockAuthService()),
            ],
            child: MaterialApp(
              theme: AppTheme.light,
              home: Scaffold(
                body: RepaintBoundary(key: key, child: child),
              ),
            ),
          ),
        );
        if (settle) {
          await tester.pumpAndSettle();
        } else {
          await tester.pump();
          await tester.pump(const Duration(seconds: 1));
        }
        if (afterPump != null) {
          await afterPump(tester);
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
          () =>
              File('docs/screenshots/$filename')
                  .writeAsBytes(byteData.buffer.asUint8List()),
        );
      }

      // 1. Register with Guru selected
      await capture(
        const RegisterPage(),
        'fase25a_register_guru.png',
        afterPump: (WidgetTester t) async {
          final Finder guruBtn = find.byKey(const Key('role_option_guru'));
          await t.ensureVisible(guruBtn);
          await t.tap(guruBtn);
          await t.pumpAndSettle();
        },
      );

      // 2. Register with Siswa selected
      await capture(const RegisterPage(), 'fase25a_register_siswa.png');

      // 3. Verification Pending page
      await capture(
        const VerificationPendingPage(email: 'guru@smk.sch.id'),
        'fase25a_verification_pending.png',
        settle: false,
      );

      // 4. Guru Dashboard page
      await capture(
        const GuruDashboardPage(),
        'fase25a_guru_dashboard.png',
      );
    });

    testWidgets('Capture Register small screen (320x568) screenshot', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(320 * 3.0, 568 * 3.0);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      Future<void> capture(Widget child, String filename) async {
        final GlobalKey key = GlobalKey();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authServiceProvider.overrideWithValue(MockAuthService()),
            ],
            child: MaterialApp(
              theme: AppTheme.light,
              home: Scaffold(
                body: RepaintBoundary(key: key, child: child),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final RenderRepaintBoundary boundary =
            key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final ui.Image image = await tester.runAsync(
          () => boundary.toImage(pixelRatio: 1.0),
        ) as ui.Image;
        final dynamic byteData = await tester.runAsync(
          () => image.toByteData(format: ui.ImageByteFormat.png),
        );
        await tester.runAsync(
          () =>
              File('docs/screenshots/$filename')
                  .writeAsBytes(byteData.buffer.asUint8List()),
        );
      }

      await capture(const RegisterPage(), 'fase25a_register_320x568.png');
    });

    testWidgets(
      'Capture Fase 25B screenshots (Siswa, Slide Mid-Animation, Guru) at 390x844 DPR 3',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390 * 3.0, 844 * 3.0);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final GlobalKey key = GlobalKey();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authServiceProvider.overrideWithValue(MockAuthService()),
            ],
            child: MaterialApp(
              theme: AppTheme.light,
              home: Scaffold(
                body: RepaintBoundary(key: key, child: const RegisterPage()),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        Future<void> savePng(String filename) async {
          final RenderRepaintBoundary boundary =
              key.currentContext!.findRenderObject() as RenderRepaintBoundary;
          final ui.Image image = await tester.runAsync(
            () => boundary.toImage(pixelRatio: 1.0),
          ) as ui.Image;
          final dynamic byteData = await tester.runAsync(
            () => image.toByteData(format: ui.ImageByteFormat.png),
          );
          await tester.runAsync(
            () => File(
              'docs/screenshots/$filename',
            ).writeAsBytes(byteData.buffer.asUint8List()),
          );
        }

        // 1. Register with Siswa selected
        await savePng('fase25b_register_siswa.png');

        // 2. Tap Guru and capture mid-slide animation (100ms of 200ms)
        final Finder guruBtn = find.byKey(const Key('role_option_guru'));
        await tester.ensureVisible(guruBtn);
        await tester.tap(guruBtn);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await savePng('fase25b_register_slide_anim.png');

        // 3. Settle animation and capture Guru selected (with symbol teacher code)
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const Key('register_teacher_code_field')),
          'guru_2026!',
        );
        await tester.pump();
        await savePng('fase25b_register_guru.png');
      },
    );
  });
}
