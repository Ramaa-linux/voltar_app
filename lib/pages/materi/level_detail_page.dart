import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/models/step_status.dart';
import 'package:voltar/pages/materi/materi_page.dart';
import 'package:voltar/repositories/progress_repository.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/step_icon_resolver.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
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
    final AsyncValue<List<LevelModel>> allLevelsAsync =
        ref.watch(levelsProvider);
    final Set<String> completedIds =
        ref.watch(completedStepsProvider).value ?? const <String>{};

    // Guard: cek apakah level terbuka. Jika data level belum dimuat,
    // anggap unlocked agar tidak flash guard sebelum data tersedia.
    final bool isUnlocked = allLevelsAsync.whenOrNull(
          data: (levels) => ProgressRepository.checkLevelUnlocked(
            levelNumber: levelNumber,
            completedSteps: completedIds,
            levels: levels,
          ),
        ) ??
        true;

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
      body: !isUnlocked
          ? _LockedLevelGuardView(levelNumber: levelNumber)
          : levelAsync.when(
              data: (level) => _LevelJourneyView(
                level: level,
                completedIds: completedIds,
                onStepReturn: () => ref.invalidate(completedStepsProvider),
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

/// Tampilan guard saat level terkunci (deep link / direct nav).
class _LockedLevelGuardView extends StatelessWidget {
  const _LockedLevelGuardView({required this.levelNumber});

  final int levelNumber;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 2),
              ),
              child: const AppIcon.lock(
                size: AppIconSize.lg,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Level Terkunci',
              style: AppTypography.title.copyWith(fontSize: 18),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Selesaikan Level sebelumnya terlebih dahulu',
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            VoltButton(
              label: 'Kembali ke Pilih Level',
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutes.materi);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelJourneyView extends StatelessWidget {
  const _LevelJourneyView({
    required this.level,
    required this.completedIds,
    required this.onStepReturn,
  });

  final LevelModel level;
  final Set<String> completedIds;
  final VoidCallback onStepReturn;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      itemCount: level.steps.length,
      itemBuilder: (context, index) {
        final step = level.steps[index];
        final isFirst = index == 0;
        final isLast = index == level.steps.length - 1;
        final StepStatus stepStatus = resolveStepStatus(
          step,
          level.steps,
          completedIds,
        );

        if (step.type == LearningStepType.folder) {
          return _FolderStepTile(
            step: step,
            allSteps: level.steps,
            completedIds: completedIds,
            stepStatus: stepStatus,
            levelNumber: level.levelNumber,
            isFirst: isFirst,
            isLast: isLast,
            onStepReturn: onStepReturn,
          );
        }

        return _StepTile(
          step: step,
          levelNumber: level.levelNumber,
          isFirst: isFirst,
          isLast: isLast,
          stepStatus: stepStatus,
          onStepReturn: onStepReturn,
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
    required this.stepStatus,
    required this.onStepReturn,
  });

  final LearningStep step;
  final int levelNumber;
  final bool isFirst;
  final bool isLast;
  final StepStatus stepStatus;
  final VoidCallback onStepReturn;

  bool get _isLocked => stepStatus == StepStatus.locked;
  bool get _isCompleted => stepStatus == StepStatus.completed;

  @override
  Widget build(BuildContext context) {
    final String badgeText = switch (step.type) {
      LearningStepType.pretest => 'PRE-TEST',
      LearningStepType.materi => 'MATERI',
      LearningStepType.posttest => 'POST-TEST',
      LearningStepType.folder => 'FOLDER',
    };

    final (String chipLabel, VoltChipStatus status) = switch (stepStatus) {
      StepStatus.completed => ('Selesai', VoltChipStatus.done),
      StepStatus.unlocked => ('Mulai', VoltChipStatus.active),
      StepStatus.locked => ('Terkunci', VoltChipStatus.locked),
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTimeline(context),
          const SizedBox(width: AppSpacing.sm),
          _buildCard(context, badgeText, chipLabel, status),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final Color dotColor = _isCompleted
        ? AppColors.success
        : (_isLocked ? AppColors.border : AppColors.primary);

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
              color: dotColor,
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
    String chipLabel,
    VoltChipStatus status,
  ) {
    final Color iconBoxColor = _isLocked
        ? AppColors.background
        : (_isCompleted ? AppColors.successLight : AppColors.primaryLight);
    final Color iconColor =
        _isCompleted ? AppColors.success : AppColors.primaryDark;
    final Color badgeColor = _isLocked
        ? AppColors.textTertiary
        : (_isCompleted ? AppColors.success : AppColors.primaryDark);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: VoltCard(
          onTap: _isLocked
              ? null
              : () async {
                  if (step.type == LearningStepType.materi) {
                    await context.push(
                      '${AppRoutes.materi}/detail/${step.id}?level=$levelNumber',
                    );
                  } else {
                    await context.push('${AppRoutes.materi}/kuis/${step.id}');
                  }
                  onStepReturn();
                },
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBoxColor,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                ),
                child: _isLocked
                    ? const AppIcon.lock(
                        size: AppIconSize.md,
                        color: AppColors.textTertiary,
                      )
                    : StepIcon(
                        step: step,
                        size: AppIconSize.md,
                        color: iconColor,
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
                            color: badgeColor,
                          ),
                        ),
                        const Spacer(),
                        VoltChip(
                          label: chipLabel,
                          status: status,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      step.title,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _isLocked
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
    required this.allSteps,
    required this.completedIds,
    required this.stepStatus,
    required this.levelNumber,
    required this.isFirst,
    required this.isLast,
    required this.onStepReturn,
  });

  final LearningStep step;
  final List<LearningStep> allSteps;
  final Set<String> completedIds;
  final StepStatus stepStatus;
  final int levelNumber;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onStepReturn;

  bool get _isLocked => stepStatus == StepStatus.locked;
  bool get _isCompleted => stepStatus == StepStatus.completed;

  @override
  Widget build(BuildContext context) {
    final sub = step.subMateri ?? const <LearningStep>[];
    final Color iconBoxColor = _isLocked
        ? AppColors.background
        : (_isCompleted ? AppColors.successLight : AppColors.primaryLight);
    final Color iconColor = _isLocked
        ? AppColors.textTertiary
        : (_isCompleted ? AppColors.success : AppColors.primaryDark);

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
                        color: iconBoxColor,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                      ),
                      child: AppIcon(
                        AppIconName.folder,
                        size: AppIconSize.md,
                        color: iconColor,
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
                          stepStatus: resolveStepStatus(
                            sub[i],
                            allSteps,
                            completedIds,
                          ),
                          levelNumber: levelNumber,
                          index: i + 1,
                          onStepReturn: onStepReturn,
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
    final Color dotColor = _isCompleted
        ? AppColors.success
        : (_isLocked ? AppColors.border : AppColors.primary);

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
              color: dotColor,
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
    required this.stepStatus,
    required this.levelNumber,
    required this.index,
    required this.onStepReturn,
  });

  final LearningStep step;
  final StepStatus stepStatus;
  final int levelNumber;
  final int index;
  final VoidCallback onStepReturn;

  bool get _isLocked => stepStatus == StepStatus.locked;
  bool get _isCompleted => stepStatus == StepStatus.completed;

  @override
  Widget build(BuildContext context) {
    final (String chipLabel, VoltChipStatus status) = switch (stepStatus) {
      StepStatus.completed => ('Selesai', VoltChipStatus.done),
      StepStatus.unlocked => ('Mulai', VoltChipStatus.active),
      StepStatus.locked => ('Terkunci', VoltChipStatus.locked),
    };

    final Color iconBoxColor = _isLocked
        ? AppColors.background
        : (_isCompleted ? AppColors.successLight : AppColors.primaryLight);
    final Color iconColor =
        _isCompleted ? AppColors.success : AppColors.primaryDark;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: VoltCard(
        padding: EdgeInsets.zero,
        onTap: _isLocked
            ? null
            : () async {
                await context.push(
                  '${AppRoutes.materi}/detail/${step.id}?level=$levelNumber',
                );
                onStepReturn();
              },
        child: ListTile(
          dense: true,
          leading: Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBoxColor,
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: _isLocked
                ? const AppIcon.lock(
                    size: AppIconSize.sm,
                    color: AppColors.textTertiary,
                  )
                : StepIcon(
                    step: step,
                    size: AppIconSize.sm,
                    color: iconColor,
                  ),
          ),
          title: Text(
            step.title,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: _isLocked
                  ? AppColors.textSecondary
                  : AppColors.textPrimary,
            ),
          ),
          subtitle: Text(
            step.estimatedTime ?? '5 menit',
            style: AppTypography.caption,
          ),
          trailing: VoltChip(
            label: chipLabel,
            status: status,
          ),
        ),
      ),
    );
  }
}
