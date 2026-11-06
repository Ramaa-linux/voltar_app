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

        if (step.type == LearningStepType.folder) {
          return _FolderStepTile(
            step: step,
            levelNumber: level.levelNumber,
            isFirst: isFirst,
            isLast: isLast,
          );
        }

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
      LearningStepType.folder => ('FOLDER', AppIconName.folder),
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
              width: 3,
              color: isFirst ? Colors.transparent : AppColors.border,
            ),
          ),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isLocked ? AppColors.border : AppColors.primary,
              border: Border.all(color: AppColors.surface, width: 3),
            ),
          ),
          Expanded(
            child: Container(
              width: 3,
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
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
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
class _FolderStepTile extends StatelessWidget {
  const _FolderStepTile({
    required this.step,
    required this.levelNumber,
    required this.isFirst,
    required this.isLast,
  });

  final LearningStep step;
  final int levelNumber;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final sub = step.subMateri ?? const <LearningStep>[];

    // Use Stack to overlay timeline on the card without constraining card height
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Stack(
        children: [
          // Timeline - positioned absolutely, doesn't affect card layout
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: _buildTimeline(context),
          ),
          // Card content - offset to make room for timeline
          Padding(
            padding: const EdgeInsets.only(left: 32 + AppSpacing.sm),
            child: VoltCard(
              padding: EdgeInsets.zero,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: Material(
                  type: MaterialType.transparency,
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    childrenPadding: const EdgeInsets.only(
                      left: AppSpacing.md,
                      right: AppSpacing.md,
                      bottom: AppSpacing.md,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                      ),
                      child: const AppIcon(
                        AppIconName.folder,
                        size: AppIconSize.md,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    title: Text(
                      step.title,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      '${sub.length} materi • ${step.description}',
                      style: AppTypography.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    children: [
                      for (int i = 0; i < sub.length; i++)
                        _SubMateriTile(
                          step: sub[i],
                          levelNumber: levelNumber,
                          index: i + 1,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Column(
        children: <Widget>[
          // Top connector - fixed height matching header area (~24px)
          Container(
            width: 3,
            height: 24,
            color: isFirst ? Colors.transparent : AppColors.border,
          ),
          // Dot - centered in header area
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              border: Border.all(color: AppColors.surface, width: 3),
            ),
          ),
          // Bottom connector - expands to fill remaining space
          Expanded(
            child: Container(
              width: 3,
              color: isLast ? Colors.transparent : AppColors.border,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubMateriTile extends StatelessWidget {
  const _SubMateriTile({
    required this.step,
    required this.levelNumber,
    required this.index,
  });

  final LearningStep step;
  final int levelNumber;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: VoltCard(
        padding: EdgeInsets.zero,
        onTap: () {
          context.push(
            '${AppRoutes.materi}/detail/${step.id}?level=$levelNumber',
          );
        },
        child: ListTile(
          dense: true,
          leading: Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Text(
              '$index',
              style: AppTypography.caption.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          title: Text(
            step.title,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          subtitle: Text(
            step.estimatedTime ?? '5 menit',
            style: AppTypography.caption,
          ),
          trailing: const VoltChip(
            label: 'Mulai',
            status: VoltChipStatus.active,
          ),
        ),
      ),
    );
  }
}
