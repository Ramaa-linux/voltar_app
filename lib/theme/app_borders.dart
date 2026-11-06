import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';

/// Radius - satu skala untuk seluruh aplikasi.
abstract final class AppRadius {
  static const double card = 24;
  static const double button = 16;
  static const double input = 12;
  static const double chip = 12;
  static const double navBar = 24;

  /// Avatar, indikator, progress bar.
  static const double pill = 999;
}

/// Ketebalan dan border siap pakai.
abstract final class AppBorders {
  static const double thin = 1;
  static const double focus = 1.5;

  /// Border standar: 1px #E5E7EB.
  static const BorderSide side = BorderSide(color: AppColors.border, width: thin);

  /// Border kartu/input non-aktif.
  static const Border standard = Border.fromBorderSide(side);

  /// Border input saat fokus.
  static const BorderSide sideFocus = BorderSide(color: AppColors.primary, width: focus);
}

/// Shadow lembut berlapis (soft UI).
abstract final class AppShadows {
  static final List<BoxShadow> navBar = <BoxShadow>[
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.08),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  /// Dua lapis shadow halus untuk kartu mengambang di atas [AppColors.background].
  static final List<BoxShadow> card = <BoxShadow>[
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.03),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  /// Glow berwarna lembut untuk tombol utama.
  static final List<BoxShadow> buttonPrimary = <BoxShadow>[
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.30),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}