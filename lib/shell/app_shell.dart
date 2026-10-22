import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_floating_nav_bar.dart';

/// Satu-satunya Scaffold aplikasi: body = branch aktif, navbar mengambang.
///
/// `extendBody: true` membuat konten halaman scroll di bawah navbar. Karena
/// itu setiap halaman wajib padding bawah [AppSpacing.navBarClearance] dan
/// tidak boleh membuat Scaffold sendiri.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  /// Urutan HARUS sama dengan urutan branch di app_router.dart.
  static const List<VoltNavItem> navItems = <VoltNavItem>[
    VoltNavItem(icon: AppIconName.home, label: 'Home'),
    VoltNavItem(icon: AppIconName.bookOpen, label: 'Materi'),
    VoltNavItem(icon: AppIconName.cpu, label: 'Simulasi'),
    VoltNavItem(icon: AppIconName.profile, label: 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        child: VoltFloatingNavBar(
          items: navItems,
          currentIndex: navigationShell.currentIndex,
          margin: const EdgeInsets.all(AppSpacing.pagePadding),
          onTap: (int index) => navigationShell.goBranch(
            index,
            // Re-tap tab aktif: kembali ke root branch (mis. keluar dari detail).
            initialLocation: index == navigationShell.currentIndex,
          ),
        ),
      ),
    );
  }
}
