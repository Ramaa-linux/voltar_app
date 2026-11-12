import 'package:flutter/painting.dart';

/// Token warna EduVolt - sumber tunggal kebenaran.
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
  static const Color background = Color(0xFFF2F3F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);

  /// Border lebih tegas: garis dashed canvas Simulasi (Fase 5).
  static const Color borderStrong = Color(0xFFD1D5DB);

  // --- Teks ---
  static const Color textPrimary = Color(0xFF17262A);
  static const Color textSecondary = Color(0xFF4A6572);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // --- Editor kode ---
  /// Latar panel sketch editor simulasi (gelap, seperti IDE).
  ///
  /// Alias [textPrimary] agar tetap satu sumber hex.
  static const Color codeBackground = textPrimary;

  /// Teks sketch di atas [codeBackground].
  static const Color codeText = background;

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

  /// Kontur/tepi papan, satu tingkat lebih gelap dari [circuitBoard].
  static const Color circuitBoardDark = Color(0xFF065A4E);

  /// Logam komponen: cincin jack DC, kaki LED, dudukan tombol reset.
  static const Color circuitMetal = Color(0xFF9CA3AF);

  /// Logam terang: tab regulator, kaki IC.
  static const Color circuitMetalLight = Color(0xFFA3A7B5);

  /// Plastik header pin (dan LED indikator mati).
  static const Color circuitPinHeader = Color(0xFF1F2937);

  /// Pad logam pin header (dudukan pin di atas plastik).
  static const Color circuitPinBox = Color(0xFFD4D4D8);

  /// Lubang pin pada header dan soket ICSP.
  static const Color circuitPin = Color(0xFF4B5563);

  /// Badan IC dan soket ICSP.
  static const Color circuitChip = Color(0xFF111827);

  /// Badan kristal osilator.
  static const Color circuitCrystal = Color(0xFFE5E7EB);

  /// Tombol reset.
  static const Color circuitReset = Color(0xFFDC2626);

  /// Cincin tombol reset.
  static const Color circuitResetDark = Color(0xFF991B1B);

  /// Badan konektor USB-B.
  static const Color circuitUsbBody = Color(0xFFB4B9C6);

  /// Pita logam pada konektor USB-B.
  static const Color circuitUsbBand = Color(0xFF7C8191);

  /// Cekungan mulut konektor USB-B.
  static const Color circuitUsbRecess = Color(0xFF8C91A1);

  /// Bayangan/tepi gelap konektor USB-B.
  static const Color circuitUsbShade = Color(0xFF5E6373);

  /// Flens dudukan USB-B yang menempel papan.
  static const Color circuitUsbFlange = Color(0xFF6F7485);

  /// Badan jack DC (barrel).
  static const Color circuitJack = Color(0xFF2A2D3B);

  /// Bibir/ring jack DC.
  static const Color circuitJackLip = Color(0xFF3B4052);

  /// LED SMD indikator TX/RX (kuning).
  static const Color circuitLedAmber = Color(0xFFFBBF24);

  /// Cincin LED eksternal saat menyala.
  static const Color circuitLedRimOn = Color(0xFFB91C1C);

  /// Tepi kabel jumper (lebih gelap dari [circuitWire]).
  static const Color circuitWireDark = Color(0xFF047857);

  // --- Elevasi ---
  /// Basis shadow; selalu dipakai dengan opacity rendah (maks 0.18).
  static const Color shadow = Color(0xFF111827);
}
