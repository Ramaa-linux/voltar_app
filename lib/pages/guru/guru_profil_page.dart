import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../router/app_routes.dart';
import '../../services/auth_service.dart';
import '../../shell/guru_shell.dart';
import '../../theme/app_borders.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../utils/volt_feedback.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/volt_card.dart';
import '../../utils/localization_helper.dart';
import '../../providers/locale_provider.dart';
import 'package:voltar/l10n/app_localizations.dart';

/// Halaman Profil Guru.
/// Menggunakan data real dari Firestore via [userProfileProvider] dan FirebaseAuth.
class GuruProfilPage extends ConsumerWidget {
  const GuruProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>?> profileAsync =
        ref.watch(userProfileProvider);
    final AuthService authService = ref.watch(authServiceProvider);
    final String? uid = authService.currentUser?.uid;
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: uid == null
                  ? const SizedBox.shrink()
                  : FutureBuilder<Map<String, int>>(
                      future: _fetchProfileStats(uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: _StatItem(
                                  label: context.t('profilStatClasses'),
                                  value: '-',
                                ),
                              ),
                              Expanded(
                                child: _StatItem(
                                  label: context.t('profilStatStudents'),
                                  value: '-',
                                ),
                              ),
                              Expanded(
                                child: _StatItem(
                                  label: context.t('profilStatAssignments'),
                                  value: '-',
                                ),
                              ),
                            ],
                          );
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: _StatItem(
                                  label: context.t('profilStatClasses'),
                                  value: '-',
                                ),
                              ),
                              Expanded(
                                child: _StatItem(
                                  label: context.t('profilStatStudents'),
                                  value: '-',
                                ),
                              ),
                              Expanded(
                                child: _StatItem(
                                  label: context.t('profilStatAssignments'),
                                  value: '-',
                                ),
                              ),
                            ],
                          );
                        }
                        final data = snapshot.data!;
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: _StatItem(
                                label: context.t('profilStatClasses'),
                                value: data['kelas']!.toString(),
                              ),
                            ),
                            Expanded(
                              child: _StatItem(
                                label: context.t('profilStatStudents'),
                                value: data['siswa']!.toString(),
                              ),
                            ),
                            Expanded(
                              child: _StatItem(
                                label: context.t('profilStatAssignments'),
                                value: data['tugas']!.toString(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: Divider(color: AppColors.border, height: 1, thickness: 1),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
            sliver: SliverList.separated(
              itemCount: _menuItems.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (BuildContext context, int index) {
                final _MenuItem item = _menuItems[index];
                return _MenuTile(
                  item: item,
                  onTap: () {
                    if (item.titleKey == 'profilMenuEditProfil') {
                      context.push(AppRoutes.profilEdit);
                    } else if (item.titleKey == 'profilLogout') {
                      _showLogoutConfirmDialog(context, authService);
                    } else if (item.titleKey == 'profilMenuBahasa') {
                      _showLanguageSheet(context, ref);
                    } else if (item.titleKey == 'profilMenuNotifikasi') {
                      showVoltSnackBar(
                        context,
                        context.t('profilSnackNotifikasi'),
                      );
                    } else if (item.titleKey == 'profilMenuBantuan') {
                      _showSupportDialog(context);
                    } else if (item.titleKey == 'profilMenuTentang') {
                      _showAboutDialog(context);
                    } else {
                      showVoltSnackBar(
                        context,
                        context.t('profilComingSoon'),
                      );
                    }
                  },
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
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

  static Future<Map<String, int>> _fetchProfileStats(String uid) async {
    final db = FirebaseFirestore.instance;

    // 1) Jumlah kelas
    final classesSnap = await db
        .collection('classes')
        .where('teacherId', isEqualTo: uid)
        .get();
    final numClasses = classesSnap.docs.length;
    final classIds = classesSnap.docs.map((d) => d.id).toList();

    // 2) Jumlah tugas (assignment)
    final postsSnap = await db
        .collection('posts')
        .where('authorId', isEqualTo: uid)
        .where('type', isEqualTo: 'assignment')
        .get();
    final numAssignments = postsSnap.docs.length;

    // 3) Total siswa di semua kelas guru
    int numStudents = 0;
    if (classIds.isNotEmpty) {
      for (int i = 0; i < classIds.length; i += 10) {
        final chunk = classIds.sublist(
          i,
          (i + 10 < classIds.length) ? i + 10 : classIds.length,
        );
        final usersSnap = await db
            .collection('users')
            .where('classId', whereIn: chunk)
            .get();
        numStudents += usersSnap.docs.length;
      }
    }

    return <String, int>{
      'kelas': numClasses,
      'tugas': numAssignments,
      'siswa': numStudents,
    };
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
            context.t('profilLogoutConfirmTitle'),
            style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
          ),
          content: Text(
            context.t('profilLogoutConfirmMsg'),
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                context.t('profilCancel'),
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
                      context.t('profilLogoutFailed'),
                    );
                  }
                }
              },
              child: Text(
                context.t('profilLogoutYes'),
                style: AppTypography.label.copyWith(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Dialog Bantuan & Dukungan: menampilkan email support dengan tombol salin.
  void _showSupportDialog(BuildContext context) {
    const String supportEmail = 'ramalewin67@gmail.com';

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          title: Row(
            children: <Widget>[
              const AppIcon.helpCircle(
                size: AppIconSize.lg,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.t('profilMenuBantuan'),
                style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                supportEmail,
                style: AppTypography.body.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Tap “Salin Email” untuk menyalin alamat email ke papan klip.',
                style: AppTypography.label.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Clipboard.setData(ClipboardData(text: supportEmail));
                if (context.mounted) {
                  showVoltSnackBar(
                    context,
                    context.t('profilSupportEmailCopied'),
                  );
                }
              },
              child: Text(
                context.t('profilSupportCopyBtn'),
                style: AppTypography.label.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Tutup',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          title: Row(
            children: <Widget>[
              const AppIcon.info(size: AppIconSize.lg, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.t('profilDialogTentangTitle'),
                style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: Text(
            context.t('profilDialogTentangBody'),
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'OK',
                style: AppTypography.label.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Bottom Sheet: memilih bahasa aplikasi (Indonesia / English).
  void _showLanguageSheet(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    String selectedLang = ref.read(localeProvider).locale.languageCode;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.card),
          topRight: Radius.circular(AppRadius.card),
        ),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom +
                AppSpacing.navBarClearance,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  l10n?.languageDialogTitle ??
                      context.t('profilLanguageDialogTitle'),
                  style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.lg),
                RadioListTile<String>(
                  title: Text(l10n?.langIndonesian ?? 'Indonesia'),
                  value: 'id',
                  groupValue: selectedLang,
                  onChanged: (String? value) {
                    selectedLang = value!;
                    ref.read(localeProvider.notifier).setLocale(value);
                    Navigator.of(ctx).pop();
                  },
                ),
                RadioListTile<String>(
                  title: Text(l10n?.langEnglish ?? 'English'),
                  value: 'en',
                  groupValue: selectedLang,
                  onChanged: (String? value) {
                    selectedLang = value!;
                    ref.read(localeProvider.notifier).setLocale(value);
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ),
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
              : context.t('profilFallbackName'));
    final String email = (data?['email'] as String?)?.trim().isNotEmpty == true
        ? (data!['email'] as String).trim()
        : (currentUser?.email?.toString().trim().isNotEmpty == true
              ? currentUser!.email!.toString().trim()
              : 'guru@sekolah.sch.id');
    final String role = (data?['role'] as String?)?.trim().isNotEmpty == true
        ? (data!['role'] as String).trim()
        : 'guru';
    final String roleLabel = role.isEmpty
        ? context.t('profilFallbackRoleLabel')
        : role[0].toUpperCase() + role.substring(1).toLowerCase();
    final String? photoUrl = (data?['photoUrl'] as String?)?.trim().isNotEmpty == true
        ? (data!['photoUrl'] as String).trim()
        : (currentUser?.photoURL?.toString().trim().isNotEmpty == true
              ? currentUser!.photoURL!.toString().trim()
              : null);
    final String nip = (data?['nip'] as String?)?.trim() ??
        context.t('profilNIPUnavailable');
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
          backgroundColor: AppColors.border,
          child: AppIcon(AppIconName.profile, size: 50, color: AppColors.textTertiary),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          AppLocalizations.of(context)!.guruGreetingError,
          style: AppTypography.bodyMuted,
        ),
      ],
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          value,
          style: AppTypography.heading.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.label.copyWith(color: AppColors.textTertiary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Chip info profil.
class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final AppIconName icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: AppBorders.standard,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppIcon(icon, size: 16, color: AppColors.textTertiary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Row logout di bottom card.
class _LogoutRow extends StatelessWidget {
  const _LogoutRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
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
      title: Text(
        context.t('profilLogout'),
        style: AppTypography.body.copyWith(
          color: AppColors.error,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const AppIcon.chevronRight(
        size: AppIconSize.sm,
        color: AppColors.textTertiary,
      ),
      onTap: onTap,
    );
  }
}

/// Daftar menu profil.
final List<_MenuItem> _menuItems = <_MenuItem>[
  _MenuItem(titleKey: 'profilMenuEditProfil', icon: AppIconName.pencil),
  _MenuItem(titleKey: 'profilMenuBahasa', icon: AppIconName.globe),
  _MenuItem(titleKey: 'profilMenuNotifikasi', icon: AppIconName.bell),
  _MenuItem(titleKey: 'profilMenuBantuan', icon: AppIconName.helpCircle),
  _MenuItem(titleKey: 'profilMenuTentang', icon: AppIconName.info),
];

class _MenuItem {
  const _MenuItem({required this.titleKey, required this.icon});
  final String titleKey;
  final AppIconName icon;
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.item, required this.onTap});

  final _MenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return VoltCard(
      onTap: onTap,
      child: ListTile(
        leading: AppIcon(item.icon, size: 20, color: AppColors.textSecondary),
        title: Text(
          context.t(item.titleKey),
          style: AppTypography.body,
        ),
        trailing: const AppIcon.chevronRight(
          size: AppIconSize.sm,
          color: AppColors.textTertiary,
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





