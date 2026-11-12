import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/pages/auth/login_page.dart';
import 'package:voltar/pages/auth/register_page.dart';
import 'package:voltar/pages/game/cable_connect_page.dart';
import 'package:voltar/pages/game/circuit_rush_page.dart';
import 'package:voltar/pages/game/guess_component_page.dart';
import 'package:voltar/pages/home/home_page.dart';
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
import 'package:voltar/shell/app_shell.dart';

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
String? authRedirect({
  required bool isLoggedIn,
  required String matchedLocation,
}) {
  final bool isAuthRoute =
      matchedLocation == '/login' || matchedLocation == '/register';

  if (!isLoggedIn && !isAuthRoute) {
    return '/login';
  }
  if (isLoggedIn && isAuthRoute) {
    // TODO(fase-guru): arahkan berdasarkan role
    return AppRoutes.home;
  }
  return null;
}

/// Router aplikasi lewat Riverpod: setiap ProviderScope (termasuk widget test)
/// punya instance sendiri, jadi tidak ada state navigasi yang bocor antar test.
final Provider<GoRouter> appRouterProvider = Provider<GoRouter>((Ref ref) {
  GoRouterRefreshStream? refreshStream;
  if (Firebase.apps.isNotEmpty) {
    refreshStream = GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    );
    ref.onDispose(refreshStream.dispose);
  }
  final GoRouter router = createAppRouter(
    initialLocation: _initialRoute,
    refreshListenable: refreshStream,
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Membuat router baru. [initialLocation], [isLoggedIn], dan
/// [refreshListenable] dipakai produksi maupun widget test.
GoRouter createAppRouter({
  String initialLocation = AppRoutes.home,
  bool Function()? isLoggedIn,
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
      if (Firebase.apps.isEmpty) {
        return null;
      }
      return authRedirect(
        isLoggedIn: FirebaseAuth.instance.currentUser != null,
        matchedLocation: state.matchedLocation,
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
                        MateriDetailPage(stepId: state.pathParameters['stepId']!),
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
                path: AppRoutes.profil,
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfilPage(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) =>
                        const EditProfilPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
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
