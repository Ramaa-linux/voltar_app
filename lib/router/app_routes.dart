/// Path route VoltAR - satu sumber agar tidak ada string path lepas.
abstract final class AppRoutes {
  static const String home = '/';
  static const String materi = '/materi';
  static const String simulasi = '/simulasi';
  static const String profil = '/profil';

  /// Editor simulasi: halaman penuh di atas AppShell (navbar tidak tampil).
  static const String simulasiEditor = '/simulasi/editor';

  /// Editor yang langsung dimuat dengan template Blink LED.
  static const String simulasiTemplateBlink = '/simulasi/template/blink';

  /// Halaman uji coba mesin AVR native (Fase 5A). Sementara, bukan nav utama.
  static const String avrDebug = '/debug-avr';

  /// Halaman uji canvas 2D rangkaian Blink (Fase 5A Hari 3).
  static const String canvasDebug = '/debug-canvas';

  /// Editor untuk project yang sudah ada. Nama project dikirim sebagai query
  /// supaya editor tidak perlu state tambahan di router.
  static String simulasiEditorFor(String projectName) => Uri(
    path: simulasiEditor,
    queryParameters: <String, String>{'title': projectName},
  ).toString();
}
