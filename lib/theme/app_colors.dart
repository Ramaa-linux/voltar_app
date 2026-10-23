import 'package:flutter/painting.dart';

/// Token warna VoltAR - sumber tunggal kebenaran.
///
/// Aturan keras: widget tidak boleh menulis `Color(0x...)` sendiri.
/// Semua warna lewat [AppColors] agar konsistensi cukup dijaga di satu tempat.
abstract final class AppColors {
  // --- Brand ---
  /// Warna utama: tombol primer, progress, state aktif.
  ///
  /// Hanya untuk fill/ikon besar. Teks kecil di atas putih wajib [primaryDark].
  static const Color primary = Color(0xFF0E9F8A);

  /// Latar lembut state aktif (pill nav, chip, highlight).
  static const Color primaryLight = Color(0xFFE6F7F4);

  /// Teal gelap: teks/ikon di atas [primaryLight] (kontras aman).
  ///
  /// Dipakai untuk label kecil, caption, dan link (AA 4.5:1 di atas putih).
  static const Color primaryDark = Color(0xFF0B7F6E);

  /// Aksen sekunder: koin, streak, badge.
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFEF3C7);

  // --- Permukaan ---
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF9FAFB);
  static const Color border = Color(0xFFE5E7EB);

  /// Border lebih tegas: garis dashed canvas Simulasi (Fase 5).
  static const Color borderStrong = Color(0xFFD1D5DB);

  // --- Teks ---
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // --- Status ---
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFECFDF5);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);

  // --- Rangkaian 2D ---
  /// Badan papan Arduino pada canvas simulator (teal gelap).
  ///
  /// Alias token brand supaya hex tetap satu sumber: mengubah [primaryDark]
  /// otomatis mengubah warna papan.
  static const Color circuitBoard = primaryDark;

  /// Kabel jumper pin 13 -> LED.
  static const Color circuitWire = success;

  /// LED saat pin HIGH (menyala).
  static const Color ledOn = error;

  /// LED saat pin LOW (mati).
  static const Color ledOff = borderStrong;

  // --- Elevasi ---
  /// Basis shadow; selalu dipakai dengan opacity rendah (maks 0.18).
  static const Color shadow = Color(0xFF111827);
}
