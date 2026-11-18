import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/router/app_router.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/services/auth_service.dart';

void main() {
  group('computeAuthRedirect — Matriks 8.3 (25 Kasus & Idempotensi)', () {
    final List<String> authLocs = <String>[AppRoutes.login, AppRoutes.register];
    final List<String> pendingLocs = <String>[AppRoutes.verificationPending];
    final List<String> loadingLocs = <String>[AppRoutes.authLoading];
    final List<String> siswaLocs = <String>[
      AppRoutes.home,
      AppRoutes.materi,
      AppRoutes.simulasi,
      AppRoutes.profil,
      '/materi/123',
    ];
    final List<String> guruLocs = <String>[AppRoutes.guru, '/guru/xyz'];

    final List<(String, List<String>, AuthStatus, UserRole?, String?)> cases = [
      // 1. Unauthenticated (5)
      ('Unauthed @ Auth', authLocs, AuthStatus.unauthenticated, null, null),
      (
        'Unauthed @ Pending',
        pendingLocs,
        AuthStatus.unauthenticated,
        null,
        AppRoutes.login,
      ),
      (
        'Unauthed @ Loading',
        loadingLocs,
        AuthStatus.unauthenticated,
        null,
        AppRoutes.login,
      ),
      (
        'Unauthed @ Siswa',
        siswaLocs,
        AuthStatus.unauthenticated,
        null,
        AppRoutes.login,
      ),
      (
        'Unauthed @ Guru',
        guruLocs,
        AuthStatus.unauthenticated,
        null,
        AppRoutes.login,
      ),

      // 2. Unverified (5)
      (
        'Unverified @ Auth',
        authLocs,
        AuthStatus.unverified,
        null,
        AppRoutes.verificationPending,
      ),
      ('Unverified @ Pending', pendingLocs, AuthStatus.unverified, null, null),
      (
        'Unverified @ Loading',
        loadingLocs,
        AuthStatus.unverified,
        null,
        AppRoutes.verificationPending,
      ),
      (
        'Unverified @ Siswa',
        siswaLocs,
        AuthStatus.unverified,
        null,
        AppRoutes.verificationPending,
      ),
      (
        'Unverified @ Guru',
        guruLocs,
        AuthStatus.unverified,
        null,
        AppRoutes.verificationPending,
      ),

      // 3. ResolvingRole & RoleError (10)
      (
        'ResolvingRole @ Auth',
        authLocs,
        AuthStatus.resolvingRole,
        null,
        AppRoutes.authLoading,
      ),
      (
        'ResolvingRole @ Pending',
        pendingLocs,
        AuthStatus.resolvingRole,
        null,
        AppRoutes.authLoading,
      ),
      (
        'ResolvingRole @ Loading',
        loadingLocs,
        AuthStatus.resolvingRole,
        null,
        null,
      ),
      (
        'ResolvingRole @ Siswa',
        siswaLocs,
        AuthStatus.resolvingRole,
        null,
        AppRoutes.authLoading,
      ),
      (
        'ResolvingRole @ Guru',
        guruLocs,
        AuthStatus.resolvingRole,
        null,
        AppRoutes.authLoading,
      ),
      (
        'RoleError @ Auth',
        authLocs,
        AuthStatus.roleError,
        null,
        AppRoutes.authLoading,
      ),
      (
        'RoleError @ Pending',
        pendingLocs,
        AuthStatus.roleError,
        null,
        AppRoutes.authLoading,
      ),
      ('RoleError @ Loading', loadingLocs, AuthStatus.roleError, null, null),
      (
        'RoleError @ Siswa',
        siswaLocs,
        AuthStatus.roleError,
        null,
        AppRoutes.authLoading,
      ),
      (
        'RoleError @ Guru',
        guruLocs,
        AuthStatus.roleError,
        null,
        AppRoutes.authLoading,
      ),

      // 4. Ready Siswa (5)
      (
        'Ready(Siswa) @ Auth',
        authLocs,
        AuthStatus.ready,
        UserRole.siswa,
        AppRoutes.home,
      ),
      (
        'Ready(Siswa) @ Pending',
        pendingLocs,
        AuthStatus.ready,
        UserRole.siswa,
        AppRoutes.home,
      ),
      (
        'Ready(Siswa) @ Loading',
        loadingLocs,
        AuthStatus.ready,
        UserRole.siswa,
        AppRoutes.home,
      ),
      (
        'Ready(Siswa) @ Siswa',
        siswaLocs,
        AuthStatus.ready,
        UserRole.siswa,
        null,
      ),
      (
        'Ready(Siswa) @ Guru',
        guruLocs,
        AuthStatus.ready,
        UserRole.siswa,
        AppRoutes.home,
      ),

      // 5. Ready Guru (5)
      (
        'Ready(Guru) @ Auth',
        authLocs,
        AuthStatus.ready,
        UserRole.guru,
        AppRoutes.guru,
      ),
      (
        'Ready(Guru) @ Pending',
        pendingLocs,
        AuthStatus.ready,
        UserRole.guru,
        AppRoutes.guru,
      ),
      (
        'Ready(Guru) @ Loading',
        loadingLocs,
        AuthStatus.ready,
        UserRole.guru,
        AppRoutes.guru,
      ),
      (
        'Ready(Guru) @ Siswa',
        siswaLocs,
        AuthStatus.ready,
        UserRole.guru,
        AppRoutes.guru,
      ),
      ('Ready(Guru) @ Guru', guruLocs, AuthStatus.ready, UserRole.guru, null),
    ];

    for (final (
          String name,
          List<String> locs,
          AuthStatus st,
          UserRole? r,
          String? exp,
        )
        in cases) {
      test(name, () {
        for (final String loc in locs) {
          final String? res = computeAuthRedirect(
            location: loc,
            status: st,
            role: r,
          );
          expect(res, exp, reason: 'Failed for $loc on $name');

          // Idempotency: second pass from target must be null
          final String target = res ?? loc;
          final String? second = computeAuthRedirect(
            location: target,
            status: st,
            role: r,
          );
          expect(
            second,
            isNull,
            reason: 'Second pass from $target was $second (loop!)',
          );
        }
      });
    }
  });
}
