import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';

/// Tipografi VoltAR - Plus Jakarta Sans (dibundel offline, tanpa google_fonts).
///
/// Skala global hanya 400 / 500 / 700, maksimal 2 weight per layar.
/// Caption dibedakan lewat ukuran + warna, bukan weight tambahan.
abstract final class AppTypography {
  static const String fontFamily = 'PlusJakartaSans';

  /// 28 / 700 - judul hero, angka besar.
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  /// 24 / 700 - judul section.
  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.textPrimary,
  );

  /// 18 / 700 - judul kartu.
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  /// 14 / 400 - body standar.
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 14 / 400 abu - body sekunder.
  static const TextStyle bodyMuted = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  /// 14 / 500 - teks tombol.
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// 12 / 500 - label form, chip, metadata.
  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  /// 12 / 400 abu terang - caption.
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  /// 11 / 500 - micro label (nav bar, badge teks).
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    height: 1.2,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    color: AppColors.textTertiary,
  );

  /// Pemetaan ke TextTheme Material 3 agar widget bawaan tetap konsisten.
  static const TextTheme textTheme = TextTheme(
    headlineLarge: display,
    headlineMedium: heading,
    titleLarge: title,
    bodyLarge: body,
    bodyMedium: body,
    bodySmall: label,
    labelLarge: button,
    labelMedium: label,
    labelSmall: caption,
  );
}