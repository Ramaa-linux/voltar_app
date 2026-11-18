import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/auth/verification_pending_page.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_theme.dart';

class _MockAuthServiceForVerification extends AuthService {
  bool sendVerificationCalled = false;
  bool reloadCheckedCalled = false;
  bool logoutCalled = false;
  bool verified = false;

  @override
  Future<void> sendVerificationEmail() async {
    sendVerificationCalled = true;
  }

  @override
  Future<bool> reloadAndCheckVerified() async {
    reloadCheckedCalled = true;
    return verified;
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }
}

Widget _wrap(Widget child, AuthService service) {
  return ProviderScope(
    overrides: [authServiceProvider.overrideWithValue(service)],
    child: MaterialApp(theme: AppTheme.light, home: child),
  );
}

void main() {
  group('VerificationPendingPage Widget Tests (Tugas 11.3)', () {
    late _MockAuthServiceForVerification mockAuth;

    setUp(() {
      mockAuth = _MockAuthServiceForVerification();
    });

    testWidgets('renders all UI elements with target email', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const VerificationPendingPage(email: 'budi@smk.sch.id'),
          mockAuth,
        ),
      );
      await tester.pump();

      expect(find.text('Cek Email Kamu!'), findsOneWidget);
      expect(find.textContaining('budi@smk.sch.id'), findsOneWidget);
      expect(
        find.text('Tidak ketemu? Cek folder Spam atau Promosi.'),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('resend_verification_button')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('check_verification_button')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('back_to_login_button')), findsOneWidget);
    });

    testWidgets('cooldown starts at 120s and ticks down properly', (
      WidgetTester tester,
    ) async {
      DateTime simulatedTime = DateTime(2026, 11, 14, 10, 0, 0);

      await tester.pumpWidget(
        _wrap(
          VerificationPendingPage(
            email: 'test@smk.sch.id',
            nowSeam: () => simulatedTime,
          ),
          mockAuth,
        ),
      );
      await tester.pump();

      expect(find.text('Kirim Ulang (120s)'), findsOneWidget);

      // Advance by 1 second
      simulatedTime = simulatedTime.add(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Kirim Ulang (119s)'), findsOneWidget);

      // Advance by 119 more seconds -> total 120s
      simulatedTime = simulatedTime.add(const Duration(seconds: 119));
      await tester.pump(const Duration(seconds: 119));
      expect(find.text('Kirim Ulang Email Verifikasi'), findsOneWidget);
    });

    testWidgets(
      'resend button triggers sendVerificationEmail and resets cooldown',
      (WidgetTester tester) async {
        DateTime simulatedTime = DateTime(2026, 11, 14, 10, 0, 0);

        await tester.pumpWidget(
          _wrap(
            VerificationPendingPage(
              email: 'test@smk.sch.id',
              nowSeam: () => simulatedTime,
            ),
            mockAuth,
          ),
        );
        await tester.pump();

        // Advance cooldown to 0
        simulatedTime = simulatedTime.add(const Duration(seconds: 121));
        await tester.pump(const Duration(seconds: 121));
        expect(find.text('Kirim Ulang Email Verifikasi'), findsOneWidget);

        // Tap resend
        await tester.tap(find.byKey(const Key('resend_verification_button')));
        await tester.pump();

        expect(mockAuth.sendVerificationCalled, isTrue);
        expect(find.text('Kirim Ulang (120s)'), findsOneWidget);
      },
    );

    testWidgets('check verification button triggers reloadAndCheckVerified', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const VerificationPendingPage(email: 'test@smk.sch.id'),
          mockAuth,
        ),
      );
      await tester.pump();

      await tester.tap(find.byKey(const Key('check_verification_button')));
      await tester.pump();

      expect(mockAuth.reloadCheckedCalled, isTrue);
    });

    testWidgets('back to login button triggers logout', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1000);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _wrap(
          const VerificationPendingPage(email: 'test@smk.sch.id'),
          mockAuth,
        ),
      );
      await tester.pump();

      await tester.scrollUntilVisible(
        find.byKey(const Key('back_to_login_button')),
        100,
      );
      await tester.tap(find.byKey(const Key('back_to_login_button')));
      await tester.pump();

      expect(mockAuth.logoutCalled, isTrue);
    });
  });
}
