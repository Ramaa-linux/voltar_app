import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/pages/auth/auth_loading_page.dart';
import 'package:voltar/pages/auth/login_page.dart';
import 'package:voltar/pages/auth/register_page.dart';
import 'package:voltar/pages/auth/verification_pending_page.dart';
import 'package:voltar/pages/game/cable_connect_page.dart';
import 'package:voltar/pages/game/circuit_rush_page.dart';
import 'package:voltar/pages/game/guess_component_page.dart';
import 'package:voltar/pages/guru/guru_dashboard_page.dart';
import 'package:voltar/pages/guru/guru_kelas_detail_page.dart';
import 'package:voltar/pages/guru/guru_kelas_page.dart';
import 'package:voltar/pages/guru/guru_profil_page.dart';
import 'package:voltar/pages/guru/guru_siswa_page.dart';
import 'package:voltar/pages/home/home_page.dart';
import 'package:voltar/pages/kelas/kelas_page.dart';
import 'package:voltar/pages/materi/kuis_page.dart';
import 'package:voltar/pages/materi/level_detail_page.dart';
import 'package:voltar/pages/materi/materi_detail_page.dart';
import 'package:voltar/pages/materi/materi_page.dart';
import 'package:voltar/pages/profil/edit_profil_page.dart';
import 'package:voltar/pages/profil/profil_page.dart';
import 'package:voltar/pages/simulasi/avr_debug_page.dart';
import 'package:voltar/pages/simulasi/canvas_debug_page.dart';
import 'package:voltar/pages/simulasi/simulasi_editor_page.dart';
import 'package:voltar/pages/simulasi/simulasi_page.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/shell/app_shell.dart';
import 'package:voltar/shell/guru_shell.dart';

/// Route awal saat aplikasi dibuka. Bisa diubah lewat
/// `--dart-define=VOLTAR_INITIAL_ROUTE=/simulasi/editor` - dipakai skrip
/// screenshot supaya tidak perlu edit kode atau klik manual.
const String _initialRoute = String.fromEnvironment(
  'VOLTAR_INITIAL_ROUTE',
  defaultValue: AppRoutes.home,
);

/// Mengubah [Stream] (mis. `FirebaseAuth.instance.authStateChanges()`) menjadi
/// [Listenable] untuk `refreshListenable` pada [GoRouter].
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Fungsi murni evaluasi redirect autentikasi [GoRouter].
/// Matriks 5 status × 5 lokasi = 25 kasus (Fase 25A Bagian 8.3).
/// Diperbarui Fase 26: Tambah rute GuruShell (/guru, /guru/kelas, /guru/tugas, /guru/profil).
String? computeAuthRedirect({
  required String location,
  required AuthStatus status,
  UserRole? role,
}) {
  final String matchedLocation = location;

  final bool isAuthRoute =
      matchedLocation == AppRoutes.login ||
      matchedLocation == AppRoutes.register;
  final bool isPendingRoute = matchedLocation == AppRoutes.verificationPending;
  final bool isLoadingRoute = matchedLocation == AppRoutes.authLoading;
  final bool isEditProfilRoute = matchedLocation == AppRoutes.profilEdit;
  final bool isGuruRoute =
      matchedLocation == AppRoutes.guru ||
      matchedLocation.startsWith('${AppRoutes.guru}/');
  final bool isSiswaRoute =
      !(isAuthRoute || isPendingRoute || isLoadingRoute || isEditProfilRoute || isGuruRoute);

  switch (status) {
    case AuthStatus.unauthenticated:
      if (isAuthRoute) return null;
      return AppRoutes.login;

    case AuthStatus.unverified:
      if (isPendingRoute) return null;
      return AppRoutes.verificationPending;

    case AuthStatus.resolvingRole:
    case AuthStatus.roleError:
      if (isLoadingRoute) return null;
      return AppRoutes.authLoading;

    case AuthStatus.ready:
      final UserRole effectiveRole = role ?? UserRole.siswa;
      if (effectiveRole == UserRole.guru) {
        // Guru: jika di route Siswa → redirect ke Dashboard Guru.
        // Jika di route Guru (termasuk sub-route) atau Edit Profil → stay.
        if (isGuruRoute || isEditProfilRoute) return null;
        return AppRoutes.guru;
      } else {
        // Siswa: jika di route Guru → redirect ke Home Siswa.
        // Jika di route Siswa atau Edit Profil → stay.
        if (isSiswaRoute || isEditProfilRoute) return null;
        return AppRoutes.home;
      }
  }
}

/// Backward compatibility untuk test lama yang memanggil `authRedirect(...)`.
String? authRedirect({
  required bool isLoggedIn,
  required String matchedLocation,
}) {
  return computeAuthRedirect(
    location: matchedLocation,
    status: isLoggedIn ? AuthStatus.ready : AuthStatus.unauthenticated,
    role: UserRole.siswa,
  );
}

/// Router aplikasi lewat Riverpod: setiap ProviderScope (termasuk widget test)
/// punya instance sendiri, jadi tidak ada state navigasi yang bocor antar test.
final Provider<GoRouter> appRouterProvider = Provider<GoRouter>((Ref ref) {
  final AuthService authService = ref.watch(authServiceProvider);
  Listenable? refreshListenable;
  if (Firebase.apps.isNotEmpty) {
    final GoRouterRefreshStream refreshStream = GoRouterRefreshStream(
      authService.userChanges,
    );
    ref.onDispose(refreshStream.dispose);
    refreshListenable = Listenable.merge(<Listenable>[
      refreshStream,
      authService,
    ]);
  } else {
    refreshListenable = authService;
  }

  final GoRouter router = createAppRouter(
    initialLocation: _initialRoute,
    authService: authService,
    refreshListenable: refreshListenable,
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Membuat router baru. [initialLocation], [isLoggedIn], [authService], dan
/// [refreshListenable] dipakai produksi maupun widget test.
GoRouter createAppRouter({
  String initialLocation = AppRoutes.home,
  bool Function()? isLoggedIn,
  AuthService? authService,
  Listenable? refreshListenable,
}) {
  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    refreshListenable: refreshListenable,
    redirect: (BuildContext context, GoRouterState state) {
      if (isLoggedIn != null) {
        return authRedirect(
          isLoggedIn: isLoggedIn(),
          matchedLocation: state.matchedLocation,
        );
      }
      final AuthService? authSvc = authService;
      if (authSvc != null) {
        final AuthSnapshot snapshot = authSvc.snapshot;
        return computeAuthRedirect(
          location: state.matchedLocation,
          status: snapshot.status,
          role: snapshot.role,
        );
      }
      if (Firebase.apps.isEmpty) {
        return null;
      }
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return computeAuthRedirect(
          location: state.matchedLocation,
          status: AuthStatus.unauthenticated,
        );
      }
      return computeAuthRedirect(
        location: state.matchedLocation,
        status: user.emailVerified ? AuthStatus.ready : AuthStatus.unverified,
        role: UserRole.siswa,
      );
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.verificationPending,
        builder: (BuildContext context, GoRouterState state) =>
            VerificationPendingPage(email: state.uri.queryParameters['email']),
      ),
      GoRoute(
        path: AppRoutes.authLoading,
        builder: (BuildContext context, GoRouterState state) =>
            const AuthLoadingPage(),
      ),
      // GuruShell: StatefulShellRoute.indexedStack dengan 4 branch.
      // Navigator terpisah (guruShellNavigatorKey) agar state branch
      // tidak bercampur dengan AppShell Siswa.
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) => GuruShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          // Branch 0: Dashboard Guru
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.guru,
                builder: (BuildContext context, GoRouterState state) =>
                    const GuruDashboardPage(),
              ),
            ],
          ),
          // Branch 1: Kelas Guru (list + detail)
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.guruKelas,
                builder: (BuildContext context, GoRouterState state) =>
                    const GuruKelasPage(),
                routes: <RouteBase>[
                  // Detail kelas: push ke root navigator supaya navbar
                  // GuruShell tetap terlihat di bawah (extended body).
                  GoRoute(
                    path: ':kelasId',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) =>
                        GuruKelasDetailPage(
                          kelasId: state.pathParameters['kelasId']!,
                        ),
                  ),
                ],
              ),
            ],
          ),
          // Branch 2: Siswa Guru (monitoring progress)
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.guruSiswa,
                builder: (BuildContext context, GoRouterState state) =>
                    const GuruSiswaPage(),
              ),
            ],
          ),
          // Branch 3: Profil Guru
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.guruProfil,
                builder: (BuildContext context, GoRouterState state) =>
                    const GuruProfilPage(),
              ),
            ],
          ),
        ],
      ),
      // IndexedStack: keempat branch tetap hidup, scroll position tidak reset.
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) => AppShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                builder: (BuildContext context, GoRouterState state) =>
                    const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.materi,
                builder: (BuildContext context, GoRouterState state) =>
                    const MateriPage(),
                routes: <RouteBase>[
                  // Level detail: peta perjalanan per level (push root).
                  GoRoute(
                    path: 'level/:levelNumber',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) =>
                        LevelDetailPage(
                          levelNumber: int.parse(
                            state.pathParameters['levelNumber']!,
                          ),
                        ),
                  ),
                  // Detail materi: pakai parentNavigatorKey root supaya navbar
                  // tertutup dan halaman tampil penuh (full-screen).
                  GoRoute(
                    path: 'detail/:stepId',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) =>
                        MateriDetailPage(
                          stepId: state.pathParameters['stepId']!,
                        ),
                  ),
                  // Kuis (pretest/posttest): pakai parentNavigatorKey root.
                  GoRoute(
                    path: 'kuis/:stepId',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) =>
                        KuisPage(stepId: state.pathParameters['stepId']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.simulasi,
                builder: (BuildContext context, GoRouterState state) =>
                    const SimulasiPage(),
                routes: <RouteBase>[
                  // `parentNavigatorKey` root: halaman tampil penuh di atas
                  // shell, jadi VoltFloatingNavBar tidak ikut dirender. Shell
                  // tetap hidup di bawahnya sehingga back kembali ke dashboard
                  // dengan state utuh.
                  GoRoute(
                    path: 'editor',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) =>
                        SimulasiEditorPage(
                          initialUrl: state.uri.queryParameters['url'],
                          projectName:
                              state.uri.queryParameters['title'] ??
                              'Simulator Velxio',
                        ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.kelas,
                builder: (BuildContext context, GoRouterState state) =>
                    const KelasPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.profil,
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfilPage(),
              ),
            ],
          ),
        ],
      ),
      // Edit Profil: top-level route agar bisa diakses dari Siswa maupun Guru.
      GoRoute(
        path: AppRoutes.profilEdit,
        parentNavigatorKey: rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) =>
            const EditProfilPage(),
      ),
      // Halaman uji mesin AVR: top-level route, jadi tampil penuh tanpa
      // VoltFloatingNavBar (sama seperti editor simulasi).
      GoRoute(
        path: AppRoutes.avrDebug,
        builder: (BuildContext context, GoRouterState state) =>
            const AvrDebugPage(),
      ), // Halaman uji canvas 2D: juga top-level, tanpa navbar.
      GoRoute(
        path: AppRoutes.canvasDebug,
        builder: (BuildContext context, GoRouterState state) =>
            const CanvasDebugPage(),
      ),
      // Mini-game Sirkuit Kilat (Fase 14B): tampil penuh tanpa navbar.
      GoRoute(
        path: AppRoutes.circuitRush,
        builder: (BuildContext context, GoRouterState state) =>
            const CircuitRushPage(),
      ),
      // Mini-game Sambung Kabel (Fase 15B): flow puzzle rangkaian tertutup.
      GoRoute(
        path: AppRoutes.cableConnect,
        builder: (BuildContext context, GoRouterState state) =>
            const CableConnectPage(),
      ),
      // Mini-game Tebak Komponen (Fase 19): kuis cepat komponen & resistor.
      GoRoute(
        path: AppRoutes.guessComponent,
        builder: (BuildContext context, GoRouterState state) =>
            const GuessComponentPage(),
      ),
    ],
  );
}
