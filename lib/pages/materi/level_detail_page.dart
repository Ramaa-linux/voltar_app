import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/pages/materi/materi_page.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Provider untuk memuat satu level berdasarkan levelNumber.
final levelDetailProvider =
    FutureProvider.family<LevelModel, int>((ref, levelNumber) async {
  final repo = ref.watch(materiRepositoryProvider);
  return repo.getLevelByNumber(levelNumber);
});

/// Halaman peta perjalanan belajar (Learning Journey Map) untuk satu level.
class LevelDetailPage extends ConsumerWidget {
  const LevelDetailPage({super.key, required this.levelNumber});

  final int levelNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<LevelModel> levelAsync =
        ref.watch(levelDetailProvider(levelNumber));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const AppIcon.arrowLeft(
            size: AppIconSize.md,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Level $levelNumber',
          style: AppTypography.title.copyWith(fontSize: 18),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppBorders.thin),
          child: Container(color: AppColors.border, height: AppBorders.thin),
        ),
      ),
      body: levelAsync.when(
        data: (level) => _LevelJourneyView(level: level),
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
class _LevelJourneyView extends StatelessWidget {
  const _LevelJourneyView({required this.level});

  final LevelModel level;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      itemCount: level.steps.length,
      itemBuilder: (context, index) {
        final step = level.steps[index];
        final isFirst = index == 0;
        final isLast = index == level.steps.length - 1;

        // Fase 2 UI-only lock logic:
        // Pre-test selalu aktif.
        // Materi selalu aktif.
        // Post-test terkunci untuk sementara sebagai preview tantangan akhir.
        final bool isLocked = step.type == LearningStepType.posttest;

        return _StepTile(
          step: step,
          levelNumber: level.levelNumber,
          isFirst: isFirst,
          isLast: isLast,
          isLocked: isLocked,
        );
      },
    );
  }
}


class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.step,
    required this.levelNumber,
    required this.isFirst,
    required this.isLast,
    required this.isLocked,
  });

  final LearningStep step;
  final int levelNumber;
  final bool isFirst;
  final bool isLast;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final (String badgeText, AppIconName iconName) = switch (step.type) {
      LearningStepType.pretest => ('PRE-TEST', AppIconName.helpCircle),
      LearningStepType.materi => ('MATERI', AppIconName.bookOpen),
      LearningStepType.posttest => ('POST-TEST', AppIconName.checkSquare),
    };

    final VoltChipStatus status =
        isLocked ? VoltChipStatus.locked : VoltChipStatus.active;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTimeline(context),
          const SizedBox(width: AppSpacing.sm),
          _buildCard(context, badgeText, iconName, status),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 2,
              color: isFirst ? Colors.transparent : AppColors.border,
            ),
          ),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isLocked ? AppColors.border : AppColors.primary,
              border: Border.all(color: AppColors.surface, width: 2),
            ),
          ),
          Expanded(
            child: Container(
              width: 2,
              color: isLast ? Colors.transparent : AppColors.border,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildCard(
    BuildContext context,
    String badgeText,
    AppIconName iconName,
    VoltChipStatus status,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: VoltCard(
          onTap: isLocked
              ? null
              : () {
                  if (step.type == LearningStepType.materi) {
                    context.push(
                      '${AppRoutes.materi}/detail/${step.id}?level=$levelNumber',
                    );
                  } else {
                    context.push('${AppRoutes.materi}/kuis/${step.id}');
                  }
                },
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isLocked ? AppColors.background : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                ),
                child: isLocked
                    ? const AppIcon.lock(
                        size: AppIconSize.md,
                        color: AppColors.textTertiary,
                      )
                    : AppIcon(
                        iconName,
                        size: AppIconSize.md,
                        color: AppColors.primaryDark,
                      ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          badgeText,
                          style: AppTypography.overline.copyWith(
                            color: isLocked
                                ? AppColors.textTertiary
                                : AppColors.primaryDark,
                          ),
                        ),
                        const Spacer(),
                        VoltChip(
                          label: isLocked ? 'Terkunci' : 'Mulai',
                          status: status,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      step.title,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isLocked
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      step.type == LearningStepType.materi
                          ? (step.estimatedTime ?? '5 menit')
                          : '${step.questions?.length ?? 5} pertanyaan',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}