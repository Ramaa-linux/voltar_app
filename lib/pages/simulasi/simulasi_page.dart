import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/volt_feedback.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Satu project simulasi milik siswa. Data dummy sampai ada penyimpanan lokal.
class _Project {
  const _Project({
    required this.name,
    required this.createdAt,
    required this.icon,
  });

  final String name;
  final String createdAt;
  final AppIconName icon;
}

const List<_Project> _projects = <_Project>[
  _Project(
    name: 'Blink LED',
    createdAt: 'Dibuat 20 Okt 2026',
    icon: AppIconName.lightbulb,
  ),
  _Project(
    name: 'Sensor Suhu DHT22',
    createdAt: 'Dibuat 18 Okt 2026',
    icon: AppIconName.cpu,
  ),
  _Project(
    name: 'Lampu Otomatis LDR',
    createdAt: 'Dibuat 12 Okt 2026',
    icon: AppIconName.zap,
  ),
];

/// Dashboard simulasi: CTA project baru, daftar project, template populer.
///
/// Tanpa Scaffold/AppBar - AppShell yang menyediakan keduanya. Padding bawah
/// memakai [AppSpacing.navBarClearance] karena navbar mengambang di atas body.
class SimulasiPage extends StatelessWidget {
  const SimulasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.pagePadding,
          AppSpacing.xl,
          AppSpacing.pagePadding,
          AppSpacing.navBarClearance,
        ),
        children: <Widget>[
          Text('Simulasi', style: AppTypography.display),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Rancang dan uji sirkuit virtual tanpa risiko.',
            style: AppTypography.bodyMuted,
          ),
          const SizedBox(height: AppSpacing.xl),
          VoltButton(
            label: 'Buat Project Baru',
            icon: AppIconName.plus,
            fullWidth: true,
            onPressed: () => context.push(AppRoutes.simulasiEditor),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Project Saya', style: AppTypography.title),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${_projects.length} project tersimpan di perangkat ini.',
            style: AppTypography.bodyMuted,
          ),
          const SizedBox(height: AppSpacing.md),
          for (final _Project project in _projects)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _ProjectCard(
                project: project,
                onTap: () =>
                    context.push(AppRoutes.simulasiEditorFor(project.name)),
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          Text('Template Populer', style: AppTypography.title),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Rangkaian siap pakai untuk mulai cepat.',
            style: AppTypography.bodyMuted,
          ),
          const SizedBox(height: AppSpacing.md),
          _TemplateCard(
            title: 'Blink LED Dasar',
            caption: 'Arduino Uno • 1 LED • 1 resistor 220Ω',
            onTap: () => context.push(AppRoutes.simulasiTemplateBlink),
          ),
          const SizedBox(height: AppSpacing.md),
          _TemplateCard(
            title: 'Tombol & LED',
            caption: 'Arduino Uno • input digital',
            locked: true,
            onTap: () => showVoltSnackBar(
              context,
              'Template Tombol & LED tersedia di Fase 5.',
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.onTap});

  final _Project project;
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
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: AppIcon(
              project.icon,
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
                  project.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(project.createdAt, style: AppTypography.caption),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const AppIcon.chevronRight(
            size: AppIconSize.sm,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  const _TemplateCard({
    required this.title,
    required this.caption,
    required this.onTap,
    this.locked = false,
  });

  final String title;
  final String caption;
  final VoidCallback onTap;

  /// True = template belum bisa dibuka: tetap bisa ditekan (memunculkan
  /// SnackBar) dan ditandai chip "Segera".
  final bool locked;

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
            child: const AppIcon.lightbulb(
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
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          if (locked)
            const VoltChip(label: 'Segera', status: VoltChipStatus.locked)
          else
            const AppIcon.chevronRight(
              size: AppIconSize.sm,
              color: AppColors.textTertiary,
            ),
        ],
      ),
    );
  }
}
