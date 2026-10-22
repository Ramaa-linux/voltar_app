import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/volt_feedback.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_card.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Satu materi pada daftar. Data masih dummy (Fase 3) - belum ada backend.
class _MateriItem {
  const _MateriItem({
    required this.title,
    required this.caption,
    required this.status,
    this.hint,
  });

  final String title;
  final String caption;
  final VoltChipStatus status;

  /// Keterangan tambahan; hanya ditampilkan untuk materi selesai.
  final String? hint;
}

class _MateriLevel {
  const _MateriLevel({required this.title, required this.items});

  final String title;
  final List<_MateriItem> items;
}

const List<_MateriLevel> _levels = <_MateriLevel>[
  _MateriLevel(
    title: 'Dasar Elektronika',
    items: <_MateriItem>[
      _MateriItem(
        title: 'Pengenalan Komponen',
        caption: '6 materi • 20 menit',
        status: VoltChipStatus.done,
        hint: 'Selesai 18 Okt',
      ),
      _MateriItem(
        title: 'Hukum Ohm',
        caption: '5 materi • 25 menit',
        status: VoltChipStatus.done,
        hint: 'Selesai 20 Okt',
      ),
      _MateriItem(
        title: 'Rangkaian Seri & Paralel',
        caption: '4 materi • 15 menit',
        status: VoltChipStatus.active,
      ),
    ],
  ),
  _MateriLevel(
    title: 'Arduino & Sensor',
    items: <_MateriItem>[
      _MateriItem(
        title: 'Dasar Arduino',
        caption: '7 materi • 30 menit',
        status: VoltChipStatus.locked,
      ),
      _MateriItem(
        title: 'Input Digital',
        caption: '5 materi • 25 menit',
        status: VoltChipStatus.locked,
      ),
    ],
  ),
  _MateriLevel(
    title: 'Proyek Akhir',
    items: <_MateriItem>[
      _MateriItem(
        title: 'Lampu Otomatis',
        caption: '3 materi • 40 menit',
        status: VoltChipStatus.locked,
      ),
    ],
  ),
];

/// Daftar materi: header ringkas + section per level, tiap materi satu kartu.
class MateriPage extends StatelessWidget {
  const MateriPage({super.key});

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
          Text('Materi', style: AppTypography.display),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Belajar bertahap, dari komponen dasar sampai Arduino.',
            style: AppTypography.bodyMuted,
          ),
          for (int i = 0; i < _levels.length; i++)
            _LevelSection(index: i, level: _levels[i]),
        ],
      ),
    );
  }
}

class _LevelSection extends StatelessWidget {
  const _LevelSection({required this.index, required this.level});

  final int index;
  final _MateriLevel level;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: AppSpacing.xl),
        Text(
          'LEVEL ${index + 1}',
          style: AppTypography.overline.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(level.title, style: AppTypography.title),
        const SizedBox(height: AppSpacing.md),
        for (final _MateriItem item in level.items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _MateriCard(item: item),
          ),
      ],
    );
  }
}


class _MateriCard extends StatelessWidget {
  const _MateriCard({required this.item});

  final _MateriItem item;

  @override
  Widget build(BuildContext context) {
    final bool locked = item.status == VoltChipStatus.locked;
    final (Color background, Color foreground) = switch (item.status) {
      VoltChipStatus.done => (AppColors.successLight, AppColors.success),
      VoltChipStatus.active => (
        AppColors.primaryLight,
        AppColors.primaryDark,
      ),
      VoltChipStatus.locked => (AppColors.surface, AppColors.textTertiary),
    };

    return VoltCard(
      // Materi terkunci belum bisa dibuka: tanpa onTap = tanpa ripple & scale.
      onTap: locked
          ? null
          : () => showVoltSnackBar(
              context,
              '${item.title} dibuka di Fase 4.',
            ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: AppIcon.bookOpen(
              size: AppIconSize.lg,
              color: foreground,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: locked
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(item.hint ?? item.caption, style: AppTypography.caption),
                const SizedBox(height: AppSpacing.sm),
                VoltChip(
                  label: switch (item.status) {
                    VoltChipStatus.done => 'Selesai',
                    VoltChipStatus.active => 'Lanjutkan',
                    VoltChipStatus.locked => 'Terkunci',
                  },
                  status: item.status,
                ),
              ],
            ),
          ),
          if (!locked) ...<Widget>[
            const SizedBox(width: AppSpacing.sm),
            const AppIcon.chevronRight(
              size: AppIconSize.sm,
              color: AppColors.textTertiary,
            ),
          ],
        ],
      ),
    );
  }
}

