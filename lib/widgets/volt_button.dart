import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/press_scale.dart';

/// Varian visual [VoltButton].
enum VoltButtonVariant { primary, secondary, danger }

/// Tombol standar EduVolt: tinggi minimum 48, radius 8, tanpa elevation.
///
/// `onPressed == null` = disabled: latar [AppColors.surface], teks
/// [AppColors.textTertiary]. Jangan bikin state disabled manual di halaman.
class VoltButton extends StatelessWidget {
  const VoltButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = VoltButtonVariant.primary,
    this.fullWidth = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final VoltButtonVariant variant;

  /// Bila true, tombol mengisi lebar induk.
  final bool fullWidth;

  /// Ikon opsional di kiri label (ukuran [AppIconSize.sm]). Warnanya mengikuti
  /// foreground varian, atau [AppColors.textTertiary] saat tombol disabled.
  final AppIconName? icon;

  @override
  Widget build(BuildContext context) {
    final AppIconName? iconName = icon;
    final bool isEnabled = onPressed != null;
    final Widget button = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.button),
        boxShadow: isEnabled && variant == VoltButtonVariant.primary
            ? AppShadows.buttonPrimary
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: _styleFor(variant),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (iconName != null) ...<Widget>[
              AppIcon(
                iconName,
                size: AppIconSize.sm,
                color: !isEnabled
                    ? AppColors.textTertiary
                    : _foregroundFor(variant),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );

    // Animasi tekan hanya untuk tombol aktif; lebar penuh dibungkus dulu agar
    // scale terjadi di dalam constraint, bukan mengecilkan constraint.
    final Widget pressable = PressScale(
      enabled: isEnabled,
      child: button,
    );

    if (!fullWidth) {
      return pressable;
    }
    return SizedBox(width: double.infinity, child: pressable);
  }

  /// Warna teks/ikon tiap varian saat tombol aktif.
  static Color _foregroundFor(VoltButtonVariant variant) => switch (variant) {
    VoltButtonVariant.primary => AppColors.textOnPrimary,
    VoltButtonVariant.secondary => AppColors.primaryDark,
    VoltButtonVariant.danger => AppColors.textOnPrimary,
  };

  static ButtonStyle _styleFor(VoltButtonVariant variant) {
    final Color fill = switch (variant) {
      VoltButtonVariant.primary => AppColors.primary,
      VoltButtonVariant.secondary => AppColors.surface,
      VoltButtonVariant.danger => AppColors.error,
    };
    final Color foreground = _foregroundFor(variant);

    return ElevatedButton.styleFrom(
      backgroundColor: fill,
      foregroundColor: foreground,
      disabledBackgroundColor: AppColors.border,
      disabledForegroundColor: AppColors.textTertiary,
      elevation: 0,
      shadowColor: Colors.transparent,
      minimumSize: const Size(0, AppSpacing.minTouchTarget),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.button),
        side: variant == VoltButtonVariant.secondary
            ? AppBorders.side
            : BorderSide.none,
      ),
      textStyle: AppTypography.button,
    );
  }
}
