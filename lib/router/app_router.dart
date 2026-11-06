import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/pages/home/home_page.dart';
import 'package:voltar/pages/materi/kuis_page.dart';
import 'package:voltar/pages/materi/level_detail_page.dart';
import 'package:voltar/pages/materi/materi_detail_page.dart';
import 'package:voltar/pages/materi/materi_page.dart';
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

/// Router aplikasi lewat Riverpod: setiap ProviderScope (termasuk widget test)
/// punya instance sendiri, jadi tidak ada state navigasi yang bocor antar test.
final Provider<GoRouter> appRouterProvider = Provider<GoRouter>((Ref ref) {
  final GoRouter router = createAppRouter(initialLocation: _initialRoute);
  ref.onDispose(router.dispose);
  return router;
});

/// Membuat router baru. [initialLocation] dipakai test dan screenshot otomatis.
GoRouter createAppRouter({String initialLocation = AppRoutes.home}) {
  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    routes: <RouteBase>[
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
                          projectName:
                              state.uri.queryParameters['title'] ??
                              SimulasiEditorPage.defaultProjectName,
                        ),
                  ),
                  GoRoute(
                    path: 'template/blink',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) =>
                        const SimulasiEditorPage(
                          projectName: 'Blink LED Dasar',
                          isTemplate: true,
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
    ],
  );
}
