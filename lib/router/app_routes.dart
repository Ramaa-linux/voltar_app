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

  /// Editor untuk project yang sudah ada. Nama project dikirim sebagai query
  /// supaya editor tidak perlu state tambahan di router.
  static String simulasiEditorFor(String projectName) => Uri(
    path: simulasiEditor,
    queryParameters: <String, String>{'title': projectName},
  ).toString();
}
