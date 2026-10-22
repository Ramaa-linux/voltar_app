import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/volt_feedback.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

class _SettingsItem {
  const _SettingsItem({required this.icon, required this.label});

  final AppIconName icon;
  final String label;
}

const List<_SettingsItem> _settings = <_SettingsItem>[
  _SettingsItem(icon: AppIconName.pencil, label: 'Edit Profil'),
  _SettingsItem(icon: AppIconName.bell, label: 'Notifikasi'),
  _SettingsItem(icon: AppIconName.info, label: 'Tentang Aplikasi'),
];

/// Profil siswa: identitas + daftar pengaturan. Data masih dummy.
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

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
          Text('Profil', style: AppTypography.display),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'BS',
                    style: AppTypography.heading.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Budi Santoso', style: AppTypography.title),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'SMK Negeri 1 • XI TEL 2',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.md),
                const VoltChip(label: 'Siswa'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Pengaturan', style: AppTypography.title),
          const SizedBox(height: AppSpacing.md),
          VoltCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                for (int i = 0; i < _settings.length; i++) ...<Widget>[
                  if (i > 0) const Divider(indent: AppSpacing.lg),
                  _SettingsRow(
                    item: _settings[i],
                    onTap: () => showVoltSnackBar(
                      context,
                      '${_settings[i].label} aktif di Fase 4.',
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'VoltAR v1.0.0 • Fase 4 (data contoh)',
            style: AppTypography.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.item, required this.onTap});

  final _SettingsItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(AppRadius.card);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppSpacing.minTouchTarget + AppSpacing.sm,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                  child: AppIcon(
                    item.icon,
                    size: AppIconSize.sm,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(item.label, style: AppTypography.body),
                ),
                const AppIcon.chevronRight(
                  size: AppIconSize.sm,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
