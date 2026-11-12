import 'package:flutter/painting.dart';
import 'package:voltar/theme/app_colors.dart';

/// Gradient siap pakai EduVolt - hanya aksen halus, bukan dekorasi berat.
///
/// Aturan: gradient tidak boleh dipakai untuk latar penuh satu halaman, cukup
/// header/CTA. Semua warna tetap dari [AppColors].
abstract final class AppGradients {
  /// Header Home: teal sangat lembut dari kiri atas ke kanan bawah.
  ///
  /// Berhenti di [AppColors.background] supaya tepi bawah menyatu dengan
  /// halaman; teks di atasnya tetap [AppColors.textPrimary] (kontras aman).
  static const LinearGradient header = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.primaryLight,
      AppColors.background,
    ],
    stops: <double>[0, 0.85],
  );

  /// CTA "Lanjutkan Belajar": teal ke teal gelap, teks putih.
  static const LinearGradient cta = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.primary,
      AppColors.primaryDark,
    ],
  );
}
