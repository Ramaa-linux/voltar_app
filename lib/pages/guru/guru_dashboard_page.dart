import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth_service.dart';
import '../../theme/app_borders.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../widgets/app_icon.dart';
import '../../shell/guru_shell.dart';
import 'data/guru_dummy_data.dart';

/// Halaman Dashboard Guru.
/// Menampilkan sapaan, statistik (3 card), dan aktivitas terkini (5+ item).
class GuruDashboardPage extends ConsumerWidget {
  const GuruDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>?> profileAsync =
        ref.watch(userProfileProvider);

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
              child: profileAsync.when(
                data: (Map<String, dynamic>? data) =>
                    _GreetingSection(data: data),
                loading: () => _GreetingSkeleton(),
                error: (Object error, StackTrace stackTrace) =>
                    _GreetingError(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: _StatsRow(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: Text(
                'Aktivitas Terkini',
                style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
            ),
            sliver: SliverList.separated(
              itemCount: dummyAktivitasList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (BuildContext context, int index) {
                final AktivitasDummy aktivitas = dummyAktivitasList[index];
                return _ActivityCard(aktivitas: aktivitas);
              },
            ),
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
        : 'Guru';
    final String tanggal = formatTanggalIndonesia(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Selamat datang,', style: AppTypography.bodyMuted),
        const SizedBox(height: AppSpacing.xs),
        Text(
          nama,
          style: AppTypography.heading.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(tanggal, style: AppTypography.bodyMuted),
      ],
    );
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
        Text('Selamat datang,', style: AppTypography.bodyMuted),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Guru',
          style: AppTypography.heading.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          formatTanggalIndonesia(DateTime.now()),
          style: AppTypography.bodyMuted,
        ),
      ],
    );
  }
}

/// Baris 3 kartu statistik: Kelas, Siswa, Tugas Aktif.
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // TODO(Fase 28+): sinkronkan nilai statistik dengan data nyata di Firestore.
        Expanded(
          child: _StatCard(
            label: 'Kelas',
            value: '2',
            icon: AppIconName.folder,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            label: 'Siswa',
            value: '60',
            icon: AppIconName.profile,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            label: 'Tugas Aktif',
            value: '3',
            icon: AppIconName.checkSquare,
            valueColor: AppColors.primary,
          ),
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
  const _ActivityCard({required this.aktivitas});

  final AktivitasDummy aktivitas;

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
                  aktivitas.teks,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  formatWaktuSingkat(aktivitas.waktu),
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
