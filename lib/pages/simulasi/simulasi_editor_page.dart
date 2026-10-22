import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/volt_feedback.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/dashed_border_box.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Editor simulasi: layar penuh dengan Scaffold + AppBar sendiri.
///
/// Route ini berada di atas AppShell (`parentNavigatorKey` root), jadi
/// VoltFloatingNavBar tidak tampil dan halaman wajib menyediakan tombol
/// kembali sendiri. Canvas masih placeholder - WebView Wokwi masuk di Fase 5.
class SimulasiEditorPage extends StatelessWidget {
  const SimulasiEditorPage({
    super.key,
    required this.projectName,
    this.isTemplate = false,
  });

  /// Judul default saat project dibuat dari tombol "Buat Project Baru".
  static const String defaultProjectName = 'Project Baru';

  final String projectName;

  /// True bila halaman dibuka dari salah satu template bawaan.
  final bool isTemplate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const AppIcon.arrowLeft(color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(projectName, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: TextButton(
              onPressed: () => showVoltSnackBar(
                context,
                'Penyimpanan project tersedia di Fase 5.',
              ),
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    isTemplate ? 'Template bawaan' : 'Project baru',
                    style: AppTypography.label,
                  ),
                  const Spacer(),
                  VoltChip(label: isTemplate ? 'Template' : 'Draft'),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: DashedBorderBox(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const AppIcon.cpu(
                          size: AppIconSize.lg,
                          color: AppColors.primaryDark,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Area WebView Wokwi akan dimuat di sini (Fase 5).',
                          style: AppTypography.bodyMuted,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
