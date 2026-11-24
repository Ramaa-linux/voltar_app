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
  String get guruNavSiswa => 'Siswa';

  @override
  String get guruNavProfil => 'Profil';

  @override
  String get guruSiswaTitle => 'Daftar Siswa';

  @override
  String get guruSiswaSubtitle => 'Pantau progress belajar siswa';

  @override
  String get guruSiswaNoProgress => 'Belum ada progress';

  @override
  String guruSiswaCompleted(Object count) {
    return '$count materi selesai';
  }

  @override
  String get guruSiswaEmail => 'Email';

  @override
  String get guruSiswaProgress => 'Progress';

  @override
  String get guruKelasDetailTitle => 'Detail Kelas';

  @override
  String get guruKelasEdit => 'Edit Kelas';

  @override
  String get guruKelasComingSoon => 'Segera hadir di pembaruan berikutnya';

  @override
  String get guruTugasTitle => 'Daftar Tugas';

  @override
  String get guruTaskTitle => 'Tugas Kelas';

  @override
  String get guruTaskEmpty => 'Belum ada tugas';

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
  String get copyright => 'Â© 2024 EduVolt. All rights reserved.';

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
  String get loginSubtitle => 'Belajar listrik jadi seru âš¡';

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
  String get semuaTugasSelesai => 'Semua Tugas Selesai! ðŸŽ‰';

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
  String get guruWelcomeSubtitle => 'Selamat mengajar hari ini';

  @override
  String get guruPagi => 'Selamat pagi';

  @override
  String get guruSiang => 'Selamat siang';

  @override
  String get guruSore => 'Selamat sore';

  @override
  String get guruMalam => 'Selamat malam';

  @override
  String get guruStatsKelas => 'Kelas';

  @override
  String get guruStatsTugas => 'Tugas';

  @override
  String get guruStatsSiswa => 'Siswa';

  @override
  String get guruStatsError => 'Gagal memuat';

  @override
  String get guruActivitiesEmpty => 'Belum ada aktivitas';

  @override
  String get guruActivitiesTugas => 'Membuat Tugas:';

  @override
  String get guruActivitiesPengumuman => 'Membuat Pengumuman:';

  @override
  String get guruGreetingError => 'Gagal memuat profil guru';

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
      'â€¢ 4 Gelang: Digit 1, Digit 2, Pengali, Toleransi\\nâ€¢ 5 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi\\nâ€¢ 6 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi, Koef. Suhu\\n\\nContoh 220 Î© Â±5%: Merah (2) - Merah (2) - Cokelat (Ã—10) - Emas (Â±5%)';

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
    return 'Hambatan: $r Î©';
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
    return 'Suhu: $t Â°C';
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
    return 'Toleransi: Â±$t%';
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
      'Mengukur suhu & kelembapan udara. Jika suhu > 30Â°C, kipas pendingin menyala.';

  @override
  String get sensorDht11Panel =>
      'Suhu (20Â°C - 40Â°C) & Kelembapan (0% - 100%)';

  @override
  String sensorDht11Status(Object h, Object t) {
    return 'Suhu: $tÂ°C | Kelembapan: $h%';
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
  String get motorInputA0 => 'A0 â†’ Output';

  @override
  String get motorInputD2D3 => 'D2/D3 â†’ Output';

  @override
  String get motorDcForward => 'Maju (CW)';

  @override
  String get motorDcReverse => 'Mundur (CCW)';

  @override
  String get motorDcGas => 'GAS â–² (Tahan)';

  @override
  String get motorDcBrake => 'REM â–¼ (Tahan)';

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
  String get motorInputAnalog => 'Analog input (ADC 0â€“1023)';

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
  String get motorServoSweepLabel => 'Mode Sweep (0Â° â†” 180Â°)';

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
    return 'Rotor ($angleÂ°/step)';
  }

  @override
  String get stepperOutputShaft => 'Output Shaft 1:64';

  @override
  String get stepperModeFullStep => 'Mode: Full-Step (4)';

  @override
  String get stepperModeHalfStep => 'Mode: Half-Step (8)';

  @override
  String get stepperHalfRev => 'Â½ Putaran (180Â°)';

  @override
  String get stepperFullRev => '1 Putaran (360Â°)';

  @override
  String get stepperResetZero => 'Reset 0Â°';

  @override
  String stepperAutoRunLabel(Object dir) {
    return 'Auto-Run Stepper ($dir)';
  }

  @override
  String get stepperAutoRunSubtitle =>
      'Melangkah kontinu dengan kecepatan terpilih';

  @override
  String get stepperDirCw => 'CW â†»';

  @override
  String get stepperDirCcw => 'CCW â†º';

  @override
  String get telemetryTitle => 'TELEMETRY & OSCILLOSCOPE';

  @override
  String get telemetryPwmServo => 'PWM 50 Hz (Periode 20 ms)';

  @override
  String get telemetryPwmDc => 'PWM ~490 Hz (Pin D5)';

  @override
  String get telemetryStepSequence => '4-Coil Step Sequence (IN1â€“IN4)';

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
  String get ohmCalcResistanceUnit => 'Ohm (Î©)';

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
  String get postDetailCompleted => 'âœ“ Selesai';

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
  String get homeAllCompleted => 'Semua materi selesai ðŸŽ‰';

  @override
  String homeSubtitleDone(Object level) {
    return 'Level $level â€¢ Semua modul tuntas';
  }

  @override
  String homeSubtitleStart(Object level) {
    return 'Level $level â€¢ Mulai Belajar';
  }

  @override
  String homeSubtitleProgress(Object completed, Object level, Object total) {
    return 'Level $level â€¢ $completed dari $total materi';
  }

  @override
  String homeSubtitleNext(Object level) {
    return 'Level $level â€¢ Materi berikutnya';
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

  @override
  String levelCaption(Object totalMateri, Object totalMinutes) {
    return '$totalMateri materi â€¢ $totalMinutes menit';
  }

  @override
  String get levelCaptionEmpty => 'Belum ada materi';

  @override
  String estimatedTimeShort(Object value) {
    return '$value menit';
  }

  @override
  String estimatedTimeMedium(Object value) {
    return '$value menit';
  }

  @override
  String estimatedTimeLong(Object value) {
    return '$value menit';
  }

  @override
  String get dayMinggu => 'Minggu';

  @override
  String get daySenin => 'Senin';

  @override
  String get daySelasa => 'Selasa';

  @override
  String get dayRabu => 'Rabu';

  @override
  String get dayKamis => 'Kamis';

  @override
  String get dayJumat => 'Jumat';

  @override
  String get daySabtu => 'Sabtu';

  @override
  String get monthJan => 'Januari';

  @override
  String get monthFeb => 'Februari';

  @override
  String get monthMar => 'Maret';

  @override
  String get monthApr => 'April';

  @override
  String get monthMei => 'Mei';

  @override
  String get monthJun => 'Juni';

  @override
  String get monthJul => 'Juli';

  @override
  String get monthAgu => 'Agustus';

  @override
  String get monthSep => 'September';

  @override
  String get monthOkt => 'Oktober';

  @override
  String get monthNov => 'November';

  @override
  String get monthDes => 'Desember';

  @override
  String get materiKomponenL1KomBreadboardEstimatedTime => '5 menit';

  @override
  String get materiKomponenL1KomBreadboardTitle => 'Breadboard';

  @override
  String get materiKomponenL1KomHukumOhmEstimatedTime => '5 menit';

  @override
  String get materiKomponenL1KomHukumOhmTitle => 'Hukum Ohm';

  @override
  String get materiKomponenL1KomKapasitorEstimatedTime => '5 menit';

  @override
  String get materiKomponenL1KomKapasitorTitle => 'Kapasitor';

  @override
  String get materiKomponenL1KomLedEstimatedTime => '5 menit';

  @override
  String get materiKomponenL1KomLedTitle => 'LED (Light Emitting Diode)';

  @override
  String get materiKomponenL1KomResistorEstimatedTime => '5 menit';

  @override
  String get materiKomponenL1KomTactileSwitchEstimatedTime => '5 menit';

  @override
  String get materiL1L1KomBreadboardEstimatedTime => '5 menit';

  @override
  String get materiL1L1KomBreadboardTitle => 'Breadboard';

  @override
  String get materiL1L1KomHukumOhmEstimatedTime => '5 menit';

  @override
  String get materiL1L1KomHukumOhmTitle => 'Hukum Ohm';

  @override
  String get materiL1L1KomHukumOhmVideoSummary5Heading => 'Bab 3: Contoh Soal';

  @override
  String get materiL1L1KomKapasitorEstimatedTime => '5 menit';

  @override
  String get materiL1L1KomKapasitorTitle => 'Kapasitor';

  @override
  String get materiL1L1KomLedEstimatedTime => '5 menit';

  @override
  String get materiL1L1KomLedTitle => 'LED (Light Emitting Diode)';

  @override
  String get materiL1L1KomLedVideoSummary0Heading => 'Bab 1: Pengenalan LED';

  @override
  String get materiL1L1KomLedVideoSummary5Heading => 'Bab 3: Jenis-Jenis LED';

  @override
  String get materiL1L1KomResistorEstimatedTime => '5 menit';

  @override
  String get materiL1L1KomResistorTitle => 'Resistor (Cara Menghitung Nilai)';

  @override
  String get materiL1L1KomTactileSwitchEstimatedTime => '5 menit';

  @override
  String get materiL1L1KomTactileSwitchTitle => 'Tactile Switch (Push Button)';

  @override
  String get materiL1L1KomponenFolderTitle => 'Pengenalan Komponen';

  @override
  String get materiL1L1PosttestQQ1Option0 => 'V = I / R';

  @override
  String get materiL1L1PosttestQQ1Option1 => 'V = I Ã— R';

  @override
  String get materiL1L1PosttestQQ1Option2 => 'R = V Ã— I';

  @override
  String get materiL1L1PosttestQQ1Option3 => 'I = V Ã— R';

  @override
  String get materiL1L1PosttestQQ1Question => 'Rumus hukum Ohm adalah...';

  @override
  String get materiL1L1PosttestQQ2Option0 => '10 Î©';

  @override
  String get materiL1L1PosttestQQ2Option1 => '150 Î©';

  @override
  String get materiL1L1PosttestQQ2Option2 => '220 Î©';

  @override
  String get materiL1L1PosttestQQ2Option3 => '10 kÎ©';

  @override
  String get materiL1L1PosttestQQ3Option0 => '13,6 mA';

  @override
  String get materiL1L1PosttestQQ3Option1 => '20 mA';

  @override
  String get materiL1L1PosttestQQ3Option2 => '36 mA';

  @override
  String get materiL1L1PosttestQQ3Option3 => '1,36 A';

  @override
  String get materiL1L1PosttestQQ4Option0 => '5 mA';

  @override
  String get materiL1L1PosttestQQ4Option1 => '20 mA';

  @override
  String get materiL1L1PosttestQQ4Option2 => '200 mA';

  @override
  String get materiL1L1PosttestQQ4Option3 => '1 A';

  @override
  String get materiL1L1PosttestQQ5Option0 => 'D13';

  @override
  String get materiL1L1PosttestQQ5Option1 => 'D8';

  @override
  String get materiL1L1PosttestQQ5Option2 => 'D2';

  @override
  String get materiL1L1PosttestQQ5Option3 => 'A0';

  @override
  String get materiL1L1PosttestTitle => 'Post-Test Level 1';

  @override
  String get materiL1L1PretestQQ1Option0 => 'Hambatan';

  @override
  String get materiL1L1PretestQQ1Option1 => 'Tegangan';

  @override
  String get materiL1L1PretestQQ1Option2 => 'Daya';

  @override
  String get materiL1L1PretestQQ1Option3 => 'Frekuensi';

  @override
  String get materiL1L1PretestQQ2Option0 => 'Volt';

  @override
  String get materiL1L1PretestQQ2Option1 => 'Ampere';

  @override
  String get materiL1L1PretestQQ2Option2 => 'Ohm';

  @override
  String get materiL1L1PretestQQ2Option3 => 'Watt';

  @override
  String get materiL1L1PretestQQ3Option0 => 'Katoda (âˆ’)';

  @override
  String get materiL1L1PretestQQ3Option1 => 'Anoda (+)';

  @override
  String get materiL1L1PretestQQ3Option2 => 'Ground';

  @override
  String get materiL1L1PretestQQ3Option3 => 'Kaki tengah';

  @override
  String get materiL1L1PretestQQ4Option0 => 'ATmega328P';

  @override
  String get materiL1L1PretestQQ4Option1 => 'ESP32';

  @override
  String get materiL1L1PretestQQ4Option2 => 'STM32';

  @override
  String get materiL1L1PretestQQ4Option3 => 'PIC16F';

  @override
  String get materiL1L1PretestTitle => 'Pre-Test Level 1';

  @override
  String get materiL2L2ArrayPointerEstimatedTime => '8 menit';

  @override
  String get materiL2L2ArrayPointerTitle => 'Array & Pointer';

  @override
  String get materiL2L2ArrayPointerVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL2L2ArrayPointerVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL2L2ArrayPointerVideoSummary4Heading => 'Wawasan Kunci';

  @override
  String get materiL2L2InputOutputEstimatedTime => '10 menit';

  @override
  String get materiL2L2InputOutputTitle => 'Input & Output Digital';

  @override
  String get materiL2L2InputOutputVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL2L2InputOutputVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL2L2InputOutputVideoSummary4Heading => 'Wawasan Kunci';

  @override
  String get materiL2L2InputOutputVideoSummary6Heading => 'Alur Program';

  @override
  String get materiL2L2OperatorPercabanganEstimatedTime => '10 menit';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary8Heading => 'Penutup';

  @override
  String get materiL2L2PosttestQQ1Option0 => 'Sekali saat board menyala';

  @override
  String get materiL2L2PosttestQQ1Option1 => 'Berulang selama Arduino menyala';

  @override
  String get materiL2L2PosttestQQ1Option2 => 'Hanya saat terjadi error';

  @override
  String get materiL2L2PosttestQQ1Option3 => 'Ketika dikompilasi';

  @override
  String get materiL2L2PosttestQQ2Option0 => '||';

  @override
  String get materiL2L2PosttestQQ2Option1 => '&&';

  @override
  String get materiL2L2PosttestQQ2Option2 => '!';

  @override
  String get materiL2L2PosttestQQ2Option3 => '==';

  @override
  String get materiL2L2PosttestQQ2Question => 'Operator logika AND ditulis...';

  @override
  String get materiL2L2PosttestQQ3Option0 => 'NC (Normally Close)';

  @override
  String get materiL2L2PosttestQQ3Option1 => 'NO (Normally Open)';

  @override
  String get materiL2L2PosttestQQ3Option2 => 'GND';

  @override
  String get materiL2L2PosttestQQ3Option3 => 'VCC';

  @override
  String get materiL2L2PosttestQQ4Option0 => 'digitalWrite()';

  @override
  String get materiL2L2PosttestQQ4Option1 => 'digitalRead()';

  @override
  String get materiL2L2PosttestQQ4Option2 => 'analogWrite()';

  @override
  String get materiL2L2PosttestQQ4Option3 => 'pinMode()';

  @override
  String get materiL2L2PosttestQQ5Option0 => '//';

  @override
  String get materiL2L2PosttestQQ5Option1 => '##';

  @override
  String get materiL2L2PosttestQQ5Option2 => '--';

  @override
  String get materiL2L2PosttestQQ5Option3 => '<!--';

  @override
  String get materiL2L2PosttestTitle => 'Post-Test Level 2';

  @override
  String get materiL2L2PretestQQ1Option0 => 'Berulang tanpa henti';

  @override
  String get materiL2L2PretestQQ1Option1 => 'Sekali saat board menyala';

  @override
  String get materiL2L2PretestQQ1Option2 => 'Setiap tombol ditekan';

  @override
  String get materiL2L2PretestQQ1Option3 => 'Tidak pernah';

  @override
  String get materiL2L2PretestQQ2Option0 => 'int';

  @override
  String get materiL2L2PretestQQ2Option1 => 'bool';

  @override
  String get materiL2L2PretestQQ2Option2 => 'float';

  @override
  String get materiL2L2PretestQQ2Option3 => 'char';

  @override
  String get materiL2L2PretestQQ3Option0 => 'HIGH dan LOW';

  @override
  String get materiL2L2PretestQQ3Option1 => 'ON dan 0';

  @override
  String get materiL2L2PretestQQ3Option2 => '1 dan 2';

  @override
  String get materiL2L2PretestQQ3Option3 => 'VCC dan AC';

  @override
  String get materiL2L2PretestQQ4Option0 => '1';

  @override
  String get materiL2L2PretestQQ4Option1 => '0';

  @override
  String get materiL2L2PretestQQ4Option2 => '-1';

  @override
  String get materiL2L2PretestQQ4Option3 => 'Tergantung tipe data';

  @override
  String get materiL2L2PretestTitle => 'Pre-Test Level 2';

  @override
  String get materiL2L2RelayEstimatedTime => '8 menit';

  @override
  String get materiL2L2RelayTitle => 'Relay';

  @override
  String get materiL2L2RelayVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL2L2RelayVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL2L2RelayVideoSummary4Heading => 'Wawasan Kunci';

  @override
  String get materiL2L2StrukturSketchEstimatedTime => '8 menit';

  @override
  String get materiL2L2StrukturSketchVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL2L2StrukturSketchVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL2L2StrukturSketchVideoSummary4Heading => 'Wawasan Kunci';

  @override
  String get materiL2L2StrukturSketchVideoSummary6Heading => 'Penutup';

  @override
  String get materiL3L3AdcEstimatedTime => '10 menit';

  @override
  String get materiL3L3AdcTitle => 'ADC (Analog to Digital Converter)';

  @override
  String get materiL3L3AdcVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL3L3AdcVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL3L3AdcVideoSummary4Heading => 'Wawasan Penting';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorEstimatedTime => '8 menit';

  @override
  String get materiL3L3PosttestQQ1Option0 => 'V = (nilai ADC / 255) Ã— 5 V';

  @override
  String get materiL3L3PosttestQQ1Option1 => 'V = (nilai ADC / 1023) Ã— 5 V';

  @override
  String get materiL3L3PosttestQQ1Option2 => 'V = nilai ADC Ã— 5 V';

  @override
  String get materiL3L3PosttestQQ1Option3 => 'V = 1023 / nilai ADC';

  @override
  String get materiL3L3PosttestQQ2Option0 => '1,25 V';

  @override
  String get materiL3L3PosttestQQ2Option1 => '2,5 V';

  @override
  String get materiL3L3PosttestQQ2Option2 => '5 V';

  @override
  String get materiL3L3PosttestQQ2Option3 => '0 V';

  @override
  String get materiL3L3PosttestQQ3Option0 => 'D2';

  @override
  String get materiL3L3PosttestQQ3Option1 => 'D4';

  @override
  String get materiL3L3PosttestQQ3Option2 => 'D9';

  @override
  String get materiL3L3PosttestQQ3Option3 => 'A0';

  @override
  String get materiL3L3PosttestQQ4Option0 => 'digitalWrite()';

  @override
  String get materiL3L3PosttestQQ4Option1 => 'analogWrite()';

  @override
  String get materiL3L3PosttestQQ4Option2 => 'analogRead()';

  @override
  String get materiL3L3PosttestQQ4Option3 => 'digitalRead()';

  @override
  String get materiL3L3PosttestQQ5Option2 => 'Menggantikan catu daya utama';

  @override
  String get materiL3L3PosttestQQ5Option3 => 'Memutus arus saat korsleting';

  @override
  String get materiL3L3PosttestTitle => 'Post-Test Level 3';

  @override
  String get materiL3L3PretestQQ1Option0 => 'D0â€“D13';

  @override
  String get materiL3L3PretestQQ1Option1 => 'A0â€“A5';

  @override
  String get materiL3L3PretestQQ1Option2 => 'RX/TX';

  @override
  String get materiL3L3PretestQQ1Option3 => 'RESET';

  @override
  String get materiL3L3PretestQQ2Option0 => '0â€“100';

  @override
  String get materiL3L3PretestQQ2Option1 => '0â€“255';

  @override
  String get materiL3L3PretestQQ2Option2 => '0â€“1023';

  @override
  String get materiL3L3PretestQQ2Option3 => '0â€“5';

  @override
  String get materiL3L3PretestQQ3Option0 => '0â€“100';

  @override
  String get materiL3L3PretestQQ3Option1 => '0â€“255';

  @override
  String get materiL3L3PretestQQ3Option2 => '0â€“1023';

  @override
  String get materiL3L3PretestQQ3Option3 => '0â€“5';

  @override
  String get materiL3L3PretestQQ4Option0 => 'map()';

  @override
  String get materiL3L3PretestQQ4Option1 => 'delay()';

  @override
  String get materiL3L3PretestQQ4Option2 => 'pinMode()';

  @override
  String get materiL3L3PretestQQ4Option3 => 'Serial.begin()';

  @override
  String get materiL3L3PretestTitle => 'Pre-Test Level 3';

  @override
  String get materiL3L3PwmEstimatedTime => '10 menit';

  @override
  String get materiL3L3PwmTitle => 'PWM (Pulse Width Modulation)';

  @override
  String get materiL3L3PwmVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL3L3PwmVideoSummary2Heading => 'Poin-poin Penting';

  @override
  String get materiL3L3PwmVideoSummary4Heading => 'Insight Kunci';

  @override
  String get materiL4L4DebouncingEstimatedTime => '8 menit';

  @override
  String get materiL4L4DebouncingTitle => 'Debouncing';

  @override
  String get materiL4L4DebouncingVideoSummary8Heading => 'Kesimpulan';

  @override
  String get materiL4L4InterruptEstimatedTime => '10 menit';

  @override
  String get materiL4L4InterruptTitle => 'Interrupt';

  @override
  String get materiL4L4InterruptVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL4L4InterruptVideoSummary2Heading => 'Contoh Implementasi';

  @override
  String get materiL4L4InterruptVideoSummary4Heading => 'Sorotan';

  @override
  String get materiL4L4InterruptVideoSummary6Heading => 'Wawasan Kunci';

  @override
  String get materiL4L4InterruptVideoSummary8Heading => 'Kesimpulan';

  @override
  String get materiL4L4JenisMotorEstimatedTime => '10 menit';

  @override
  String get materiL4L4JenisMotorTitle => 'Jenis Motor: Servo';

  @override
  String get materiL4L4JenisMotorVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL4L4JenisMotorVideoSummary2Heading => 'Poin-poin Penting';

  @override
  String get materiL4L4JenisMotorVideoSummary4Heading => 'Insight Utama';

  @override
  String get materiL4L4PosttestQQ1Option0 => 'ADC';

  @override
  String get materiL4L4PosttestQQ1Option1 => 'PWM';

  @override
  String get materiL4L4PosttestQQ1Option2 => 'I2C';

  @override
  String get materiL4L4PosttestQQ1Option3 => 'UART';

  @override
  String get materiL4L4PosttestQQ2Option1 => 'Jam dan tanggal sebenarnya';

  @override
  String get materiL4L4PosttestQQ2Option2 => 'Nilai ADC terakhir';

  @override
  String get materiL4L4PosttestQQ2Option3 => 'Duty cycle PWM';

  @override
  String get materiL4L4PosttestQQ3Option1 => 'Konsumsi memori menjadi nol';

  @override
  String get materiL4L4PosttestQQ3Option2 => 'Tidak membutuhkan fungsi loop()';

  @override
  String get materiL4L4PosttestQQ3Option3 => 'Tegangan pin menjadi 12 V';

  @override
  String get materiL4L4PosttestQQ4Option0 => 'Polling';

  @override
  String get materiL4L4PosttestQQ4Option1 => 'Interrupt';

  @override
  String get materiL4L4PosttestQQ4Option2 => 'Debouncing';

  @override
  String get materiL4L4PosttestQQ4Option3 => 'Mapping';

  @override
  String get materiL4L4PosttestQQ5Option0 => 'Memakai delay(5000)';

  @override
  String get materiL4L4PosttestQQ5Option2 => 'Menghapus fungsi setup()';

  @override
  String get materiL4L4PosttestQQ5Option3 => 'Mengganti board Arduino';

  @override
  String get materiL4L4PosttestTitle => 'Post-Test Level 4';

  @override
  String get materiL4L4PretestQQ1Option0 => 'Putaran kontinu tanpa batas';

  @override
  String get materiL4L4PretestQQ1Option2 => 'Menyambung beban AC';

  @override
  String get materiL4L4PretestQQ1Option3 => 'Mengukur suhu';

  @override
  String get materiL4L4PretestQQ1Question => 'Servo digunakan untuk...';

  @override
  String get materiL4L4PretestQQ2Option0 => 'VCC 5V';

  @override
  String get materiL4L4PretestQQ2Option1 => 'Ground';

  @override
  String get materiL4L4PretestQQ2Option2 => 'Pin Reset';

  @override
  String get materiL4L4PretestQQ2Option3 => 'Pin RX';

  @override
  String get materiL4L4PretestQQ3Option1 => 'Bekerja lebih cepat';

  @override
  String get materiL4L4PretestQQ3Option2 => 'Menghemat daya otomatis';

  @override
  String get materiL4L4PretestQQ3Option3 => 'Mengaktifkan PWM';

  @override
  String get materiL4L4PretestQQ4Option0 => 'Bouncing';

  @override
  String get materiL4L4PretestQQ4Option1 => 'Floating';

  @override
  String get materiL4L4PretestQQ4Option2 => 'Overflow';

  @override
  String get materiL4L4PretestQQ4Option3 => 'Polling';

  @override
  String get materiL4L4PretestTitle => 'Pre-Test Level 4';

  @override
  String get materiL4L4TimerTanpaHentiEstimatedTime => '10 menit';

  @override
  String get materiL4L4TimerTanpaHentiTitle => 'Timer Tanpa Henti (millis)';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary4Heading => 'Sorotan Utama';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary6Heading => 'Wawasan Kunci';

  @override
  String get materiL5L5M1EstimatedTime => '8 menit';

  @override
  String get materiL5L5M1Title => 'Deskripsi Proyek & Histeresis';

  @override
  String get materiL5L5M2EstimatedTime => '10 menit';

  @override
  String get materiL5L5M2Title => 'Rangkaian Lengkap';

  @override
  String get materiL5L5M3EstimatedTime => '15 menit';

  @override
  String get materiL5L5M3Title => 'Kode Program Kipas Otomatis';

  @override
  String get materiL5L5M4EstimatedTime => '10 menit';

  @override
  String get materiL5L5M4Title => 'Pengujian & Pengembangan';

  @override
  String get materiL5L5PosttestQQ1Option1 => 'Mempercepat pembacaan sensor';

  @override
  String get materiL5L5PosttestQQ1Option2 => 'Menghemat memori';

  @override
  String get materiL5L5PosttestQQ1Option3 => 'Mengganti sensor';

  @override
  String get materiL5L5PosttestQQ2Option0 => 'â‰¤ 28 Â°C';

  @override
  String get materiL5L5PosttestQQ2Option1 => 'â‰¥ 30 Â°C';

  @override
  String get materiL5L5PosttestQQ2Option2 => 'Tepat 29 Â°C';

  @override
  String get materiL5L5PosttestQQ2Option3 => 'Tidak terbaca';

  @override
  String get materiL5L5PosttestQQ3Option1 => 'Lebih murah';

  @override
  String get materiL5L5PosttestQQ3Option2 => 'Lebih cepat';

  @override
  String get materiL5L5PosttestQQ3Option3 => 'Terminal NC pasti rusak';

  @override
  String get materiL5L5PosttestQQ4Option0 => 'Pembacaan sensor gagal';

  @override
  String get materiL5L5PosttestQQ4Option1 => 'Suhu sangat tinggi';

  @override
  String get materiL5L5PosttestQQ4Option2 => 'Kipas sedang ON';

  @override
  String get materiL5L5PosttestQQ4Option3 => 'OLED rusak';

  @override
  String get materiL5L5PosttestQQ5Option0 =>
      'Galat mutlak / pembanding Ã— 100%';

  @override
  String get materiL5L5PosttestQQ5Option1 => 'Pembanding / galat mutlak';

  @override
  String get materiL5L5PosttestQQ5Option2 => 'DHT11 Ã— 100%';

  @override
  String get materiL5L5PosttestQQ5Option3 => 'Galat mutlak âˆ’ pembanding';

  @override
  String get materiL5L5PosttestTitle => 'Post-Test Level 5';

  @override
  String get materiL5L5PretestQQ1Option1 => 'Penguat suara';

  @override
  String get materiL5L5PretestQQ1Option2 => 'Sensor suhu';

  @override
  String get materiL5L5PretestQQ1Option3 => 'Penyimpan data';

  @override
  String get materiL5L5PretestQQ1Question => 'Relay berfungsi sebagai...';

  @override
  String get materiL5L5PretestQQ2Option0 => 'Suhu dan kelembaban';

  @override
  String get materiL5L5PretestQQ2Option1 => 'Jarak';

  @override
  String get materiL5L5PretestQQ2Option2 => 'Kadar gas';

  @override
  String get materiL5L5PretestQQ2Option3 => 'Cahaya';

  @override
  String get materiL5L5PretestQQ2Question => 'Sensor DHT11 mengukur...';

  @override
  String get materiL5L5PretestQQ3Option0 => 'A4 (SDA) dan A5 (SCL)';

  @override
  String get materiL5L5PretestQQ3Option1 => 'D0 dan D1';

  @override
  String get materiL5L5PretestQQ3Option2 => 'D2 dan D3';

  @override
  String get materiL5L5PretestQQ3Option3 => 'A0 dan A1';

  @override
  String get materiL5L5PretestQQ4Option0 => '0x3C';

  @override
  String get materiL5L5PretestQQ4Option1 => '0xFF';

  @override
  String get materiL5L5PretestQQ4Option2 => '0x00';

  @override
  String get materiL5L5PretestQQ4Option3 => '0x68';

  @override
  String get materiL5L5PretestTitle => 'Pre-Test Level 5';

  @override
  String get materiKomponenL1KomBreadboardContent0Text =>
      'Breadboard adalah alat prototipe untuk merangkai rangkaian elektronik tanpa menyolder. Memahami pola koneksinya penting agar rangkaian tidak salah sambung.';

  @override
  String get materiKomponenL1KomBreadboardContent1Text =>
      'Poin penting:\n- Jalur biru dan merah menandai baris yang terhubung.\n- Celah tengah memisahkan dua sisi, cocok untuk memasang IC.\n- Pin berdekatan belum tentu terhubung, periksa polanya.\n- Gunakan avometer mode continuity untuk menguji koneksi.\n- Tersedia tipe 400 dan 830 pin.';

  @override
  String get materiKomponenL1KomBreadboardDescription =>
      'Breadboard adalah papan untuk merangkai komponen elektronik tanpa solder, dengan pola koneksi pin yang sudah ditentukan.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary0Heading =>
      'Bab 1: Struktur Breadboard';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary1Text =>
      'Breadboard terdiri dari deretan pin yang terhubung secara internal dengan pola tertentu. Jalur berwarna biru dan merah menunjukkan baris yang saling terhubung.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary2Text =>
      'Terdapat dua tipe breadboard dengan jumlah pin berbeda, sekitar 400 pin dan 830 pin, tetapi prinsip kerjanya sama.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary3Heading =>
      'Bab 2: Pola Koneksi dan Celah Tengah';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary4Text =>
      'Pin yang berdekatan belum tentu terhubung karena ada celah pembatas di bagian tengah. Jalur koneksi umumnya horizontal di sisi pinggir dan vertikal di bagian tengah.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary5Text =>
      'Celah tengah dimanfaatkan untuk memasang IC agar pin kiri dan kanan IC tidak saling terhubung.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary6Heading =>
      'Bab 3: Pengujian dan Penggunaan';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary7Text =>
      'Multimeter (avometer) dengan fungsi continuity test dapat digunakan untuk memeriksa apakah pin-pin breadboard saling terhubung.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary8Text =>
      'Breadboard digunakan untuk membuat prototipe rangkaian tanpa menyolder, sehingga memudahkan perubahan dan pengujian.';

  @override
  String get materiKomponenL1KomHukumOhmContent0Text =>
      'Hukum Ohm menghubungkan arus, tegangan, dan hambatan dalam rangkaian listrik. Rumus dasarnya: I = V / R.';

  @override
  String get materiKomponenL1KomHukumOhmContent1Text =>
      'Poin penting:\n- Arus berbanding lurus dengan tegangan.\n- Arus berbanding terbalik dengan hambatan.\n- Satuan: I (ampere), V (volt), R (ohm).\n- Dapat dipakai untuk menghitung salah satu nilai jika dua lainnya diketahui.';

  @override
  String get materiKomponenL1KomHukumOhmDescription =>
      'Hukum Ohm menjelaskan hubungan antara arus, tegangan, dan hambatan dalam rangkaian listrik, dengan rumus I = V / R.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary0Heading =>
      'Bab 1: Pengertian Hukum Ohm';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary1Text =>
      'Hukum Ohm adalah prinsip dasar elektronika yang menjelaskan hubungan antara arus listrik (I), tegangan (V), dan hambatan (R) dalam suatu rangkaian.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary2Text =>
      'Arus yang mengalir melalui konduktor berbanding lurus dengan tegangan yang diberikan dan berbanding terbalik dengan hambatannya.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary3Heading =>
      'Bab 2: Rumus Hukum Ohm';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary4Text =>
      'Rumusnya adalah I = V / R, dengan I dalam ampere, V dalam volt, dan R dalam ohm.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary5Heading =>
      'Bab 3: Contoh Soal';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary6Text =>
      'Contoh pertama adalah menghitung arus yang mengalir melalui sebuah lampu dengan hambatan dan tegangan tertentu.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary7Text =>
      'Contoh kedua adalah menghitung tegangan yang dibutuhkan untuk menghasilkan arus tertentu pada hambatan tertentu.';

  @override
  String get materiKomponenL1KomKapasitorContent0Text =>
      'Kapasitor menyimpan dan melepaskan energi listrik. Fungsinya antara lain menjaga kestabilan tegangan, menyaring sinyal, dan penyetelan frekuensi.';

  @override
  String get materiKomponenL1KomKapasitorContent1Text =>
      'Poin penting:\n- Struktur: dua pelat logam dengan bahan dielektrik di antaranya.\n- Jenis keramik untuk kapasitansi kecil dan frekuensi tinggi.\n- Jenis poliester untuk audio.\n- Elco dan solid capacitor berpolaritas, pasang sesuai kaki positif dan negatif.\n- Variable capacitor untuk penyetelan frekuensi radio.\n- Rentang nilai dari pF hingga F.';

  @override
  String get materiKomponenL1KomKapasitorDescription =>
      'Kapasitor adalah komponen yang menyimpan dan melepaskan energi listrik dengan cepat, dengan jenis yang ditentukan oleh bahan dielektriknya.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary0Heading =>
      'Bab 1: Pengertian Kapasitor';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary10Text =>
      'Pemasangan kapasitor berpolaritas dengan terbalik dapat menyebabkan kerusakan, bahkan ledakan.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary1Text =>
      'Kapasitor adalah komponen elektronik yang mampu menyimpan dan melepas energi listrik secara cepat. Komponen ini terdiri dari dua pelat logam yang dipisahkan oleh bahan dielektrik yang tidak menghantarkan listrik.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary2Text =>
      'Bahan dielektrik menentukan jenis kapasitor, misalnya keramik, kertas, atau poliester.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary3Heading =>
      'Bab 2: Jenis-Jenis Kapasitor';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary4Text =>
      'Kapasitor keramik umum ditemui, berkapasitansi kecil, dan sering dipakai untuk frekuensi tinggi. Kapasitor poliester banyak dipakai pada aplikasi audio.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary5Text =>
      'Kapasitor elektrolitik (Elco) dan solid capacitor memiliki kapasitansi besar dan berpolaritas, sehingga harus dipasang dengan benar. Solid capacitor lebih tahan panas dan awet, banyak dipakai di motherboard komputer.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary6Text =>
      'Variable capacitor dapat diatur nilainya secara mekanis dan sering dipakai untuk penyetelan frekuensi pada radio.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary7Text =>
      'Superkapasitor memiliki kapasitansi hingga ratusan farad dan berpotensi menggantikan baterai pada beberapa aplikasi.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary8Heading =>
      'Bab 3: Rentang Kapasitansi dan Keselamatan';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary9Text =>
      'Kapasitansi kapasitor bervariasi dari beberapa pikofarad (pF) hingga ratusan farad (F).';

  @override
  String get materiKomponenL1KomLedContent0Text =>
      'LED (Light Emitting Diode) adalah dioda yang memancarkan cahaya. Berbeda dengan lampu pijar, LED menghasilkan cahaya melalui rekombinasi elektron dan lubang muatan di dalam semikonduktor, sehingga lebih efisien dan lebih tahan lama.';

  @override
  String get materiKomponenL1KomLedContent1Text =>
      'Poin penting:\n- Warna LED ditentukan oleh bahan semikonduktor.\n- Tegangan maju (Vf) berbeda untuk setiap warna.\n- Sudut pancaran dan intensitas cahaya dapat dipilih sesuai kebutuhan.\n- Kaki LED memiliki polaritas, dan kaki panjang umumnya adalah anoda.';

  @override
  String get materiKomponenL1KomLedContent2Text =>
      'Jenis LED: through-hole (umum, 5 mm), SMD (kecil dan tipis), berdaya tinggi (perlu pendingin), COB (banyak chip dalam satu modul), RGB (multi-warna), dan alfanumerik (display angka dan huruf).';

  @override
  String get materiKomponenL1KomLedDescription =>
      'LED adalah dioda yang memancarkan cahaya saat dialiri listrik, dengan warna dan tegangan kerja yang ditentukan oleh bahan semikonduktornya.';

  @override
  String get materiKomponenL1KomLedVideoSummary0Heading =>
      'Bab 1: Pengenalan LED';

  @override
  String get materiKomponenL1KomLedVideoSummary1Text =>
      'LED bukan lampu biasa seperti lampu pijar, melainkan jenis dioda yang memancarkan cahaya ketika dialiri listrik. LED terbuat dari bahan semikonduktor tipe P dan tipe N, dan cahaya dihasilkan saat elektron dan lubang muatan bertemu.';

  @override
  String get materiKomponenL1KomLedVideoSummary2Heading =>
      'Bab 2: Warna, Tegangan, dan Karakteristik';

  @override
  String get materiKomponenL1KomLedVideoSummary3Text =>
      'Warna cahaya LED ditentukan oleh bahan pembuatnya, yang juga menentukan panjang gelombang dan tegangan kerja. Contohnya, LED biru biasanya membutuhkan tegangan maju lebih tinggi dibanding LED merah.';

  @override
  String get materiKomponenL1KomLedVideoSummary4Text =>
      'Karakteristik lain yang perlu diperhatikan adalah sudut pancaran cahaya (sekitar 10° sampai 120°) dan intensitas cahaya yang diukur dalam millicandela.';

  @override
  String get materiKomponenL1KomLedVideoSummary5Heading =>
      'Bab 3: Jenis-Jenis LED';

  @override
  String get materiKomponenL1KomLedVideoSummary6Text =>
      'LED through-hole adalah tipe yang umum dengan ukuran paling sering 5 mm, mudah dipasang, dan polaritasnya mudah dikenali dari panjang kaki.';

  @override
  String get materiKomponenL1KomLedVideoSummary7Text =>
      'LED SMD berukuran sangat kecil dan tipis, cocok untuk pemasangan massal pada ruang terbatas. LED berdaya tinggi sangat terang tetapi menghasilkan panas sehingga memerlukan heatsink.';

  @override
  String get materiKomponenL1KomLedVideoSummary8Text =>
      'LED COB menggabungkan banyak chip dalam satu modul kecil. LED RGB terdiri dari tiga warna dasar merah, hijau, dan biru yang dapat dikontrol secara independen untuk menghasilkan berbagai warna.';

  @override
  String get materiKomponenL1KomLedVideoSummary9Text =>
      'LED alfanumerik digunakan sebagai tampilan angka dan huruf pada berbagai alat elektronik.';

  @override
  String get materiKomponenL1KomResistorContent0Text =>
      'Nilai resistor dibaca dari kode warna gelang. Untuk resistor di bawah 1 ohm, gelang pengali bernilai pecahan, sehingga nilai akhirnya bisa berupa desimal.';

  @override
  String get materiKomponenL1KomResistorContent2Text =>
      'Poin penting:\n- Dua gelang pertama adalah digit signifikan.\n- Gelang ketiga adalah pengali.\n- Gelang emas menandakan toleransi 5%.\n- Metode yang sama berlaku dari 1 kiloohm hingga 1 gigaohm.';

  @override
  String get materiKomponenL1KomResistorDescription =>
      'Cara menghitung nilai resistor dengan kode warna, termasuk resistor di bawah 1 ohm menggunakan metode kedua.';

  @override
  String get materiKomponenL1KomResistorTitle =>
      'Resistor (Cara Menghitung Nilai)';

  @override
  String get materiKomponenL1KomResistorVideoSummary0Heading =>
      'Bab 1: Metode Kedua untuk Resistor';

  @override
  String get materiKomponenL1KomResistorVideoSummary1Text =>
      'Video ini membahas cara kedua menghitung nilai resistor, khususnya resistor dengan nilai di bawah 1 ohm, menggunakan tabel khusus.';

  @override
  String get materiKomponenL1KomResistorVideoSummary2Text =>
      'Metode ini menyediakan dua cara perhitungan, yaitu cara konvensional dan cara menggunakan bilangan berpangkat. Hasil keduanya sama.';

  @override
  String get materiKomponenL1KomResistorVideoSummary3Heading =>
      'Bab 2: Contoh Perhitungan';

  @override
  String get materiKomponenL1KomResistorVideoSummary4Text =>
      'Contohnya adalah resistor dengan gelang hijau, hitam, silver, dan emas. Warna hijau bernilai 5, hitam bernilai 0, dan silver sebagai pengali bernilai 0,01.';

  @override
  String get materiKomponenL1KomResistorVideoSummary5Text =>
      'Perhitungannya adalah 50 x 0,01 = 0,5 ohm, dengan toleransi 5% yang ditandai gelang emas.';

  @override
  String get materiKomponenL1KomResistorVideoSummary6Heading =>
      'Bab 3: Cakupan Metode';

  @override
  String get materiKomponenL1KomResistorVideoSummary7Text =>
      'Metode ini juga berlaku untuk semua resistor dengan rentang nilai dari 1 kiloohm sampai 1 gigaohm.';

  @override
  String get materiKomponenL1KomTactileSwitchContent0Text =>
      'Tactile switch adalah push button kecil yang memberikan sinyal on saat ditekan dan off saat dilepas. Cocok untuk input tombol pada rangkaian elektronik kecil.';

  @override
  String get materiKomponenL1KomTactileSwitchContent1Text =>
      'Poin penting:\n- Sifatnya momentary (tekan untuk on, lepas untuk off).\n- Tegangan kerja DC sekitar 4,5 sampai 12 V.\n- Arus maksimum sekitar 100 mA.\n- Tidak disarankan untuk rangkaian AC.\n- Umum dipakai pada remote control dan perangkat elektronik kecil.';

  @override
  String get materiKomponenL1KomTactileSwitchDescription =>
      'Tactile switch adalah saklar tekan kecil yang aktif saat ditekan dan mati saat dilepas, umum dipakai pada rangkaian DC tegangan rendah.';

  @override
  String get materiKomponenL1KomTactileSwitchTitle =>
      'Tactile Switch (Push Button)';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary0Heading =>
      'Bab 1: Pengenalan Saklar Mini Tactile';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary1Text =>
      'Saklar mini atau tactile switch, juga dikenal sebagai micro switch, berukuran sangat kecil dan berfungsi sebagai saklar tekan (push button).';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary2Text =>
      'Saklar ini bekerja secara momentary: on saat ditekan dan off saat dilepas.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary3Heading =>
      'Bab 2: Pin dan Prinsip Kerja';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary4Text =>
      'Saklar ini umumnya memiliki empat pin, tetapi prinsip kerjanya sederhana dengan dua kutub. Dua pin biasanya berpasangan secara paralel sehingga stabil secara mekanis dan listrik.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary5Text =>
      'Terdapat variasi bentuk batang, dari panjang, pendek, hingga pipih, sesuai kebutuhan desain.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary6Heading =>
      'Bab 3: Batasan dan Aplikasi';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary7Text =>
      'Saklar digunakan pada rangkaian DC dengan tegangan sekitar 4,5 sampai 12 volt dan arus maksimum sekitar 100 mA.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary8Text =>
      'Saklar ini jarang digunakan pada rangkaian AC karena alasan keselamatan dan peruntukannya untuk sirkuit DC kecil.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary9Text =>
      'Saklar ditemukan pada remote control, TV lama, dan set-top box. Pemasangannya dilakukan pada PCB, atau breadboard untuk eksperimen.';

  @override
  String get materiL1L1KomBreadboardContent0Text =>
      'Breadboard adalah alat prototipe untuk merangkai rangkaian elektronik tanpa menyolder. Memahami pola koneksinya penting agar rangkaian tidak salah sambung.';

  @override
  String get materiL1L1KomBreadboardContent1Text =>
      'Poin penting:\n- Jalur biru dan merah menandai baris yang terhubung.\n- Celah tengah memisahkan dua sisi, cocok untuk memasang IC.\n- Pin berdekatan belum tentu terhubung, periksa polanya.\n- Gunakan avometer mode continuity untuk menguji koneksi.\n- Tersedia tipe 400 dan 830 pin.';

  @override
  String get materiL1L1KomBreadboardDescription =>
      'Breadboard adalah papan untuk merangkai komponen elektronik tanpa solder, dengan pola koneksi pin yang sudah ditentukan.';

  @override
  String get materiL1L1KomBreadboardVideoSummary0Heading =>
      'Bab 1: Struktur Breadboard';

  @override
  String get materiL1L1KomBreadboardVideoSummary1Text =>
      'Breadboard terdiri dari deretan pin yang terhubung secara internal dengan pola tertentu. Jalur berwarna biru dan merah menunjukkan baris yang saling terhubung.';

  @override
  String get materiL1L1KomBreadboardVideoSummary2Text =>
      'Terdapat dua tipe breadboard dengan jumlah pin berbeda, sekitar 400 pin dan 830 pin, tetapi prinsip kerjanya sama.';

  @override
  String get materiL1L1KomBreadboardVideoSummary3Heading =>
      'Bab 2: Pola Koneksi dan Celah Tengah';

  @override
  String get materiL1L1KomBreadboardVideoSummary4Text =>
      'Pin yang berdekatan belum tentu terhubung karena ada celah pembatas di bagian tengah. Jalur koneksi umumnya horizontal di sisi pinggir dan vertikal di bagian tengah.';

  @override
  String get materiL1L1KomBreadboardVideoSummary5Text =>
      'Celah tengah dimanfaatkan untuk memasang IC agar pin kiri dan kanan IC tidak saling terhubung.';

  @override
  String get materiL1L1KomBreadboardVideoSummary6Heading =>
      'Bab 3: Pengujian dan Penggunaan';

  @override
  String get materiL1L1KomBreadboardVideoSummary7Text =>
      'Multimeter (avometer) dengan fungsi continuity test dapat digunakan untuk memeriksa apakah pin-pin breadboard saling terhubung.';

  @override
  String get materiL1L1KomBreadboardVideoSummary8Text =>
      'Breadboard digunakan untuk membuat prototipe rangkaian tanpa menyolder, sehingga memudahkan perubahan dan pengujian.';

  @override
  String get materiL1L1KomHukumOhmContent0Text =>
      'Hukum Ohm menghubungkan arus, tegangan, dan hambatan dalam rangkaian listrik. Rumus dasarnya: I = V / R.';

  @override
  String get materiL1L1KomHukumOhmContent1Text =>
      'Poin penting:\n- Arus berbanding lurus dengan tegangan.\n- Arus berbanding terbalik dengan hambatan.\n- Satuan: I (ampere), V (volt), R (ohm).\n- Dapat dipakai untuk menghitung salah satu nilai jika dua lainnya diketahui.';

  @override
  String get materiL1L1KomHukumOhmDescription =>
      'Hukum Ohm menjelaskan hubungan antara arus, tegangan, dan hambatan dalam rangkaian listrik, dengan rumus I = V / R.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary0Heading =>
      'Bab 1: Pengertian Hukum Ohm';

  @override
  String get materiL1L1KomHukumOhmVideoSummary1Text =>
      'Hukum Ohm adalah prinsip dasar elektronika yang menjelaskan hubungan antara arus listrik (I), tegangan (V), dan hambatan (R) dalam suatu rangkaian.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary2Text =>
      'Arus yang mengalir melalui konduktor berbanding lurus dengan tegangan yang diberikan dan berbanding terbalik dengan hambatannya.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary3Heading =>
      'Bab 2: Rumus Hukum Ohm';

  @override
  String get materiL1L1KomHukumOhmVideoSummary4Text =>
      'Rumusnya adalah I = V / R, dengan I dalam ampere, V dalam volt, dan R dalam ohm.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary6Text =>
      'Contoh pertama adalah menghitung arus yang mengalir melalui sebuah lampu dengan hambatan dan tegangan tertentu.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary7Text =>
      'Contoh kedua adalah menghitung tegangan yang dibutuhkan untuk menghasilkan arus tertentu pada hambatan tertentu.';

  @override
  String get materiL1L1KomKapasitorContent0Text =>
      'Kapasitor menyimpan dan melepaskan energi listrik. Fungsinya antara lain menjaga kestabilan tegangan, menyaring sinyal, dan penyetelan frekuensi.';

  @override
  String get materiL1L1KomKapasitorContent1Text =>
      'Poin penting:\n- Struktur: dua pelat logam dengan bahan dielektrik di antaranya.\n- Jenis keramik untuk kapasitansi kecil dan frekuensi tinggi.\n- Jenis poliester untuk audio.\n- Elco dan solid capacitor berpolaritas, pasang sesuai kaki positif dan negatif.\n- Variable capacitor untuk penyetelan frekuensi radio.\n- Rentang nilai dari pF hingga F.';

  @override
  String get materiL1L1KomKapasitorDescription =>
      'Kapasitor adalah komponen yang menyimpan dan melepaskan energi listrik dengan cepat, dengan jenis yang ditentukan oleh bahan dielektriknya.';

  @override
  String get materiL1L1KomKapasitorVideoSummary0Heading =>
      'Bab 1: Pengertian Kapasitor';

  @override
  String get materiL1L1KomKapasitorVideoSummary10Text =>
      'Pemasangan kapasitor berpolaritas dengan terbalik dapat menyebabkan kerusakan, bahkan ledakan.';

  @override
  String get materiL1L1KomKapasitorVideoSummary1Text =>
      'Kapasitor adalah komponen elektronik yang mampu menyimpan dan melepas energi listrik secara cepat. Komponen ini terdiri dari dua pelat logam yang dipisahkan oleh bahan dielektrik yang tidak menghantarkan listrik.';

  @override
  String get materiL1L1KomKapasitorVideoSummary2Text =>
      'Bahan dielektrik menentukan jenis kapasitor, misalnya keramik, kertas, atau poliester.';

  @override
  String get materiL1L1KomKapasitorVideoSummary3Heading =>
      'Bab 2: Jenis-Jenis Kapasitor';

  @override
  String get materiL1L1KomKapasitorVideoSummary4Text =>
      'Kapasitor keramik umum ditemui, berkapasitansi kecil, dan sering dipakai untuk frekuensi tinggi. Kapasitor poliester banyak dipakai pada aplikasi audio.';

  @override
  String get materiL1L1KomKapasitorVideoSummary5Text =>
      'Kapasitor elektrolitik (Elco) dan solid capacitor memiliki kapasitansi besar dan berpolaritas, sehingga harus dipasang dengan benar. Solid capacitor lebih tahan panas dan awet, banyak dipakai di motherboard komputer.';

  @override
  String get materiL1L1KomKapasitorVideoSummary6Text =>
      'Variable capacitor dapat diatur nilainya secara mekanis dan sering dipakai untuk penyetelan frekuensi pada radio.';

  @override
  String get materiL1L1KomKapasitorVideoSummary7Text =>
      'Superkapasitor memiliki kapasitansi hingga ratusan farad dan berpotensi menggantikan baterai pada beberapa aplikasi.';

  @override
  String get materiL1L1KomKapasitorVideoSummary8Heading =>
      'Bab 3: Rentang Kapasitansi dan Keselamatan';

  @override
  String get materiL1L1KomKapasitorVideoSummary9Text =>
      'Kapasitansi kapasitor bervariasi dari beberapa pikofarad (pF) hingga ratusan farad (F).';

  @override
  String get materiL1L1KomLedContent0Text =>
      'LED (Light Emitting Diode) adalah dioda yang memancarkan cahaya. Berbeda dengan lampu pijar, LED menghasilkan cahaya melalui rekombinasi elektron dan lubang muatan di dalam semikonduktor, sehingga lebih efisien dan lebih tahan lama.';

  @override
  String get materiL1L1KomLedContent1Text =>
      'Poin penting:\n- Warna LED ditentukan oleh bahan semikonduktor.\n- Tegangan maju (Vf) berbeda untuk setiap warna.\n- Sudut pancaran dan intensitas cahaya dapat dipilih sesuai kebutuhan.\n- Kaki LED memiliki polaritas, dan kaki panjang umumnya adalah anoda.';

  @override
  String get materiL1L1KomLedContent2Text =>
      'Jenis LED: through-hole (umum, 5 mm), SMD (kecil dan tipis), berdaya tinggi (perlu pendingin), COB (banyak chip dalam satu modul), RGB (multi-warna), dan alfanumerik (display angka dan huruf).';

  @override
  String get materiL1L1KomLedDescription =>
      'LED adalah dioda yang memancarkan cahaya saat dialiri listrik, dengan warna dan tegangan kerja yang ditentukan oleh bahan semikonduktornya.';

  @override
  String get materiL1L1KomLedVideoSummary1Text =>
      'LED bukan lampu biasa seperti lampu pijar, melainkan jenis dioda yang memancarkan cahaya ketika dialiri listrik. LED terbuat dari bahan semikonduktor tipe P dan tipe N, dan cahaya dihasilkan saat elektron dan lubang muatan bertemu.';

  @override
  String get materiL1L1KomLedVideoSummary2Heading =>
      'Bab 2: Warna, Tegangan, dan Karakteristik';

  @override
  String get materiL1L1KomLedVideoSummary3Text =>
      'Warna cahaya LED ditentukan oleh bahan pembuatnya, yang juga menentukan panjang gelombang dan tegangan kerja. Contohnya, LED biru biasanya membutuhkan tegangan maju lebih tinggi dibanding LED merah.';

  @override
  String get materiL1L1KomLedVideoSummary4Text =>
      'Karakteristik lain yang perlu diperhatikan adalah sudut pancaran cahaya (sekitar 10° sampai 120°) dan intensitas cahaya yang diukur dalam millicandela.';

  @override
  String get materiL1L1KomLedVideoSummary6Text =>
      'LED through-hole adalah tipe yang umum dengan ukuran paling sering 5 mm, mudah dipasang, dan polaritasnya mudah dikenali dari panjang kaki.';

  @override
  String get materiL1L1KomLedVideoSummary7Text =>
      'LED SMD berukuran sangat kecil dan tipis, cocok untuk pemasangan massal pada ruang terbatas. LED berdaya tinggi sangat terang tetapi menghasilkan panas sehingga memerlukan heatsink.';

  @override
  String get materiL1L1KomLedVideoSummary8Text =>
      'LED COB menggabungkan banyak chip dalam satu modul kecil. LED RGB terdiri dari tiga warna dasar merah, hijau, dan biru yang dapat dikontrol secara independen untuk menghasilkan berbagai warna.';

  @override
  String get materiL1L1KomLedVideoSummary9Text =>
      'LED alfanumerik digunakan sebagai tampilan angka dan huruf pada berbagai alat elektronik.';

  @override
  String get materiL1L1KomResistorContent0Text =>
      'Nilai resistor dibaca dari kode warna gelang. Untuk resistor di bawah 1 ohm, gelang pengali bernilai pecahan, sehingga nilai akhirnya bisa berupa desimal.';

  @override
  String get materiL1L1KomResistorContent2Text =>
      'Poin penting:\n- Dua gelang pertama adalah digit signifikan.\n- Gelang ketiga adalah pengali.\n- Gelang emas menandakan toleransi 5%.\n- Metode yang sama berlaku dari 1 kiloohm hingga 1 gigaohm.';

  @override
  String get materiL1L1KomResistorDescription =>
      'Cara menghitung nilai resistor dengan kode warna, termasuk resistor di bawah 1 ohm menggunakan metode kedua.';

  @override
  String get materiL1L1KomResistorVideoSummary0Heading =>
      'Bab 1: Metode Kedua untuk Resistor';

  @override
  String get materiL1L1KomResistorVideoSummary1Text =>
      'Video ini membahas cara kedua menghitung nilai resistor, khususnya resistor dengan nilai di bawah 1 ohm, menggunakan tabel khusus.';

  @override
  String get materiL1L1KomResistorVideoSummary2Text =>
      'Metode ini menyediakan dua cara perhitungan, yaitu cara konvensional dan cara menggunakan bilangan berpangkat. Hasil keduanya sama.';

  @override
  String get materiL1L1KomResistorVideoSummary3Heading =>
      'Bab 2: Contoh Perhitungan';

  @override
  String get materiL1L1KomResistorVideoSummary4Text =>
      'Contohnya adalah resistor dengan gelang hijau, hitam, silver, dan emas. Warna hijau bernilai 5, hitam bernilai 0, dan silver sebagai pengali bernilai 0,01.';

  @override
  String get materiL1L1KomResistorVideoSummary5Text =>
      'Perhitungannya adalah 50 x 0,01 = 0,5 ohm, dengan toleransi 5% yang ditandai gelang emas.';

  @override
  String get materiL1L1KomResistorVideoSummary6Heading =>
      'Bab 3: Cakupan Metode';

  @override
  String get materiL1L1KomResistorVideoSummary7Text =>
      'Metode ini juga berlaku untuk semua resistor dengan rentang nilai dari 1 kiloohm sampai 1 gigaohm.';

  @override
  String get materiL1L1KomTactileSwitchContent0Text =>
      'Tactile switch adalah push button kecil yang memberikan sinyal on saat ditekan dan off saat dilepas. Cocok untuk input tombol pada rangkaian elektronik kecil.';

  @override
  String get materiL1L1KomTactileSwitchContent1Text =>
      'Poin penting:\n- Sifatnya momentary (tekan untuk on, lepas untuk off).\n- Tegangan kerja DC sekitar 4,5 sampai 12 V.\n- Arus maksimum sekitar 100 mA.\n- Tidak disarankan untuk rangkaian AC.\n- Umum dipakai pada remote control dan perangkat elektronik kecil.';

  @override
  String get materiL1L1KomTactileSwitchDescription =>
      'Tactile switch adalah saklar tekan kecil yang aktif saat ditekan dan mati saat dilepas, umum dipakai pada rangkaian DC tegangan rendah.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary0Heading =>
      'Bab 1: Pengenalan Saklar Mini Tactile';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary1Text =>
      'Saklar mini atau tactile switch, juga dikenal sebagai micro switch, berukuran sangat kecil dan berfungsi sebagai saklar tekan (push button).';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary2Text =>
      'Saklar ini bekerja secara momentary: on saat ditekan dan off saat dilepas.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary3Heading =>
      'Bab 2: Pin dan Prinsip Kerja';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary4Text =>
      'Saklar ini umumnya memiliki empat pin, tetapi prinsip kerjanya sederhana dengan dua kutub. Dua pin biasanya berpasangan secara paralel sehingga stabil secara mekanis dan listrik.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary5Text =>
      'Terdapat variasi bentuk batang, dari panjang, pendek, hingga pipih, sesuai kebutuhan desain.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary6Heading =>
      'Bab 3: Batasan dan Aplikasi';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary7Text =>
      'Saklar digunakan pada rangkaian DC dengan tegangan sekitar 4,5 sampai 12 volt dan arus maksimum sekitar 100 mA.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary8Text =>
      'Saklar ini jarang digunakan pada rangkaian AC karena alasan keselamatan dan peruntukannya untuk sirkuit DC kecil.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary9Text =>
      'Saklar ditemukan pada remote control, TV lama, dan set-top box. Pemasangannya dilakukan pada PCB, atau breadboard untuk eksperimen.';

  @override
  String get materiL1L1KomponenFolderDescription =>
      'Pelajari komponen-komponen dasar elektronika beserta fungsi dan karakteristiknya.';

  @override
  String get materiL1L1PosttestDescription =>
      'Uji pemahamanmu setelah belajar.';

  @override
  String get materiL1L1PosttestQQ2Question =>
      'Hasil hitung resistor LED adalah 150 Ω. Nilai standar aman yang dipilih pada modul adalah...';

  @override
  String get materiL1L1PosttestQQ3Question =>
      'Arus LED 2 V dengan resistor 220 Ω pada catu 5 V adalah sekitar...';

  @override
  String get materiL1L1PosttestQQ4Question =>
      'Batas arus yang aman per pin Arduino Uno adalah sekitar...';

  @override
  String get materiL1L1PosttestQQ5Question =>
      'Pada praktikum LED eksternal, resistor dan LED dihubungkan ke pin...';

  @override
  String get materiL1L1PretestDescription =>
      'Ukur pengetahuan awalmu tentang dasar elektronika.';

  @override
  String get materiL1L1PretestQQ1Question =>
      'Besaran yang mendorong muatan listrik mengalir disebut...';

  @override
  String get materiL1L1PretestQQ2Question =>
      'Satuan hambatan listrik adalah...';

  @override
  String get materiL1L1PretestQQ3Question =>
      'Pada LED, kaki yang lebih panjang adalah...';

  @override
  String get materiL1L1PretestQQ4Question =>
      'Chip mikrokontroler yang digunakan Arduino Uno adalah...';

  @override
  String get materiL2L2ArrayPointerContent0Text =>
      'Poin penting:\n• Array menyimpan banyak nilai dalam satu variabel; array multidimensi seperti tabel baris dan kolom.\n• Indeks array dimulai dari 0, jadi tambahkan 1 saat menampilkan nomor agar mudah dibaca.\n• Batasi indeks agar tidak melewati ukuran array.\n• Gunakan fungsi terpisah untuk mengisi data dan mencari nilai tertentu.';

  @override
  String get materiL2L2ArrayPointerContent1Text =>
      'Cara mencari nilai terendah:\n1. Mulai dari nilai awal yang besar (contoh 100).\n2. Bandingkan setiap elemen array dengan nilai tersebut.\n3. Jika ada elemen yang lebih kecil, ganti nilai terendah.\n4. Setelah semua elemen diperiksa, nilai yang tersisa adalah yang terendah.';

  @override
  String get materiL2L2ArrayPointerDescription =>
      'Mengelola data berbentuk tabel dengan array satu dimensi dan multidimensi, lengkap dengan fungsi dan pembatasan indeks.';

  @override
  String get materiL2L2ArrayPointerVideoSummary1Text =>
      'Video ini melanjutkan seri belajar Arduino dengan fokus pada array satu dimensi dan multidimensi. Array multidimensi dijelaskan sebagai data tabel seperti di Excel, misalnya nilai beberapa siswa pada beberapa mata pelajaran. Program mengisi nilai ke dalam array, lalu mencari nilai matematika terendah, nilai IPA tertinggi, dan nilai rata-rata tertinggi. Serial monitor dipakai untuk memantau nilai dan proses perhitungan langkah demi langkah.';

  @override
  String get materiL2L2ArrayPointerVideoSummary3Text =>
      '• Array multidimensi untuk merepresentasikan data tabel seperti nilai siswa.\n• Pengisian data nilai siswa ke dalam array multidimensi.\n• Fungsi khusus untuk mencari nilai terendah, tertinggi, dan rata-rata tertinggi.\n• Pembatasan indeks array agar tidak terjadi error saat indeks melebihi batas data.\n• Serial monitor untuk debugging dan memantau perhitungan secara real-time.\n• Variabel, fungsi, dan array digabung dalam satu program yang relatif lengkap.';

  @override
  String get materiL2L2ArrayPointerVideoSummary5Text =>
      '• Array multidimensi memudahkan pengelolaan data kompleks, terutama saat satu operasi melibatkan banyak data sekaligus.\n• Fungsi membuat kode modular: misalnya satu fungsi untuk mengisi nilai dan satu fungsi untuk mencari nilai terendah, sehingga kode lebih rapi dan mudah di-debug.\n• Pembatasan indeks krusial: array punya batas indeks tetap, jadi program harus memeriksa indeks agar tidak melebihi jumlah data dan menghindari error runtime.\n• Serial monitor menampilkan nilai dan hasil hitung berurutan, sehingga logika program mudah dipahami langkah demi langkah.\n• Penomoran ramah pengguna: menambah 1 pada indeks membuat nomor siswa dimulai dari 1, bukan 0.\n• Mencari nilai minimum atau maksimum: tentukan nilai awal (misalnya 100 untuk nilai terendah), bandingkan satu per satu, dan perbarui nilainya sampai ditemukan hasil yang dicari.';

  @override
  String get materiL2L2InputOutputContent0Text =>
      'Rangkaian:\n• Empat LED di pin digital 9 sampai 12.\n• Push button di pin analog 4.';

  @override
  String get materiL2L2InputOutputContent1Text =>
      'Poin penting:\n• Simpan pin LED dalam array konstan, lalu atur semuanya sebagai output dengan perulangan for.\n• Pin push button diatur sebagai input dan dibaca dengan digitalRead().\n• Setiap tekanan menambah penghitung x; switch case memilih LED yang menyala sesuai nilai x.\n• Saat x mencapai 4, reset ke 0 agar urutan kembali ke LED pertama.\n• Delay 300 ms mencegah pembacaan ganda akibat bouncing.';

  @override
  String get materiL2L2InputOutputDescription =>
      'Mengontrol empat LED secara bergantian dengan satu push button memakai array, perulangan for, dan switch case.';

  @override
  String get materiL2L2InputOutputVideoSummary1Text =>
      'Video ini menjawab pertanyaan: bisakah satu push button mengontrol beberapa LED secara bergantian? Empat LED dipasang di pin digital 9 sampai 12, dan push button di pin analog 4. Pin LED disimpan dalam array konstan dan diinisialisasi dengan perulangan for. Setiap kali tombol ditekan, variabel penghitung x bertambah satu, dan nilai x menentukan LED mana yang menyala lewat switch case. Setelah LED keempat, x kembali ke 0 sehingga urutan berulang.';

  @override
  String get materiL2L2InputOutputVideoSummary3Text =>
      '• Satu push button dapat mengontrol empat LED secara bergantian.\n• Array pin LED membuat kode rapi dan mudah ditambah.\n• Perulangan for dan switch case mengatur LED yang aktif.\n• Pin tombol harus diatur sebagai input dengan pinMode() dan dibaca dengan digitalRead().\n• Penghitung x di-reset ke 0 saat mencapai 4 agar siklus berulang.\n• Jeda 300 ms mencegah pembacaan ganda akibat bouncing tombol.';

  @override
  String get materiL2L2InputOutputVideoSummary5Text =>
      '• Array konstan untuk pin LED membuat program skalabel: menambah LED tidak perlu banyak mengubah kode.\n• Perulangan for dan switch case menghemat kode dan menghindari if-else yang rumit; nilai x langsung menentukan LED aktif.\n• Pin Arduino harus diset sebagai input secara eksplisit dengan pinMode(), lalu status tombol dibaca dengan digitalRead().\n• Mereset penghitung saat mencapai 4 adalah contoh sederhana pengendalian state yang berulang (siklik) dan sering dipakai di sistem embedded.\n• Delay 300 ms setelah pembacaan tombol meredam bouncing sehingga satu tekanan tidak terbaca berkali-kali.';

  @override
  String get materiL2L2InputOutputVideoSummary7Text =>
      '1. Inisialisasi array pin LED: LED[0] = 12, LED[1] = 11, LED[2] = 10, LED[3] = 9.\n2. Atur pin push button sebagai input.\n3. Baca status push button dengan digitalRead().\n4. Jika tombol ditekan (status == 1), tambahkan x = x + 1.\n5. Gunakan switch case pada x: 0 menyalakan LED 1, 1 menyalakan LED 2, 2 menyalakan LED 3, 3 menyalakan LED 4 (LED lain mati), dan 4 mereset x menjadi 0.\n6. Beri delay 300 ms sebelum membaca input lagi.\n7. Ulangi dari langkah 3.';

  @override
  String get materiL2L2OperatorPercabanganContent0Text =>
      'Poin penting:\n• Fungsi yang dipakai: setup(), loop(), digitalWrite(), delay(), dan digitalRead().\n• LED harus dipasang dengan resistor (contoh 220 ohm) agar arus aman.\n• Push button dibaca dengan digitalRead(); hasilnya diproses dengan if-else.\n• Contoh logika: jika tombol ditekan, kedipkan LED lebih cepat; jika tidak, kembali ke kecepatan normal.\n• Serial monitor membantu memantau status tombol saat debugging.';

  @override
  String get materiL2L2OperatorPercabanganContent1Text =>
      'Alur praktik:\n1. Kedipkan LED bawaan Arduino.\n2. Pindahkan ke LED eksternal di breadboard.\n3. Tambahkan LED kedua agar berkedip bergantian.\n4. Tambahkan push button untuk mengubah kecepatan kedip.';

  @override
  String get materiL2L2OperatorPercabanganDescription =>
      'Praktik membuat LED berkedip dan mengubah kecepatan kedipnya dengan push button memakai digitalRead() dan if-else.';

  @override
  String get materiL2L2OperatorPercabanganTitle =>
      'Operator & Percabangan (Simulasi LED)';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary1Text =>
      'Tutorial pengantar untuk pemula yang belajar Arduino dari nol. Video memakai Arduino Uno R3, breadboard, LED, resistor, dan push button. Alurnya: instalasi Arduino IDE, memasang komponen, membuat program LED berkedip, lalu membuat mode kecepatan kedip yang diubah dengan push button. Video juga menekankan kesabaran, eksplorasi mandiri, dan belajar bersama komunitas.';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary2Heading =>
      'Sorotan Utama';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary3Text =>
      '• Panduan memulai Arduino dari nol tanpa asumsi pengetahuan teknis.\n• Komponen yang dibahas: Arduino Uno R3, breadboard, LED, resistor, kabel jumper, dan push button.\n• Instalasi dan penggunaan Arduino IDE untuk pemrograman dasar LED.\n• Rangkaian LED sederhana yang berkedip dengan interval yang bisa diubah.\n• Dua LED berkedip bergantian pada breadboard.\n• Push button dipakai untuk mengubah kecepatan kedip LED secara interaktif.';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary4Heading =>
      'Wawasan Kunci';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary5Text =>
      '• Arduino sebagai otak rangkaian: program yang di-upload mengatur cara kerja komponen elektronik. Banyaknya pin I/O memudahkan sambungan ke sensor dan modul lain.\n• Breadboard: memudahkan merangkai tanpa solder. Jalur positif (garis merah) dan negatif (garis biru) serta jalur horizontal perlu dipahami agar tidak salah menyusun rangkaian.\n• Resistor: menghambat arus agar LED tidak rusak karena kelebihan arus. Resistor 220 ohm menjadi contoh paling dasar.\n• Arduino IDE dan bahasa Arduino (mirip C/C++): setup() untuk inisialisasi sekali, loop() untuk perintah berulang, serta digitalWrite() dan delay() untuk mengatur pin dan waktu.\n• Push button sebagai input: digitalRead() membaca status tombol, lalu if-else mengubah kecepatan kedip LED. Serial monitor dipakai untuk memantau status tombol (debugging).\n• Praktik langsung: unggah program, lalu coba modifikasi seperti mengubah nilai delay agar pemahaman lebih dalam.';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary6Heading =>
      'Langkah-langkah Penting';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary7Text =>
      '1. Siapkan peralatan dan komponen sesuai daftar.\n2. Pahami fungsi breadboard dan aturan jalur listriknya (merah positif, biru negatif).\n3. Pasang Arduino IDE versi terbaru dan sambungkan Arduino ke PC dengan kabel USB.\n4. Buat program pertama: LED bawaan Arduino berkedip dengan delay yang bisa diatur.\n5. Pasang LED di breadboard dengan resistor dan sambungkan ke pin digital Arduino.\n6. Ubah program agar mengendalikan LED eksternal pada pin yang sesuai, lalu uji.\n7. Tambahkan LED kedua untuk kedip bergantian.\n8. Pasang push button di breadboard dan sambungkan ke pin digital sebagai input.\n9. Program kecepatan kedip agar berubah saat tombol ditekan memakai digitalRead() dan if-else.\n10. Gunakan serial monitor untuk memantau status tombol.';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary9Text =>
      'Dengan biaya sekitar 100 ribu rupiah, siapa pun bisa mulai belajar Arduino. Pesan pembuat video: jangan cepat menyerah, terus bereksplorasi, dan berbagi di komunitas.';

  @override
  String get materiL2L2PosttestDescription =>
      'Uji pemahamanmu setelah belajar.';

  @override
  String get materiL2L2PosttestQQ1Question =>
      'Fungsi loop() pada sketch Arduino dijalankan...';

  @override
  String get materiL2L2PosttestQQ3Question =>
      'Terminal relay yang terhubung ke COM hanya saat relay aktif (ON) adalah...';

  @override
  String get materiL2L2PosttestQQ4Question =>
      'Perintah untuk membaca status tombol pada pin digital adalah...';

  @override
  String get materiL2L2PosttestQQ5Question =>
      'Cara menulis komentar satu baris pada kode Arduino adalah menggunakan...';

  @override
  String get materiL2L2PretestDescription =>
      'Ukur pengetahuan awalmu tentang pemrograman Arduino.';

  @override
  String get materiL2L2PretestQQ1Question =>
      'Fungsi setup() pada sketch Arduino dijalankan...';

  @override
  String get materiL2L2PretestQQ2Question =>
      'Tipe data untuk bilangan desimal adalah...';

  @override
  String get materiL2L2PretestQQ3Question =>
      'Dua keadaan pin digital adalah...';

  @override
  String get materiL2L2PretestQQ4Question =>
      'Indeks elemen pertama sebuah array adalah...';

  @override
  String get materiL2L2RelayContent0Text =>
      'Pin relay:\n• COM (Common): terminal bersama.\n• NO (Normally Open): terhubung ke COM hanya saat relay ON.\n• NC (Normally Close): terhubung ke COM saat relay OFF.';

  @override
  String get materiL2L2RelayContent1Text =>
      'Poin penting:\n• Relay memisahkan sisi kontrol (5V Arduino) dari sisi beban.\n• Kendalikan relay dengan pinMode(pin, OUTPUT) dan digitalWrite() HIGH atau LOW.\n• Atur siklus ON/OFF dengan delay, misalnya ON 5 detik lalu OFF 1 detik.\n• Menukar sambungan NO dan NC membalik pola hidup-mati beban.\n• Kemampuan relay pada video: AC hingga 250 volt, arus maksimal 10-15 ampere.';

  @override
  String get materiL2L2RelayDescription =>
      'Cara kerja relay 5V DC, fungsi pin COM, NO, dan NC, serta cara memprogramnya dengan Arduino.';

  @override
  String get materiL2L2RelayVideoSummary1Text =>
      'Video ini menjelaskan relay 5 volt DC dengan tiga pin utama: COM (Common), NO (Normally Open), dan NC (Normally Close). Relay bekerja sebagai saklar elektromagnetik yang menyambung atau memutus koneksi antar pin sesuai kondisi ON/OFF. Pembahasan mencakup fungsi tiap pin, pengkabelan relay dengan Arduino Nano, pemrograman sederhana lewat pin digital dengan interval waktu tertentu, dan demo pengendalian kipas DC 12 volt memakai pin NO dan NC. Relay ini juga dapat dipakai pada tegangan AC hingga 250 volt dengan arus maksimal 10-15 ampere.';

  @override
  String get materiL2L2RelayVideoSummary3Text =>
      '• Fungsi pin COM, NO, dan NC pada relay 5V DC.\n• Relay dihubungkan ke Arduino Nano lewat pin digital dan ground.\n• Pemrograman dasar relay tidak membutuhkan library khusus.\n• Waktu hidup-mati relay diatur dengan delay.\n• Demo kipas DC 12 volt, termasuk perbedaan kerja relay saat memakai NO dan NC.\n• Relay dapat mengendalikan beban AC hingga 250 volt dan maksimal 10-15 ampere.';

  @override
  String get materiL2L2RelayVideoSummary5Text =>
      '• NO dan NC: NO hanya terhubung dengan COM saat relay aktif (ON), sedangkan NC terhubung saat relay OFF. Dengan demikian ada dua skenario kendali beban tanpa mengubah rangkaian lain.\n• Relay sebagai saklar elektromagnetik: tegangan rendah (5V dari Arduino) dapat mengendalikan beban bertegangan tinggi atau arus besar karena sisi kontrol dan sisi beban terpisah.\n• Tanpa library khusus: cukup atur pin digital sebagai output lalu beri sinyal HIGH atau LOW.\n• Pengaturan waktu dengan delay: misalnya kipas menyala 5 detik, mati 1 detik, lalu berulang.\n• Menukar sambungan dari NO ke NC akan membalik pola hidup-mati perangkat tanpa mengubah kode.\n• Relay ini cocok untuk peralatan rumah tangga seperti lampu, kipas angin, atau mesin dengan tegangan AC standar.';

  @override
  String get materiL2L2StrukturSketchContent0Text =>
      'Poin penting:\n• setup(): berjalan sekali saat Arduino menyala, dipakai untuk inisialisasi.\n• loop(): berjalan berulang selama Arduino menyala.\n• Variabel: tanpa spasi, tidak diawali angka.\n• Tipe data umum: boolean, byte, char, int, unsigned int, long, unsigned long, float, double, String.\n• Komentar: // untuk satu baris, /* ... */ untuk blok.';

  @override
  String get materiL2L2StrukturSketchDescription =>
      'Mengenal fungsi setup() dan loop(), aturan penulisan variabel, tipe data umum, dan komentar pada program Arduino.';

  @override
  String get materiL2L2StrukturSketchTitle =>
      'Struktur Sketch, Variabel & Tipe Data';

  @override
  String get materiL2L2StrukturSketchVideoSummary1Text =>
      'Video ini membahas dasar pemrograman Arduino: struktur program, penulisan variabel, tipe data yang umum dipakai, dan cara menulis komentar. Fungsi setup() berjalan sekali saat program dijalankan, sedangkan loop() berjalan berulang selama alat menyala. Tipe data dipilih sesuai kebutuhan penyimpanan angka, karakter, hingga kalimat. Di akhir dijelaskan dua bentuk komentar: satu baris dengan // dan blok dengan /* ... */.';

  @override
  String get materiL2L2StrukturSketchVideoSummary3Text =>
      '• setup() dan loop() adalah fungsi wajib dalam semua program Arduino.\n• Nama variabel tidak boleh mengandung spasi dan tidak boleh diawali angka.\n• int, long, dan versi unsigned-nya menyimpan bilangan bulat dengan rentang memori berbeda.\n• char dan String menyimpan karakter dan kalimat; boolean menyimpan true/false.\n• Komentar menjelaskan kode tanpa memengaruhi eksekusi program.';

  @override
  String get materiL2L2StrukturSketchVideoSummary5Text =>
      '• Setup dan loop: setup() bekerja sekali di awal untuk inisialisasi, sedangkan loop() mengulang perintah terus-menerus sehingga Arduino berjalan tanpa henti.\n• Aturan penamaan variabel: tanpa spasi dan tidak diawali angka agar kode bebas error dan mudah dibaca. Underscore atau gabungan kata tanpa spasi membantu keterbacaan.\n• Pilihan tipe data: byte untuk angka kecil tanpa tanda, int dan long untuk bilangan bulat yang lebih besar, float dan double untuk bilangan pecahan. Pilih sesuai kebutuhan agar memori efisien dan data akurat.\n• Boolean: hanya bernilai true atau false, cocok untuk kondisi logika seperti sensor digital yang hanya punya dua keadaan.\n• Komentar satu baris (//) cocok untuk penjelasan singkat, sedangkan komentar blok (/* ... */) cocok untuk catatan panjang atau menonaktifkan banyak baris kode sekaligus.';

  @override
  String get materiL2L2StrukturSketchVideoSummary7Text =>
      'Video ini adalah pertemuan pertama dari seri belajar Arduino. Memahami struktur dasar, tipe data, dan komentar adalah fondasi sebelum membuat proyek yang lebih kompleks.';

  @override
  String get materiL3L3AdcContent0Text =>
      'Poin penting:\n• Pin digital: hanya HIGH (1) atau LOW (0).\n• Pin analog: membaca tegangan 0-5 V sebagai angka 0-1023 (ADC 10-bit).\n• Potensiometer menghasilkan tegangan yang berubah saat knob diputar.\n• Arduino Uno punya enam pin analog; Arduino Mega punya lebih banyak.';

  @override
  String get materiL3L3AdcContent1Text =>
      'Rumus konversi:\nV = (nilai ADC / 1023) × 5 V\n\nContoh pengondisian LED:\n• ADC < 350: LED merah menyala\n• ADC 351-700: LED kuning menyala\n• ADC > 700: LED hijau menyala';

  @override
  String get materiL3L3AdcDescription =>
      'Memahami input analog Arduino, konversi ADC 0-1023, dan membaca potensiometer untuk mengendalikan LED indikator.';

  @override
  String get materiL3L3AdcVideoSummary1Text =>
      'Video ini membahas pin analog Arduino Uno dengan potensiometer sebagai input dan LED sebagai indikator. Dimulai dari perbedaan pin digital dan analog, konsep Analog to Digital Converter (ADC), hingga cara membaca tegangan potensiometer menjadi nilai digital 0 sampai 1023. Nilai itu dipakai untuk menyalakan LED sesuai rentang tegangan. Pin analog penting untuk sensor yang mengeluarkan tegangan kontinu, berbeda dengan sinyal digital yang hanya bernilai 0 dan 1.';

  @override
  String get materiL3L3AdcVideoSummary3Text =>
      '• Input digital hanya 0 dan 1, sedangkan input analog bernilai kontinu antara 0 sampai 5 Volt.\n• ADC Arduino mengubah sinyal analog menjadi nilai digital 0 sampai 1023.\n• Potensiometer adalah sensor analog yang tegangan keluarannya bisa diatur manual.\n• Rumus tegangan: V = (nilai ADC / 1023) × 5 V.\n• Struktur if-else mengatur LED sesuai rentang nilai analog.\n• Pilih jenis Arduino dengan jumlah pin analog sesuai kebutuhan, misalnya Arduino Mega untuk banyak sensor.';

  @override
  String get materiL3L3AdcVideoSummary5Text =>
      '• ADC itu esensial: ADC 10-bit mengubah tegangan kontinu menjadi angka 0-1023. Tanpa ADC, Arduino hanya paham nyala atau mati.\n• Potensiometer cocok untuk belajar: memutar knob membuat nilai ADC di serial monitor naik atau turun sehingga hubungan tegangan dan nilai terbaca mudah dipahami.\n• Rumus konversi: Tegangan input = (nilai ADC / 1023) × 5 Volt, dipakai untuk mengubah angka digital menjadi besaran tegangan nyata.\n• Pengkondisian LED: contoh if-else dengan nilai ADC di bawah 350 menyalakan LED merah, 351-700 kuning, dan di atas 700 hijau.\n• Batasan pin: Arduino Uno hanya punya enam pin analog. Arduino Mega punya lebih banyak untuk kebutuhan yang lebih kompleks.\n• Hardware dan software harus sejalan: pemasangan potensiometer, resistor, dan LED yang benar dipadukan dengan program yang logis.\n• Banyak sensor fisik (suhu, arus, tegangan, posisi) memberi keluaran analog, sehingga materi ini menjadi dasar untuk IoT, robotika, dan otomasi.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorContent0Text =>
      'Poin penting:\n• Sensor mengubah kondisi fisik (cahaya, suhu, jarak, suara, magnet) menjadi sinyal listrik yang dibaca mikrokontroler.\n• Ada sensor analog dan digital; sebagian sensor sama fungsinya tetapi berbeda bentuk dan ukuran modul.\n• Sensor suhu: termistor NTC dan sensor analog; ada juga sensor kelembaban.\n• Sensor garis dan laser dipakai untuk robot dan pengindraan jarak.\n• Sensor magnetik mendeteksi magnet atau logam; sensor sentuh dipakai sebagai pengganti tombol.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorContent1Text =>
      'Contoh sensor yang dibahas: joystick, modul suara, sensor garis, sensor jarak, sensor suhu, sensor sentuh, sensor magnetik, LED RGB, sensor laser, potensiometer, dan fotoresistor.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorDescription =>
      'Mengenal berbagai jenis sensor untuk belajar elektronika, dari joystick dan sensor suhu hingga sensor garis dan laser.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorTitle =>
      'Jenis & Prinsip Kerja Sensor';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary0Heading =>
      'Ringkasan';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary1Text =>
      'Video ini memperkenalkan 37 jenis sensor untuk belajar elektronika dan mengembangkan aplikasi mikrokontroler. Pembicara menunjukkan sensor satu per satu sambil menguji fungsinya. Sebagian sudah dicoba, sebagian masih dievaluasi. Video memberi gambaran fungsi dasar maupun khusus berbagai sensor yang cocok untuk eksperimen pemula dan hobiis.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary2Heading =>
      'Sensor yang Ditampilkan';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary3Text =>
      '• Joystick\n• Modul sensor suara (besar dan kecil)\n• Sensor garis (line tracking)\n• Sensor jarak\n• Sensor suhu dan kelembaban (termistor NTC dan analog)\n• Sensor sentuh (metal touch)\n• Sensor magnetik\n• LED RGB dan LED dua warna\n• Sensor laser\n• Potensiometer rotary\n• Sensor fotoresistor';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary4Heading =>
      'Wawasan Kunci';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary5Text =>
      '• Paket sensor lengkap mempercepat belajar karena bisa langsung dicoba, dari input analog hingga digital. Paket 37 sensor ini sekitar Rp190.000.\n• Ada sensor dengan fungsi sama tetapi bentuk dan ukuran modul berbeda (misalnya modul suara besar dan kecil), sehingga bisa disesuaikan dengan ruang proyek.\n• Sensor magnetik mendeteksi magnet atau logam; sensor metal touch dapat dipakai untuk kontak sentuh tanpa tombol fisik.\n• LED RGB dan LED dua warna memungkinkan eksperimen pengaturan warna dengan mikrokontroler.\n• Sensor suhu (termistor NTC maupun analog) dan sensor kelembaban penting untuk monitoring lingkungan dan IoT.\n• Sensor garis dan sensor laser berguna untuk robot bergerak otomatis dan pengindraan jarak.\n• Sensor banyak dipakai pada aplikasi robotik dan kontrol otomatis.';

  @override
  String get materiL3L3PosttestDescription =>
      'Uji pemahamanmu setelah belajar.';

  @override
  String get materiL3L3PosttestQQ1Question =>
      'Rumus konversi nilai ADC menjadi tegangan (dengan referensi 5 V) adalah...';

  @override
  String get materiL3L3PosttestQQ2Question =>
      'Jika analogRead menghasilkan sekitar 512, tegangan yang dibaca mendekati...';

  @override
  String get materiL3L3PosttestQQ3Question =>
      'Pin berikut yang mendukung keluaran PWM adalah...';

  @override
  String get materiL3L3PosttestQQ4Question =>
      'Perintah untuk mengatur kecerahan LED melalui sinyal PWM adalah...';

  @override
  String get materiL3L3PosttestQQ5Option0 =>
      'Mengubah kondisi fisik menjadi sinyal listrik';

  @override
  String get materiL3L3PosttestQQ5Option1 =>
      'Menyimpan program secara permanen';

  @override
  String get materiL3L3PosttestQQ5Question =>
      'Fungsi utama sensor dalam sistem mikrokontroler adalah...';

  @override
  String get materiL3L3PretestDescription =>
      'Ukur pengetahuan awalmu tentang input analog dan sensor.';

  @override
  String get materiL3L3PretestQQ1Question =>
      'Pin input analog pada Arduino Uno adalah...';

  @override
  String get materiL3L3PretestQQ2Question =>
      'Rentang nilai hasil konversi ADC 10-bit pada Arduino adalah...';

  @override
  String get materiL3L3PretestQQ3Question =>
      'Rentang nilai pada analogWrite() untuk PWM adalah...';

  @override
  String get materiL3L3PretestQQ4Question =>
      'Fungsi yang digunakan untuk memetakan rentang nilai 0–1023 ke 0–255 adalah...';

  @override
  String get materiL3L3PwmContent0Text =>
      'Poin penting:\n• PWM meniru tegangan analog dengan menyalakan dan mematikan sinyal digital secara cepat.\n• analogWrite(pin, nilai) dengan nilai 0-255.\n• Gunakan hanya pin PWM (3, 5, 6, 9, 10, 11 pada Arduino Nano).\n• map(nilai, 0, 1023, 0, 255) menyesuaikan nilai potensiometer ke rentang PWM.';

  @override
  String get materiL3L3PwmContent1Text =>
      'Alur program:\n1. Baca potensiometer dengan analogRead() (0-1023).\n2. Ubah ke 0-255 dengan map().\n3. Kirim hasilnya ke LED dengan analogWrite().\n4. Tampilkan nilai input dan output di serial monitor.';

  @override
  String get materiL3L3PwmDescription =>
      'Mengatur kecerahan LED dengan PWM, analogWrite(), dan potensiometer menggunakan fungsi map().';

  @override
  String get materiL3L3PwmVideoSummary1Text =>
      'Video ini menjelaskan konsep Pulse Width Modulation (PWM) dan penerapannya untuk mengatur kecerahan LED. Dengan PWM, Arduino dapat menghasilkan berbagai nilai tegangan antara 0 sampai 5 volt lewat pin digital yang mendukung PWM, tidak hanya 0 atau 5 volt. Pada contoh praktik, nilai analog potensiometer (0-1023) dikonversi dengan map() menjadi 0-255, lalu dipakai sebagai parameter analogWrite() untuk mengatur intensitas LED. Nilai input dan output dipantau di serial monitor.';

  @override
  String get materiL3L3PwmVideoSummary3Text =>
      '• PWM memungkinkan tegangan variatif (0-5 V) pada pin digital Arduino.\n• analogWrite() menerima nilai 0-255 untuk mengatur output PWM.\n• Potensiometer memberi nilai analog 0-1023.\n• map() mengubah nilai analog menjadi rentang PWM 0-255.\n• Arduino Nano mendukung PWM di pin digital 3, 5, 6, 9, 10, dan 11.\n• Kecerahan LED berubah real-time sesuai putaran potensiometer.\n• Serial monitor menampilkan nilai input potensiometer dan output PWM.';

  @override
  String get materiL3L3PwmVideoSummary5Text =>
      '• PWM efisien untuk kontrol tegangan: sinyal digital dihidupkan dan dimatikan sangat cepat sehingga tegangan rata-rata menjadi variatif tanpa DAC fisik atau hardware tambahan.\n• Potensiometer adalah input analog yang mudah dipakai sehingga rangkaian interaktif dan mudah diatur manual.\n• map() penting karena ADC 10-bit (0-1023) dan PWM 8-bit (0-255) memiliki skala berbeda; map() mengonversinya secara proporsional.\n• Tidak semua pin digital mendukung PWM; pahami pin yang didukung tiap board agar program berjalan benar.\n• Serial monitor mempercepat debugging karena nilai input dan output bisa dibandingkan langsung.\n• Dibanding on/off biasa, PWM membuat gradasi kecerahan LED lebih halus, berguna untuk pencahayaan dekoratif, indikator, atau display.\n• PWM adalah fondasi sebelum mengendalikan motor, servo, atau perangkat analog lain.';

  @override
  String get materiL4L4DebouncingContent0Text =>
      'Poin penting:\n• Bouncing: getaran mekanis tombol terbaca sebagai beberapa tekanan sekaligus.\n• Akibatnya counter bisa melonjak walau tombol ditekan sekali.\n• Solusi tanpa delay(): gunakan variabel boolean btnState sebagai penanda tombol siap ditekan.';

  @override
  String get materiL4L4DebouncingContent1Text =>
      'Logika btnState:\n1. Tombol ditekan dan btnState == true: tambah counter, lalu set btnState = false.\n2. Tombol masih ditahan atau bergetar: btnState false, counter tidak bertambah.\n3. Tombol dilepas: set btnState = true agar siap untuk tekanan berikutnya.';

  @override
  String get materiL4L4DebouncingContent2Text =>
      'Tips kode rapi:\n• Gunakan switch-case atau if-else if untuk memilih LED sesuai nilai counter.\n• Buat fungsi kustom runLed(byte a, byte b, byte c) agar digitalWrite tidak diulang-ulang.';

  @override
  String get materiL4L4DebouncingDescription =>
      'Mengatasi getaran mekanis tombol (bouncing) dengan logika state tanpa delay().';

  @override
  String get materiL4L4DebouncingVideoSummary0Heading =>
      'Masalah Bouncing (Getaran Fisik Tombol)';

  @override
  String get materiL4L4DebouncingVideoSummary1Text =>
      'Pada program counter sederhana (misalnya ledState++), angka counter sering melonjak hanya karena satu kali tekanan cepat pada tombol. Penyebabnya, mikrokontroler membaca getaran mekanis kecil pada tombol fisik sebagai tekanan berkali-kali dalam hitungan mikrodetik.';

  @override
  String get materiL4L4DebouncingVideoSummary2Heading =>
      'Solusi Debouncing via Software (Logika State)';

  @override
  String get materiL4L4DebouncingVideoSummary3Text =>
      'Masalah ini tidak diselesaikan dengan delay(), tetapi dengan variabel kontrol boolean tambahan bernama btnState.\n• Mendeteksi tekanan: saat tombol ditekan, program memeriksa apakah btnState == true. Jika ya, counter (ledState) ditambah 1, lalu btnState langsung diubah menjadi false.\n• Mencegah looping: karena btnState sudah false, tombol yang ditahan atau getaran sisa (bouncing) tidak menambah counter lagi.\n• Reset state: saat tombol dilepas, bagian else mengembalikan btnState menjadi true sehingga tombol siap untuk tekanan berikutnya.';

  @override
  String get materiL4L4DebouncingVideoSummary4Heading =>
      'Metode Eksekusi Output';

  @override
  String get materiL4L4DebouncingVideoSummary5Text =>
      'Setelah nilai counter stabil (0 sampai 3), ada dua metode untuk menyalakan LED:\n• If - Else If: cara logis standar dengan pemeriksaan kondisi bertingkat.\n• Switch - Case: hasilnya sama persis, tetapi struktur kodenya lebih rapi dan efisien dibaca.';

  @override
  String get materiL4L4DebouncingVideoSummary6Heading =>
      'Penyederhanaan Kode (Custom Void)';

  @override
  String get materiL4L4DebouncingVideoSummary7Text =>
      'Agar perintah digitalWrite tidak ditulis berulang di setiap kondisi, dibuat fungsi kustom void runLed(byte a, byte b, byte c). Untuk mengatur lampu, program cukup memanggil satu baris fungsi ini beserta parameternya, sehingga kode akhir jauh lebih ringkas.';

  @override
  String get materiL4L4DebouncingVideoSummary9Text =>
      'Logika debouncing berbasis state ini efisien karena tidak memblokir mikrokontroler seperti delay().';

  @override
  String get materiL4L4InterruptContent0Text =>
      'Poin penting:\n• Interrupt: menghentikan sebentar program utama untuk menjalankan fungsi khusus (ISR) saat ada kejadian di pin.\n• Pin interrupt eksternal Arduino Uno (ATmega328): pin 2 dan 3.\n• Variabel yang diubah di ISR wajib volatile.\n• Jangan pakai delay() atau millis() di dalam ISR; buat ISR sesingkat mungkin.';

  @override
  String get materiL4L4InterruptContent1Text =>
      'Mode interrupt:\n• LOW: dipicu saat pin bernilai LOW.\n• CHANGE: dipicu saat sinyal berubah (naik atau turun).\n• RISING: dipicu saat sinyal naik dari LOW ke HIGH.\n• FALLING: dipicu saat sinyal turun dari HIGH ke LOW.';

  @override
  String get materiL4L4InterruptContent2Text =>
      'Interrupt vs if biasa:\n• Interrupt: input langsung ditangani meski program utama sedang sibuk.\n• If biasa: input baru terbaca saat program sampai ke baris tersebut, sehingga bisa terlewat saat proses berat berjalan.';

  @override
  String get materiL4L4InterruptDescription =>
      'Menangani input eksternal secara langsung dengan interrupt, ISR, variabel volatile, dan mode RISING, FALLING, CHANGE, LOW.';

  @override
  String get materiL4L4InterruptVideoSummary1Text =>
      'Video ini membahas cara kerja dan implementasi interrupt pada Arduino dengan mikrokontroler ATmega328 seperti Arduino Uno. Interrupt memungkinkan Arduino menjalankan fungsi tertentu segera saat sinyal pada pin berubah, tanpa menunggu proses utama selesai. Topiknya meliputi definisi interrupt, pemilihan pin pemicu, mode interrupt (rising, falling, change, low), dan penulisan Interrupt Service Routine (ISR).';

  @override
  String get materiL4L4InterruptVideoSummary3Text =>
      'Kode contoh memakai LCD untuk menampilkan counter yang bertambah saat interrupt terjadi. Proses utama disimulasikan dengan loading yang lama. Counter tetap bertambah tanpa menunggu loading selesai, sedangkan logika if biasa tidak dapat menangani input secara real-time saat program lain berjalan berat.';

  @override
  String get materiL4L4InterruptVideoSummary5Text =>
      '• Konsep dan fungsi dasar interrupt pada Arduino.\n• Pin 2 dan 3 sebagai pin interrupt eksternal pada ATmega328.\n• ISR yang memodifikasi variabel volatile.\n• Perbandingan interrupt dan logika if biasa saat proses berat berjalan.\n• delay() dan millis() tidak efektif di dalam ISR.';

  @override
  String get materiL4L4InterruptVideoSummary7Text =>
      '• Interrupt mengeksekusi fungsi secara asinkron saat sinyal pin berubah, sangat penting untuk input real-time seperti tombol atau sensor.\n• Arduino Uno dan board ATmega328 lain memakai pin 2 dan 3 untuk interrupt eksternal; sesuaikan pin jika memakai board lain.\n• Variabel yang diubah ISR harus dideklarasikan volatile agar compiler tidak mengoptimasinya dan nilainya selalu terbaru.\n• ISR sebaiknya sesingkat mungkin dan tidak memakai delay() atau millis() karena dapat mengganggu kestabilan program.\n• Mode LOW, CHANGE, RISING, dan FALLING mengatur kapan ISR dipanggil sesuai karakter input.\n• Interrupt mengubah pola pemrograman dari sinkron ke asinkron: program merespons input tanpa menunggu proses lain selesai.';

  @override
  String get materiL4L4InterruptVideoSummary9Text =>
      'Interrupt membuat sistem merespons input eksternal dengan cepat, terutama saat proses utama berlangsung lama dan tidak boleh terganggu. Mekanisme ini penting pada sistem embedded dan sensor yang butuh pembacaan data real-time.';

  @override
  String get materiL4L4JenisMotorContent0Text =>
      'Poin penting:\n• Servo: motor yang sudutnya dapat ditentukan, dikendalikan sinyal PWM.\n• Rentang gerak servo pada video: 0° sampai 180°.\n• Kabel servo: merah = VCC 5V, coklat = ground, oranye/kuning = sinyal PWM.\n• Delay kecil (contoh 0,05 detik) membuat gerakan servo halus.';

  @override
  String get materiL4L4JenisMotorContent1Text =>
      'Cara menggerakkan servo secara bertahap:\n1. Sambungkan servo: merah ke 5V, coklat ke ground, oranye/kuning ke pin PWM.\n2. Naikkan sudut sedikit demi sedikit dari 0° ke 180° dengan loop.\n3. Beri delay pendek di setiap langkah.\n4. Turunkan sudut kembali dari 180° ke 0° untuk gerakan bolak-balik (sweep).';

  @override
  String get materiL4L4JenisMotorContent2Text =>
      'Pengembangan: Python dengan library pyfirmata dapat mengontrol Arduino, dan Tkinter dapat dipakai untuk membuat slider sudut serta tombol sweep.';

  @override
  String get materiL4L4JenisMotorDescription =>
      'Cara kerja servo yang dikendalikan sinyal PWM, standar kabel servo, dan pemrograman Arduino lewat Python (pyfirmata).';

  @override
  String get materiL4L4JenisMotorVideoSummary1Text =>
      'Video ini membahas cara mengendalikan motor servo dengan Python yang terhubung ke board Arduino. Dimulai dari konsep dasar servo yang dikendalikan sinyal PWM, lalu contoh kode Python yang menggerakkan servo dari sudut 0° sampai 180° dengan variasi kecepatan dan sudut. Video juga membahas sambungan kabel servo (VCC, ground, PWM), library pyfirmata untuk komunikasi dengan Arduino, dan antarmuka grafis sederhana dengan Tkinter untuk kontrol servo secara interaktif.';

  @override
  String get materiL4L4JenisMotorVideoSummary3Text =>
      '• Servo dikendalikan sinyal PWM dari Arduino.\n• Kabel servo: merah (VCC 5V), coklat (ground), oranye atau kuning (sinyal PWM).\n• Contoh perangkat: Arduino Uno dan servo MG90S atau MG995.\n• Python memakai library pyfirmata dan port serial untuk berkomunikasi dengan Arduino.\n• Loop dengan penambahan sudut menggerakkan servo secara bertahap.\n• Delay mengatur kecepatan gerak servo.\n• GUI Tkinter menyediakan slider sudut dan tombol sweep otomatis.';

  @override
  String get materiL4L4JenisMotorVideoSummary5Text =>
      '• Servo bergantung pada PWM: sudut servo mengikuti durasi pulsa. Semakin panjang pulsa ON, sudut bertambah hingga maksimum 180°.\n• Python-Arduino membuka peluang pemrograman tingkat tinggi dan antarmuka kontrol yang lebih interaktif dibanding hanya memakai Arduino IDE.\n• pyfirmata memudahkan komunikasi dengan Arduino lewat serial, sedangkan Tkinter memberi GUI sederhana tanpa toolkit berat.\n• Delay singkat (misalnya 0,05 detik) membuat gerak servo halus dan mudah diikuti, serta tidak membebani mikrokontroler dan servo.\n• Memahami fungsi warna kabel servo mencegah korsleting dan kerusakan komponen.\n• Loop menaikkan dan menurunkan sudut adalah dasar untuk aplikasi seperti robotika, kamera otomatis, dan sistem kendali posisi.';

  @override
  String get materiL4L4PosttestDescription =>
      'Uji pemahamanmu setelah belajar.';

  @override
  String get materiL4L4PosttestQQ1Question =>
      'Sudut posisi motor servo dikendalikan menggunakan sinyal...';

  @override
  String get materiL4L4PosttestQQ2Option0 =>
      'Jumlah milidetik sejak board menyala';

  @override
  String get materiL4L4PosttestQQ2Question =>
      'Fungsi millis() mengembalikan...';

  @override
  String get materiL4L4PosttestQQ3Option0 =>
      'Program tidak terblokir dan bisa menjalankan tugas lain';

  @override
  String get materiL4L4PosttestQQ3Question =>
      'Keunggulan menggunakan millis() dibanding delay() adalah...';

  @override
  String get materiL4L4PosttestQQ4Question =>
      'Mekanisme yang menghentikan sementara program utama untuk langsung merespons sinyal penting disebut...';

  @override
  String get materiL4L4PosttestQQ5Option1 =>
      'Menggunakan logika variabel state (seperti btnState)';

  @override
  String get materiL4L4PosttestQQ5Question =>
      'Cara mengatasi bouncing tombol tanpa memblokir program adalah...';

  @override
  String get materiL4L4PretestDescription =>
      'Ukur pengetahuan awalmu tentang motor, timer, dan interrupt.';

  @override
  String get materiL4L4PretestQQ1Option1 =>
      'Menggerakkan ke sudut tertentu dalam rentang terbatas';

  @override
  String get materiL4L4PretestQQ2Question =>
      'Kabel warna merah pada motor servo standar umumnya dihubungkan ke...';

  @override
  String get materiL4L4PretestQQ3Option0 =>
      'Berhenti menunggu dan memblokir perintah lain';

  @override
  String get materiL4L4PretestQQ3Question =>
      'Saat delay() berjalan, mikrokontroler...';

  @override
  String get materiL4L4PretestQQ4Question =>
      'Masalah getaran mekanis pada tombol yang terbaca berkali-kali disebut...';

  @override
  String get materiL4L4TimerTanpaHentiContent0Text =>
      'Poin penting:\n• delay() menghentikan program, millis() tidak.\n• millis() = jumlah milidetik sejak Arduino menyala.\n• Simpan waktu terakhir aksi di variabel (previousTime) bertipe unsigned long.\n• Jika millis() - previousTime >= interval, jalankan aksi lalu perbarui previousTime.\n• Gunakan variabel boolean untuk membalik status LED.';

  @override
  String get materiL4L4TimerTanpaHentiContent1Text =>
      'Contoh pada video:\n• LED 1 berubah status setiap 10 detik.\n• LED 2 berubah status setiap 6 detik.\n• Keduanya berjalan bersamaan tanpa saling menunggu.';

  @override
  String get materiL4L4TimerTanpaHentiDescription =>
      'Membuat program berbasis event dengan millis() agar tugas berjalan tanpa terhenti oleh delay().';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary1Text =>
      'Video ini menjelaskan cara memakai millis() untuk pemrograman berbasis event tanpa delay(). Fungsi millis() menghasilkan waktu dalam milidetik sejak Arduino dinyalakan dan terus berjalan kecuali board di-reset. Nilainya dipakai untuk mengatur interval secara non-blocking sehingga perangkat bisa mengerjakan tugas lain, berbeda dengan delay() yang membuat program berhenti sementara.';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary2Heading =>
      'Contoh Implementasi';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary3Text =>
      'Dua lampu LED dikendalikan dengan interval berbeda: lampu pertama berubah setiap 10 detik dan lampu kedua setiap 6 detik. Status dan waktu ditampilkan di LCD 20x4 dengan library LiquidCrystal. Aksi hanya dijalankan saat selisih antara millis() sekarang dan waktu sebelumnya mencapai interval. Tipe data unsigned long menampung nilai waktu, variabel boolean menyimpan status lampu, dan if membandingkan waktu.';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary5Text =>
      '• millis() menghitung waktu berjalan dalam milidetik sejak Arduino menyala.\n• Pemrograman event-based membandingkan waktu sekarang dengan waktu sebelumnya (non-blocking).\n• Dua LED dengan interval 10 detik dan 6 detik sebagai contoh.\n• LCD 20x4 menampilkan status dan waktu.\n• unsigned long untuk waktu dan boolean untuk status lampu.\n• Kode modular dengan fungsi untuk membalik status lampu dan memperbarui waktu sebelumnya.';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary7Text =>
      '• millis() mengatasi masalah delay() yang bersifat blocking, sehingga program bisa multitasking dan responsif untuk aplikasi IoT, kontrol real-time, dan robotika.\n• unsigned long dipakai untuk waktu karena nilai millis() bisa mencapai sekitar 4,2 miliar ms (sekitar 50 hari) sebelum kembali ke nol.\n• Pendekatan event-based: aksi dipicu oleh waktu atau kejadian lain, konsep yang juga dipakai di banyak bahasa pemrograman modern.\n• Toggle status boolean: membalik status lampu (true/false) setiap interval tercapai adalah cara sederhana mengendalikan output.\n• LCD memberi umpan balik visual untuk memverifikasi program tanpa alat tambahan.\n• Variabel waktu sebelumnya (previousTime) menjaga interval tetap konsisten dan tidak bergantung pada nilai mutlak millis().';

  @override
  String get materiL5L5M1Content0Text =>
      'Cara kerja sistem:\n• DHT11 membaca suhu.\n• Suhu mencapai batas atas → kipas ON lewat relay.\n• Suhu turun melewati batas bawah → kipas OFF.\n• OLED menampilkan suhu dan status kipas.\n\nPenggunaan dua batas (histeresis) mencegah relay menyala-mati terus-menerus di sekitar satu nilai suhu.';

  @override
  String get materiL5L5M1Content1Text =>
      'Alat dan bahan:\n• Arduino Uno\n• DHT11\n• OLED I2C 128×64\n• Modul relay 5 V\n• Kipas DC kecil dengan catu terpisah\n• Breadboard dan kabel jumper';

  @override
  String get materiL5L5M1Description =>
      'Kipas pendingin otomatis berbasis suhu.';

  @override
  String get materiL5L5M2Content0Text =>
      'Sisi kontrol (Arduino, 5 V):\n• DHT11: VCC → 5V, DATA → D2, GND → GND\n• OLED: VCC → 5V, GND → GND, SDA → A4, SCL → A5\n• Modul relay: VCC → 5V, GND → GND, IN → D7 (active LOW)';

  @override
  String get materiL5L5M2Content1Text =>
      'Sisi beban (catu kipas terpisah):\n• Catu kipas (+) → terminal COM relay\n• Terminal NO relay → kipas (+)\n• Kipas (−) → catu kipas (−), langsung tanpa relay\n\nRelay memisahkan kedua sisi: sisi beban tidak terhubung ke Arduino sama sekali. Gunakan terminal NO (normally open) agar kipas mati saat relay tidak aktif atau Arduino kehilangan daya.';

  @override
  String get materiL5L5M2Description =>
      'Sambungan sisi kontrol dan sisi beban.';

  @override
  String get materiL5L5M3Content1Text =>
      'Logika utama:\n• t ≥ 30 °C → kipasNyala = true\n• t ≤ 28 °C → kipasNyala = false\n• Di antara 28–30 °C status tidak berubah (histeresis)\n• Jika pembacaan gagal (isnan), status kipas dipertahankan dan OLED menampilkan Error';

  @override
  String get materiL5L5M3Description =>
      'Sketch lengkap dengan histeresis dan tampilan OLED.';

  @override
  String get materiL5L5M4Content0Text =>
      'Skenario pengujian:\n1. Suhu < 28 °C → kipas OFF, OLED menampilkan suhu\n2. Sensor dihangatkan ≥ 30 °C → kipas ON\n3. Suhu turun ke 28–30 °C → kipas tetap ON (histeresis)\n4. Suhu ≤ 28 °C → kipas OFF\n5. Kabel DATA DHT11 dicabut → OLED menampilkan Error, status kipas tidak berubah';

  @override
  String get materiL5L5M4Content1Text =>
      'Analisis ketelitian sensor (bandingkan dengan termometer pembanding di beberapa titik suhu):\n• Galat mutlak = |DHT11 − pembanding|\n• Galat (%) = galat mutlak / pembanding × 100%\n• Hitung rata-ratanya, bandingkan dengan akurasi pada datasheet.\n• Catat juga waktu kipas menyala setelah suhu mencapai 30 °C untuk menilai kecepatan respons.';

  @override
  String get materiL5L5M4Content2Text =>
      'Ide pengembangan:\n• Kendali kecepatan kipas dengan PWM dan driver motor\n• Buzzer sebagai alarm suhu berlebih\n• Log suhu ke kartu SD lewat SPI';

  @override
  String get materiL5L5M4Description =>
      'Skenario uji, analisis galat, dan ide pengembangan.';

  @override
  String get materiL5L5PosttestDescription =>
      'Uji pemahamanmu setelah menyelesaikan proyek akhir.';

  @override
  String get materiL5L5PosttestQQ1Option0 =>
      'Mencegah relay menyala-mati terus-menerus';

  @override
  String get materiL5L5PosttestQQ1Question =>
      'Tujuan penggunaan dua batas suhu (histeresis) adalah...';

  @override
  String get materiL5L5PosttestQQ2Question =>
      'Pada proyek ini, kipas menyala ketika suhu...';

  @override
  String get materiL5L5PosttestQQ3Option0 =>
      'Kipas mati saat relay tidak aktif atau Arduino kehilangan daya';

  @override
  String get materiL5L5PosttestQQ3Question =>
      'Mengapa dipilih terminal NO (normally open) pada relay?';

  @override
  String get materiL5L5PosttestQQ4Question =>
      'Jika isnan(t) bernilai true, artinya...';

  @override
  String get materiL5L5PosttestQQ5Question =>
      'Rumus galat (%) pada analisis sensor adalah...';

  @override
  String get materiL5L5PretestDescription =>
      'Ukur pengetahuan awalmu sebelum membuat proyek akhir.';

  @override
  String get materiL5L5PretestQQ1Option0 =>
      'Saklar yang dikendalikan sinyal kecil';

  @override
  String get materiL5L5PretestQQ3Question =>
      'OLED I2C pada Arduino Uno dihubungkan ke pin...';

  @override
  String get materiL5L5PretestQQ4Question =>
      'Alamat I2C OLED SSD1306 yang umum adalah...';

  @override
  String kuisQuestionCounter(Object current, Object total) {
    return 'Pertanyaan $current dari $total';
  }

  @override
  String get btnPrevious => 'Sebelumnya';

  @override
  String folderSubtitle(Object count, Object subtitle) {
    return '$count materi • $subtitle';
  }

  @override
  String get profilMenuTentang => 'Tentang Aplikasi';

  @override
  String get profilSnackNotifikasi => 'Fitur Notifikasi segera hadir';

  @override
  String get profilSnackBantuan => 'Fitur Bantuan segera hadir';

  @override
  String get profilDialogTentangTitle => 'Tentang Aplikasi';

  @override
  String get profilDialogTentangBody =>
      'EduVolt v1.0.0\nPlatform Pembelajaran Mikrokontroler Interaktif\n\nDibuat oleh Tim EduVolt';

  @override
  String get profilSupportEmailCopied => 'Email disalin ke papan klip';

  @override
  String get profilSupportCopyBtn => 'Salin Email';
}
