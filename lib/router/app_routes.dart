/// Path route VoltAR - satu sumber agar tidak ada string path lepas.
abstract final class AppRoutes {
  static const String home = '/';
  static const String materi = '/materi';
  static const String simulasi = '/simulasi';
  static const String profil = '/profil';

  /// Halaman edit profil pengguna (Fase 22A).
  static const String profilEdit = '/profil/edit';

  /// Editor simulasi: halaman penuh di atas AppShell (navbar tidak tampil).
  static const String simulasiEditor = '/simulasi/editor';

  /// Editor yang langsung dimuat dengan template Blink LED.
  static const String simulasiTemplateBlink = '/simulasi/template/blink';

  /// Halaman detail level (peta perjalanan per level).
  static const String levelDetail = '/materi/level';

  /// Halaman detail materi: push ke root navigator (navbar tertutup).
  static const String materiDetail = '/materi/detail';

  /// Halaman kuis (pretest/posttest).
  static const String kuis = '/materi/kuis';

  /// Halaman uji coba mesin AVR native (Fase 5A). Sementara, bukan nav utama.
  static const String avrDebug = '/debug-avr';

  /// Halaman uji canvas 2D rangkaian Blink (Fase 5A Hari 3).
  static const String canvasDebug = '/debug-canvas';

  /// Mini-game Sirkuit Kilat (Fase 14B): halaman penuh tanpa navbar.
  static const String circuitRush = '/game/circuit-rush';

  /// Mini-game Sambung Kabel (Fase 15B): flow puzzle rangkaian tertutup.
  static const String cableConnect = '/game/cable-connect';

  /// Mini-game Tebak Komponen (Fase 19): halaman penuh tanpa navbar.
  static const String guessComponent = '/game/guess-component';


  /// Editor untuk project yang sudah ada. Nama project dikirim sebagai query
  /// supaya editor tidak perlu state tambahan di router.
  static String simulasiEditorFor(String projectName) => Uri(
    path: simulasiEditor,
    queryParameters: <String, String>{'title': projectName},
  ).toString();
}
