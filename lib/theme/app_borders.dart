import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';

/// Radius - satu skala untuk seluruh aplikasi.
abstract final class AppRadius {
  static const double card = 12;
  static const double button = 8;
  static const double input = 8;
  static const double chip = 8;
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

/// Shadow - hanya untuk elemen mengambang (nav bar), bukan kartu.
abstract final class AppShadows {
  static final List<BoxShadow> navBar = <BoxShadow>[
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.08),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}