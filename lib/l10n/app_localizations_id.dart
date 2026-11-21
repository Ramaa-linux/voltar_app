// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'EduVolt';

  @override
  String homeGreeting(Object name) {
    return 'Halo, $name!';
  }

  @override
  String get btnStart => 'Mulai';

  @override
  String get btnContinue => 'Lanjutkan';

  @override
  String get btnSave => 'Simpan';

  @override
  String get btnCancel => 'Batal';

  @override
  String get menuProfile => 'Profil';

  @override
  String get menuLanguage => 'Bahasa';

  @override
  String get langIndonesian => 'Indonesia';

  @override
  String get langEnglish => 'English';

  @override
  String get loginTitle => 'Masuk';

  @override
  String get registerTitle => 'Daftar Akun';

  @override
  String get classTitle => 'Kelas';

  @override
  String get taskTitle => 'Tugas';

  @override
  String get commentTitle => 'Komentar';

  @override
  String get navHome => 'Home';

  @override
  String get navMateri => 'Materi';

  @override
  String get navSimulasi => 'Simulasi';

  @override
  String get navKelas => 'Kelas';

  @override
  String get navProfil => 'Profil';

  @override
  String get guruNavDashboard => 'Dashboard';

  @override
  String get guruNavKelas => 'Kelas';

  @override
  String get guruNavTugas => 'Tugas';

  @override
  String get guruNavProfil => 'Profil';

  @override
  String get guruKelasDetailTitle => 'Detail Kelas';

  @override
  String get guruKelasEdit => 'Edit Kelas';

  @override
  String get guruKelasComingSoon => 'Segera hadir di pembaruan berikutnya';

  @override
  String get guruTugasTitle => 'Daftar Tugas';

  @override
  String guruTugasCount(Object count) {
    return '$count tugas';
  }

  @override
  String get guruTugasCreate => 'Buat Tugas';

  @override
  String get guruTugasFilterAll => 'Semua';

  @override
  String get guruTugasFilterActive => 'Aktif';

  @override
  String get guruTugasFilterCompleted => 'Selesai';

  @override
  String get guruTugasStatusActive => 'Aktif';

  @override
  String get guruTugasStatusCompleted => 'Selesai';

  @override
  String guruTugasDeadline(Object date) {
    return 'Deadline: $date';
  }

  @override
  String guruTugasDetailSnack(Object title) {
    return 'Detail \"$title\" - Segera hadir';
  }

  @override
  String get settingsEditProfil => 'Edit Profil';

  @override
  String get settingsNotifications => 'Notifikasi';

  @override
  String get settingsAbout => 'Tentang Aplikasi';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get logout => 'Keluar';

  @override
  String get logoutConfirm => 'Konfirmasi Keluar';

  @override
  String get logoutConfirmMessage => 'Apakah kamu yakin ingin keluar?';

  @override
  String get confirmYes => 'Ya';

  @override
  String get confirmNo => 'Tidak';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'nama@sekolah.sch.id';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Masukkan password Anda';

  @override
  String get nameLabel => 'Nama Lengkap';

  @override
  String get nameHint => 'Masukkan nama lengkap';

  @override
  String get confirmPasswordLabel => 'Konfirmasi Password';

  @override
  String get confirmPasswordHint => 'Masukkan ulang password';

  @override
  String get teacherCodeLabel => 'Kode Guru (Opsional)';

  @override
  String get teacherCodeHint => 'Masukkan kode undangan guru';

  @override
  String get roleStudent => 'Siswa';

  @override
  String get roleTeacher => 'Guru';

  @override
  String get registerRoleLabel => 'Daftar Sebagai';

  @override
  String get btnLogin => 'Masuk';

  @override
  String get btnRegister => 'Daftar';

  @override
  String get noAccount => 'Belum punya akun? ';

  @override
  String get registerLink => 'Daftar';

  @override
  String get hasAccount => 'Sudah punya akun? ';

  @override
  String get loginLink => 'Masuk';

  @override
  String get welcomeTitle => 'Selamat Datang';

  @override
  String get welcomeSubtitle => 'Belajar elektronika jadi seru dan interaktif!';

  @override
  String get continueLearning => 'Lanjutkan Belajar';

  @override
  String get quickShortcuts => 'Pintasan Cepat';

  @override
  String get miniGames => 'Mini-Game';

  @override
  String get joinClassTitle => 'Gabung Kelas';

  @override
  String get joinClassDesc => 'Masukkan kode kelas dari guru Anda';

  @override
  String get classCodeLabel => 'Kode Kelas';

  @override
  String get classCodeHint => 'Contoh: ABC123';

  @override
  String get btnJoinClass => 'Gabung';

  @override
  String get myClass => 'Kelas Saya';

  @override
  String classCode(Object code) {
    return 'Kode: $code';
  }

  @override
  String studentCount(Object count) {
    return '$count siswa';
  }

  @override
  String teacherLabel(Object name) {
    return 'Guru: $name';
  }

  @override
  String get levelUnlocked => 'Terbuka';

  @override
  String get levelLocked => 'Terkunci';

  @override
  String get completePrevLevel => 'Selesaikan Level sebelumnya terlebih dahulu';

  @override
  String get selectLevel => 'Pilih Level';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get languageDialogTitle => 'Pilih Bahasa / Choose Language';

  @override
  String get saveChanges => 'Simpan Perubahan';

  @override
  String get saving => 'Menyimpan...';

  @override
  String get processing => 'Memproses...';

  @override
  String get showPassword => 'Tampilkan password';

  @override
  String get hidePassword => 'Sembunyikan password';

  @override
  String get avatarChange => 'Ganti Foto';

  @override
  String get photoUploading => 'Mengunggah foto...';

  @override
  String get errorRequired => 'Harap isi kolom ini';

  @override
  String get errorEmail => 'Format email tidak valid';

  @override
  String get errorPasswordMin => 'Password minimal 6 karakter';

  @override
  String get errorPasswordMatch => 'Password tidak cocok';

  @override
  String get errorName => 'Nama minimal 2 karakter';

  @override
  String get errorTeacherCode => 'Kode guru tidak valid';

  @override
  String get authErrorNetwork => 'Koneksi jaringan bermasalah. Coba lagi.';

  @override
  String get authErrorWrongPassword => 'Email atau password salah';

  @override
  String get authErrorUserNotFound => 'Akun tidak ditemukan';

  @override
  String get authErrorEmailInUse => 'Email sudah terdaftar';

  @override
  String get authErrorWeakPassword => 'Password terlalu lemah';

  @override
  String get authErrorInvalidEmail => 'Format email tidak valid';

  @override
  String get verificationPendingTitle => 'Verifikasi Email';

  @override
  String verificationPendingDesc(Object email) {
    return 'Kami telah mengirim email verifikasi ke $email. Silakan cek kotak masuk Anda.';
  }

  @override
  String get verificationResend => 'Kirim Ulang';

  @override
  String get verificationCheck => 'Cek Verifikasi';

  @override
  String get profileName => 'Nama';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileRole => 'Peran';

  @override
  String get profileClass => 'Kelas';

  @override
  String get profileStudentId => 'NIS';

  @override
  String get profileTeacherId => 'NIP';

  @override
  String get statsClasses => 'Kelas';

  @override
  String get statsStudents => 'Siswa';

  @override
  String get statsTasks => 'Tugas';

  @override
  String get menuEditProfil => 'Edit Profil';

  @override
  String get menuNotifications => 'Notifikasi';

  @override
  String get menuAbout => 'Tentang Aplikasi';

  @override
  String get menuLogout => 'Keluar';

  @override
  String get appName => 'EduVolt';

  @override
  String version(Object version) {
    return 'Versi $version';
  }

  @override
  String get copyright => '© 2024 EduVolt. All rights reserved.';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Hapus';

  @override
  String get edit => 'Edit';

  @override
  String get close => 'Tutup';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get loading => 'Memuat...';

  @override
  String get noData => 'Tidak ada data';

  @override
  String get search => 'Cari';

  @override
  String get filter => 'Filter';

  @override
  String get sort => 'Urutkan';

  @override
  String get refresh => 'Muat Ulang';

  @override
  String get titleProfile => 'Profil';

  @override
  String get titleSettings => 'Pengaturan';

  @override
  String get btnYesLogout => 'Ya, Keluar';

  @override
  String errLogoutFailed(Object error) {
    return 'Gagal keluar: $error';
  }

  @override
  String get msgNoNotifications => 'Belum ada notifikasi baru.';

  @override
  String get btnClose => 'Tutup';

  @override
  String aboutDesc(Object version) {
    return 'EduVolt v$version - Platform Pembelajaran Elektronika untuk SMK.';
  }

  @override
  String get aboutMadeBy => 'Dibuat oleh: Tim EduVolt';

  @override
  String appVersion(Object version) {
    return 'EduVolt v$version';
  }

  @override
  String get loginSubtitle => 'Belajar listrik jadi seru ⚡';

  @override
  String get tidakAdaSoal => 'Tidak ada soal tersedia';

  @override
  String get gagalMemuatLevel => 'Gagal memuat level';

  @override
  String get selesaikanLevelSebelumnya =>
      'Selesaikan Level sebelumnya terlebih dahulu';

  @override
  String get kirimJawaban => 'Kirim Jawaban';

  @override
  String get kembaliKeLevel => 'Kembali ke Level';

  @override
  String get memuatKuis => 'Memuat kuis...';

  @override
  String get gagalMemuatKuis => 'Gagal memuat kuis';

  @override
  String get tidakAdaData => 'Tidak ada data';

  @override
  String get kodeKelas => 'Kode Kelas';

  @override
  String get gabungKelas => 'Gabung Kelas';

  @override
  String get kelasSaya => 'Kelas Saya';

  @override
  String get cari => 'Cari';

  @override
  String get urutkan => 'Urutkan';

  @override
  String get muatUlang => 'Muat Ulang';

  @override
  String get cobaLagi => 'Coba Lagi';

  @override
  String get memuat => 'Memuat...';

  @override
  String get kelasTidakDitemukan => 'Kelas tidak ditemukan';

  @override
  String get hubungiGuruKodeKelas =>
      'Hubungi guru Anda untuk kode kelas yang benar';

  @override
  String get belumAdaPostingan => 'Belum Ada Postingan';

  @override
  String get tungguPengumumanGuru => 'Tunggu pengumuman dari guru';

  @override
  String get belumAdaTugas => 'Belum ada tugas';

  @override
  String get belumAdaKelas => 'Belum ada kelas';

  @override
  String get gagalMemuat => 'Gagal Memuat';

  @override
  String get selesaiTugas => 'Selesai Tugas';

  @override
  String get tugasTerlambat => 'Tugas terlambat';

  @override
  String get belumDikerjakan => 'Belum dikerjakan';

  @override
  String get hapusPostingan => 'Hapus Postingan';

  @override
  String get hapusTugas => 'Hapus Tugas?';

  @override
  String get tindakanTidakDapatDibatalkan =>
      'Tindakan ini tidak dapat dibatalkan';

  @override
  String get postinganDihapus => 'Postingan dihapus';

  @override
  String get tugasDihapus => 'Tugas dihapus';

  @override
  String get belumLogin => 'Belum Login';

  @override
  String get silakanLoginGuru =>
      'Silakan login sebagai guru untuk mengelola kelas.';

  @override
  String get daftarKelas => 'Daftar Kelas';

  @override
  String get kelolaKelasYangAndaAmpu => 'Kelola kelas yang Anda ampu';

  @override
  String get buatKelasBaru => 'Buat Kelas Baru';

  @override
  String get buatTugasBaru => 'Buat tugas baru untuk siswa Anda';

  @override
  String get namaKelas => 'Nama Kelas';

  @override
  String get deskripsiKelas => 'Deskripsi Kelas';

  @override
  String get kodeUndangan => 'Kode Undangan';

  @override
  String get tanggalBatas => 'Tanggal Batas';

  @override
  String get mataPelajaran => 'Mata Pelajaran';

  @override
  String get pilihMataPelajaran => 'Pilih Mata Pelajaran';

  @override
  String get totalSiswa => 'Total Siswa';

  @override
  String get totalKelas => 'Total Kelas';

  @override
  String get totalTugas => 'Total Tugas';

  @override
  String get aktivitasTerkini => 'Aktivitas Terkini';

  @override
  String get guru => 'Guru';

  @override
  String get siswa => 'Siswa';

  @override
  String get kode => 'Kode';

  @override
  String get buatPengumumanAtauTugasPertama =>
      'Buat pengumuman atau tugas pertama Anda';

  @override
  String get belumPunyaKelas => 'Belum Punya Kelas?';

  @override
  String get masukkanKodeKelas =>
      'Masukkan kode kelas dari guru Anda untuk bergabung.';

  @override
  String get joinClassSuccess => 'Berhasil bergabung ke kelas!';

  @override
  String get lihatDetail => 'Lihat Detail';

  @override
  String get tugasDanAbsen => 'Tugas & Absen';

  @override
  String get pengguna => 'Pengguna';

  @override
  String semuaTab(Object count) {
    return 'Semua ($count)';
  }

  @override
  String get belumAdaTugasSelesai => 'Belum Ada Tugas Selesai';

  @override
  String get tugasSelesaiWillAppear =>
      'Tugas yang diselesaikan akan muncul di sini.';

  @override
  String get semuaTugasSelesai => 'Semua Tugas Selesai! 🎉';

  @override
  String get tidakAdaTugasTertunda => 'Tidak ada tugas yang tertunda.';

  @override
  String get postUpdated => 'Postingan diperbarui';

  @override
  String deadlineLabel(Object deadline) {
    return 'Deadline: $deadline';
  }

  @override
  String get lewat => 'Lewat';

  @override
  String get pengumuman => 'Pengumuman';

  @override
  String hapusApa(Object item) {
    return 'Hapus $item?';
  }

  @override
  String get assignmentUpdated => 'Tugas diperbarui';

  @override
  String siswaTab(Object count) {
    return 'Siswa ($count)';
  }

  @override
  String kodeLabel(Object code) {
    return 'Kode: $code';
  }

  @override
  String get gagalMemuatSiswa => 'Terjadi kesalahan saat memuat daftar siswa.';

  @override
  String get tanpaNama => 'Tanpa Nama';

  @override
  String get tungguTugasDariGuru => 'Tunggu tugas dari guru';

  @override
  String get buatPengumuman => 'Buat Pengumuman';

  @override
  String get bagikanInfo =>
      'Bagikan informasi penting kepada seluruh siswa di kelas.';

  @override
  String get judulOpsional => 'Judul (Opsional)';

  @override
  String get contohJudul => 'Contoh: Jadwal Praktikum Minggu Depan';

  @override
  String get isiPengumuman => 'Isi Pengumuman';

  @override
  String get tulisPengumuman => 'Tulis pengumuman di sini...';

  @override
  String get memposting => 'Memposting...';

  @override
  String get postingPengumuman => 'Posting Pengumuman';

  @override
  String get isiPengumumanTidakBolehKosong =>
      'Isi pengumuman tidak boleh kosong';

  @override
  String get pilihDeadline => 'Pilih Batas Waktu (Deadline)';

  @override
  String deadlineWithTime(Object date, Object time) {
    return 'Deadline: $date $time';
  }

  @override
  String get membuat => 'Membuat...';

  @override
  String get buatTugas => 'Buat Tugas';

  @override
  String get judulTugasWajibDiisi => 'Judul tugas wajib diisi';

  @override
  String get deskripsiTugasWajibDiisi => 'Deskripsi tugas wajib diisi';

  @override
  String get deadlineWajibDipilih => 'Deadline wajib dipilih';

  @override
  String get tugasBerhasilDibuat => 'Tugas berhasil dibuat';

  @override
  String get gagalMemuatMateri => 'Gagal memuat materi';

  @override
  String get kembali => 'Kembali';

  @override
  String get kuis => 'Kuis';

  @override
  String get selanjutnya => 'Selanjutnya';

  @override
  String get selamat => 'Selamat!';

  @override
  String get perluBelajarLagi => 'Perlu Belajar Lagi';

  @override
  String skorKamu(Object score) {
    return 'Skor Kamu: $score';
  }

  @override
  String benarDari(Object correct, Object total) {
    return '$correct dari $total benar';
  }

  @override
  String get levelPrefix => 'Level';

  @override
  String get kembaliKePilihLevel => 'Kembali ke Pilih Level';

  @override
  String get badgePretest => 'PRE-TEST';

  @override
  String get badgeMateri => 'MATERI';

  @override
  String get badgePosttest => 'POST-TEST';

  @override
  String get badgeFolder => 'FOLDER';

  @override
  String get chipSelesai => 'Selesai';

  @override
  String get chipMulai => 'Mulai';

  @override
  String pertanyaan(Object count) {
    return '$count pertanyaan';
  }

  @override
  String get videoTidakTersedia => 'Video tidak tersedia';

  @override
  String get ringkasanVideo => 'Ringkasan Video';

  @override
  String simulasiSegeraHadir(Object title) {
    return 'Simulasi praktik untuk $title segera hadir.';
  }

  @override
  String get tandaiSelesai => 'Tandai Selesai';

  @override
  String get tandaiSelesaiDialog => 'Tandai Selesai?';

  @override
  String konfirmasiTandaiSelesai(Object title) {
    return 'Apakah kamu yakin ingin menandai \"$title\" sebagai selesai?';
  }

  @override
  String ditandaiSelesai(Object title) {
    return '$title ditandai selesai!';
  }

  @override
  String get sudahSelesai => 'Sudah Selesai';

  @override
  String gambarPlaceholder(Object url) {
    return 'Gambar: $url\\n\\n(Tap untuk lihat fullscreen di Fase 3+)';
  }

  @override
  String get homeContinueLearning => 'Lanjutkan Belajar';

  @override
  String get homeQuickShortcuts => 'Pintasan Cepat';

  @override
  String get homeMiniGames => 'Mini-Games';

  @override
  String get homeStudyReady => 'Siap belajar elektronika hari ini?';

  @override
  String get homeProgressLabel => 'PROGRESS BELAJAR';

  @override
  String get homeCourseTitle => 'Dasar Elektronika';

  @override
  String get homeStreakLabel => 'Streak';

  @override
  String homeStreakDays(Object days) {
    return '$days hari';
  }

  @override
  String get homeCoinsLabel => 'Koin';

  @override
  String get homeModuleLabel => 'Modul';

  @override
  String homeModuleText(Object count) {
    return '$count Modul selesai';
  }

  @override
  String get homeJoinClass => 'Gabung Kelas';

  @override
  String get homeJoinClassDesc => 'Masukkan kode kelas dari guru Anda';

  @override
  String get homeJoinSuccess => 'Berhasil bergabung ke kelas!';

  @override
  String get homeClassCodeLabel => 'Kode Kelas';

  @override
  String get homeClassCodeHint => 'Contoh: ABC123';

  @override
  String get homeGabung => 'Gabung';

  @override
  String get homeClassNotFound => 'Kelas tidak ditemukan';

  @override
  String get homeContactTeacher =>
      'Hubungi guru Anda untuk kode kelas yang benar';

  @override
  String get homeNoClassName => 'Tanpa Nama';

  @override
  String get homeKode => 'Kode:';

  @override
  String get homeLevelCompleted => 'Selesai';

  @override
  String homeLevelCurrent(Object level) {
    return 'Level $level';
  }

  @override
  String get homeExploreMateri => 'Jelajahi Materi';

  @override
  String get homeStartLearning => 'Mulai Belajar';

  @override
  String get homeContinue => 'Lanjutkan';

  @override
  String get homeGuessComponent => 'Tebak Komponen';

  @override
  String get homeGuessDesc => 'Tebak komponen dan baca gelang warna resistor!';

  @override
  String get homeCircuitRush => 'Sirkuit Kilat';

  @override
  String get homeCircuitRushDesc =>
      'Pandu elektron melewati rintangan resistor!';

  @override
  String get homeCableConnect => 'Sambung Kabel';

  @override
  String get homeCableConnectDesc =>
      'Rangkai jalur kabel tertutup melewati komponen!';

  @override
  String get homePlay => 'Main';

  @override
  String get guruWelcome => 'Selamat datang,';

  @override
  String get guruActivities => 'Aktivitas Terkini';

  @override
  String get guruStatsClasses => 'Kelas';

  @override
  String get guruStatsStudents => 'Siswa';

  @override
  String get guruStatsActiveAssignments => 'Tugas Aktif';

  @override
  String get guruCreateClass => '+ Buat Kelas';

  @override
  String get guruNotLoggedIn => 'Belum Login';

  @override
  String get guruLoginPrompt =>
      'Silakan login sebagai guru untuk mengelola kelas.';

  @override
  String get guruNoClasses => 'Belum Ada Kelas';

  @override
  String get guruCreateClassPrompt =>
      'Tekan \"+ Buat Kelas\" untuk membuat kelas baru.';

  @override
  String get guruCreateClassTitle => 'Buat Kelas Baru';

  @override
  String get guruClassNameLabel => 'Nama Kelas';

  @override
  String get guruClassNameHint => 'Contoh: 10 IPA 1';

  @override
  String get guruClassNameRequired => 'Nama kelas tidak boleh kosong';

  @override
  String get guruCancel => 'Batal';

  @override
  String get guruCreate => 'Buat';

  @override
  String get guruLoginFirst => 'Silakan login terlebih dahulu';

  @override
  String guruClassCreated(Object code, Object name) {
    return 'Kelas \"$name\" berhasil dibuat (Kode: $code)';
  }

  @override
  String guruClassCreateFailed(Object error) {
    return 'Gagal membuat kelas: $error';
  }

  @override
  String get homeCalcResistor => 'Kalkulator Resistor';

  @override
  String get homeCalcResistorDesc => 'Baca warna gelang';

  @override
  String get homeCalcOhm => 'Kalkulator Ohm';

  @override
  String get homeCalcOhmDesc => 'Hitung V, I, R';

  @override
  String get defaultName => 'Budi Santoso';

  @override
  String get defaultEmail => 'budi.santoso@sekolah.sch.id';

  @override
  String get fotoProfilDiperbarui => 'Foto profil berhasil diperbarui';

  @override
  String get gagalUnggahFoto =>
      'Gagal memilih atau mengunggah foto profil. Silakan coba lagi.';

  @override
  String get profilDiperbarui => 'Profil berhasil diperbarui';

  @override
  String get gagalSimpanProfil =>
      'Terjadi kesalahan saat menyimpan profil. Silakan coba lagi.';

  @override
  String get editProfil => 'Edit Profil';

  @override
  String get tambahFoto => 'Tambah foto';

  @override
  String get pilihFotoGaleri => 'Pilih dari galeri';

  @override
  String get ledSimTitle => 'Simulasi Running LED';

  @override
  String get ledSimDesc =>
      'Amati bagaimana pin digital mikrokontroler menyalakan deretan LED bergantian.';

  @override
  String ledStatusActive(Object pin) {
    return 'Aktif: Pin D$pin HIGH';
  }

  @override
  String get ledStatusStandby => 'Status: Standby (Semua Pin LOW)';

  @override
  String get ledBtnStop => 'Hentikan Animasi';

  @override
  String get ledBtnStart => 'Jalankan Animasi';

  @override
  String get ledConceptTitle => 'Konsep Kerja';

  @override
  String get ledConceptText =>
      '1. Mikrokontroler mengirim sinyal HIGH (5V) ke satu pin.\\n2. LED menyala karena arus mengalir melewati resistor ke GND.\\n3. Rutin loop mematikan LED (LOW) lalu beralih ke pin berikutnya.';

  @override
  String get pbSimTitle => 'Simulasi Push Button';

  @override
  String get pbSimDesc =>
      'Tekan dan tahan tombol tactile switch di bawah untuk mengalirkan arus ke LED.';

  @override
  String get pbCircuitClosed => 'RANGKAIAN TERTUTUP: ARUS MENGALIR';

  @override
  String get pbCircuitOpen => 'RANGKAIAN TERBUKA: STANDBY';

  @override
  String get pbBtnPressed => 'Ditekan';

  @override
  String get pbBtnHold => 'Tekan & Tahan';

  @override
  String get pbLedOn => 'LED ON';

  @override
  String get pbLedOff => 'LED OFF';

  @override
  String get relaySimTitle => 'Simulasi Modul Relay 5V';

  @override
  String get relayOn => 'ON';

  @override
  String get relayOff => 'OFF';

  @override
  String get relayDesc =>
      'Logika Active LOW: Beri sinyal LOW (0V) di Pin D7 untuk mengalirkan arus ke koil relay.';

  @override
  String get relayDc12v => 'DC 12V';

  @override
  String get relayLoadOn => 'BEBAN (ON)';

  @override
  String get relayLoadOff => 'BEBAN (OFF)';

  @override
  String get rcTitle => 'Kalkulator Kode Warna Resistor';

  @override
  String get rcDesc =>
      'Pilih jumlah gelang lalu ketuk gelang untuk mengubah warna.';

  @override
  String get rcBandCount => 'Jumlah Gelang';

  @override
  String get rcBand4 => '4 Gelang';

  @override
  String get rcBand5 => '5 Gelang';

  @override
  String get rcBand6 => '6 Gelang';

  @override
  String get rcReadingTitle => 'Cara Membaca Gelang';

  @override
  String get rcReadingText =>
      '• 4 Gelang: Digit 1, Digit 2, Pengali, Toleransi\\n• 5 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi\\n• 6 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi, Koef. Suhu\\n\\nContoh 220 Ω ±5%: Merah (2) - Merah (2) - Cokelat (×10) - Emas (±5%)';

  @override
  String rcBandDigit(Object n) {
    return 'Gelang $n (Digit)';
  }

  @override
  String rcBandMultiplier(Object n) {
    return 'Gelang $n (Pengali)';
  }

  @override
  String rcBandTolerance(Object n) {
    return 'Gelang $n (Toleransi)';
  }

  @override
  String rcBandTempco(Object n) {
    return 'Gelang $n (Koef. Suhu)';
  }

  @override
  String get ohmSimTitle => 'Simulasi Rangkaian Tertutup & Hukum Ohm';

  @override
  String get ohmSimDesc =>
      'Amati aliran arus listrik pada rangkaian tertutup dari kutub (+) baterai, melewati hambatan dan beban, kembali ke kutub (-).';

  @override
  String get ohmSwitchOpen => 'TERBUKA';

  @override
  String get ohmSwitchClosed => 'TERTUTUP';

  @override
  String ohmVoltage(Object v) {
    return 'Tegangan: $v V';
  }

  @override
  String ohmResistance(Object r) {
    return 'Hambatan: $r Ω';
  }

  @override
  String ohmCurrent(Object i) {
    return 'Arus: $i mA';
  }

  @override
  String ohmCircuitClosed(Object i) {
    return 'RANGKAIAN TERTUTUP: Arus Mengalir ($i mA)';
  }

  @override
  String get ohmCircuitOpen => 'RANGKAIAN TERBUKA: Arus Terputus (0.0 mA)';

  @override
  String get ohmBtnOpen => 'Buka Saklar (OFF)';

  @override
  String get ohmBtnClose => 'Tutup Saklar (ON)';

  @override
  String get ohmParamTitle => 'Pengaturan Parameter';

  @override
  String get ohmParamDesc =>
      'Ubah nilai tegangan atau hambatan untuk melihat pengaruhnya terhadap laju partikel dan terangnya lampu.';

  @override
  String get ohmVoltageLabel => 'Tegangan (V)';

  @override
  String get ohmResistanceLabel => 'Hambatan (R)';

  @override
  String get ohmConceptTitle => 'Konsep Rangkaian Tertutup & Hukum Ohm';

  @override
  String get ohmConceptText =>
      '1. Rangkaian Tertutup (Closed Circuit):\\n   Arus hanya mengalir bila ada lintasan konduktor tertutup dari kutub (+) baterai menuju beban dan kembali ke kutub (-).\\n\\n2. Hambatan Resistor (R):\\n   Resistor membatasi laju partikel muatan. Semakin tinggi hambatan, semakin lambat aliran arus.\\n\\n3. Daya Terang Lampu:\\n   Kuat arus (I = V / R) menentukan terang bohlam. Arus besar membuat lampu menyala lebih terang.';

  @override
  String get ohmLampLabel => 'Lampu';

  @override
  String get ohmSwitchLabelOn => 'Saklar ON';

  @override
  String get ohmSwitchLabelOff => 'Saklar OFF';

  @override
  String get motorSimTitle => 'Simulasi Motor';

  @override
  String get motorServo => 'Servo';

  @override
  String get motorDc => 'Motor DC';

  @override
  String get motorStepper => 'Motor Stepper';

  @override
  String get motorStatusRunning => 'Berjalan';

  @override
  String get motorStatusStopped => 'Berhenti';

  @override
  String get motorStatusStalled => 'Tergantung';

  @override
  String get motorServoTitle => 'Simulasi Servo Motor SG90';

  @override
  String get motorDcTitle => 'Simulasi Motor DC & Kontrol PWM';

  @override
  String get motorStepperTitle => 'Simulasi Stepper 28BYJ-48 + ULN2003';

  @override
  String get sensorTabHcsr04 => 'HC-SR04';

  @override
  String get sensorTabLdr => 'LDR';

  @override
  String get sensorTabDht11 => 'DHT11';

  @override
  String get sensorTabMq135 => 'MQ-135';

  @override
  String sensorDistance(Object d) {
    return 'Jarak: $d cm';
  }

  @override
  String sensorLight(Object l) {
    return 'Cahaya: $l %';
  }

  @override
  String sensorTemperature(Object t) {
    return 'Suhu: $t °C';
  }

  @override
  String sensorHumidity(Object h) {
    return 'Kelembaban: $h %';
  }

  @override
  String sensorGas(Object g) {
    return 'Gas: $g ppm';
  }

  @override
  String get sensorFanOn => 'KIPAS ON';

  @override
  String get sensorFanOff => 'KIPAS OFF';

  @override
  String get sensorAlarmBlink => 'ALARM BLINK';

  @override
  String get sensorStandby => 'STANDBY';

  @override
  String get rcResultTitle => 'Nilai Hambatan';

  @override
  String rcToleranceLabel(Object t) {
    return 'Toleransi: ±$t%';
  }

  @override
  String rcTempcoLabel(Object t) {
    return 'Koefisien Suhu: $t ppm/K';
  }

  @override
  String get sensorHcsr04Title => 'Sensor Ultrasonik HC-SR04';

  @override
  String get sensorHcsr04Desc =>
      'Gelombang suara keluar dari Transmitter (T), memantul di objek, dan masuk ke Receiver (R).';

  @override
  String get sensorHcsr04Panel => 'Jarak Objek (2 cm - 400 cm)';

  @override
  String sensorHcsr04StatusDanger(Object d) {
    return 'Jarak: $d cm (Bahaya!)';
  }

  @override
  String sensorHcsr04StatusSafe(Object d) {
    return 'Jarak: $d cm (Aman)';
  }

  @override
  String get sensorHcsr04SubDanger =>
      'Jarak < 20 cm -> LED Indikator Hijau MENYALA';

  @override
  String get sensorHcsr04SubSafe => 'Jarak >= 20 cm -> LED MATI';

  @override
  String get sensorHcsr04BadgeOn => 'LED: ON';

  @override
  String get sensorHcsr04BadgeOff => 'LED: OFF';

  @override
  String get sensorLdrTitle => 'Sensor Cahaya LDR';

  @override
  String get sensorLdrDesc =>
      'Saat cahaya < 30%, resistansi LDR naik sehingga lampu menyala otomatis.';

  @override
  String get sensorLdrPanel => 'Intensitas Cahaya (0% - 100%)';

  @override
  String get sensorLdrStatusDark => 'Kondisi: Gelap -> Lampu ON';

  @override
  String get sensorLdrStatusBright => 'Kondisi: Terang -> Lampu OFF';

  @override
  String sensorLdrSub(Object l) {
    return 'Intensitas: $l% (Ambang gelap < 30%)';
  }

  @override
  String get sensorLdrBadgeOn => 'GLOW: ON';

  @override
  String get sensorLdrBadgeOff => 'GLOW: OFF';

  @override
  String get sensorDht11Title => 'Sensor Suhu & Kelembapan DHT11';

  @override
  String get sensorDht11Desc =>
      'Mengukur suhu & kelembapan udara. Jika suhu > 30°C, kipas pendingin menyala.';

  @override
  String get sensorDht11Panel => 'Suhu (20°C - 40°C) & Kelembapan (0% - 100%)';

  @override
  String sensorDht11Status(Object h, Object t) {
    return 'Suhu: $t°C | Kelembapan: $h%';
  }

  @override
  String get sensorDht11FanOn => 'KIPAS ON';

  @override
  String get sensorDht11FanOff => 'KIPAS OFF';

  @override
  String get sensorMq135Title => 'Sensor Gas MQ-135';

  @override
  String get sensorMq135Desc =>
      'Mendeteksi konsentrasi gas/asap di udara. Jika di ambang, LED alarm berkedip.';

  @override
  String get sensorMq135Panel => 'Konsentrasi Gas (0 - 1000 ppm)';

  @override
  String sensorMq135Status(Object g) {
    return 'Gas: $g ppm';
  }

  @override
  String get sensorMq135Alarm => 'ALARM BLINK';

  @override
  String get sensorMq135Standby => 'STANDBY';

  @override
  String get sensorLedOn => 'LED ON';

  @override
  String get sensorLedOff => 'LED OFF';

  @override
  String get sensorTempHeader => 'Suhu';

  @override
  String get sensorHumidityHeader => 'Kelembapan';

  @override
  String get motorSketchTitle => 'PRATINJAU SKETCH ARDUINO LANGSUNG';

  @override
  String get motorInputA0 => 'A0 → Output';

  @override
  String get motorInputD2D3 => 'D2/D3 → Output';

  @override
  String get motorDcForward => 'Maju (CW)';

  @override
  String get motorDcReverse => 'Mundur (CCW)';

  @override
  String get motorDcGas => 'GAS ▲ (Tahan)';

  @override
  String get motorDcBrake => 'REM ▼ (Tahan)';

  @override
  String get motorDcStop => 'BERHENTI';

  @override
  String get motorDcPresetFwd200 => 'Maju (PWM 200)';

  @override
  String get motorDcPresetRev100 => 'Mundur (PWM 100)';

  @override
  String get motorDcPowerLabel => 'Saklar Utama Motor DC (Soft-Start)';

  @override
  String get motorDcPowerSubtitle =>
      'Saat ON, kecepatan naik bertahap ke target PWM';

  @override
  String get motorDcAutoBrakeLabel => 'Auto-Brake (Lepas GAS = Turun)';

  @override
  String get motorDcAutoBrakeSubtitle =>
      'Coasting otomatis saat tombol GAS dilepas';

  @override
  String motorDcStalled(Object pwm) {
    return 'Torsi belum cukup (stall): PWM di bawah $pwm belum mampu memutar rotor.';
  }

  @override
  String get motorInputDeviceTitle => 'PERANGKAT INPUT';

  @override
  String get motorInputAnalog => 'Analog input (ADC 0–1023)';

  @override
  String get motorInputDigital => 'Digital input (HIGH/LOW)';

  @override
  String get motorInputPotentiometer => 'Potensiometer';

  @override
  String get motorInputSwitchPushButton => 'Switch / Push Button';

  @override
  String get motorServoPresetTitle =>
      'PRESET SUDUT & LANGKAH (TAHAN UNTUK REPEAT)';

  @override
  String get motorServoSweepLabel => 'Mode Sweep (0° ↔ 180°)';

  @override
  String get motorServoSweepSubtitle =>
      'Bergerak bolak-balik otomatis seperti contoh Arduino Sweep';

  @override
  String get motorServoSweepSpeed => 'Kecepatan Sweep:';

  @override
  String get motorSpeedSlow => 'Lambat';

  @override
  String get motorSpeedMedium => 'Sedang';

  @override
  String get motorSpeedFast => 'Cepat';

  @override
  String stepperRotorView(Object angle) {
    return 'Rotor ($angle°/step)';
  }

  @override
  String get stepperOutputShaft => 'Output Shaft 1:64';

  @override
  String get stepperModeFullStep => 'Mode: Full-Step (4)';

  @override
  String get stepperModeHalfStep => 'Mode: Half-Step (8)';

  @override
  String get stepperHalfRev => '½ Putaran (180°)';

  @override
  String get stepperFullRev => '1 Putaran (360°)';

  @override
  String get stepperResetZero => 'Reset 0°';

  @override
  String stepperAutoRunLabel(Object dir) {
    return 'Auto-Run Stepper ($dir)';
  }

  @override
  String get stepperAutoRunSubtitle =>
      'Melangkah kontinu dengan kecepatan terpilih';

  @override
  String get stepperDirCw => 'CW ↻';

  @override
  String get stepperDirCcw => 'CCW ↺';

  @override
  String get telemetryTitle => 'TELEMETRY & OSCILLOSCOPE';

  @override
  String get telemetryPwmServo => 'PWM 50 Hz (Periode 20 ms)';

  @override
  String get telemetryPwmDc => 'PWM ~490 Hz (Pin D5)';

  @override
  String get telemetryStepSequence => '4-Coil Step Sequence (IN1–IN4)';

  @override
  String get telemetryActualAngle => 'Sudut Aktual';

  @override
  String get telemetryTargetAngle => 'Sudut Target';

  @override
  String get telemetryPulseWidth => 'Lebar Pulsa';

  @override
  String get telemetryFrequency => 'Frekuensi';

  @override
  String get telemetryPwm => 'PWM';

  @override
  String get telemetryDutyCycle => 'Duty Cycle';

  @override
  String get telemetryRpm => 'RPM';

  @override
  String get telemetryDirection => 'Arah';

  @override
  String get telemetryDirectionCw => 'CW (Maju)';

  @override
  String get telemetryDirectionCcw => 'CCW (Mundur)';

  @override
  String get telemetryDirectionStall => 'STALL';

  @override
  String get telemetryDirectionStop => 'STOP';

  @override
  String get telemetryStepCounter => 'Step Counter';

  @override
  String get telemetryStepperAngle => 'Sudut';

  @override
  String get telemetryStepperCoils => 'Kumparan ABCD';

  @override
  String get telemetryStepperSpeed => 'Kecepatan';

  @override
  String get potentiometerTitle => 'Potensiometer Rotary (A0)';

  @override
  String get ohmCalcTitle => 'Kalkulator Hukum Ohm';

  @override
  String get ohmCalcVoltageLabel => 'Tegangan (V)';

  @override
  String get ohmCalcCurrentLabel => 'Arus (I)';

  @override
  String get ohmCalcResistanceLabel => 'Hambatan (R)';

  @override
  String get ohmCalcVoltageUnit => 'Volt (V)';

  @override
  String get ohmCalcCurrentUnit => 'Ampere (A)';

  @override
  String get ohmCalcResistanceUnit => 'Ohm (Ω)';

  @override
  String get ohmCalcAutoResult => 'Hasil otomatis';

  @override
  String get ohmCalcHintValue => '0';

  @override
  String get ohmCalcErrRZero => 'Hambatan (R) tidak boleh 0';

  @override
  String get ohmCalcErrIZero => 'Arus (I) tidak boleh 0';

  @override
  String get ohmCalcDesc => 'Isi 2 nilai, nilai ketiga dihitung otomatis';

  @override
  String get ohmCalcBasicFormulas => 'Rumus Dasar';

  @override
  String get ohmCalcResetButton => 'Reset';

  @override
  String get authErrNameRequired => 'Nama lengkap wajib diisi';

  @override
  String get authErrNameMin => 'Nama lengkap minimal 2 karakter';

  @override
  String get authErrEmailRequired => 'Email wajib diisi';

  @override
  String get authErrEmailInvalid => 'Format email tidak valid';

  @override
  String get authErrPasswordRequired => 'Password wajib diisi';

  @override
  String get authErrPasswordMin => 'Password minimal 6 karakter';

  @override
  String get authErrConfirmPasswordRequired =>
      'Konfirmasi password wajib diisi';

  @override
  String get authErrConfirmPasswordMismatch =>
      'Konfirmasi password tidak cocok';

  @override
  String get authErrTeacherCodeRequired => 'Kode Verifikasi wajib diisi';

  @override
  String get authErrTeacherCodeNotFound =>
      'Kode Verifikasi Guru tidak ditemukan.';

  @override
  String get authErrTeacherCodeInvalid =>
      'Kode Verifikasi Guru tidak valid (isValid = false).';

  @override
  String get authErrTeacherCodePermissionDenied =>
      'Gagal memeriksa kode (Akses Ditolak). Pastikan Firestore Rules sudah benar.';

  @override
  String get registerNameLabel => 'Nama Lengkap';

  @override
  String get registerNameHint => 'Masukkan nama lengkap Anda';

  @override
  String get registerEmailHint => 'nama@sekolah.sch.id';

  @override
  String get registerPasswordHint => 'Minimal 6 karakter';

  @override
  String get registerConfirmPasswordLabel => 'Konfirmasi Password';

  @override
  String get registerConfirmPasswordHint => 'Ulangi password Anda';

  @override
  String get registerRoleStudent => 'Siswa';

  @override
  String get registerRoleTeacher => 'Guru';

  @override
  String get registerTeacherCodeLabel => 'Kode Verifikasi Guru';

  @override
  String get registerTeacherCodeHint => 'Masukkan kode verifikasi';

  @override
  String get registerTeacherCodeDescription =>
      'Kode verifikasi diberikan oleh pihak Admin. Jangan bagikan kode kepada siswa.';

  @override
  String get authErrEmailAlreadyInUse =>
      'Email ini sudah terdaftar. Coba masuk atau gunakan email lain.';

  @override
  String get authErrWeakPassword =>
      'Kata sandi terlalu lemah. Gunakan minimal 8 karakter.';

  @override
  String get authErrNetworkFailed =>
      'Tidak ada koneksi internet. Periksa jaringanmu lalu coba lagi.';

  @override
  String get authErrTooManyRequests =>
      'Terlalu banyak percobaan. Tunggu beberapa menit lalu coba lagi.';

  @override
  String get authErrOperationNotAllowed =>
      'Pendaftaran email sedang dinonaktifkan. Hubungi admin.';

  @override
  String get authErrSessionExpired =>
      'Sesi kamu berakhir. Silakan masuk kembali.';

  @override
  String get authErrInvalidCredentials => 'Email atau password salah.';

  @override
  String get authErrServerBusy =>
      'Server sedang sibuk atau koneksi terputus. Coba lagi sebentar.';

  @override
  String get authErrPermissionDenied =>
      'Kamu tidak punya izin untuk tindakan ini.';

  @override
  String get authErrUnknown => 'Terjadi kesalahan. Silakan coba lagi.';

  @override
  String get passwordStrengthWeak => 'Lemah';

  @override
  String get passwordStrengthMedium => 'Sedang';

  @override
  String get passwordStrengthStrong => 'Kuat';

  @override
  String get resistorCalcSheetTitle => 'Alat Bantu Cepat';

  @override
  String get resistorCalcCloseTooltip => 'Tutup';

  @override
  String get authLoadingPreparing => 'Menyiapkan akunmu...';

  @override
  String get authLoadingWaitMessage =>
      'Mohon tunggu sebentar, sedang memuat data peran akun.';

  @override
  String get authLoadingFailedTitle => 'Gagal Menyiapkan Akun';

  @override
  String get authLoadingFailedMessage =>
      'Terjadi kendala saat memuat peran akun. Periksa koneksi internet Anda.';

  @override
  String get authLoadingRetrying => 'Mencoba...';

  @override
  String get authLoadingRetry => 'Coba Lagi';

  @override
  String get authLoadingLoggingOut => 'Keluar...';

  @override
  String get authLoadingLogout => 'Keluar';

  @override
  String get verificationPendingHeader => 'Cek Email Kamu!';

  @override
  String get verificationPendingSpamHint =>
      'Tidak ketemu? Cek folder Spam atau Promosi.';

  @override
  String get verificationPendingResending => 'Mengirim...';

  @override
  String get verificationPendingCheckButton => 'Saya sudah verifikasi';

  @override
  String get verificationPendingLoggingOut => 'Keluar...';

  @override
  String get verificationPendingBackToLogin => 'Kembali ke Login';

  @override
  String get verificationPendingErrorDefault =>
      'Terjadi kendala saat memuat peran akun. Periksa koneksi internet Anda.';

  @override
  String get verificationPendingResent =>
      'Email verifikasi telah dikirim ulang.';

  @override
  String get verificationPendingNotVerified =>
      'Email kamu belum terverifikasi. Silakan klik link di email.';

  @override
  String get verificationPendingDescEmailPrefix =>
      'Kami telah mengirim link verifikasi ke: ';

  @override
  String get verificationPendingDescEmailSuffix =>
      '. Silakan buka email dan klik link tersebut untuk mengaktifkan akun.';

  @override
  String get verificationPendingDescGeneric =>
      'Kami telah mengirim link verifikasi ke email kamu. Silakan buka email dan klik link tersebut untuk mengaktifkan akun.';

  @override
  String verificationPendingResendCooldown(Object seconds) {
    return 'Kirim Ulang (${seconds}s)';
  }

  @override
  String get verificationPendingResendLabel => 'Kirim Ulang Email Verifikasi';

  @override
  String get verificationPendingResendingEn => 'Mengirim...';

  @override
  String get gameCableConnectTooltipBack => 'Kembali';

  @override
  String get gameCableConnectTooltipRedo => 'Ulang Jalur';

  @override
  String get gameCableConnectCircuitClosed => 'Rangkaian Tertutup';

  @override
  String get gameCableConnectExit => 'Keluar';

  @override
  String get gameCableConnectTimeUp => 'Waktu Habis';

  @override
  String get gameCableConnectTryAgain => 'Coba Lagi';

  @override
  String get gameCableConnectNextLevel => 'Level Berikutnya (+10s)';

  @override
  String get gameCableConnectFeedback =>
      'Tarik kawat dari (+) melewati semua komponen ke (-).';

  @override
  String get gameCableConnectChipCurrent => 'Arus Mengalir!';

  @override
  String get gameCircuitRushTooltipBack => 'Kembali';

  @override
  String get gameCircuitRushTooltipResume => 'Lanjut';

  @override
  String get gameCircuitRushTooltipPause => 'Jeda';

  @override
  String get gameCircuitRushTitle => 'Sirkuit Kilat';

  @override
  String get gameCircuitRushStart => 'Mulai Main';

  @override
  String get gameCircuitRushPaused => 'Permainan Dijeda';

  @override
  String get gameCircuitRushResumeBtn => 'Lanjutkan';

  @override
  String get gameCircuitRushRestartBtn => 'Ulangi';

  @override
  String get gameCircuitRushExitBtn => 'Keluar';

  @override
  String get gameCircuitRushShortCircuit => 'Arus Terputus';

  @override
  String get gameCircuitRushGameOverRetry => 'Main Lagi';

  @override
  String gameGuessLevel(Object level) {
    return 'Level $level';
  }

  @override
  String get gameCircuitRushChipShort => 'Korsleting!';

  @override
  String get gameCircuitRushReadyDesc =>
      'Ketuk layar untuk melompat melewati celah resistor dan kumpulkan koin voltase!';

  @override
  String get simulasiTitle => 'Simulasi';

  @override
  String get simulasiNewProject => 'Buka Project Baru';

  @override
  String get simulasiExistingProjects => 'Project yang sudah ada';

  @override
  String get simulasiLedBlinkerTitle => 'LED Blinker';

  @override
  String get simulasiLedBlinkerDesc => 'Simulasi kedip LED dasar Arduino';

  @override
  String get simulasiTooltipBack => 'Kembali';

  @override
  String get simulasiDebugAvrTitle => 'Debug AVR';

  @override
  String get simulasiSimMachine => 'Mesin simulasi';

  @override
  String get simulasiModeIsolate => 'Isolate';

  @override
  String get simulasiModeTimer => 'Timer';

  @override
  String get simulasiStopped => 'Berhenti';

  @override
  String get simulasiBtnStart => 'Start';

  @override
  String get simulasiBtnStop => 'Stop';

  @override
  String get simulasiBlinkCircuit => 'Rangkaian Blink';

  @override
  String get simulasiLedOn => 'menyala';

  @override
  String get simulasiLedOff => 'mati';

  @override
  String get simulasiEditorDefaultName => 'Simulator Velxio';

  @override
  String get simulasiBtnReload => 'Muat Ulang';

  @override
  String get simulasiConnDisconnected => 'Koneksi Terputus';

  @override
  String get simulasiBtnRetry => 'Coba Lagi';

  @override
  String get simulasiSubtitle =>
      'Rancang dan uji sirkuit virtual langsung di browser.';

  @override
  String get simulasiTrafficLightTitle => '4-Way Traffic Light';

  @override
  String get simulasiTrafficLightDesc => 'Simulasi lampu lalu lintas 4 arah';

  @override
  String get simulasiCanvas2dTitle => 'Canvas 2D';

  @override
  String get kelasJoinSuccess => 'Berhasil bergabung ke kelas!';

  @override
  String get kelasNoClassYet => 'Belum Punya Kelas?';

  @override
  String get kelasTabForum => 'Forum';

  @override
  String get kelasTabTugas => 'Tugas';

  @override
  String get kelasTabOrang => 'Orang';

  @override
  String get postDetailTaskMarkedComplete => 'Tugas ditandai selesai';

  @override
  String get postDetailSubmissionCancelled => 'Penyaluran dibatalkan';

  @override
  String postDetailDeleteTitle(Object type) {
    return 'Hapus $type?';
  }

  @override
  String get postDetailDeleteConfirm => 'Tindakan ini tidak dapat dibatalkan.';

  @override
  String get postDetailCancel => 'Batal';

  @override
  String get postDetailDelete => 'Hapus';

  @override
  String get postDetailDeleted => 'Berhasil dihapus';

  @override
  String get postDetailEditComingSoon => 'Edit postingan segera hadir';

  @override
  String get postDetailUser => 'Pengguna';

  @override
  String get postDetailEdited => 'diedit';

  @override
  String get postDetailNoDeadline => 'Tanpa deadline';

  @override
  String postDetailDeadline(Object date) {
    return 'Deadline: $date';
  }

  @override
  String get postDetailOverdue => 'Lewat deadline';

  @override
  String postDetailComments(Object count) {
    return 'Komentar ($count)';
  }

  @override
  String get postDetailNoComments =>
      'Belum ada komentar. Jadilah yang pertama!';

  @override
  String get postDetailCommentsDisabled => 'Komentar dinonaktifkan oleh guru.';

  @override
  String get postDetailCommentHint => 'Tulis komentar...';

  @override
  String get postDetailSend => 'Kirim';

  @override
  String get postDetailViewCompleted => 'Lihat Siswa yang Selesai';

  @override
  String get postDetailCompleted => '✓ Selesai';

  @override
  String get postDetailCancelSubmission => 'Batalkan';

  @override
  String get postDetailSubmittedLate => 'Dikumpulkan setelah deadline';

  @override
  String get postDetailSubmitLate => 'Kumpulkan (Terlambat)';

  @override
  String get postDetailMarkComplete => 'Tandai Selesai';

  @override
  String get postDetailUploadFile => 'Upload File';

  @override
  String get postDetailUploadComingSoon => 'Fitur upload segera hadir';

  @override
  String get postDetailDetailTask => 'Detail Tugas';

  @override
  String get postDetailDetailAnnouncement => 'Detail Pengumuman';

  @override
  String get postDetailEditMenu => 'Edit';

  @override
  String get postDetailDeleteMenu => 'Hapus';

  @override
  String get postDetailFailedLoadComments => 'Gagal memuat komentar';

  @override
  String get postDetailFailedLoad => 'Gagal Memuat';

  @override
  String get postDetailRetry => 'Coba Lagi';

  @override
  String get postDetailNotFound => 'Postingan Tidak Ditemukan';

  @override
  String get postDetailNotFoundMsg =>
      'Postingan tidak ditemukan atau sudah dihapus.';

  @override
  String get postDetailBack => 'Kembali';

  @override
  String get postDetailStudentsCompleted => 'Siswa yang Selesai';

  @override
  String get postDetailNoStudentsCompleted =>
      'Belum ada siswa yang menyelesaikan tugas ini.';

  @override
  String postDetailCompletedAt(Object date) {
    return 'Selesai: $date';
  }

  @override
  String get postDetailClose => 'Tutup';

  @override
  String get postDetailYou => 'Anda';

  @override
  String get postDetailDeleteComment => 'Hapus Komentar?';

  @override
  String postDetailFailedSendComment(Object error) {
    return 'Gagal mengirim komentar: $error';
  }

  @override
  String postDetailFailedUpdateStatus(Object error) {
    return 'Gagal memperbarui status: $error';
  }

  @override
  String postDetailFailedDelete(Object error) {
    return 'Gagal menghapus: $error';
  }

  @override
  String get createPostAnnouncementPosted => 'Pengumuman berhasil diposting';

  @override
  String get createPostCreateAssignment => 'Buat Tugas Baru';

  @override
  String get createPostAssignmentDescription => 'Deskripsi Tugas';

  @override
  String get editPostEditAssignment => 'Edit Tugas';

  @override
  String get editPostEditAnnouncement => 'Edit Pengumuman';

  @override
  String get editPostTitle => 'Judul';

  @override
  String get editPostAssignmentTitle => 'Judul Tugas';

  @override
  String get editPostTitleOptional => 'Judul (Opsional)';

  @override
  String get editPostDeadline => 'Deadline';

  @override
  String get editPostSelectDeadline => 'Pilih deadline';

  @override
  String get editPostAllowComments => 'Izinkan komentar';

  @override
  String get editPostCancel => 'Batal';

  @override
  String get editPostSaving => 'Menyimpan...';

  @override
  String get editPostSave => 'Simpan';

  @override
  String get editPostContentEmpty => 'Isi tidak boleh kosong';

  @override
  String get editPostUpdated => 'Berhasil diperbarui';

  @override
  String guruKelasCardSiswa(Object count) {
    return '$count siswa';
  }

  @override
  String get profilStatClasses => 'Kelas';

  @override
  String get profilStatStudents => 'Siswa';

  @override
  String get profilStatAssignments => 'Tugas';

  @override
  String get profilMenuEditProfil => 'Edit Profil';

  @override
  String get profilMenuEditProfilSub => 'Ubah nama, foto, dan informasi akun';

  @override
  String get profilMenuNotifikasi => 'Notifikasi';

  @override
  String get profilMenuNotifikasiSub => 'Kelola preferensi notifikasi';

  @override
  String get profilMenuBantuan => 'Bantuan & Dukungan';

  @override
  String get profilMenuBantuanSub => 'FAQ, panduan, dan hubungi kami';

  @override
  String get profilMenuKeamanan => 'Keamanan';

  @override
  String get profilMenuKeamananSub => 'Ubah kata sandi dan keamanan akun';

  @override
  String get profilMenuBahasa => 'Bahasa / Language';

  @override
  String get profilMenuBahasaSub => 'Ganti bahasa aplikasi';

  @override
  String get profilComingSoon => 'Fitur segera hadir';

  @override
  String get profilLogout => 'Keluar';

  @override
  String get profilLogoutConfirmTitle => 'Konfirmasi Keluar';

  @override
  String get profilLogoutConfirmMsg => 'Apakah kamu yakin ingin keluar?';

  @override
  String get profilCancel => 'Batal';

  @override
  String get profilLogoutYes => 'Ya, Keluar';

  @override
  String get profilLogoutFailed => 'Gagal keluar dari akun. Silakan coba lagi.';

  @override
  String get profilLoadFailed => 'Gagal memuat profil';

  @override
  String get profilLoadFailedMsg => 'Periksa koneksi internet Anda';

  @override
  String get profilFallbackName => 'Guru';

  @override
  String get profilFallbackRoleLabel => 'Guru';

  @override
  String get profilNIPUnavailable => 'NIP tidak tersedia';

  @override
  String get profilLanguageDialogTitle => 'Pilih Bahasa';

  @override
  String homeProgressCaption(Object completed, Object total) {
    return '$completed dari $total materi selesai';
  }

  @override
  String homeCoinsCount(Object coins) {
    return '$coins Koin';
  }

  @override
  String homeProgressSemantics(Object completed, Object percent, Object total) {
    return 'Progres belajar $percent persen, $completed dari $total materi selesai';
  }

  @override
  String get homeAllCompleted => 'Semua materi selesai 🎉';

  @override
  String homeSubtitleDone(Object level) {
    return 'Level $level • Semua modul tuntas';
  }

  @override
  String homeSubtitleStart(Object level) {
    return 'Level $level • Mulai Belajar';
  }

  @override
  String homeSubtitleProgress(Object completed, Object level, Object total) {
    return 'Level $level • $completed dari $total materi';
  }

  @override
  String homeSubtitleNext(Object level) {
    return 'Level $level • Materi berikutnya';
  }

  @override
  String materiGagalMemuatLevel(Object error) {
    return 'Gagal memuat level: $error';
  }

  @override
  String homeLevelLocked(Object level) {
    return 'Level $level, terkunci';
  }

  @override
  String materiLevelHeader(Object level) {
    return 'LEVEL $level';
  }

  @override
  String get materiChipBelajar => 'Sedang Belajar';

  @override
  String get materiChipLocked => 'Terkunci';

  @override
  String get materiGambarTidakDitemukan => 'Gambar tidak ditemukan';

  @override
  String get materiTabBacaan => 'Bacaan';

  @override
  String get materiTabVideo => 'Video';

  @override
  String get materiTabPraktik => 'Praktik';
}
