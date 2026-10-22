/// Skala spacing 4-based.
///
/// Semua jarak (padding, gap, margin) harus berasal dari skala ini.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  /// Padding horizontal standar untuk konten halaman.
  static const double pagePadding = 20;

  /// Tinggi minimum area sentuh (Material + pedoman aksesibilitas).
  static const double minTouchTarget = 48;

  /// Ruang bawah halaman agar item terakhir tidak tertutup NavBar mengambang.
  ///
  /// Rincian: navbar 71 (ikon 22 + gap 4 + label 13 + padding 16 + padding
  /// dalam 16) + margin 40 (20 atas + 20 bawah) + 17 ruang napas = 128.
  /// Wajib dipakai setiap halaman karena AppShell memakai `extendBody: true`.
  static const double navBarClearance = 128;
}