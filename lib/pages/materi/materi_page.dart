import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/repositories/materi_repository.dart';
import 'package:voltar/repositories/progress_repository.dart';
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
    final AsyncValue<Set<String>> completedAsync =
        ref.watch(completedStepsProvider);

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
        data: (levels) {
          final Set<String> completed =
              completedAsync.value ?? const <String>{};
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            itemCount: levels.length,
            itemBuilder: (context, index) {
              final level = levels[index];
              final bool isUnlocked = ProgressRepository.checkLevelUnlocked(
                levelNumber: level.levelNumber,
                completedSteps: completed,
                levels: levels,
              );
              return _LevelCard(
                level: level,
                isUnlocked: isUnlocked,
                onReturn: () => ref.invalidate(completedStepsProvider),
              );
            },
          );
        },
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
  const _LevelCard({
    required this.level,
    required this.isUnlocked,
    this.onReturn,
  });

  final LevelModel level;
  final bool isUnlocked;
  final VoidCallback? onReturn;

  @override
  Widget build(BuildContext context) {
    final Widget card = VoltCard(
      onTap: isUnlocked
          ? () async {
              await context.push(
                '${AppRoutes.materi}/level/${level.levelNumber}',
              );
              onReturn?.call();
            }
          : () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Selesaikan Level sebelumnya terlebih dahulu',
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
            },
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? AppColors.primaryLight
                  : AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Text(
              '${level.levelNumber}',
              style: AppTypography.display.copyWith(
                color: isUnlocked
                    ? AppColors.primaryDark
                    : AppColors.textTertiary,
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
                    color: isUnlocked
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  level.caption,
                  style: AppTypography.caption.copyWith(
                    color: isUnlocked
                        ? AppColors.textSecondary
                        : AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          isUnlocked
              ? const AppIcon.chevronRight(
                  size: AppIconSize.md,
                  color: AppColors.textTertiary,
                )
              : const AppIcon.lock(
                  size: AppIconSize.md,
                  color: AppColors.textTertiary,
                ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Semantics(
        label: isUnlocked
            ? 'Level ${level.levelNumber}'
            : 'Level ${level.levelNumber}, terkunci',
        child: isUnlocked
            ? card
            : Opacity(
                opacity: 0.55,
                child: card,
              ),
      ),
    );
  }
}
