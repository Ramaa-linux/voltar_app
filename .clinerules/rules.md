---
disabled: true
---
# RULES.MD - VOLTAR/EDUVOLT PROJECT (STRICT MODE)

## 1. PRINSIP UTAMA (NON-NEGOTIABLE)
- **JANGAN** menambah fitur, halaman, atau *library* baru tanpa persetujuan eksplisit dari user.
- **JANGAN** mengubah kode di luar file yang diminta di dalam *prompt*.
- **JANGAN** mengubah struktur database (Firestore) atau model data tanpa instruksi.
- **SELALU** bertanya jika ada instruksi yang ambigu atau kurang jelas. Jangan berasumsi.
- **PRIORITASKAN** stabilitas dan performa di atas estetika atau fitur baru.

## 2. BATASAN TEKNIS (UI & CODE)
- **DILARANG** menggunakan `ListView` di dalam `ListView` (atau `SingleChildScrollView`) tanpa `shrinkWrap: true` dan `physics: NeverScrollableScrollPhysics()`. Gunakan `Column` jika data sedikit (<10 item).
- **DILARANG** menggunakan `FittedBox` untuk mengecilkan teks secara berlebihan. Gunakan `Flexible` atau `TextOverflow.ellipsis`.
- **WAJIB** menggunakan *Design System* (AppColors, AppTypography, VoltCard, VoltButton, AppIcon). Dilarang *hardcode* warna/ukuran.
- **WAJIB** menangani *loading state*, *empty state*, dan *error state* di setiap halaman yang memuat data (Firestore/JSON).
- **WAJIB** melakukan `dispose()` pada semua `TextEditingController`, `AnimationController`, `StreamSubscription`, dan `Timer`.

## 3. LOKALISASI (i18n)
- **WAJIB** menggunakan `AppLocalizations.of(context)!.key` untuk semua teks UI.
- **DILARANG** menulis teks *hardcoded* di UI (kecuali teks *debug*/*log*).
- **DILARANG** menerjemahkan data dari Firestore (nama, komentar, pengumuman).
- Untuk Materi/JSON: **WAJIB** menggunakan field `_en` (misal `title_en`, `data_en`) dan *fallback* ke bahasa Indonesia jika `_en` null.

## 4. FIRESTORE & DATA
- **DILARANG** mengubah struktur Rules Firestore tanpa instruksi.
- **WAJIB** menggunakan `FutureBuilder` atau `StreamBuilder` untuk data Firestore (kecuali diinstruksikan lain).
- **DILARANG** melakukan *query* yang membutuhkan *Composite Index* tanpa persetujuan (hindari `orderBy` jika tidak perlu).
- **WAJIB** membersihkan data terkait (seperti komentar) saat menghapus data utama (Post/Kelas).

## 5. GAYA KERJA (EKSEKUSI)
- **SELALU** membaca file yang akan diubah sebelum menulis kode.
- **SELALU** menjalankan `flutter analyze` dan `flutter test` setelah perubahan.
- **JANGAN** memberikan kode yang belum teruji. Jika ada error, perbaiki dulu sebelum menyerahkan ke user.
- **JANGAN** berhenti di tengah jalan. Selesaikan semua tugas di dalam *prompt* sampai tuntas (atau laporkan jika benar-benar terblokir).
- **JIKA** ada *error* yang tidak bisa diselesaikan, jelaskan penyebabnya dan minta bantuan user.

## 6. DOKUMENTASI & KOMUNIKASI
- **WAJIB** memberikan ringkasan perubahan (file apa saja yang diubah) di akhir setiap tugas.
- **WAJIB** menyertakan *screenshot* (jika memungkinkan) untuk membuktikan UI berjalan.
- **JANGAN** menggunakan bahasa yang bertele-tele. Langsung to the point.