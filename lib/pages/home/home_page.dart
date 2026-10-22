import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_gradients.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/volt_feedback.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Beranda: sapaan, ringkasan progress, lanjutkan belajar, tantangan harian.
///
/// Tanpa Scaffold/AppBar - AppShell yang menyediakan keduanya. Padding bawah
/// memakai [AppSpacing.navBarClearance] karena navbar mengambang di atas body.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              Text('Tantangan', style: AppTypography.title),
              const SizedBox(height: AppSpacing.md),
              _DailyChallengeCard(
                onTap: () => showVoltSnackBar(
                  context,
                  'Tantangan harian dibuka di Fase 4.',
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    // Gradient ikut menutup status bar agar tidak ada garis putih di atas.
    final double topInset = MediaQuery.paddingOf(context).top;

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
                Text('Halo, Budi!', style: AppTypography.display),
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
            ),
            child: Text(
              'B',
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

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return VoltCard(
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
              // Angka besar: satu-satunya elemen 28pt di kartu.
              Text(
                '48%',
                style: AppTypography.display.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: const LinearProgressIndicator(
              value: 0.48,
              minHeight: 8,
              backgroundColor: AppColors.primaryLight,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('12 dari 25 materi selesai', style: AppTypography.caption),
          const SizedBox(height: AppSpacing.lg),
          const Divider(),
          const SizedBox(height: AppSpacing.md),
          const Row(
            children: <Widget>[
              Expanded(
                child: _ProgressStat(
                  icon: AppIconName.zap,
                  iconColor: AppColors.accent,
                  value: '5 hari',
                  label: 'Streak',
                ),
              ),
              Expanded(
                child: _ProgressStat(
                  icon: AppIconName.lightbulb,
                  iconColor: AppColors.accent,
                  value: '240',
                  label: 'Koin',
                ),
              ),
              Expanded(
                child: _ProgressStat(
                  icon: AppIconName.bookOpen,
                  iconColor: AppColors.primaryDark,
                  value: '12',
                  label: 'Modul',
                ),
              ),
            ],
          ),
        ],
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


class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard();

  @override
  Widget build(BuildContext context) {
    return VoltCard(
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
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                ),
                child: const AppIcon.lightbulb(
                  size: AppIconSize.lg,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Dasar LED', style: AppTypography.title),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Modul 3 • 4 dari 6 materi',
                      style: AppTypography.bodyMuted,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const VoltChip(label: 'Aktif'),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: const LinearProgressIndicator(
              value: 0.66,
              minHeight: 6,
              backgroundColor: AppColors.primaryLight,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          VoltButton(
            label: 'Lanjutkan',
            fullWidth: true,
            onPressed: () => showVoltSnackBar(
              context,
              'Materi Dasar LED dibuka di Fase 4.',
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyChallengeCard extends StatelessWidget {
  const _DailyChallengeCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return VoltCard(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: const AppIcon.zap(color: AppColors.accent),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tantangan Harian',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Rangkai LED + resistor 220Ω',
                  style: AppTypography.bodyMuted,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const VoltChip(label: '50 XP'),
        ],
      ),
    );
  }
}

