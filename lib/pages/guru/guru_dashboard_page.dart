import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/auth_service.dart';
import '../../models/class_post.dart';
import '../../theme/app_borders.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../widgets/app_icon.dart';
import '../../shell/guru_shell.dart';
import 'package:voltar/l10n/app_localizations.dart';

/// Halaman Dashboard Guru.
/// Menampilkan sapaan, statistik (3 card), dan aktivitas terkini (5+ item).
class GuruDashboardPage extends ConsumerWidget {
  const GuruDashboardPage({super.key});

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
                AppSpacing.md,
              ),
              child: ref.watch(userProfileProvider).when(
                data: (data) => _GreetingSection(data: data),
                loading: () => _GreetingSkeleton(),
                error: (_, __) => _GreetingError(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: uid == null
                  ? const _StatsError(message: 'User belum login')
                  : _StatsRow(uid: uid),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: Text(
                AppLocalizations.of(context)!.guruActivities,
                style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
            ),
            sliver: uid == null
                ? SliverToBoxAdapter(
                    child: _EmptyActivities(message: AppLocalizations.of(context)!.guruNotLoggedIn),
                  )
                : _ActivitiesList(uid: uid),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: GuruShell.bottomInset),
          ),
        ],
      ),
    );
  }
}

/// Section sapaan dengan nama guru dan tanggal hari ini.
class _GreetingSection extends StatelessWidget {
  const _GreetingSection({required this.data});

  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    final String nama = (data?['name'] as String?)?.trim().isNotEmpty == true
        ? (data!['name'] as String).trim()
        : AppLocalizations.of(context)!.guruNotLoggedIn;
    final String waktu = _waktuSapaan(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$waktu, $nama',
          style: AppTypography.heading.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          AppLocalizations.of(context)!.guruWelcomeSubtitle,
          style: AppTypography.bodyMuted,
        ),
      ],
    );
  }

  String _waktuSapaan(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 11) return AppLocalizations.of(context)!.guruPagi;
    if (hour < 15) return AppLocalizations.of(context)!.guruSiang;
    if (hour < 18) return AppLocalizations.of(context)!.guruSore;
    return AppLocalizations.of(context)!.guruMalam;
  }
}

/// Skeleton loading untuk sapaan.
class _GreetingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SkeletonLine(width: 150, height: 20),
        const SizedBox(height: AppSpacing.xs),
        _SkeletonLine(width: 200, height: 28),
        const SizedBox(height: AppSpacing.xs),
        _SkeletonLine(width: 180, height: 18),
      ],
    );
  }
}

/// Error state untuk sapaan.
class _GreetingError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.guruGreetingError,
          style: AppTypography.bodyMuted,
        ),
      ],
    );
  }
}

/// Kartu statistik individual.
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final AppIconName icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: AppBorders.standard,
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              AppIcon(icon, size: 20, color: AppColors.textTertiary),
              const Spacer(),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            value,
            style: AppTypography.heading.copyWith(
              fontWeight: FontWeight.w800,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.label.copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }
}

/// Kartu aktivitas individual.
class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.teks, required this.waktu});

  final String teks;
  final DateTime waktu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: AppBorders.standard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6, right: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  teks,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${waktu.hour.toString().padLeft(2, '0')}:${waktu.minute.toString().padLeft(2, '0')}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
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

/// Kartu statistik dengan FutureBuilder - mengambil data real dari Firestore.
class _StatsRow extends ConsumerWidget {
  const _StatsRow({required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<Map<String, int>>(
      future: _fetchStats(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            children: <Widget>[
              Expanded(child: _StatCardSkeleton()),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _StatCardSkeleton()),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _StatCardSkeleton()),
            ],
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Row(
            children: <Widget>[
              Expanded(child: _StatErrorCard(label: AppLocalizations.of(context)!.guruStatsError)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _StatErrorCard(label: AppLocalizations.of(context)!.guruStatsError)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _StatErrorCard(label: AppLocalizations.of(context)!.guruStatsError)),
            ],
          );
        }
        final data = snapshot.data!;
        return Row(
          children: <Widget>[
            Expanded(
              child: _StatCard(
                label: AppLocalizations.of(context)!.guruStatsKelas,
                value: data['kelas']!.toString(),
                icon: AppIconName.folder,
                valueColor: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _StatCard(
                label: AppLocalizations.of(context)!.guruStatsTugas,
                value: data['tugas']!.toString(),
                icon: AppIconName.fileText,
                valueColor: AppColors.accent,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _StatCard(
                label: AppLocalizations.of(context)!.guruStatsSiswa,
                value: data['siswa']!.toString(),
                icon: AppIconName.profile,
                valueColor: AppColors.accent,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<Map<String, int>> _fetchStats(String uid) async {
    final db = FirebaseFirestore.instance;

    // 1) Jumlah kelas
    final classesSnap = await db
        .collection('classes')
        .where('teacherId', isEqualTo: uid)
        .get();
    final numClasses = classesSnap.docs.length;
    final classIds = classesSnap.docs.map((d) => d.id).toList();

    // 2) Jumlah tugas (assignment) buat guru ini
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
}



/// List aktivitas terbaru - 5 postingan terbaru dari guru.
class _ActivitiesList extends ConsumerWidget {
  const _ActivitiesList({required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<ClassPost>>(
      future: _fetchActivities(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverList.separated(
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, __) => const _ActivitySkeleton(),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SliverToBoxAdapter(
            child: _EmptyActivities(message: AppLocalizations.of(context)!.guruActivitiesEmpty),
          );
        }
        final posts = snapshot.data!;
        return SliverList.separated(
          itemCount: posts.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final post = posts[index];
            final isTugas = post.isAssignment;
            final teks = isTugas
                ? 'Membuat Tugas: "${post.title ?? post.content}"'
                : 'Membuat Pengumuman: "${post.title ?? post.content}"';
            return _ActivityCard(
              teks: teks,
              waktu: post.createdAt.toDate(),
            );
          },
        );
      },
    );
  }

  static Future<List<ClassPost>> _fetchActivities(String uid) async {
    final snap = await FirebaseFirestore.instance
        .collection('posts')
        .where('authorId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(5)
        .get();
    return snap.docs
        .map((d) => ClassPost.fromMap(d.id, d.data()))
        .toList();
  }
}


/// Skeleton untuk kartu statistik.
class _StatCardSkeleton extends StatelessWidget {
  const _StatCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: AppBorders.standard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(width: 40, height: 20, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Container(width: 60, height: 28, color: AppColors.border),
          const SizedBox(height: AppSpacing.xs),
          Container(width: 100, height: 16, color: AppColors.border),
        ],
      ),
    );
  }
}

/// Skeleton untuk kartu aktivitas.
class _ActivitySkeleton extends StatelessWidget {
  const _ActivitySkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: AppBorders.standard,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.border,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(width: double.infinity, height: 16, color: AppColors.border),
                const SizedBox(height: AppSpacing.xs),
                Container(width: 120, height: 14, color: AppColors.border),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty state aktivitas.
class _EmptyActivities extends StatelessWidget {
  const _EmptyActivities({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: AppBorders.standard,
      ),
      child: Center(
        child: Text(
          message,
          style: AppTypography.bodyMuted,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Error card statistik.
class _StatErrorCard extends StatelessWidget {
  const _StatErrorCard({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: AppBorders.standard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppIcon(AppIconName.info, size: 20, color: AppColors.textTertiary),
          const SizedBox(height: AppSpacing.md),
          Text(
            '-',
            style: AppTypography.heading.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.label.copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }
}

/// Stats error state.
class _StatsError extends StatelessWidget {

  const _StatsError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTypography.bodyMuted,
      ),
    );
  }
}


