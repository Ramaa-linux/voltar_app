import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_icon.dart';
import '../widgets/volt_floating_nav_bar.dart';

/// Shell untuk navigasi Guru (4 tab: Dashboard, Kelas, Siswa, Profil).
/// Menggunakan [VoltFloatingNavBar] generic yang sudah ada.
class GuruShell extends ConsumerStatefulWidget {
  const GuruShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  /// Inset bawah yang sama dengan [AppSpacing.navBarClearance] (128).
  /// Digunakan oleh halaman-halaman di dalam shell untuk padding bottom.
  static const double bottomInset = 128.0;

  @override
  ConsumerState<GuruShell> createState() => _GuruShellState();
}

class _GuruShellState extends ConsumerState<GuruShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      extendBody: true,
      bottomNavigationBar: SafeArea(
        top: false,
        child: VoltFloatingNavBar(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: _onNavTap,
          margin: const EdgeInsets.all(AppSpacing.pagePadding),
          items: const <VoltNavItem>[
            VoltNavItem(icon: AppIconName.home, labelKey: 'guruNavDashboard'),
            VoltNavItem(icon: AppIconName.folder, labelKey: 'guruNavKelas'),
            VoltNavItem(icon: AppIconName.profile, labelKey: 'guruNavSiswa'),
            VoltNavItem(icon: AppIconName.profile, labelKey: 'guruNavProfil'),
          ],
        ),
      ),
    );
  }

  void _onNavTap(int index) {
    // Jika tap tab yang sudah aktif, reset ke root branch (initialLocation: true).
    // Jika tab berbeda, pindah branch tanpa reset (initialLocation: false).
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}