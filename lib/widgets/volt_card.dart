import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/widgets/press_scale.dart';

/// Kartu standar EduVolt: latar putih bersih ([AppColors.surface]), radius 24,
/// dan soft layered shadow ([AppShadows.card]).
///
/// `onTap` opsional untuk kartu yang bisa dibuka (ripple di dalam area kartu).
class VoltCard extends StatelessWidget {
  const VoltCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(AppRadius.card);
    final Widget content = Padding(padding: padding, child: child);

    final Widget card = DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: radius,
        boxShadow: AppShadows.card,
      ),
      child: onTap == null
          ? content
          : Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                borderRadius: radius,
                child: content,
              ),
            ),
    );

    // Hanya kartu yang bisa ditekan yang diberi animasi tekan.
    return PressScale(enabled: onTap != null, scale: 0.985, child: card);
  }
}
