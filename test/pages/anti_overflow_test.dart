import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/auth/auth_loading_page.dart';
import 'package:voltar/pages/auth/register_page.dart';
import 'package:voltar/pages/auth/verification_pending_page.dart';
import 'package:voltar/pages/guru/guru_dashboard_page.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_theme.dart';

class _FakeOverflowAuthService extends AuthService {
  @override
  AuthSnapshot get snapshot =>
      const AuthSnapshot(status: AuthStatus.ready, role: UserRole.guru);
}

void main() {
  group(
    'Anti-Overflow Responsive & Text Scaling Tests (Fase 25A Bagian 11.3)',
    () {
      final List<Size> testSizes = <Size>[
        const Size(320, 568), // Small phone
        const Size(360, 640), // Standard Android
        const Size(412, 915), // Tall phone
        const Size(640, 360), // Landscape
      ];

      final List<double> textScales = <double>[1.0, 1.5, 2.0];

      Widget buildTestApp(Widget child, double textScale) {
        return ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(_FakeOverflowAuthService()),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            builder: (BuildContext context, Widget? widget) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(textScale)),
                child: widget!,
              );
            },
            home: child,
          ),
        );
      }

      for (final Size size in testSizes) {
        for (final double scale in textScales) {
          final String configLabel =
              '${size.width.toInt()}x${size.height.toInt()} scale $scale';

          testWidgets(
            'RegisterPage (Siswa & Guru) no overflow on $configLabel',
            (WidgetTester tester) async {
              tester.view.physicalSize = size;
              tester.view.devicePixelRatio = 1.0;
              addTearDown(() {
                tester.view.resetPhysicalSize();
                tester.view.resetDevicePixelRatio();
              });

              await tester.pumpWidget(
                buildTestApp(const RegisterPage(), scale),
              );
              await tester.pumpAndSettle();

              expect(tester.takeException(), isNull);

              // Test switching to Guru (reveals teacher code field)
              final Finder guruOption = find.byKey(
                const Key('role_option_guru'),
              );
              await tester.ensureVisible(guruOption);
              await tester.tap(guruOption);
              await tester.pumpAndSettle();

              expect(tester.takeException(), isNull);
            },
          );

          testWidgets('VerificationPendingPage no overflow on $configLabel', (
            WidgetTester tester,
          ) async {
            tester.view.physicalSize = size;
            tester.view.devicePixelRatio = 1.0;
            addTearDown(() {
              tester.view.resetPhysicalSize();
              tester.view.resetDevicePixelRatio();
            });

            await tester.pumpWidget(
              buildTestApp(
                const VerificationPendingPage(
                  email: 'guru.elektronika@smk.sch.id',
                ),
                scale,
              ),
            );
            // Gunakan pump bukan pumpAndSettle karena ada polling timer
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));

            expect(tester.takeException(), isNull);
          });

          testWidgets('GuruDashboardPage no overflow on $configLabel', (
            WidgetTester tester,
          ) async {
            tester.view.physicalSize = size;
            tester.view.devicePixelRatio = 1.0;
            addTearDown(() {
              tester.view.resetPhysicalSize();
              tester.view.resetDevicePixelRatio();
            });

            await tester.pumpWidget(
              buildTestApp(const GuruDashboardPage(), scale),
            );
            await tester.pumpAndSettle();

            expect(tester.takeException(), isNull);
          });

          testWidgets('AuthLoadingPage no overflow on $configLabel', (
            WidgetTester tester,
          ) async {
            tester.view.physicalSize = size;
            tester.view.devicePixelRatio = 1.0;
            addTearDown(() {
              tester.view.resetPhysicalSize();
              tester.view.resetDevicePixelRatio();
            });

            await tester.pumpWidget(
              buildTestApp(const AuthLoadingPage(), scale),
            );
            // Gunakan pump bukan pumpAndSettle karena ada CircularProgressIndicator
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));

            expect(tester.takeException(), isNull);
          });
        }
      }
    },
  );
}
