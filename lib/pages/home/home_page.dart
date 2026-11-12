import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/pages/alat/ohm_calculator_sheet.dart';
import 'package:voltar/pages/alat/resistor_calculator_sheet.dart';
import 'package:voltar/repositories/progress_repository.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_gradients.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/spark_progress_bar.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Beranda: sapaan, ringkasan progress, lanjutkan belajar, mini-game.
///
/// Tanpa Scaffold/AppBar - AppShell yang menyediakan keduanya. Padding bawah
/// memakai [AppSpacing.navBarClearance] karena navbar mengambang di atas body.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(homeProgressSummaryProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.navBarClearance),
      children: <Widget>[
        const _HomeHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pagePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: AppSpacing.xl),
              const _ProgressCard(),
              const SizedBox(height: AppSpacing.xl),
              Text('Lanjutkan Belajar', style: AppTypography.title),
              const SizedBox(height: AppSpacing.md),
              const _ContinueLearningCard(),
              const SizedBox(height: AppSpacing.xl),
              Text('Pintasan Cepat', style: AppTypography.title),
              const SizedBox(height: AppSpacing.md),
              const _QuickShortcutsSection(),
              const SizedBox(height: AppSpacing.xl),
              Text('Mini-Game', style: AppTypography.title),
              const SizedBox(height: AppSpacing.md),
              _CircuitRushCard(
                onTap: () => context.push(AppRoutes.circuitRush),
              ),
              const SizedBox(height: AppSpacing.md),
              _CableConnectCard(
                onTap: () => context.push(AppRoutes.cableConnect),
              ),
              const SizedBox(height: AppSpacing.md),
              _GuessComponentCard(
                onTap: () => context.push(AppRoutes.guessComponent),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ],
    );
  }
}

/// Mengekstrak nama depan dari nama lengkap. Jika kosong/null, mengembalikan `'Siswa'`.
String firstNameFromFullName(String? name) {
  final String clean = (name ?? '').trim();
  if (clean.isEmpty) {
    return 'Siswa';
  }
  final List<String> parts = clean
      .split(RegExp(r'\s+'))
      .where((String s) => s.isNotEmpty)
      .toList();
  if (parts.isEmpty) {
    return 'Siswa';
  }
  return parts.first;
}

class _HomeHeader extends ConsumerWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Gradient ikut menutup status bar agar tidak ada garis putih di atas.
    final double topInset = MediaQuery.paddingOf(context).top;
    final AsyncValue<Map<String, dynamic>?> profileAsync = ref.watch(
      userProfileProvider,
    );
    final Map<String, dynamic>? data = profileAsync.value;
    final String? rawName = data?['name'] as String?;
    final String? photoUrl = (data?['photoUrl'] as String?)?.trim();
    final String firstName = firstNameFromFullName(rawName);
    final String avatarInitial = firstName.isNotEmpty
        ? firstName.substring(0, 1).toUpperCase()
        : 'S';
    final bool hasPhoto = photoUrl != null && photoUrl.isNotEmpty;

    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.header),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        topInset + AppSpacing.xl,
        AppSpacing.pagePadding,
        AppSpacing.xl,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Halo, $firstName!', style: AppTypography.display),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Siap belajar elektronika hari ini?',
                  style: AppTypography.bodyMuted,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: AppBorders.standard,
              image: hasPhoto
                  ? DecorationImage(
                      image: NetworkImage(photoUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: hasPhoto
                ? null
                : Text(
                    avatarInitial,
                    style: AppTypography.heading.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ProgressPercentText extends ConsumerWidget {
  const _ProgressPercentText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int percentLabel = ref.watch(
      homeProgressSummaryProvider.select(
        (asyncVal) => asyncVal.value?.percentLabel ?? 0,
      ),
    );
    return Text(
      '$percentLabel%',
      style: AppTypography.display.copyWith(color: AppColors.primaryDark),
    );
  }
}

class _ProgressBar extends ConsumerWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double overallPercent = ref.watch(
      homeProgressSummaryProvider.select(
        (asyncVal) => asyncVal.value?.overallPercent ?? 0.0,
      ),
    );
    final double progressValue = (overallPercent / 100.0).clamp(0.0, 1.0);
    return SparkProgressBar(
      value: progressValue.isNaN ? 0.0 : progressValue,
      height: 8,
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.primary,
    );
  }
}

class _ProgressCaption extends ConsumerWidget {
  const _ProgressCaption();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ({int completed, int total}) counts = ref.watch(
      homeProgressSummaryProvider.select(
        (asyncVal) => (
          completed: asyncVal.value?.completedCount ?? 0,
          total: asyncVal.value?.totalSteps ?? 0,
        ),
      ),
    );
    return Text(
      '${counts.completed} dari ${counts.total} materi selesai',
      style: AppTypography.caption,
    );
  }
}

class _ProgressStreakStat extends ConsumerWidget {
  const _ProgressStreakStat();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int streakDays = ref.watch(
      homeProgressSummaryProvider.select(
        (asyncVal) => asyncVal.value?.streakDays ?? 0,
      ),
    );
    return Semantics(
      label: 'Streak $streakDays hari',
      child: _ProgressStat(
        icon: AppIconName.zap,
        iconColor: AppColors.accent,
        value: '$streakDays hari',
        label: 'Streak',
      ),
    );
  }
}

class _ProgressCoinsStat extends ConsumerWidget {
  const _ProgressCoinsStat();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int coins = ref.watch(
      homeProgressSummaryProvider.select(
        (asyncVal) => asyncVal.value?.coins ?? 240,
      ),
    );
    return Semantics(
      label: '$coins Koin',
      child: _ProgressStat(
        icon: AppIconName.lightbulb,
        iconColor: AppColors.accent,
        value: '$coins',
        label: 'Koin',
      ),
    );
  }
}

class _ProgressModuleStat extends ConsumerWidget {
  const _ProgressModuleStat();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int completedCount = ref.watch(
      homeProgressSummaryProvider.select(
        (asyncVal) => asyncVal.value?.completedCount ?? 0,
      ),
    );
    return Semantics(
      label: '$completedCount Modul selesai',
      child: _ProgressStat(
        icon: AppIconName.bookOpen,
        iconColor: AppColors.primaryDark,
        value: '$completedCount',
        label: 'Modul',
      ),
    );
  }
}

class _ProgressCard extends ConsumerWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ({int percentLabel, int completedCount, int totalSteps}) sem = ref
        .watch(
          homeProgressSummaryProvider.select(
            (asyncVal) => (
              percentLabel: asyncVal.value?.percentLabel ?? 0,
              completedCount: asyncVal.value?.completedCount ?? 0,
              totalSteps: asyncVal.value?.totalSteps ?? 0,
            ),
          ),
        );

    return Semantics(
      label:
          'Progres belajar ${sem.percentLabel} persen, ${sem.completedCount} dari ${sem.totalSteps} materi selesai',
      child: VoltCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'PROGRESS BELAJAR',
                        style: AppTypography.overline.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text('Dasar Elektronika', style: AppTypography.title),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                const _ProgressPercentText(),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const _ProgressBar(),
            const SizedBox(height: AppSpacing.sm),
            const _ProgressCaption(),
            const SizedBox(height: AppSpacing.lg),
            const Divider(),
            const SizedBox(height: AppSpacing.md),
            const Row(
              children: <Widget>[
                Expanded(child: _ProgressStreakStat()),
                Expanded(child: _ProgressCoinsStat()),
                Expanded(child: _ProgressModuleStat()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressStat extends StatelessWidget {
  const _ProgressStat({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final AppIconName icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppIcon(icon, size: AppIconSize.sm, color: iconColor),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.body.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _ContinueLearningCard extends ConsumerWidget {
  const _ContinueLearningCard();

  void _handleNavigate(
    BuildContext context, {
    required String? nextStepId,
    required LearningStepType? nextStepType,
    required bool allCompleted,
  }) {
    if (allCompleted || nextStepId == null) {
      context.go(AppRoutes.materi);
      return;
    }

    if (nextStepType == LearningStepType.pretest ||
        nextStepType == LearningStepType.posttest) {
      context.push('/materi/kuis/$nextStepId');
    } else {
      context.push('/materi/detail/$nextStepId');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(
      homeProgressSummaryProvider.select(
        (asyncVal) => asyncVal.value ?? HomeProgressSummary.empty,
      ),
    );

    final bool allCompleted = summary.allCompleted;
    final String title = allCompleted
        ? 'Semua materi selesai 🎉'
        : (summary.nextStepTitle ?? 'Lanjutkan belajar');

    final String subtitle;
    if (allCompleted) {
      subtitle = 'Level ${summary.currentLevel} • Semua modul tuntas';
    } else if (summary.completedCount == 0) {
      subtitle = 'Level ${summary.currentLevel} • Mulai Belajar';
    } else if (summary.nextStepLevel != null &&
        summary.nextStepLevelTotal > 0) {
      subtitle =
          'Level ${summary.currentLevel} • ${summary.nextStepLevelCompleted} dari ${summary.nextStepLevelTotal} materi';
    } else {
      subtitle = 'Level ${summary.currentLevel} • Materi berikutnya';
    }

    final String chipLabel = allCompleted
        ? 'Selesai'
        : 'Level ${summary.currentLevel}';
    final String buttonLabel = allCompleted
        ? 'Jelajahi Materi'
        : (summary.completedCount == 0 ? 'Mulai Belajar' : 'Lanjutkan');

    final double barValue = allCompleted
        ? 1.0
        : (summary.nextStepLevelTotal > 0
              ? (summary.nextStepLevelCompleted / summary.nextStepLevelTotal)
                    .clamp(0.0, 1.0)
              : (summary.overallPercent / 100.0).clamp(0.0, 1.0));

    return Semantics(
      label: 'Lanjutkan belajar: $title',
      child: VoltCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: allCompleted
                        ? AppColors.accentLight
                        : AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                  ),
                  child: allCompleted
                      ? const AppIcon.bookOpen(
                          size: AppIconSize.lg,
                          color: AppColors.primaryDark,
                        )
                      : (summary.nextStepType == LearningStepType.pretest ||
                                summary.nextStepType ==
                                    LearningStepType.posttest
                            ? const AppIcon.helpCircle(
                                size: AppIconSize.lg,
                                color: AppColors.primaryDark,
                              )
                            : const AppIcon.lightbulb(
                                size: AppIconSize.lg,
                                color: AppColors.primaryDark,
                              )),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: AppTypography.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle,
                        style: AppTypography.bodyMuted,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                VoltChip(label: chipLabel),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SparkProgressBar(
              value: barValue.isNaN ? 0.0 : barValue,
              height: 6,
              backgroundColor: AppColors.primaryLight,
              foregroundColor: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.lg),
            VoltButton(
              label: buttonLabel,
              fullWidth: true,
              onPressed: () => _handleNavigate(
                context,
                nextStepId: summary.nextStepId,
                nextStepType: summary.nextStepType,
                allCompleted: allCompleted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircuitRushCard extends StatelessWidget {
  const _CircuitRushCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return VoltCard(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: const AppIcon.zap(
              size: AppIconSize.lg,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sirkuit Kilat',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Pandu elektron melewati rintangan resistor!',
                  style: AppTypography.bodyMuted,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const VoltChip(label: 'Main'),
        ],
      ),
    );
  }
}

class _CableConnectCard extends StatelessWidget {
  const _CableConnectCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return VoltCard(
      onTap: onTap,
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
            child: const AppIcon.cpu(
              size: AppIconSize.lg,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sambung Kabel',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Rangkai jalur kabel tertutup melewati komponen!',
                  style: AppTypography.bodyMuted,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const VoltChip(label: 'Main'),
        ],
      ),
    );
  }
}

class _GuessComponentCard extends StatelessWidget {
  const _GuessComponentCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return VoltCard(
      onTap: onTap,
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
            child: const AppIcon.helpCircle(
              size: AppIconSize.lg,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tebak Komponen',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Tebak komponen & baca gelang warna resistor!',
                  style: AppTypography.bodyMuted,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const VoltChip(label: 'Main'),
        ],
      ),
    );
  }
}

class _QuickShortcutsSection extends StatelessWidget {
  const _QuickShortcutsSection();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: _QuickShortcutCard(
              semanticsLabel: 'Buka Kalkulator Resistor',
              title: 'Kalkulator Resistor',
              subtitle: 'Baca warna gelang',
              icon: const AppIcon.zap(
                size: AppIconSize.lg,
                color: AppColors.primaryDark,
              ),
              onTap: () => showResistorCalculator(context),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _QuickShortcutCard(
              semanticsLabel: 'Buka Kalkulator Hukum Ohm',
              title: 'Kalkulator Ohm',
              subtitle: 'Hitung V, I, R',
              icon: const Icon(
                Icons.calculate_outlined,
                size: AppIconSize.lg,
                color: AppColors.primaryDark,
              ),
              onTap: () => showOhmCalculator(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickShortcutCard extends StatelessWidget {
  const _QuickShortcutCard({
    required this.semanticsLabel,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String semanticsLabel;
  final String title;
  final String subtitle;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: VoltCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.input),
              ),
              child: icon,
            ),
            const SizedBox(height: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
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
