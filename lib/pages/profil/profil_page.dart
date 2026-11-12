import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/volt_feedback.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

class _SettingsItem {
  const _SettingsItem({required this.icon, required this.label});

  final AppIconName icon;
  final String label;
}

const List<_SettingsItem> _settings = <_SettingsItem>[
  _SettingsItem(icon: AppIconName.pencil, label: 'Edit Profil'),
  _SettingsItem(icon: AppIconName.bell, label: 'Notifikasi'),
  _SettingsItem(icon: AppIconName.info, label: 'Tentang Aplikasi'),
];

/// Menghasilkan inisial nama untuk avatar (mis. "Rama" -> "R", "Rama Pratama" -> "RP").
String initialsFromName(String? name) {
  final String clean = (name ?? '').trim();
  if (clean.isEmpty) {
    return '?';
  }
  final List<String> parts = clean
      .split(RegExp(r'\s+'))
      .where((String s) => s.isNotEmpty)
      .toList();
  if (parts.isEmpty) {
    return '?';
  }
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
      .toUpperCase();
}

String _formatRoleLabel(String? role) {
  final String clean = (role ?? '').trim();
  if (clean.isEmpty) {
    return 'Siswa';
  }
  return clean[0].toUpperCase() + clean.substring(1).toLowerCase();
}

String? _safePhotoUrl(dynamic user) {
  if (user == null) return null;
  try {
    return user.photoURL?.toString().trim();
  } catch (_) {
    return null;
  }
}

/// Profil siswa: identitas dinamis dari Firestore + daftar pengaturan.
class ProfilPage extends ConsumerWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>?> profileAsync =
        ref.watch(userProfileProvider);
    final AuthService authService = ref.watch(authServiceProvider);
    final Map<String, dynamic>? data = profileAsync.value;
    final dynamic currentUser = authService.currentUser;

    final String name = (data?['name'] as String?)?.trim().isNotEmpty == true
        ? (data!['name'] as String).trim()
        : (currentUser?.displayName?.toString().trim().isNotEmpty == true
              ? currentUser!.displayName!.toString().trim()
              : 'Budi Santoso');
    final String email = (data?['email'] as String?)?.trim().isNotEmpty == true
        ? (data!['email'] as String).trim()
        : (currentUser?.email?.toString().trim().isNotEmpty == true
              ? currentUser!.email!.toString().trim()
              : 'budi.santoso@sekolah.sch.id');
    final String roleLabel = _formatRoleLabel(data?['role'] as String?);
    final String initials = initialsFromName(name);
    final String? photoUrl = (data?['photoUrl'] as String?)?.trim().isNotEmpty == true
        ? (data!['photoUrl'] as String).trim()
        : _safePhotoUrl(currentUser);
    final bool hasPhoto = photoUrl != null && photoUrl.isNotEmpty;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.pagePadding,
          AppSpacing.xl,
          AppSpacing.pagePadding,
          AppSpacing.navBarClearance,
        ),
        children: <Widget>[
          Text('Profil', style: AppTypography.display),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  key: const Key('profil_avatar'),
                  radius: 40,
                  backgroundColor: AppColors.primaryLight,
                  backgroundImage: hasPhoto ? NetworkImage(photoUrl) : null,
                  child: hasPhoto
                      ? null
                      : Text(
                          initials,
                          style: AppTypography.heading.copyWith(
                            color: AppColors.primaryDark,
                          ),
                        ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(name, style: AppTypography.title),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  email,
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.md),
                VoltChip(label: roleLabel),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Pengaturan', style: AppTypography.title),
          const SizedBox(height: AppSpacing.md),
          VoltCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                for (int i = 0; i < _settings.length; i++) ...<Widget>[
                  if (i > 0) const Divider(indent: AppSpacing.lg),
                  _SettingsRow(
                    item: _settings[i],
                    onTap: () {
                      if (_settings[i].label == 'Edit Profil') {
                        context.push(AppRoutes.profilEdit);
                      } else if (_settings[i].label == 'Notifikasi') {
                        _showNotificationDialog(context);
                      } else if (_settings[i].label == 'Tentang Aplikasi') {
                        _showAboutDialog(context);
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          VoltCard(
            padding: EdgeInsets.zero,
            child: _LogoutRow(
              onTap: () async {
                try {
                  await ref.read(authServiceProvider).logout();
                  if (context.mounted) {
                    context.go('/login');
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
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'EduVolt v1.0.0',
            style: AppTypography.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Dialog Notifikasi: menampilkan pesan sederhana "Belum ada notifikasi baru."
  void _showNotificationDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        key: const Key('notification_dialog'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        title: Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.input),
              ),
              child: const AppIcon.bell(
                size: AppIconSize.md,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text('Notifikasi', style: AppTypography.title),
          ],
        ),
        content: Text(
          'Belum ada notifikasi baru.',
          style: AppTypography.body,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Tutup',
              style: AppTypography.body.copyWith(color: AppColors.primaryDark),
            ),
          ),
        ],
      ),
    );
  }

  /// Dialog Tentang Aplikasi: menampilkan logo EduVolt, versi, dan kredit pembuat.
  void _showAboutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        key: const Key('about_dialog'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        contentPadding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.md,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: AppBorders.standard,
              ),
              child: const AppIcon.zap(
                size: 36,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('EduVolt', style: AppTypography.display),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'EduVolt v1.0.0 - Platform Pembelajaran Elektronika untuk SMK.',
              style: AppTypography.bodyMuted,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Dibuat oleh: Tim EduVolt',
              style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    'Tutup',
                    style: AppTypography.body.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.item, required this.onTap});

  final _SettingsItem item;
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
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                  child: AppIcon(
                    item.icon,
                    size: AppIconSize.sm,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(item.label, style: AppTypography.body),
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

