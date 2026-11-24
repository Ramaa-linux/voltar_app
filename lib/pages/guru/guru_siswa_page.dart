import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/auth_service.dart';
import '../../theme/app_borders.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../shell/guru_shell.dart';
import '../../utils/localization_helper.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/volt_card.dart';

/// Halaman Monitoring Progress Siswa untuk Guru.
/// Menampilkan daftar siswa (role == 'siswa') dari koleksi `users`
/// beserta progres belajar mereka.
class GuruSiswaPage extends ConsumerWidget {
  const GuruSiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final String? uid = authService.currentUser?.uid;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.xl,
                AppSpacing.pagePadding,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    context.t('guruSiswaTitle'),
                    style: AppTypography.heading.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    context.t('guruSiswaSubtitle'),
                    style: AppTypography.bodyMuted,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
            sliver: uid == null
                ? SliverToBoxAdapter(
                    child: _EmptyState(
                      icon: AppIconName.info,
                      title: context.t('guruNotLoggedIn'),
                      message: context.t('guruLoginPrompt'),
                    ),
                  )
                : _SiswaList(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: GuruShell.bottomInset),
          ),
        ],
      ),
    );
  }
}

/// Kartu satu siswa dengan nama, email, dan progress bar.
class _SiswaCard extends StatelessWidget {
  const _SiswaCard({required this.data});

  final Map<String, dynamic> data;

  double _getProgress() {
    final completed = data['completedSteps'] as num?;
    final total = data['totalSteps'] as num?;
    if (completed == null || total == null || total == 0) return 0;
    return (completed / total).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final String nama = (data['name'] as String?)?.trim().isNotEmpty == true
        ? (data['name'] as String).trim()
        : '-';
    final String email = (data['email'] as String?)?.trim().isNotEmpty == true
        ? (data['email'] as String).trim()
        : '-';
    final progress = _getProgress();
    final completed = data['completedSteps'] as int? ?? 0;
    final total = data['totalSteps'] as int? ?? 0;

    return VoltCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      nama,
                      style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      email,
                      style: AppTypography.label.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (total > 0)
                Text(
                  '${(progress * 100).round()}%',
                  style: AppTypography.title.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (total > 0) ...<Widget>[
            LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              borderRadius: BorderRadius.circular(AppRadius.button),
              backgroundColor: AppColors.border,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              context.t('guruSiswaCompleted', args: [completed]),
              style: AppTypography.label.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ] else ...<Widget>[
            Text(
              context.t('guruSiswaNoProgress'),
              style: AppTypography.label.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Skeleton loading untuk kartu siswa.
class _SiswaSkeleton extends StatelessWidget {
  const _SiswaSkeleton();

  @override
  Widget build(BuildContext context) {
    return VoltCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(width: double.infinity, height: 20, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Container(width: 120, height: 16, color: AppColors.border),
          const SizedBox(height: AppSpacing.xs),
          Container(width: double.infinity, height: 6, color: AppColors.border),
        ],
      ),
    );
  }
}

/// Empty state widget.
class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final AppIconName icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Column(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AppIcon(icon, size: 40, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: AppTypography.title.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.xs),
          Text(message, style: AppTypography.bodyMuted, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/// Daftar siswa dengan progress belajar (StreamBuilder real dari Firestore).
class _SiswaList extends ConsumerWidget {
  const _SiswaList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'siswa')
        .orderBy('name', descending: false)
        .snapshots();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverList.separated(
            itemCount: 3,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, _) => const _SiswaSkeleton(),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return SliverToBoxAdapter(
            child: _EmptyState(
              icon: AppIconName.profile,
              title: context.t('guruSiswaTitle'),
              message: context.t('guruSiswaNoProgress'),
            ),
          );
        }
        final siswa = snapshot.data!.docs;
        return SliverList.separated(
          itemCount: siswa.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final data = siswa[index].data();
            return _SiswaCard(data: data);
          },
        );
      },
    );
  }
}
