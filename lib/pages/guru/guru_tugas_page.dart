import 'package:flutter/material.dart';

import '../../shell/guru_shell.dart';
import '../../theme/app_borders.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/press_scale.dart';
import '../../widgets/volt_button.dart';
import '../../utils/localization_helper.dart';
import 'data/guru_dummy_data.dart';

/// Halaman Daftar Tugas Guru.
class GuruTugasPage extends StatefulWidget {
  const GuruTugasPage({super.key});

  @override
  State<GuruTugasPage> createState() => _GuruTugasPageState();
}

class _GuruTugasPageState extends State<GuruTugasPage> {
  int _selectedFilter = 0; // 0: Semua, 1: Aktif, 2: Selesai

  List<TugasDummy> get _filteredTugas {
    switch (_selectedFilter) {
      case 1:
        return dummyTugasList.where((TugasDummy t) => t.status == StatusTugas.aktif).toList();
      case 2:
        return dummyTugasList.where((TugasDummy t) => t.status == StatusTugas.selesai).toList();
      default:
        return dummyTugasList;
    }
  }

  String _formatTanggal(BuildContext context, DateTime date) {
    final List<String> bulan = <String>[
      context.t('monthJan'),
      context.t('monthFeb'),
      context.t('monthMar'),
      context.t('monthApr'),
      context.t('monthMei'),
      context.t('monthJun'),
      context.t('monthJul'),
      context.t('monthAgu'),
      context.t('monthSep'),
      context.t('monthOkt'),
      context.t('monthNov'),
      context.t('monthDes'),
    ];
    return '${date.day} ${bulan[date.month - 1]} ${date.year}';
  }

  void _onBuatTugas(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.t('guruKelasComingSoon')),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onTapTugas(BuildContext context, TugasDummy tugas) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.t('guruTugasDetailSnack', args: [tugas.judul])),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.xl,
                AppSpacing.pagePadding,
                AppSpacing.lg,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(context.t('guruTugasTitle'), style: AppTypography.heading.copyWith(fontWeight: FontWeight.w800)),
                        const SizedBox(height: AppSpacing.xs),
                        Text(context.t('guruTugasCount', args: [_filteredTugas.length]), style: AppTypography.bodyMuted),
                      ],
                    ),
                  ),
                  VoltButton(label: context.t('guruTugasCreate'), onPressed: () => _onBuatTugas(context), variant: VoltButtonVariant.primary),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
              child: Row(
                children: <Widget>[
                  _FilterChip(label: context.t('guruTugasFilterAll'), selected: _selectedFilter == 0, onTap: () => setState(() => _selectedFilter = 0)),
                  const SizedBox(width: AppSpacing.sm),
                  _FilterChip(label: context.t('guruTugasFilterActive'), selected: _selectedFilter == 1, onTap: () => setState(() => _selectedFilter = 1)),
                  const SizedBox(width: AppSpacing.sm),
                  _FilterChip(label: context.t('guruTugasFilterCompleted'), selected: _selectedFilter == 2, onTap: () => setState(() => _selectedFilter = 2)),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
            sliver: SliverList.separated(
              itemCount: _filteredTugas.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (BuildContext context, int index) {
                final TugasDummy tugas = _filteredTugas[index];
                return _TugasCard(tugas: tugas, onTap: () => _onTapTugas(context, tugas), formatTanggal: (date) => _formatTanggal(context, date));
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: GuruShell.bottomInset)),
        ],
      ),
    );
  }
}
/// Chip filter tab.
class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: AppBorders.standard,
        ),
        child: Text(
          label,
          style: AppTypography.label.copyWith(
            color: selected ? AppColors.textOnPrimary : AppColors.textSecondary,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

/// Kartu tugas individual.
class _TugasCard extends StatelessWidget {
  const _TugasCard({required this.tugas, required this.onTap, required this.formatTanggal});
  final TugasDummy tugas;
  final VoidCallback onTap;
  final String Function(DateTime) formatTanggal;

  @override
  Widget build(BuildContext context) {
    final bool isAktif = tugas.status == StatusTugas.aktif;
    return PressScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: AppBorders.standard,
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text(tugas.judul, style: AppTypography.title.copyWith(fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: isAktif ? AppColors.successLight : AppColors.accentLight,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(isAktif ? context.t('guruTugasStatusActive') : context.t('guruTugasStatusCompleted'), style: AppTypography.caption.copyWith(color: isAktif ? AppColors.success : AppColors.accent, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(children: <Widget>[const AppIcon(AppIconName.bell, size: 16, color: AppColors.textTertiary), const SizedBox(width: AppSpacing.xs), Text(context.t('guruTugasDeadline', args: [formatTanggal(tugas.deadline)]), style: AppTypography.bodyMuted)]),
          ],
        ),
      ),
    );
  }
}