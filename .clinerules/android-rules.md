# Workspace Rules - Proyek Flutter Voltar

## 1. Target Perangkat & Build (Wajib Android)
- Proyek ini dikembangkan **khusus untuk target Android** (device testing: Redmi 7).
- **DILARANG KERAS** menjalankan perintah `flutter run`, `flutter build`, atau perintah kompilasi apa pun untuk target `windows`, `web`, `linux`, atau `macos`.
- Sebelum menjalankan aplikasi di perangkat, cek perangkat yang terhubung menggunakan `flutter devices`.
- Jika HP Android terhubung, jalankan perintah secara spesifik ke perangkat tersebut (contoh: `flutter run -d <device_id>`).
- **JANGAN** jalankan `flutter build apk --release` kecuali diminta secara eksplisit oleh pengguna.

## 2. Efisiensi Pengecekan Kode & Kecepatan Eksekusi
- Untuk memeriksa apakah ada error syntax, import, atau type setelah mengedit kode, **CUKUP gunakan `flutter analyze`**. Jangan melakukan full build/run hanya untuk mengecek error.
- Jika sesi `flutter run` sudah berjalan di terminal, gunakan **Hot Reload** (ketik `r` di terminal) daripada mematikan dan mem-build ulang aplikasi dari nol.

## 3. Batasan Pemindaian Direktori (Anti-Lag)
- **JANGAN PERNAH** membaca, mencari (`grep`/`search_files`), atau memindai isi folder `build/`, `.dart_tool/`, `.gradle/`, maupun `windows/`.
- Fokuskan pencarian dan pembacaan kode hanya pada folder `lib/`, `test/`, dan file `pubspec.yaml`.
