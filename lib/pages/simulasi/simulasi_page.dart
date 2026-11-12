import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Halaman tab Simulasi — pintu masuk menuju Simulator Velxio.
///
/// Tanpa Scaffold/AppBar - AppShell yang menyediakan keduanya. Padding bawah
/// memakai [AppSpacing.navBarClearance] karena navbar mengambang di atas body.
class SimulasiPage extends StatelessWidget {
  const SimulasiPage({super.key});

  static const String _blankProjectUrl = 'https://velxio.dev';
  static const String _ledBlinkerUrl =
      'https://velxio.dev/ramaa-linux/arduino-uno';
  static const String _trafficLightUrl =
      'https://velxio.dev/ramaa-linux/4-way-traffic-light/';

  void _openEditor(BuildContext context, String url, {String? title}) {
    final Map<String, String> params = <String, String>{'url': url};
    if (title != null) {
      params['title'] = title;
    }
    final Uri uri = Uri(path: '/simulasi/editor', queryParameters: params);
    context.push(uri.toString());
  }

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
          const Text('Simulasi', style: AppTypography.display),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Rancang dan uji sirkuit virtual langsung di browser.',
            style: AppTypography.bodyMuted,
          ),
          const SizedBox(height: AppSpacing.xl),
          VoltButton(
            label: 'Buka Project Baru',
            fullWidth: true,
            onPressed: () => _openEditor(context, _blankProjectUrl),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Project yang sudah ada', style: AppTypography.title),
          const SizedBox(height: AppSpacing.md),
          // ponytail: list kartu statis 2 template; upgrade ke ListView.builder jika template dinamis dari API
          VoltCard(
            onTap: () => _openEditor(
              context,
              _ledBlinkerUrl,
              title: 'LED Blinker',
            ),
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
                      Text(
                        'LED Blinker',
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(
                        'Simulasi kedip LED dasar Arduino',
                        style: AppTypography.bodyMuted,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const AppIcon.chevronRight(
                  size: AppIconSize.md,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          VoltCard(
            onTap: () => _openEditor(
              context,
              _trafficLightUrl,
              title: '4-Way Traffic Light',
            ),
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
                  child: const Icon(
                    Icons.traffic_rounded,
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
                        '4-Way Traffic Light',
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(
                        'Simulasi lampu lalu lintas 4 arah',
                        style: AppTypography.bodyMuted,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const AppIcon.chevronRight(
                  size: AppIconSize.md,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
