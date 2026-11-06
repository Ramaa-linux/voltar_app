import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/repositories/materi_repository.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Provider untuk repository materi (singleton).
final materiRepositoryProvider = Provider<MateriRepository>((ref) {
  return const MateriRepository();
});

/// Provider untuk memuat seluruh level (1-5) dari JSON.
final levelsProvider = FutureProvider<List<LevelModel>>((ref) async {
  final repo = ref.watch(materiRepositoryProvider);
  return repo.getAllLevels();
});

/// Halaman daftar level (peta perjalanan semua level 1-5).
class MateriPage extends ConsumerWidget {
  const MateriPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<LevelModel>> levelsAsync = ref.watch(levelsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Pilih Level',
          style: AppTypography.title,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppBorders.thin),
          child: Container(color: AppColors.border, height: AppBorders.thin),
        ),
      ),
      body: levelsAsync.when(
        data: (levels) => ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          itemCount: levels.length,
          itemBuilder: (context, index) {
            final level = levels[index];
            return _LevelCard(level: level);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text('Gagal memuat level: $error'),
          ),
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.level});

  final LevelModel level;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: VoltCard(
        onTap: () =>
            context.push('${AppRoutes.materi}/level/${level.levelNumber}'),
        child: Row(
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Text(
                '${level.levelNumber}',
                style: AppTypography.display.copyWith(
                  color: AppColors.primaryDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Level ${level.levelNumber}',
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    level.caption,
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            const AppIcon.chevronRight(
              size: AppIconSize.md,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
