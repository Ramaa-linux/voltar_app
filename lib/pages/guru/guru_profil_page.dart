import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_routes.dart';
import '../../services/auth_service.dart';
import '../../shell/guru_shell.dart';
import '../../theme/app_borders.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../utils/volt_feedback.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/press_scale.dart';
import '../../widgets/volt_card.dart';

/// Halaman Profil Guru.
/// Menggunakan data real dari Firestore via [userProfileProvider].
class GuruProfilPage extends ConsumerWidget {
  const GuruProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>?> profileAsync =
        ref.watch(userProfileProvider);
    final AuthService authService = ref.watch(authServiceProvider);
    final dynamic currentUser = authService.currentUser;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: <Widget>[ 
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.xl,
                AppSpacing.pagePadding,
                AppSpacing.lg,
              ),
              child: profileAsync.when(
                data: (Map<String, dynamic>? data) =>
                    _ProfileHeader(data: data, currentUser: currentUser),
                loading: () => _ProfileHeaderSkeleton(),
                error: (Object error, StackTrace stackTrace) =>
                    _ProfileHeaderError(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
              child: Row(
                children: <Widget>[ 
                  Expanded(child: _StatItem(label: 'Kelas', value: '2')),
                  Expanded(child: _StatItem(label: 'Siswa', value: '60')),
                  Expanded(child: _StatItem(label: 'Tugas', value: '12')),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
              child: Divider(color: AppColors.border, height: 1, thickness: 1),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
            sliver: SliverList.separated(
              itemCount: _menuItems.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: AppSpacing.xs),
              itemBuilder: (BuildContext context, int index) {
                final _MenuItem item = _menuItems[index];
                return _MenuTile(
                  item: item,
                  onTap: () {
                    if (item.title == 'Edit Profil') {
                      context.push(AppRoutes.profilEdit);
                    } else if (item.title == 'Keluar') {
                      _showLogoutConfirmDialog(context, authService);
                    } else {
                      showVoltSnackBar(
                        context,
                        'Fitur segera hadir',
                      );
                    }
                  },
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.lg,
                AppSpacing.pagePadding,
                AppSpacing.lg,
              ),
              child: VoltCard(
                padding: EdgeInsets.zero,
                child: _LogoutRow(
                  onTap: () => _showLogoutConfirmDialog(context, authService),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: GuruShell.bottomInset)),
        ],
      ),
    );
  }

  Future<void> _showLogoutConfirmDialog(
    BuildContext context,
    AuthService authService,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          title: Text(
            'Konfirmasi Keluar',
            style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Apakah kamu yakin ingin keluar?',
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Batal',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                try {
                  await authService.logout();
                  if (context.mounted) {
                    context.go(AppRoutes.login);
                  }
                } on AuthException catch (e) {
                  if (context.mounted) {
                    showVoltSnackBar(context, e.message);
                  }
                } catch (_) {
                  if (context.mounted) {
                    showVoltSnackBar(
                      context,
                      'Gagal keluar dari akun. Silakan coba lagi.',
                    );
                  }
                }
              },
              child: Text(
                'Ya, Keluar',
                style: AppTypography.label.copyWith(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Header profil dengan avatar, nama, email, role, dan chip mata pelajaran.
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.data, required this.currentUser});

  final Map<String, dynamic>? data;
  final dynamic currentUser;

  @override
  Widget build(BuildContext context) {
    final String name = (data?['name'] as String?)?.trim().isNotEmpty == true
        ? (data!['name'] as String).trim()
        : (currentUser?.displayName?.toString().trim().isNotEmpty == true
              ? currentUser!.displayName!.toString().trim()
              : 'Guru');
    final String email = (data?['email'] as String?)?.trim().isNotEmpty == true
        ? (data!['email'] as String).trim()
        : (currentUser?.email?.toString().trim().isNotEmpty == true
              ? currentUser!.email!.toString().trim()
              : 'guru@sekolah.sch.id');
    final String role = (data?['role'] as String?)?.trim().isNotEmpty == true
        ? (data!['role'] as String).trim()
        : 'guru';
    final String roleLabel = role.isEmpty
        ? 'Guru'
        : role[0].toUpperCase() + role.substring(1).toLowerCase();
    final String? photoUrl = (data?['photoUrl'] as String?)?.trim().isNotEmpty == true
        ? (data!['photoUrl'] as String).trim()
        : (currentUser?.photoURL?.toString().trim().isNotEmpty == true
              ? currentUser!.photoURL!.toString().trim()
              : null);
    final String nip = (data?['nip'] as String?)?.trim() ?? 'NIP tidak tersedia';
    final String mapel = (data?['subject'] as String?)?.trim() ?? 'TKJ';
    final bool hasPhoto = photoUrl != null && photoUrl.isNotEmpty;

    return Column(
      children: <Widget>[ 
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primaryLight,
          backgroundImage: hasPhoto ? NetworkImage(photoUrl) : null,
          child: hasPhoto
              ? null
              : AppIcon(AppIconName.profile, size: 50, color: AppColors.primary),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(name, style: AppTypography.heading.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: AppSpacing.xs),
        Text(email, style: AppTypography.bodyMuted),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          alignment: WrapAlignment.center,
          children: <Widget>[ 
            _InfoChip(icon: AppIconName.folder, label: mapel),
            _InfoChip(icon: AppIconName.cpu, label: roleLabel),
            _InfoChip(icon: AppIconName.checkSquare, label: nip),
          ],
        ),
      ],
    );
  }
}

/// Skeleton loading untuk header profil.
class _ProfileHeaderSkeleton extends StatelessWidget {
  const _ProfileHeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ 
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.border,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _SkeletonLine(width: 180, height: 24),
        const SizedBox(height: AppSpacing.xs),
        _SkeletonLine(width: 200, height: 16),
        const SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ 
            _SkeletonLine(width: 80, height: 28),
            const SizedBox(width: AppSpacing.sm),
            _SkeletonLine(width: 80, height: 28),
            const SizedBox(width: AppSpacing.sm),
            _SkeletonLine(width: 120, height: 28),
          ],
        ),
      ],
    );
  }
}

/// Error state untuk header profil.
class _ProfileHeaderError extends StatelessWidget {
  const _ProfileHeaderError();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ 
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.errorLight,
          child: Icon(Icons.error_outline, size: 50, color: AppColors.error),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Gagal memuat profil', style: AppTypography.title.copyWith(color: AppColors.error)),
        const SizedBox(height: AppSpacing.xs),
        Text('Periksa koneksi internet Anda', style: AppTypography.bodyMuted),
      ],
    );
  }
}

/// Chip info (mata pelajaran / NIP).
class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final AppIconName icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: AppBorders.standard,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[ 
          AppIcon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Item statistik profil.
class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ 
        Text(
          value,
          style: AppTypography.heading.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTypography.bodyMuted),
      ],
    );
  }
}

/// Item menu profil.
class _MenuItem {
  const _MenuItem({required this.icon, required this.title, required this.subtitle});
  final AppIconName icon;
  final String title;
  final String subtitle;
}

/// Daftar menu statis.
const List<_MenuItem> _menuItems = <_MenuItem>[
  _MenuItem(
    icon: AppIconName.pencil,
    title: 'Edit Profil',
    subtitle: 'Ubah nama, foto, dan informasi akun',
  ),
  _MenuItem(
    icon: AppIconName.bell,
    title: 'Notifikasi',
    subtitle: 'Kelola preferensi notifikasi',
  ),
  _MenuItem(
    icon: AppIconName.helpCircle,
    title: 'Bantuan & Dukungan',
    subtitle: 'FAQ, panduan, dan hubungi kami',
  ),
  _MenuItem(
    icon: AppIconName.lock,
    title: 'Keamanan',
    subtitle: 'Ubah kata sandi dan keamanan akun',
  ),
];

/// Tile menu dengan PressScale.
/// Tile menu dengan PressScale + InkWell.
class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.item, required this.onTap});
  final _MenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(AppRadius.button);

    return PressScale(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: radius,
              border: AppBorders.standard,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                  child: Center(
                    child: AppIcon(item.icon, size: 20, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.title, style: AppTypography.body.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: AppSpacing.xs),
                      Text(item.subtitle, style: AppTypography.caption),
                    ],
                  ),
                ),
                const AppIcon(AppIconName.chevronRight, size: 20, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Baris logout merah.
class _LogoutRow extends StatelessWidget {
  const _LogoutRow({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(AppRadius.card);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppSpacing.minTouchTarget + AppSpacing.sm,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: <Widget>[ 
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    size: 20,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    'Keluar',
                    style: AppTypography.body.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const AppIcon.chevronRight(
                  size: AppIconSize.sm,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper untuk skeleton line.
class _SkeletonLine extends StatelessWidget {
  const _SkeletonLine({required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
    );
  }
}




