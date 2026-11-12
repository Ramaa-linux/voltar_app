import 'package:flutter/material.dart';
import 'package:voltar/pages/materi/detail/praktik/resistor_calculator.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

/// Menampilkan Kalkulator Resistor ([ResistorCalculator]) sebagai modal bottom sheet.
Future<void> showResistorCalculator(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext ctx) => const ResistorCalculatorSheet(),
  );
}

/// Pembungkus [ResistorCalculator] untuk ditampilkan di dalam bottom sheet.
///
/// Karena [ResistorCalculator] sudah memiliki judul internal ("Kalkulator Kode Warna Resistor")
/// dan `SingleChildScrollView`, sheet ini menyediakan drag handle, tombol tutup,
/// dan latar [AppColors.background] agar `VoltCard` di dalamnya terlihat kontras.
class ResistorCalculatorSheet extends StatelessWidget {
  const ResistorCalculatorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.card),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderStrong,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
            // Baris aksi tutup (tanpa menggandakan judul yang sudah ada di dalam ResistorCalculator)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.xs,
                AppSpacing.sm,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Alat Bantu Cepat',
                    style: AppTypography.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Tutup',
                  ),
                ],
              ),
            ),
            const Flexible(child: ResistorCalculator()),
          ],
        ),
      ),
    );
  }
}
