/// Konstanta fisika dan konfigurasi mini-game Sirkuit Kilat (Fase 14B & 14D).
///
/// Seluruh angka kecepatan dan ukuran dikumpulkan di sini agar mudah disetel
/// dan diuji oleh unit test tanpa duplikasi magic number.
abstract final class CircuitRushConfig {
  /// Gravitasi vertikal bola elektron (piksel/detik^2).
  static const double gravity = 1100.0;

  /// Impuls kecepatan vertikal saat layar diketuk (piksel/detik).
  static const double tapImpulse = -380.0;

  /// Batas kecepatan jatuh maksimum agar bola tidak menembus celah.
  static const double maxFallSpeed = 620.0;

  /// Kecepatan gulir rintangan awal (piksel/detik).
  static const double initialScrollSpeed = 180.0;

  /// Kenaikan kecepatan gulir per poin skor.
  static const double speedPerScore = 4.0;

  /// Batas maksimum kecepatan gulir rintangan (piksel/detik).
  static const double maxScrollSpeed = 270.0;

  /// Radius bola elektron pemain (piksel).
  static const double playerRadius = 14.0;

  /// Posisi X tetap pemain relatif terhadap lebar layar (rasio 0..1).
  static const double playerXRatio = 0.28;

  /// Lebar gerbang rintangan resistor/kapasitor (piksel).
  static const double obstacleWidth = 52.0;

  /// Tinggi celah aman awal di antara gerbang atas dan bawah (piksel).
  static const double initialGapHeight = 156.0;

  /// Tinggi celah minimum saat skor tinggi (piksel).
  static const double minGapHeight = 116.0;

  /// Pengurangan celah per poin skor.
  static const double gapShrinkPerScore = 1.5;

  /// Rasio jarak horizontal awal antar rintangan relatif terhadap lebar layar.
  static const double initialObstacleSpacingRatio = 1.15;

  /// Rasio jarak horizontal minimum antar rintangan relatif terhadap lebar layar.
  static const double minObstacleSpacingRatio = 0.95;

  /// Pengurangan rasio jarak horizontal per poin skor.
  static const double obstacleSpacingShrinkPerScore = 0.004;

  /// Waktu tempuh minimum antar rintangan (detik) agar selalu nyaman dimainkan.
  static const double minObstacleTravelTime = 1.3;

  /// Rasio jarak rintangan pertama dari posisi X pemain terhadap lebar layar.
  static const double firstObstacleOffsetRatio = 1.0;

  /// Rasio margin vertikal aman terhadap tinggi layar untuk posisi celah.
  static const double gapVerticalMarginRatio = 0.08;

  /// Margin aman minimum dari tepi atas dan bawah untuk posisi celah (piksel).
  static const double minGapVerticalMargin = 50.0;

  /// Rasio perubahan vertikal maksimum antar celah terhadap tinggi layar.
  static const double maxGapDeltaHeightRatio = 0.20;

  /// Faktor keamanan batas fisika untuk perubahan vertikal antar celah.
  static const double physicsDeltaSafetyFactor = 0.6;

  /// Radius koin voltase (piksel).
  static const double coinRadius = 10.0;

  /// Bonus skor saat mengambil koin voltase.
  static const int coinBonusScore = 2;

  /// Jumlah maksimum titik jejak ekor partikel pemain.
  static const int maxTrailPoints = 12;

  /// Batas maksimum dt per langkah simulasi (detik) untuk mencegah lompatan ekstrem.
  static const double maxDeltaTime = 0.05;
}

