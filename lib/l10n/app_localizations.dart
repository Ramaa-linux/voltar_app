import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In id, this message translates to:
  /// **'EduVolt'**
  String get appTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In id, this message translates to:
  /// **'Halo, {name}!'**
  String homeGreeting(Object name);

  /// No description provided for @btnStart.
  ///
  /// In id, this message translates to:
  /// **'Mulai'**
  String get btnStart;

  /// No description provided for @btnContinue.
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan'**
  String get btnContinue;

  /// No description provided for @btnSave.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get btnSave;

  /// No description provided for @btnCancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get btnCancel;

  /// No description provided for @menuProfile.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get menuProfile;

  /// No description provided for @menuLanguage.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get menuLanguage;

  /// No description provided for @langIndonesian.
  ///
  /// In id, this message translates to:
  /// **'Indonesia'**
  String get langIndonesian;

  /// No description provided for @langEnglish.
  ///
  /// In id, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @loginTitle.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginTitle;

  /// No description provided for @registerTitle.
  ///
  /// In id, this message translates to:
  /// **'Daftar Akun'**
  String get registerTitle;

  /// No description provided for @classTitle.
  ///
  /// In id, this message translates to:
  /// **'Kelas'**
  String get classTitle;

  /// No description provided for @taskTitle.
  ///
  /// In id, this message translates to:
  /// **'Tugas'**
  String get taskTitle;

  /// No description provided for @commentTitle.
  ///
  /// In id, this message translates to:
  /// **'Komentar'**
  String get commentTitle;

  /// No description provided for @navHome.
  ///
  /// In id, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMateri.
  ///
  /// In id, this message translates to:
  /// **'Materi'**
  String get navMateri;

  /// No description provided for @navSimulasi.
  ///
  /// In id, this message translates to:
  /// **'Simulasi'**
  String get navSimulasi;

  /// No description provided for @navKelas.
  ///
  /// In id, this message translates to:
  /// **'Kelas'**
  String get navKelas;

  /// No description provided for @navProfil.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get navProfil;

  /// No description provided for @guruNavDashboard.
  ///
  /// In id, this message translates to:
  /// **'Dashboard'**
  String get guruNavDashboard;

  /// No description provided for @guruNavKelas.
  ///
  /// In id, this message translates to:
  /// **'Kelas'**
  String get guruNavKelas;

  /// No description provided for @guruNavTugas.
  ///
  /// In id, this message translates to:
  /// **'Tugas'**
  String get guruNavTugas;

  /// No description provided for @guruNavProfil.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get guruNavProfil;

  /// No description provided for @guruKelasDetailTitle.
  ///
  /// In id, this message translates to:
  /// **'Detail Kelas'**
  String get guruKelasDetailTitle;

  /// No description provided for @guruKelasEdit.
  ///
  /// In id, this message translates to:
  /// **'Edit Kelas'**
  String get guruKelasEdit;

  /// No description provided for @guruKelasComingSoon.
  ///
  /// In id, this message translates to:
  /// **'Segera hadir di pembaruan berikutnya'**
  String get guruKelasComingSoon;

  /// No description provided for @guruTugasTitle.
  ///
  /// In id, this message translates to:
  /// **'Daftar Tugas'**
  String get guruTugasTitle;

  /// No description provided for @guruTugasCount.
  ///
  /// In id, this message translates to:
  /// **'{count} tugas'**
  String guruTugasCount(Object count);

  /// No description provided for @guruTugasCreate.
  ///
  /// In id, this message translates to:
  /// **'Buat Tugas'**
  String get guruTugasCreate;

  /// No description provided for @guruTugasFilterAll.
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get guruTugasFilterAll;

  /// No description provided for @guruTugasFilterActive.
  ///
  /// In id, this message translates to:
  /// **'Aktif'**
  String get guruTugasFilterActive;

  /// No description provided for @guruTugasFilterCompleted.
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get guruTugasFilterCompleted;

  /// No description provided for @guruTugasStatusActive.
  ///
  /// In id, this message translates to:
  /// **'Aktif'**
  String get guruTugasStatusActive;

  /// No description provided for @guruTugasStatusCompleted.
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get guruTugasStatusCompleted;

  /// No description provided for @guruTugasDeadline.
  ///
  /// In id, this message translates to:
  /// **'Deadline: {date}'**
  String guruTugasDeadline(Object date);

  /// No description provided for @guruTugasDetailSnack.
  ///
  /// In id, this message translates to:
  /// **'Detail \"{title}\" - Segera hadir'**
  String guruTugasDetailSnack(Object title);

  /// No description provided for @settingsEditProfil.
  ///
  /// In id, this message translates to:
  /// **'Edit Profil'**
  String get settingsEditProfil;

  /// No description provided for @settingsNotifications.
  ///
  /// In id, this message translates to:
  /// **'Notifikasi'**
  String get settingsNotifications;

  /// No description provided for @settingsAbout.
  ///
  /// In id, this message translates to:
  /// **'Tentang Aplikasi'**
  String get settingsAbout;

  /// No description provided for @settingsLanguage.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get settingsLanguage;

  /// No description provided for @logout.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Keluar'**
  String get logoutConfirm;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In id, this message translates to:
  /// **'Apakah kamu yakin ingin keluar?'**
  String get logoutConfirmMessage;

  /// No description provided for @confirmYes.
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get confirmYes;

  /// No description provided for @confirmNo.
  ///
  /// In id, this message translates to:
  /// **'Tidak'**
  String get confirmNo;

  /// No description provided for @emailLabel.
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In id, this message translates to:
  /// **'nama@sekolah.sch.id'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In id, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan password Anda'**
  String get passwordHint;

  /// No description provided for @nameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama Lengkap'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan nama lengkap'**
  String get nameHint;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan ulang password'**
  String get confirmPasswordHint;

  /// No description provided for @teacherCodeLabel.
  ///
  /// In id, this message translates to:
  /// **'Kode Guru (Opsional)'**
  String get teacherCodeLabel;

  /// No description provided for @teacherCodeHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kode undangan guru'**
  String get teacherCodeHint;

  /// No description provided for @roleStudent.
  ///
  /// In id, this message translates to:
  /// **'Siswa'**
  String get roleStudent;

  /// No description provided for @roleTeacher.
  ///
  /// In id, this message translates to:
  /// **'Guru'**
  String get roleTeacher;

  /// No description provided for @registerRoleLabel.
  ///
  /// In id, this message translates to:
  /// **'Daftar Sebagai'**
  String get registerRoleLabel;

  /// No description provided for @btnLogin.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get btnLogin;

  /// No description provided for @btnRegister.
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get btnRegister;

  /// No description provided for @noAccount.
  ///
  /// In id, this message translates to:
  /// **'Belum punya akun? '**
  String get noAccount;

  /// No description provided for @registerLink.
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get registerLink;

  /// No description provided for @hasAccount.
  ///
  /// In id, this message translates to:
  /// **'Sudah punya akun? '**
  String get hasAccount;

  /// No description provided for @loginLink.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginLink;

  /// No description provided for @welcomeTitle.
  ///
  /// In id, this message translates to:
  /// **'Selamat Datang'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Belajar elektronika jadi seru dan interaktif!'**
  String get welcomeSubtitle;

  /// No description provided for @continueLearning.
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan Belajar'**
  String get continueLearning;

  /// No description provided for @quickShortcuts.
  ///
  /// In id, this message translates to:
  /// **'Pintasan Cepat'**
  String get quickShortcuts;

  /// No description provided for @miniGames.
  ///
  /// In id, this message translates to:
  /// **'Mini-Game'**
  String get miniGames;

  /// No description provided for @joinClassTitle.
  ///
  /// In id, this message translates to:
  /// **'Gabung Kelas'**
  String get joinClassTitle;

  /// No description provided for @joinClassDesc.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kode kelas dari guru Anda'**
  String get joinClassDesc;

  /// No description provided for @classCodeLabel.
  ///
  /// In id, this message translates to:
  /// **'Kode Kelas'**
  String get classCodeLabel;

  /// No description provided for @classCodeHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: ABC123'**
  String get classCodeHint;

  /// No description provided for @btnJoinClass.
  ///
  /// In id, this message translates to:
  /// **'Gabung'**
  String get btnJoinClass;

  /// No description provided for @myClass.
  ///
  /// In id, this message translates to:
  /// **'Kelas Saya'**
  String get myClass;

  /// No description provided for @classCode.
  ///
  /// In id, this message translates to:
  /// **'Kode: {code}'**
  String classCode(Object code);

  /// No description provided for @studentCount.
  ///
  /// In id, this message translates to:
  /// **'{count} siswa'**
  String studentCount(Object count);

  /// No description provided for @teacherLabel.
  ///
  /// In id, this message translates to:
  /// **'Guru: {name}'**
  String teacherLabel(Object name);

  /// No description provided for @levelUnlocked.
  ///
  /// In id, this message translates to:
  /// **'Terbuka'**
  String get levelUnlocked;

  /// No description provided for @levelLocked.
  ///
  /// In id, this message translates to:
  /// **'Terkunci'**
  String get levelLocked;

  /// No description provided for @completePrevLevel.
  ///
  /// In id, this message translates to:
  /// **'Selesaikan Level sebelumnya terlebih dahulu'**
  String get completePrevLevel;

  /// No description provided for @selectLevel.
  ///
  /// In id, this message translates to:
  /// **'Pilih Level'**
  String get selectLevel;

  /// No description provided for @settingsTitle.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get settingsTitle;

  /// No description provided for @languageDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Pilih Bahasa / Choose Language'**
  String get languageDialogTitle;

  /// No description provided for @saveChanges.
  ///
  /// In id, this message translates to:
  /// **'Simpan Perubahan'**
  String get saveChanges;

  /// No description provided for @saving.
  ///
  /// In id, this message translates to:
  /// **'Menyimpan...'**
  String get saving;

  /// No description provided for @processing.
  ///
  /// In id, this message translates to:
  /// **'Memproses...'**
  String get processing;

  /// No description provided for @showPassword.
  ///
  /// In id, this message translates to:
  /// **'Tampilkan password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In id, this message translates to:
  /// **'Sembunyikan password'**
  String get hidePassword;

  /// No description provided for @avatarChange.
  ///
  /// In id, this message translates to:
  /// **'Ganti Foto'**
  String get avatarChange;

  /// No description provided for @photoUploading.
  ///
  /// In id, this message translates to:
  /// **'Mengunggah foto...'**
  String get photoUploading;

  /// No description provided for @errorRequired.
  ///
  /// In id, this message translates to:
  /// **'Harap isi kolom ini'**
  String get errorRequired;

  /// No description provided for @errorEmail.
  ///
  /// In id, this message translates to:
  /// **'Format email tidak valid'**
  String get errorEmail;

  /// No description provided for @errorPasswordMin.
  ///
  /// In id, this message translates to:
  /// **'Password minimal 6 karakter'**
  String get errorPasswordMin;

  /// No description provided for @errorPasswordMatch.
  ///
  /// In id, this message translates to:
  /// **'Password tidak cocok'**
  String get errorPasswordMatch;

  /// No description provided for @errorName.
  ///
  /// In id, this message translates to:
  /// **'Nama minimal 2 karakter'**
  String get errorName;

  /// No description provided for @errorTeacherCode.
  ///
  /// In id, this message translates to:
  /// **'Kode guru tidak valid'**
  String get errorTeacherCode;

  /// No description provided for @authErrorNetwork.
  ///
  /// In id, this message translates to:
  /// **'Koneksi jaringan bermasalah. Coba lagi.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorWrongPassword.
  ///
  /// In id, this message translates to:
  /// **'Email atau password salah'**
  String get authErrorWrongPassword;

  /// No description provided for @authErrorUserNotFound.
  ///
  /// In id, this message translates to:
  /// **'Akun tidak ditemukan'**
  String get authErrorUserNotFound;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In id, this message translates to:
  /// **'Email sudah terdaftar'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In id, this message translates to:
  /// **'Password terlalu lemah'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In id, this message translates to:
  /// **'Format email tidak valid'**
  String get authErrorInvalidEmail;

  /// No description provided for @verificationPendingTitle.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Email'**
  String get verificationPendingTitle;

  /// No description provided for @verificationPendingDesc.
  ///
  /// In id, this message translates to:
  /// **'Kami telah mengirim email verifikasi ke {email}. Silakan cek kotak masuk Anda.'**
  String verificationPendingDesc(Object email);

  /// No description provided for @verificationResend.
  ///
  /// In id, this message translates to:
  /// **'Kirim Ulang'**
  String get verificationResend;

  /// No description provided for @verificationCheck.
  ///
  /// In id, this message translates to:
  /// **'Cek Verifikasi'**
  String get verificationCheck;

  /// No description provided for @profileName.
  ///
  /// In id, this message translates to:
  /// **'Nama'**
  String get profileName;

  /// No description provided for @profileEmail.
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profileRole.
  ///
  /// In id, this message translates to:
  /// **'Peran'**
  String get profileRole;

  /// No description provided for @profileClass.
  ///
  /// In id, this message translates to:
  /// **'Kelas'**
  String get profileClass;

  /// No description provided for @profileStudentId.
  ///
  /// In id, this message translates to:
  /// **'NIS'**
  String get profileStudentId;

  /// No description provided for @profileTeacherId.
  ///
  /// In id, this message translates to:
  /// **'NIP'**
  String get profileTeacherId;

  /// No description provided for @statsClasses.
  ///
  /// In id, this message translates to:
  /// **'Kelas'**
  String get statsClasses;

  /// No description provided for @statsStudents.
  ///
  /// In id, this message translates to:
  /// **'Siswa'**
  String get statsStudents;

  /// No description provided for @statsTasks.
  ///
  /// In id, this message translates to:
  /// **'Tugas'**
  String get statsTasks;

  /// No description provided for @menuEditProfil.
  ///
  /// In id, this message translates to:
  /// **'Edit Profil'**
  String get menuEditProfil;

  /// No description provided for @menuNotifications.
  ///
  /// In id, this message translates to:
  /// **'Notifikasi'**
  String get menuNotifications;

  /// No description provided for @menuAbout.
  ///
  /// In id, this message translates to:
  /// **'Tentang Aplikasi'**
  String get menuAbout;

  /// No description provided for @menuLogout.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get menuLogout;

  /// No description provided for @appName.
  ///
  /// In id, this message translates to:
  /// **'EduVolt'**
  String get appName;

  /// No description provided for @version.
  ///
  /// In id, this message translates to:
  /// **'Versi {version}'**
  String version(Object version);

  /// No description provided for @copyright.
  ///
  /// In id, this message translates to:
  /// **'© 2024 EduVolt. All rights reserved.'**
  String get copyright;

  /// No description provided for @cancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In id, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @close.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get close;

  /// No description provided for @ok.
  ///
  /// In id, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @yes.
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In id, this message translates to:
  /// **'Tidak'**
  String get no;

  /// No description provided for @retry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In id, this message translates to:
  /// **'Memuat...'**
  String get loading;

  /// No description provided for @noData.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada data'**
  String get noData;

  /// No description provided for @search.
  ///
  /// In id, this message translates to:
  /// **'Cari'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In id, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In id, this message translates to:
  /// **'Urutkan'**
  String get sort;

  /// No description provided for @refresh.
  ///
  /// In id, this message translates to:
  /// **'Muat Ulang'**
  String get refresh;

  /// No description provided for @titleProfile.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get titleProfile;

  /// No description provided for @titleSettings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get titleSettings;

  /// No description provided for @btnYesLogout.
  ///
  /// In id, this message translates to:
  /// **'Ya, Keluar'**
  String get btnYesLogout;

  /// No description provided for @errLogoutFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal keluar: {error}'**
  String errLogoutFailed(Object error);

  /// No description provided for @msgNoNotifications.
  ///
  /// In id, this message translates to:
  /// **'Belum ada notifikasi baru.'**
  String get msgNoNotifications;

  /// No description provided for @btnClose.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get btnClose;

  /// No description provided for @aboutDesc.
  ///
  /// In id, this message translates to:
  /// **'EduVolt v{version} - Platform Pembelajaran Elektronika untuk SMK.'**
  String aboutDesc(Object version);

  /// No description provided for @aboutMadeBy.
  ///
  /// In id, this message translates to:
  /// **'Dibuat oleh: Tim EduVolt'**
  String get aboutMadeBy;

  /// No description provided for @appVersion.
  ///
  /// In id, this message translates to:
  /// **'EduVolt v{version}'**
  String appVersion(Object version);

  /// No description provided for @loginSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Belajar listrik jadi seru ⚡'**
  String get loginSubtitle;

  /// No description provided for @tidakAdaSoal.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada soal tersedia'**
  String get tidakAdaSoal;

  /// No description provided for @gagalMemuatLevel.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat level'**
  String get gagalMemuatLevel;

  /// No description provided for @selesaikanLevelSebelumnya.
  ///
  /// In id, this message translates to:
  /// **'Selesaikan Level sebelumnya terlebih dahulu'**
  String get selesaikanLevelSebelumnya;

  /// No description provided for @kirimJawaban.
  ///
  /// In id, this message translates to:
  /// **'Kirim Jawaban'**
  String get kirimJawaban;

  /// No description provided for @kembaliKeLevel.
  ///
  /// In id, this message translates to:
  /// **'Kembali ke Level'**
  String get kembaliKeLevel;

  /// No description provided for @memuatKuis.
  ///
  /// In id, this message translates to:
  /// **'Memuat kuis...'**
  String get memuatKuis;

  /// No description provided for @gagalMemuatKuis.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat kuis'**
  String get gagalMemuatKuis;

  /// No description provided for @tidakAdaData.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada data'**
  String get tidakAdaData;

  /// No description provided for @kodeKelas.
  ///
  /// In id, this message translates to:
  /// **'Kode Kelas'**
  String get kodeKelas;

  /// No description provided for @gabungKelas.
  ///
  /// In id, this message translates to:
  /// **'Gabung Kelas'**
  String get gabungKelas;

  /// No description provided for @kelasSaya.
  ///
  /// In id, this message translates to:
  /// **'Kelas Saya'**
  String get kelasSaya;

  /// No description provided for @cari.
  ///
  /// In id, this message translates to:
  /// **'Cari'**
  String get cari;

  /// No description provided for @urutkan.
  ///
  /// In id, this message translates to:
  /// **'Urutkan'**
  String get urutkan;

  /// No description provided for @muatUlang.
  ///
  /// In id, this message translates to:
  /// **'Muat Ulang'**
  String get muatUlang;

  /// No description provided for @cobaLagi.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get cobaLagi;

  /// No description provided for @memuat.
  ///
  /// In id, this message translates to:
  /// **'Memuat...'**
  String get memuat;

  /// No description provided for @kelasTidakDitemukan.
  ///
  /// In id, this message translates to:
  /// **'Kelas tidak ditemukan'**
  String get kelasTidakDitemukan;

  /// No description provided for @hubungiGuruKodeKelas.
  ///
  /// In id, this message translates to:
  /// **'Hubungi guru Anda untuk kode kelas yang benar'**
  String get hubungiGuruKodeKelas;

  /// No description provided for @belumAdaPostingan.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Postingan'**
  String get belumAdaPostingan;

  /// No description provided for @tungguPengumumanGuru.
  ///
  /// In id, this message translates to:
  /// **'Tunggu pengumuman dari guru'**
  String get tungguPengumumanGuru;

  /// No description provided for @belumAdaTugas.
  ///
  /// In id, this message translates to:
  /// **'Belum ada tugas'**
  String get belumAdaTugas;

  /// No description provided for @belumAdaKelas.
  ///
  /// In id, this message translates to:
  /// **'Belum ada kelas'**
  String get belumAdaKelas;

  /// No description provided for @gagalMemuat.
  ///
  /// In id, this message translates to:
  /// **'Gagal Memuat'**
  String get gagalMemuat;

  /// No description provided for @selesaiTugas.
  ///
  /// In id, this message translates to:
  /// **'Selesai Tugas'**
  String get selesaiTugas;

  /// No description provided for @tugasTerlambat.
  ///
  /// In id, this message translates to:
  /// **'Tugas terlambat'**
  String get tugasTerlambat;

  /// No description provided for @belumDikerjakan.
  ///
  /// In id, this message translates to:
  /// **'Belum dikerjakan'**
  String get belumDikerjakan;

  /// No description provided for @hapusPostingan.
  ///
  /// In id, this message translates to:
  /// **'Hapus Postingan'**
  String get hapusPostingan;

  /// No description provided for @hapusTugas.
  ///
  /// In id, this message translates to:
  /// **'Hapus Tugas?'**
  String get hapusTugas;

  /// No description provided for @tindakanTidakDapatDibatalkan.
  ///
  /// In id, this message translates to:
  /// **'Tindakan ini tidak dapat dibatalkan'**
  String get tindakanTidakDapatDibatalkan;

  /// No description provided for @postinganDihapus.
  ///
  /// In id, this message translates to:
  /// **'Postingan dihapus'**
  String get postinganDihapus;

  /// No description provided for @tugasDihapus.
  ///
  /// In id, this message translates to:
  /// **'Tugas dihapus'**
  String get tugasDihapus;

  /// No description provided for @belumLogin.
  ///
  /// In id, this message translates to:
  /// **'Belum Login'**
  String get belumLogin;

  /// No description provided for @silakanLoginGuru.
  ///
  /// In id, this message translates to:
  /// **'Silakan login sebagai guru untuk mengelola kelas.'**
  String get silakanLoginGuru;

  /// No description provided for @daftarKelas.
  ///
  /// In id, this message translates to:
  /// **'Daftar Kelas'**
  String get daftarKelas;

  /// No description provided for @kelolaKelasYangAndaAmpu.
  ///
  /// In id, this message translates to:
  /// **'Kelola kelas yang Anda ampu'**
  String get kelolaKelasYangAndaAmpu;

  /// No description provided for @buatKelasBaru.
  ///
  /// In id, this message translates to:
  /// **'Buat Kelas Baru'**
  String get buatKelasBaru;

  /// No description provided for @buatTugasBaru.
  ///
  /// In id, this message translates to:
  /// **'Buat tugas baru untuk siswa Anda'**
  String get buatTugasBaru;

  /// No description provided for @namaKelas.
  ///
  /// In id, this message translates to:
  /// **'Nama Kelas'**
  String get namaKelas;

  /// No description provided for @deskripsiKelas.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi Kelas'**
  String get deskripsiKelas;

  /// No description provided for @kodeUndangan.
  ///
  /// In id, this message translates to:
  /// **'Kode Undangan'**
  String get kodeUndangan;

  /// No description provided for @tanggalBatas.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Batas'**
  String get tanggalBatas;

  /// No description provided for @mataPelajaran.
  ///
  /// In id, this message translates to:
  /// **'Mata Pelajaran'**
  String get mataPelajaran;

  /// No description provided for @pilihMataPelajaran.
  ///
  /// In id, this message translates to:
  /// **'Pilih Mata Pelajaran'**
  String get pilihMataPelajaran;

  /// No description provided for @totalSiswa.
  ///
  /// In id, this message translates to:
  /// **'Total Siswa'**
  String get totalSiswa;

  /// No description provided for @totalKelas.
  ///
  /// In id, this message translates to:
  /// **'Total Kelas'**
  String get totalKelas;

  /// No description provided for @totalTugas.
  ///
  /// In id, this message translates to:
  /// **'Total Tugas'**
  String get totalTugas;

  /// No description provided for @aktivitasTerkini.
  ///
  /// In id, this message translates to:
  /// **'Aktivitas Terkini'**
  String get aktivitasTerkini;

  /// No description provided for @guru.
  ///
  /// In id, this message translates to:
  /// **'Guru'**
  String get guru;

  /// No description provided for @siswa.
  ///
  /// In id, this message translates to:
  /// **'Siswa'**
  String get siswa;

  /// No description provided for @kode.
  ///
  /// In id, this message translates to:
  /// **'Kode'**
  String get kode;

  /// No description provided for @buatPengumumanAtauTugasPertama.
  ///
  /// In id, this message translates to:
  /// **'Buat pengumuman atau tugas pertama Anda'**
  String get buatPengumumanAtauTugasPertama;

  /// No description provided for @belumPunyaKelas.
  ///
  /// In id, this message translates to:
  /// **'Belum Punya Kelas?'**
  String get belumPunyaKelas;

  /// No description provided for @masukkanKodeKelas.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kode kelas dari guru Anda untuk bergabung.'**
  String get masukkanKodeKelas;

  /// No description provided for @joinClassSuccess.
  ///
  /// In id, this message translates to:
  /// **'Berhasil bergabung ke kelas!'**
  String get joinClassSuccess;

  /// No description provided for @lihatDetail.
  ///
  /// In id, this message translates to:
  /// **'Lihat Detail'**
  String get lihatDetail;

  /// No description provided for @tugasDanAbsen.
  ///
  /// In id, this message translates to:
  /// **'Tugas & Absen'**
  String get tugasDanAbsen;

  /// No description provided for @pengguna.
  ///
  /// In id, this message translates to:
  /// **'Pengguna'**
  String get pengguna;

  /// No description provided for @semuaTab.
  ///
  /// In id, this message translates to:
  /// **'Semua ({count})'**
  String semuaTab(Object count);

  /// No description provided for @belumAdaTugasSelesai.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Tugas Selesai'**
  String get belumAdaTugasSelesai;

  /// No description provided for @tugasSelesaiWillAppear.
  ///
  /// In id, this message translates to:
  /// **'Tugas yang diselesaikan akan muncul di sini.'**
  String get tugasSelesaiWillAppear;

  /// No description provided for @semuaTugasSelesai.
  ///
  /// In id, this message translates to:
  /// **'Semua Tugas Selesai! 🎉'**
  String get semuaTugasSelesai;

  /// No description provided for @tidakAdaTugasTertunda.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada tugas yang tertunda.'**
  String get tidakAdaTugasTertunda;

  /// No description provided for @postUpdated.
  ///
  /// In id, this message translates to:
  /// **'Postingan diperbarui'**
  String get postUpdated;

  /// No description provided for @deadlineLabel.
  ///
  /// In id, this message translates to:
  /// **'Deadline: {deadline}'**
  String deadlineLabel(Object deadline);

  /// No description provided for @lewat.
  ///
  /// In id, this message translates to:
  /// **'Lewat'**
  String get lewat;

  /// No description provided for @pengumuman.
  ///
  /// In id, this message translates to:
  /// **'Pengumuman'**
  String get pengumuman;

  /// No description provided for @hapusApa.
  ///
  /// In id, this message translates to:
  /// **'Hapus {item}?'**
  String hapusApa(Object item);

  /// No description provided for @assignmentUpdated.
  ///
  /// In id, this message translates to:
  /// **'Tugas diperbarui'**
  String get assignmentUpdated;

  /// No description provided for @siswaTab.
  ///
  /// In id, this message translates to:
  /// **'Siswa ({count})'**
  String siswaTab(Object count);

  /// No description provided for @kodeLabel.
  ///
  /// In id, this message translates to:
  /// **'Kode: {code}'**
  String kodeLabel(Object code);

  /// No description provided for @gagalMemuatSiswa.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan saat memuat daftar siswa.'**
  String get gagalMemuatSiswa;

  /// No description provided for @tanpaNama.
  ///
  /// In id, this message translates to:
  /// **'Tanpa Nama'**
  String get tanpaNama;

  /// No description provided for @tungguTugasDariGuru.
  ///
  /// In id, this message translates to:
  /// **'Tunggu tugas dari guru'**
  String get tungguTugasDariGuru;

  /// No description provided for @buatPengumuman.
  ///
  /// In id, this message translates to:
  /// **'Buat Pengumuman'**
  String get buatPengumuman;

  /// No description provided for @bagikanInfo.
  ///
  /// In id, this message translates to:
  /// **'Bagikan informasi penting kepada seluruh siswa di kelas.'**
  String get bagikanInfo;

  /// No description provided for @judulOpsional.
  ///
  /// In id, this message translates to:
  /// **'Judul (Opsional)'**
  String get judulOpsional;

  /// No description provided for @contohJudul.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Jadwal Praktikum Minggu Depan'**
  String get contohJudul;

  /// No description provided for @isiPengumuman.
  ///
  /// In id, this message translates to:
  /// **'Isi Pengumuman'**
  String get isiPengumuman;

  /// No description provided for @tulisPengumuman.
  ///
  /// In id, this message translates to:
  /// **'Tulis pengumuman di sini...'**
  String get tulisPengumuman;

  /// No description provided for @memposting.
  ///
  /// In id, this message translates to:
  /// **'Memposting...'**
  String get memposting;

  /// No description provided for @postingPengumuman.
  ///
  /// In id, this message translates to:
  /// **'Posting Pengumuman'**
  String get postingPengumuman;

  /// No description provided for @isiPengumumanTidakBolehKosong.
  ///
  /// In id, this message translates to:
  /// **'Isi pengumuman tidak boleh kosong'**
  String get isiPengumumanTidakBolehKosong;

  /// No description provided for @pilihDeadline.
  ///
  /// In id, this message translates to:
  /// **'Pilih Batas Waktu (Deadline)'**
  String get pilihDeadline;

  /// No description provided for @deadlineWithTime.
  ///
  /// In id, this message translates to:
  /// **'Deadline: {date} {time}'**
  String deadlineWithTime(Object date, Object time);

  /// No description provided for @membuat.
  ///
  /// In id, this message translates to:
  /// **'Membuat...'**
  String get membuat;

  /// No description provided for @buatTugas.
  ///
  /// In id, this message translates to:
  /// **'Buat Tugas'**
  String get buatTugas;

  /// No description provided for @judulTugasWajibDiisi.
  ///
  /// In id, this message translates to:
  /// **'Judul tugas wajib diisi'**
  String get judulTugasWajibDiisi;

  /// No description provided for @deskripsiTugasWajibDiisi.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi tugas wajib diisi'**
  String get deskripsiTugasWajibDiisi;

  /// No description provided for @deadlineWajibDipilih.
  ///
  /// In id, this message translates to:
  /// **'Deadline wajib dipilih'**
  String get deadlineWajibDipilih;

  /// No description provided for @tugasBerhasilDibuat.
  ///
  /// In id, this message translates to:
  /// **'Tugas berhasil dibuat'**
  String get tugasBerhasilDibuat;

  /// No description provided for @gagalMemuatMateri.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat materi'**
  String get gagalMemuatMateri;

  /// No description provided for @kembali.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get kembali;

  /// No description provided for @kuis.
  ///
  /// In id, this message translates to:
  /// **'Kuis'**
  String get kuis;

  /// No description provided for @selanjutnya.
  ///
  /// In id, this message translates to:
  /// **'Selanjutnya'**
  String get selanjutnya;

  /// No description provided for @selamat.
  ///
  /// In id, this message translates to:
  /// **'Selamat!'**
  String get selamat;

  /// No description provided for @perluBelajarLagi.
  ///
  /// In id, this message translates to:
  /// **'Perlu Belajar Lagi'**
  String get perluBelajarLagi;

  /// No description provided for @skorKamu.
  ///
  /// In id, this message translates to:
  /// **'Skor Kamu: {score}'**
  String skorKamu(Object score);

  /// No description provided for @benarDari.
  ///
  /// In id, this message translates to:
  /// **'{correct} dari {total} benar'**
  String benarDari(Object correct, Object total);

  /// No description provided for @levelPrefix.
  ///
  /// In id, this message translates to:
  /// **'Level'**
  String get levelPrefix;

  /// No description provided for @kembaliKePilihLevel.
  ///
  /// In id, this message translates to:
  /// **'Kembali ke Pilih Level'**
  String get kembaliKePilihLevel;

  /// No description provided for @badgePretest.
  ///
  /// In id, this message translates to:
  /// **'PRE-TEST'**
  String get badgePretest;

  /// No description provided for @badgeMateri.
  ///
  /// In id, this message translates to:
  /// **'MATERI'**
  String get badgeMateri;

  /// No description provided for @badgePosttest.
  ///
  /// In id, this message translates to:
  /// **'POST-TEST'**
  String get badgePosttest;

  /// No description provided for @badgeFolder.
  ///
  /// In id, this message translates to:
  /// **'FOLDER'**
  String get badgeFolder;

  /// No description provided for @chipSelesai.
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get chipSelesai;

  /// No description provided for @chipMulai.
  ///
  /// In id, this message translates to:
  /// **'Mulai'**
  String get chipMulai;

  /// No description provided for @pertanyaan.
  ///
  /// In id, this message translates to:
  /// **'{count} pertanyaan'**
  String pertanyaan(Object count);

  /// No description provided for @videoTidakTersedia.
  ///
  /// In id, this message translates to:
  /// **'Video tidak tersedia'**
  String get videoTidakTersedia;

  /// No description provided for @ringkasanVideo.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan Video'**
  String get ringkasanVideo;

  /// No description provided for @simulasiSegeraHadir.
  ///
  /// In id, this message translates to:
  /// **'Simulasi praktik untuk {title} segera hadir.'**
  String simulasiSegeraHadir(Object title);

  /// No description provided for @tandaiSelesai.
  ///
  /// In id, this message translates to:
  /// **'Tandai Selesai'**
  String get tandaiSelesai;

  /// No description provided for @tandaiSelesaiDialog.
  ///
  /// In id, this message translates to:
  /// **'Tandai Selesai?'**
  String get tandaiSelesaiDialog;

  /// No description provided for @konfirmasiTandaiSelesai.
  ///
  /// In id, this message translates to:
  /// **'Apakah kamu yakin ingin menandai \"{title}\" sebagai selesai?'**
  String konfirmasiTandaiSelesai(Object title);

  /// No description provided for @ditandaiSelesai.
  ///
  /// In id, this message translates to:
  /// **'{title} ditandai selesai!'**
  String ditandaiSelesai(Object title);

  /// No description provided for @sudahSelesai.
  ///
  /// In id, this message translates to:
  /// **'Sudah Selesai'**
  String get sudahSelesai;

  /// No description provided for @gambarPlaceholder.
  ///
  /// In id, this message translates to:
  /// **'Gambar: {url}\\n\\n(Tap untuk lihat fullscreen di Fase 3+)'**
  String gambarPlaceholder(Object url);

  /// No description provided for @homeContinueLearning.
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan Belajar'**
  String get homeContinueLearning;

  /// No description provided for @homeQuickShortcuts.
  ///
  /// In id, this message translates to:
  /// **'Pintasan Cepat'**
  String get homeQuickShortcuts;

  /// No description provided for @homeMiniGames.
  ///
  /// In id, this message translates to:
  /// **'Mini-Games'**
  String get homeMiniGames;

  /// No description provided for @homeStudyReady.
  ///
  /// In id, this message translates to:
  /// **'Siap belajar elektronika hari ini?'**
  String get homeStudyReady;

  /// No description provided for @homeProgressLabel.
  ///
  /// In id, this message translates to:
  /// **'PROGRESS BELAJAR'**
  String get homeProgressLabel;

  /// No description provided for @homeCourseTitle.
  ///
  /// In id, this message translates to:
  /// **'Dasar Elektronika'**
  String get homeCourseTitle;

  /// No description provided for @homeStreakLabel.
  ///
  /// In id, this message translates to:
  /// **'Streak'**
  String get homeStreakLabel;

  /// No description provided for @homeStreakDays.
  ///
  /// In id, this message translates to:
  /// **'{days} hari'**
  String homeStreakDays(Object days);

  /// No description provided for @homeCoinsLabel.
  ///
  /// In id, this message translates to:
  /// **'Koin'**
  String get homeCoinsLabel;

  /// No description provided for @homeModuleLabel.
  ///
  /// In id, this message translates to:
  /// **'Modul'**
  String get homeModuleLabel;

  /// No description provided for @homeModuleText.
  ///
  /// In id, this message translates to:
  /// **'{count} Modul selesai'**
  String homeModuleText(Object count);

  /// No description provided for @homeJoinClass.
  ///
  /// In id, this message translates to:
  /// **'Gabung Kelas'**
  String get homeJoinClass;

  /// No description provided for @homeJoinClassDesc.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kode kelas dari guru Anda'**
  String get homeJoinClassDesc;

  /// No description provided for @homeJoinSuccess.
  ///
  /// In id, this message translates to:
  /// **'Berhasil bergabung ke kelas!'**
  String get homeJoinSuccess;

  /// No description provided for @homeClassCodeLabel.
  ///
  /// In id, this message translates to:
  /// **'Kode Kelas'**
  String get homeClassCodeLabel;

  /// No description provided for @homeClassCodeHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: ABC123'**
  String get homeClassCodeHint;

  /// No description provided for @homeGabung.
  ///
  /// In id, this message translates to:
  /// **'Gabung'**
  String get homeGabung;

  /// No description provided for @homeClassNotFound.
  ///
  /// In id, this message translates to:
  /// **'Kelas tidak ditemukan'**
  String get homeClassNotFound;

  /// No description provided for @homeContactTeacher.
  ///
  /// In id, this message translates to:
  /// **'Hubungi guru Anda untuk kode kelas yang benar'**
  String get homeContactTeacher;

  /// No description provided for @homeNoClassName.
  ///
  /// In id, this message translates to:
  /// **'Tanpa Nama'**
  String get homeNoClassName;

  /// No description provided for @homeKode.
  ///
  /// In id, this message translates to:
  /// **'Kode:'**
  String get homeKode;

  /// No description provided for @homeLevelCompleted.
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get homeLevelCompleted;

  /// No description provided for @homeLevelCurrent.
  ///
  /// In id, this message translates to:
  /// **'Level {level}'**
  String homeLevelCurrent(Object level);

  /// No description provided for @homeExploreMateri.
  ///
  /// In id, this message translates to:
  /// **'Jelajahi Materi'**
  String get homeExploreMateri;

  /// No description provided for @homeStartLearning.
  ///
  /// In id, this message translates to:
  /// **'Mulai Belajar'**
  String get homeStartLearning;

  /// No description provided for @homeContinue.
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan'**
  String get homeContinue;

  /// No description provided for @homeGuessComponent.
  ///
  /// In id, this message translates to:
  /// **'Tebak Komponen'**
  String get homeGuessComponent;

  /// No description provided for @homeGuessDesc.
  ///
  /// In id, this message translates to:
  /// **'Tebak komponen dan baca gelang warna resistor!'**
  String get homeGuessDesc;

  /// No description provided for @homeCircuitRush.
  ///
  /// In id, this message translates to:
  /// **'Sirkuit Kilat'**
  String get homeCircuitRush;

  /// No description provided for @homeCircuitRushDesc.
  ///
  /// In id, this message translates to:
  /// **'Pandu elektron melewati rintangan resistor!'**
  String get homeCircuitRushDesc;

  /// No description provided for @homeCableConnect.
  ///
  /// In id, this message translates to:
  /// **'Sambung Kabel'**
  String get homeCableConnect;

  /// No description provided for @homeCableConnectDesc.
  ///
  /// In id, this message translates to:
  /// **'Rangkai jalur kabel tertutup melewati komponen!'**
  String get homeCableConnectDesc;

  /// No description provided for @homePlay.
  ///
  /// In id, this message translates to:
  /// **'Main'**
  String get homePlay;

  /// No description provided for @guruWelcome.
  ///
  /// In id, this message translates to:
  /// **'Selamat datang,'**
  String get guruWelcome;

  /// No description provided for @guruActivities.
  ///
  /// In id, this message translates to:
  /// **'Aktivitas Terkini'**
  String get guruActivities;

  /// No description provided for @guruStatsClasses.
  ///
  /// In id, this message translates to:
  /// **'Kelas'**
  String get guruStatsClasses;

  /// No description provided for @guruStatsStudents.
  ///
  /// In id, this message translates to:
  /// **'Siswa'**
  String get guruStatsStudents;

  /// No description provided for @guruStatsActiveAssignments.
  ///
  /// In id, this message translates to:
  /// **'Tugas Aktif'**
  String get guruStatsActiveAssignments;

  /// No description provided for @guruCreateClass.
  ///
  /// In id, this message translates to:
  /// **'+ Buat Kelas'**
  String get guruCreateClass;

  /// No description provided for @guruNotLoggedIn.
  ///
  /// In id, this message translates to:
  /// **'Belum Login'**
  String get guruNotLoggedIn;

  /// No description provided for @guruLoginPrompt.
  ///
  /// In id, this message translates to:
  /// **'Silakan login sebagai guru untuk mengelola kelas.'**
  String get guruLoginPrompt;

  /// No description provided for @guruNoClasses.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Kelas'**
  String get guruNoClasses;

  /// No description provided for @guruCreateClassPrompt.
  ///
  /// In id, this message translates to:
  /// **'Tekan \"+ Buat Kelas\" untuk membuat kelas baru.'**
  String get guruCreateClassPrompt;

  /// No description provided for @guruCreateClassTitle.
  ///
  /// In id, this message translates to:
  /// **'Buat Kelas Baru'**
  String get guruCreateClassTitle;

  /// No description provided for @guruClassNameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama Kelas'**
  String get guruClassNameLabel;

  /// No description provided for @guruClassNameHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: 10 IPA 1'**
  String get guruClassNameHint;

  /// No description provided for @guruClassNameRequired.
  ///
  /// In id, this message translates to:
  /// **'Nama kelas tidak boleh kosong'**
  String get guruClassNameRequired;

  /// No description provided for @guruCancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get guruCancel;

  /// No description provided for @guruCreate.
  ///
  /// In id, this message translates to:
  /// **'Buat'**
  String get guruCreate;

  /// No description provided for @guruLoginFirst.
  ///
  /// In id, this message translates to:
  /// **'Silakan login terlebih dahulu'**
  String get guruLoginFirst;

  /// No description provided for @guruClassCreated.
  ///
  /// In id, this message translates to:
  /// **'Kelas \"{name}\" berhasil dibuat (Kode: {code})'**
  String guruClassCreated(Object code, Object name);

  /// No description provided for @guruClassCreateFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal membuat kelas: {error}'**
  String guruClassCreateFailed(Object error);

  /// No description provided for @homeCalcResistor.
  ///
  /// In id, this message translates to:
  /// **'Kalkulator Resistor'**
  String get homeCalcResistor;

  /// No description provided for @homeCalcResistorDesc.
  ///
  /// In id, this message translates to:
  /// **'Baca warna gelang'**
  String get homeCalcResistorDesc;

  /// No description provided for @homeCalcOhm.
  ///
  /// In id, this message translates to:
  /// **'Kalkulator Ohm'**
  String get homeCalcOhm;

  /// No description provided for @homeCalcOhmDesc.
  ///
  /// In id, this message translates to:
  /// **'Hitung V, I, R'**
  String get homeCalcOhmDesc;

  /// No description provided for @defaultName.
  ///
  /// In id, this message translates to:
  /// **'Budi Santoso'**
  String get defaultName;

  /// No description provided for @defaultEmail.
  ///
  /// In id, this message translates to:
  /// **'budi.santoso@sekolah.sch.id'**
  String get defaultEmail;

  /// No description provided for @fotoProfilDiperbarui.
  ///
  /// In id, this message translates to:
  /// **'Foto profil berhasil diperbarui'**
  String get fotoProfilDiperbarui;

  /// No description provided for @gagalUnggahFoto.
  ///
  /// In id, this message translates to:
  /// **'Gagal memilih atau mengunggah foto profil. Silakan coba lagi.'**
  String get gagalUnggahFoto;

  /// No description provided for @profilDiperbarui.
  ///
  /// In id, this message translates to:
  /// **'Profil berhasil diperbarui'**
  String get profilDiperbarui;

  /// No description provided for @gagalSimpanProfil.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan saat menyimpan profil. Silakan coba lagi.'**
  String get gagalSimpanProfil;

  /// No description provided for @editProfil.
  ///
  /// In id, this message translates to:
  /// **'Edit Profil'**
  String get editProfil;

  /// No description provided for @tambahFoto.
  ///
  /// In id, this message translates to:
  /// **'Tambah foto'**
  String get tambahFoto;

  /// No description provided for @pilihFotoGaleri.
  ///
  /// In id, this message translates to:
  /// **'Pilih dari galeri'**
  String get pilihFotoGaleri;

  /// No description provided for @ledSimTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Running LED'**
  String get ledSimTitle;

  /// No description provided for @ledSimDesc.
  ///
  /// In id, this message translates to:
  /// **'Amati bagaimana pin digital mikrokontroler menyalakan deretan LED bergantian.'**
  String get ledSimDesc;

  /// No description provided for @ledStatusActive.
  ///
  /// In id, this message translates to:
  /// **'Aktif: Pin D{pin} HIGH'**
  String ledStatusActive(Object pin);

  /// No description provided for @ledStatusStandby.
  ///
  /// In id, this message translates to:
  /// **'Status: Standby (Semua Pin LOW)'**
  String get ledStatusStandby;

  /// No description provided for @ledBtnStop.
  ///
  /// In id, this message translates to:
  /// **'Hentikan Animasi'**
  String get ledBtnStop;

  /// No description provided for @ledBtnStart.
  ///
  /// In id, this message translates to:
  /// **'Jalankan Animasi'**
  String get ledBtnStart;

  /// No description provided for @ledConceptTitle.
  ///
  /// In id, this message translates to:
  /// **'Konsep Kerja'**
  String get ledConceptTitle;

  /// No description provided for @ledConceptText.
  ///
  /// In id, this message translates to:
  /// **'1. Mikrokontroler mengirim sinyal HIGH (5V) ke satu pin.\\n2. LED menyala karena arus mengalir melewati resistor ke GND.\\n3. Rutin loop mematikan LED (LOW) lalu beralih ke pin berikutnya.'**
  String get ledConceptText;

  /// No description provided for @pbSimTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Push Button'**
  String get pbSimTitle;

  /// No description provided for @pbSimDesc.
  ///
  /// In id, this message translates to:
  /// **'Tekan dan tahan tombol tactile switch di bawah untuk mengalirkan arus ke LED.'**
  String get pbSimDesc;

  /// No description provided for @pbCircuitClosed.
  ///
  /// In id, this message translates to:
  /// **'RANGKAIAN TERTUTUP: ARUS MENGALIR'**
  String get pbCircuitClosed;

  /// No description provided for @pbCircuitOpen.
  ///
  /// In id, this message translates to:
  /// **'RANGKAIAN TERBUKA: STANDBY'**
  String get pbCircuitOpen;

  /// No description provided for @pbBtnPressed.
  ///
  /// In id, this message translates to:
  /// **'Ditekan'**
  String get pbBtnPressed;

  /// No description provided for @pbBtnHold.
  ///
  /// In id, this message translates to:
  /// **'Tekan & Tahan'**
  String get pbBtnHold;

  /// No description provided for @pbLedOn.
  ///
  /// In id, this message translates to:
  /// **'LED ON'**
  String get pbLedOn;

  /// No description provided for @pbLedOff.
  ///
  /// In id, this message translates to:
  /// **'LED OFF'**
  String get pbLedOff;

  /// No description provided for @relaySimTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Modul Relay 5V'**
  String get relaySimTitle;

  /// No description provided for @relayOn.
  ///
  /// In id, this message translates to:
  /// **'ON'**
  String get relayOn;

  /// No description provided for @relayOff.
  ///
  /// In id, this message translates to:
  /// **'OFF'**
  String get relayOff;

  /// No description provided for @relayDesc.
  ///
  /// In id, this message translates to:
  /// **'Logika Active LOW: Beri sinyal LOW (0V) di Pin D7 untuk mengalirkan arus ke koil relay.'**
  String get relayDesc;

  /// No description provided for @relayDc12v.
  ///
  /// In id, this message translates to:
  /// **'DC 12V'**
  String get relayDc12v;

  /// No description provided for @relayLoadOn.
  ///
  /// In id, this message translates to:
  /// **'BEBAN (ON)'**
  String get relayLoadOn;

  /// No description provided for @relayLoadOff.
  ///
  /// In id, this message translates to:
  /// **'BEBAN (OFF)'**
  String get relayLoadOff;

  /// No description provided for @rcTitle.
  ///
  /// In id, this message translates to:
  /// **'Kalkulator Kode Warna Resistor'**
  String get rcTitle;

  /// No description provided for @rcDesc.
  ///
  /// In id, this message translates to:
  /// **'Pilih jumlah gelang lalu ketuk gelang untuk mengubah warna.'**
  String get rcDesc;

  /// No description provided for @rcBandCount.
  ///
  /// In id, this message translates to:
  /// **'Jumlah Gelang'**
  String get rcBandCount;

  /// No description provided for @rcBand4.
  ///
  /// In id, this message translates to:
  /// **'4 Gelang'**
  String get rcBand4;

  /// No description provided for @rcBand5.
  ///
  /// In id, this message translates to:
  /// **'5 Gelang'**
  String get rcBand5;

  /// No description provided for @rcBand6.
  ///
  /// In id, this message translates to:
  /// **'6 Gelang'**
  String get rcBand6;

  /// No description provided for @rcReadingTitle.
  ///
  /// In id, this message translates to:
  /// **'Cara Membaca Gelang'**
  String get rcReadingTitle;

  /// No description provided for @rcReadingText.
  ///
  /// In id, this message translates to:
  /// **'• 4 Gelang: Digit 1, Digit 2, Pengali, Toleransi\\n• 5 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi\\n• 6 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi, Koef. Suhu\\n\\nContoh 220 Ω ±5%: Merah (2) - Merah (2) - Cokelat (×10) - Emas (±5%)'**
  String get rcReadingText;

  /// No description provided for @rcBandDigit.
  ///
  /// In id, this message translates to:
  /// **'Gelang {n} (Digit)'**
  String rcBandDigit(Object n);

  /// No description provided for @rcBandMultiplier.
  ///
  /// In id, this message translates to:
  /// **'Gelang {n} (Pengali)'**
  String rcBandMultiplier(Object n);

  /// No description provided for @rcBandTolerance.
  ///
  /// In id, this message translates to:
  /// **'Gelang {n} (Toleransi)'**
  String rcBandTolerance(Object n);

  /// No description provided for @rcBandTempco.
  ///
  /// In id, this message translates to:
  /// **'Gelang {n} (Koef. Suhu)'**
  String rcBandTempco(Object n);

  /// No description provided for @ohmSimTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Rangkaian Tertutup & Hukum Ohm'**
  String get ohmSimTitle;

  /// No description provided for @ohmSimDesc.
  ///
  /// In id, this message translates to:
  /// **'Amati aliran arus listrik pada rangkaian tertutup dari kutub (+) baterai, melewati hambatan dan beban, kembali ke kutub (-).'**
  String get ohmSimDesc;

  /// No description provided for @ohmSwitchOpen.
  ///
  /// In id, this message translates to:
  /// **'TERBUKA'**
  String get ohmSwitchOpen;

  /// No description provided for @ohmSwitchClosed.
  ///
  /// In id, this message translates to:
  /// **'TERTUTUP'**
  String get ohmSwitchClosed;

  /// No description provided for @ohmVoltage.
  ///
  /// In id, this message translates to:
  /// **'Tegangan: {v} V'**
  String ohmVoltage(Object v);

  /// No description provided for @ohmResistance.
  ///
  /// In id, this message translates to:
  /// **'Hambatan: {r} Ω'**
  String ohmResistance(Object r);

  /// No description provided for @ohmCurrent.
  ///
  /// In id, this message translates to:
  /// **'Arus: {i} mA'**
  String ohmCurrent(Object i);

  /// No description provided for @ohmCircuitClosed.
  ///
  /// In id, this message translates to:
  /// **'RANGKAIAN TERTUTUP: Arus Mengalir ({i} mA)'**
  String ohmCircuitClosed(Object i);

  /// No description provided for @ohmCircuitOpen.
  ///
  /// In id, this message translates to:
  /// **'RANGKAIAN TERBUKA: Arus Terputus (0.0 mA)'**
  String get ohmCircuitOpen;

  /// No description provided for @ohmBtnOpen.
  ///
  /// In id, this message translates to:
  /// **'Buka Saklar (OFF)'**
  String get ohmBtnOpen;

  /// No description provided for @ohmBtnClose.
  ///
  /// In id, this message translates to:
  /// **'Tutup Saklar (ON)'**
  String get ohmBtnClose;

  /// No description provided for @ohmParamTitle.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan Parameter'**
  String get ohmParamTitle;

  /// No description provided for @ohmParamDesc.
  ///
  /// In id, this message translates to:
  /// **'Ubah nilai tegangan atau hambatan untuk melihat pengaruhnya terhadap laju partikel dan terangnya lampu.'**
  String get ohmParamDesc;

  /// No description provided for @ohmVoltageLabel.
  ///
  /// In id, this message translates to:
  /// **'Tegangan (V)'**
  String get ohmVoltageLabel;

  /// No description provided for @ohmResistanceLabel.
  ///
  /// In id, this message translates to:
  /// **'Hambatan (R)'**
  String get ohmResistanceLabel;

  /// No description provided for @ohmConceptTitle.
  ///
  /// In id, this message translates to:
  /// **'Konsep Rangkaian Tertutup & Hukum Ohm'**
  String get ohmConceptTitle;

  /// No description provided for @ohmConceptText.
  ///
  /// In id, this message translates to:
  /// **'1. Rangkaian Tertutup (Closed Circuit):\\n   Arus hanya mengalir bila ada lintasan konduktor tertutup dari kutub (+) baterai menuju beban dan kembali ke kutub (-).\\n\\n2. Hambatan Resistor (R):\\n   Resistor membatasi laju partikel muatan. Semakin tinggi hambatan, semakin lambat aliran arus.\\n\\n3. Daya Terang Lampu:\\n   Kuat arus (I = V / R) menentukan terang bohlam. Arus besar membuat lampu menyala lebih terang.'**
  String get ohmConceptText;

  /// No description provided for @ohmLampLabel.
  ///
  /// In id, this message translates to:
  /// **'Lampu'**
  String get ohmLampLabel;

  /// No description provided for @ohmSwitchLabelOn.
  ///
  /// In id, this message translates to:
  /// **'Saklar ON'**
  String get ohmSwitchLabelOn;

  /// No description provided for @ohmSwitchLabelOff.
  ///
  /// In id, this message translates to:
  /// **'Saklar OFF'**
  String get ohmSwitchLabelOff;

  /// No description provided for @motorSimTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Motor'**
  String get motorSimTitle;

  /// No description provided for @motorServo.
  ///
  /// In id, this message translates to:
  /// **'Servo'**
  String get motorServo;

  /// No description provided for @motorDc.
  ///
  /// In id, this message translates to:
  /// **'Motor DC'**
  String get motorDc;

  /// No description provided for @motorStepper.
  ///
  /// In id, this message translates to:
  /// **'Motor Stepper'**
  String get motorStepper;

  /// No description provided for @motorStatusRunning.
  ///
  /// In id, this message translates to:
  /// **'Berjalan'**
  String get motorStatusRunning;

  /// No description provided for @motorStatusStopped.
  ///
  /// In id, this message translates to:
  /// **'Berhenti'**
  String get motorStatusStopped;

  /// No description provided for @motorStatusStalled.
  ///
  /// In id, this message translates to:
  /// **'Tergantung'**
  String get motorStatusStalled;

  /// No description provided for @motorServoTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Servo Motor SG90'**
  String get motorServoTitle;

  /// No description provided for @motorDcTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Motor DC & Kontrol PWM'**
  String get motorDcTitle;

  /// No description provided for @motorStepperTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Stepper 28BYJ-48 + ULN2003'**
  String get motorStepperTitle;

  /// No description provided for @sensorTabHcsr04.
  ///
  /// In id, this message translates to:
  /// **'HC-SR04'**
  String get sensorTabHcsr04;

  /// No description provided for @sensorTabLdr.
  ///
  /// In id, this message translates to:
  /// **'LDR'**
  String get sensorTabLdr;

  /// No description provided for @sensorTabDht11.
  ///
  /// In id, this message translates to:
  /// **'DHT11'**
  String get sensorTabDht11;

  /// No description provided for @sensorTabMq135.
  ///
  /// In id, this message translates to:
  /// **'MQ-135'**
  String get sensorTabMq135;

  /// No description provided for @sensorDistance.
  ///
  /// In id, this message translates to:
  /// **'Jarak: {d} cm'**
  String sensorDistance(Object d);

  /// No description provided for @sensorLight.
  ///
  /// In id, this message translates to:
  /// **'Cahaya: {l} %'**
  String sensorLight(Object l);

  /// No description provided for @sensorTemperature.
  ///
  /// In id, this message translates to:
  /// **'Suhu: {t} °C'**
  String sensorTemperature(Object t);

  /// No description provided for @sensorHumidity.
  ///
  /// In id, this message translates to:
  /// **'Kelembaban: {h} %'**
  String sensorHumidity(Object h);

  /// No description provided for @sensorGas.
  ///
  /// In id, this message translates to:
  /// **'Gas: {g} ppm'**
  String sensorGas(Object g);

  /// No description provided for @sensorFanOn.
  ///
  /// In id, this message translates to:
  /// **'KIPAS ON'**
  String get sensorFanOn;

  /// No description provided for @sensorFanOff.
  ///
  /// In id, this message translates to:
  /// **'KIPAS OFF'**
  String get sensorFanOff;

  /// No description provided for @sensorAlarmBlink.
  ///
  /// In id, this message translates to:
  /// **'ALARM BLINK'**
  String get sensorAlarmBlink;

  /// No description provided for @sensorStandby.
  ///
  /// In id, this message translates to:
  /// **'STANDBY'**
  String get sensorStandby;

  /// No description provided for @rcResultTitle.
  ///
  /// In id, this message translates to:
  /// **'Nilai Hambatan'**
  String get rcResultTitle;

  /// No description provided for @rcToleranceLabel.
  ///
  /// In id, this message translates to:
  /// **'Toleransi: ±{t}%'**
  String rcToleranceLabel(Object t);

  /// No description provided for @rcTempcoLabel.
  ///
  /// In id, this message translates to:
  /// **'Koefisien Suhu: {t} ppm/K'**
  String rcTempcoLabel(Object t);

  /// No description provided for @sensorHcsr04Title.
  ///
  /// In id, this message translates to:
  /// **'Sensor Ultrasonik HC-SR04'**
  String get sensorHcsr04Title;

  /// No description provided for @sensorHcsr04Desc.
  ///
  /// In id, this message translates to:
  /// **'Gelombang suara keluar dari Transmitter (T), memantul di objek, dan masuk ke Receiver (R).'**
  String get sensorHcsr04Desc;

  /// No description provided for @sensorHcsr04Panel.
  ///
  /// In id, this message translates to:
  /// **'Jarak Objek (2 cm - 400 cm)'**
  String get sensorHcsr04Panel;

  /// No description provided for @sensorHcsr04StatusDanger.
  ///
  /// In id, this message translates to:
  /// **'Jarak: {d} cm (Bahaya!)'**
  String sensorHcsr04StatusDanger(Object d);

  /// No description provided for @sensorHcsr04StatusSafe.
  ///
  /// In id, this message translates to:
  /// **'Jarak: {d} cm (Aman)'**
  String sensorHcsr04StatusSafe(Object d);

  /// No description provided for @sensorHcsr04SubDanger.
  ///
  /// In id, this message translates to:
  /// **'Jarak < 20 cm -> LED Indikator Hijau MENYALA'**
  String get sensorHcsr04SubDanger;

  /// No description provided for @sensorHcsr04SubSafe.
  ///
  /// In id, this message translates to:
  /// **'Jarak >= 20 cm -> LED MATI'**
  String get sensorHcsr04SubSafe;

  /// No description provided for @sensorHcsr04BadgeOn.
  ///
  /// In id, this message translates to:
  /// **'LED: ON'**
  String get sensorHcsr04BadgeOn;

  /// No description provided for @sensorHcsr04BadgeOff.
  ///
  /// In id, this message translates to:
  /// **'LED: OFF'**
  String get sensorHcsr04BadgeOff;

  /// No description provided for @sensorLdrTitle.
  ///
  /// In id, this message translates to:
  /// **'Sensor Cahaya LDR'**
  String get sensorLdrTitle;

  /// No description provided for @sensorLdrDesc.
  ///
  /// In id, this message translates to:
  /// **'Saat cahaya < 30%, resistansi LDR naik sehingga lampu menyala otomatis.'**
  String get sensorLdrDesc;

  /// No description provided for @sensorLdrPanel.
  ///
  /// In id, this message translates to:
  /// **'Intensitas Cahaya (0% - 100%)'**
  String get sensorLdrPanel;

  /// No description provided for @sensorLdrStatusDark.
  ///
  /// In id, this message translates to:
  /// **'Kondisi: Gelap -> Lampu ON'**
  String get sensorLdrStatusDark;

  /// No description provided for @sensorLdrStatusBright.
  ///
  /// In id, this message translates to:
  /// **'Kondisi: Terang -> Lampu OFF'**
  String get sensorLdrStatusBright;

  /// No description provided for @sensorLdrSub.
  ///
  /// In id, this message translates to:
  /// **'Intensitas: {l}% (Ambang gelap < 30%)'**
  String sensorLdrSub(Object l);

  /// No description provided for @sensorLdrBadgeOn.
  ///
  /// In id, this message translates to:
  /// **'GLOW: ON'**
  String get sensorLdrBadgeOn;

  /// No description provided for @sensorLdrBadgeOff.
  ///
  /// In id, this message translates to:
  /// **'GLOW: OFF'**
  String get sensorLdrBadgeOff;

  /// No description provided for @sensorDht11Title.
  ///
  /// In id, this message translates to:
  /// **'Sensor Suhu & Kelembapan DHT11'**
  String get sensorDht11Title;

  /// No description provided for @sensorDht11Desc.
  ///
  /// In id, this message translates to:
  /// **'Mengukur suhu & kelembapan udara. Jika suhu > 30°C, kipas pendingin menyala.'**
  String get sensorDht11Desc;

  /// No description provided for @sensorDht11Panel.
  ///
  /// In id, this message translates to:
  /// **'Suhu (20°C - 40°C) & Kelembapan (0% - 100%)'**
  String get sensorDht11Panel;

  /// No description provided for @sensorDht11Status.
  ///
  /// In id, this message translates to:
  /// **'Suhu: {t}°C | Kelembapan: {h}%'**
  String sensorDht11Status(Object h, Object t);

  /// No description provided for @sensorDht11FanOn.
  ///
  /// In id, this message translates to:
  /// **'KIPAS ON'**
  String get sensorDht11FanOn;

  /// No description provided for @sensorDht11FanOff.
  ///
  /// In id, this message translates to:
  /// **'KIPAS OFF'**
  String get sensorDht11FanOff;

  /// No description provided for @sensorMq135Title.
  ///
  /// In id, this message translates to:
  /// **'Sensor Gas MQ-135'**
  String get sensorMq135Title;

  /// No description provided for @sensorMq135Desc.
  ///
  /// In id, this message translates to:
  /// **'Mendeteksi konsentrasi gas/asap di udara. Jika di ambang, LED alarm berkedip.'**
  String get sensorMq135Desc;

  /// No description provided for @sensorMq135Panel.
  ///
  /// In id, this message translates to:
  /// **'Konsentrasi Gas (0 - 1000 ppm)'**
  String get sensorMq135Panel;

  /// No description provided for @sensorMq135Status.
  ///
  /// In id, this message translates to:
  /// **'Gas: {g} ppm'**
  String sensorMq135Status(Object g);

  /// No description provided for @sensorMq135Alarm.
  ///
  /// In id, this message translates to:
  /// **'ALARM BLINK'**
  String get sensorMq135Alarm;

  /// No description provided for @sensorMq135Standby.
  ///
  /// In id, this message translates to:
  /// **'STANDBY'**
  String get sensorMq135Standby;

  /// No description provided for @sensorLedOn.
  ///
  /// In id, this message translates to:
  /// **'LED ON'**
  String get sensorLedOn;

  /// No description provided for @sensorLedOff.
  ///
  /// In id, this message translates to:
  /// **'LED OFF'**
  String get sensorLedOff;

  /// No description provided for @sensorTempHeader.
  ///
  /// In id, this message translates to:
  /// **'Suhu'**
  String get sensorTempHeader;

  /// No description provided for @sensorHumidityHeader.
  ///
  /// In id, this message translates to:
  /// **'Kelembapan'**
  String get sensorHumidityHeader;

  /// No description provided for @motorSketchTitle.
  ///
  /// In id, this message translates to:
  /// **'PRATINJAU SKETCH ARDUINO LANGSUNG'**
  String get motorSketchTitle;

  /// No description provided for @motorInputA0.
  ///
  /// In id, this message translates to:
  /// **'A0 → Output'**
  String get motorInputA0;

  /// No description provided for @motorInputD2D3.
  ///
  /// In id, this message translates to:
  /// **'D2/D3 → Output'**
  String get motorInputD2D3;

  /// No description provided for @motorDcForward.
  ///
  /// In id, this message translates to:
  /// **'Maju (CW)'**
  String get motorDcForward;

  /// No description provided for @motorDcReverse.
  ///
  /// In id, this message translates to:
  /// **'Mundur (CCW)'**
  String get motorDcReverse;

  /// No description provided for @motorDcGas.
  ///
  /// In id, this message translates to:
  /// **'GAS ▲ (Tahan)'**
  String get motorDcGas;

  /// No description provided for @motorDcBrake.
  ///
  /// In id, this message translates to:
  /// **'REM ▼ (Tahan)'**
  String get motorDcBrake;

  /// No description provided for @motorDcStop.
  ///
  /// In id, this message translates to:
  /// **'BERHENTI'**
  String get motorDcStop;

  /// No description provided for @motorDcPresetFwd200.
  ///
  /// In id, this message translates to:
  /// **'Maju (PWM 200)'**
  String get motorDcPresetFwd200;

  /// No description provided for @motorDcPresetRev100.
  ///
  /// In id, this message translates to:
  /// **'Mundur (PWM 100)'**
  String get motorDcPresetRev100;

  /// No description provided for @motorDcPowerLabel.
  ///
  /// In id, this message translates to:
  /// **'Saklar Utama Motor DC (Soft-Start)'**
  String get motorDcPowerLabel;

  /// No description provided for @motorDcPowerSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Saat ON, kecepatan naik bertahap ke target PWM'**
  String get motorDcPowerSubtitle;

  /// No description provided for @motorDcAutoBrakeLabel.
  ///
  /// In id, this message translates to:
  /// **'Auto-Brake (Lepas GAS = Turun)'**
  String get motorDcAutoBrakeLabel;

  /// No description provided for @motorDcAutoBrakeSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Coasting otomatis saat tombol GAS dilepas'**
  String get motorDcAutoBrakeSubtitle;

  /// No description provided for @motorDcStalled.
  ///
  /// In id, this message translates to:
  /// **'Torsi belum cukup (stall): PWM di bawah {pwm} belum mampu memutar rotor.'**
  String motorDcStalled(Object pwm);

  /// No description provided for @motorInputDeviceTitle.
  ///
  /// In id, this message translates to:
  /// **'PERANGKAT INPUT'**
  String get motorInputDeviceTitle;

  /// No description provided for @motorInputAnalog.
  ///
  /// In id, this message translates to:
  /// **'Analog input (ADC 0–1023)'**
  String get motorInputAnalog;

  /// No description provided for @motorInputDigital.
  ///
  /// In id, this message translates to:
  /// **'Digital input (HIGH/LOW)'**
  String get motorInputDigital;

  /// No description provided for @motorInputPotentiometer.
  ///
  /// In id, this message translates to:
  /// **'Potensiometer'**
  String get motorInputPotentiometer;

  /// No description provided for @motorInputSwitchPushButton.
  ///
  /// In id, this message translates to:
  /// **'Switch / Push Button'**
  String get motorInputSwitchPushButton;

  /// No description provided for @motorServoPresetTitle.
  ///
  /// In id, this message translates to:
  /// **'PRESET SUDUT & LANGKAH (TAHAN UNTUK REPEAT)'**
  String get motorServoPresetTitle;

  /// No description provided for @motorServoSweepLabel.
  ///
  /// In id, this message translates to:
  /// **'Mode Sweep (0° ↔ 180°)'**
  String get motorServoSweepLabel;

  /// No description provided for @motorServoSweepSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Bergerak bolak-balik otomatis seperti contoh Arduino Sweep'**
  String get motorServoSweepSubtitle;

  /// No description provided for @motorServoSweepSpeed.
  ///
  /// In id, this message translates to:
  /// **'Kecepatan Sweep:'**
  String get motorServoSweepSpeed;

  /// No description provided for @motorSpeedSlow.
  ///
  /// In id, this message translates to:
  /// **'Lambat'**
  String get motorSpeedSlow;

  /// No description provided for @motorSpeedMedium.
  ///
  /// In id, this message translates to:
  /// **'Sedang'**
  String get motorSpeedMedium;

  /// No description provided for @motorSpeedFast.
  ///
  /// In id, this message translates to:
  /// **'Cepat'**
  String get motorSpeedFast;

  /// No description provided for @stepperRotorView.
  ///
  /// In id, this message translates to:
  /// **'Rotor ({angle}°/step)'**
  String stepperRotorView(Object angle);

  /// No description provided for @stepperOutputShaft.
  ///
  /// In id, this message translates to:
  /// **'Output Shaft 1:64'**
  String get stepperOutputShaft;

  /// No description provided for @stepperModeFullStep.
  ///
  /// In id, this message translates to:
  /// **'Mode: Full-Step (4)'**
  String get stepperModeFullStep;

  /// No description provided for @stepperModeHalfStep.
  ///
  /// In id, this message translates to:
  /// **'Mode: Half-Step (8)'**
  String get stepperModeHalfStep;

  /// No description provided for @stepperHalfRev.
  ///
  /// In id, this message translates to:
  /// **'½ Putaran (180°)'**
  String get stepperHalfRev;

  /// No description provided for @stepperFullRev.
  ///
  /// In id, this message translates to:
  /// **'1 Putaran (360°)'**
  String get stepperFullRev;

  /// No description provided for @stepperResetZero.
  ///
  /// In id, this message translates to:
  /// **'Reset 0°'**
  String get stepperResetZero;

  /// No description provided for @stepperAutoRunLabel.
  ///
  /// In id, this message translates to:
  /// **'Auto-Run Stepper ({dir})'**
  String stepperAutoRunLabel(Object dir);

  /// No description provided for @stepperAutoRunSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Melangkah kontinu dengan kecepatan terpilih'**
  String get stepperAutoRunSubtitle;

  /// No description provided for @stepperDirCw.
  ///
  /// In id, this message translates to:
  /// **'CW ↻'**
  String get stepperDirCw;

  /// No description provided for @stepperDirCcw.
  ///
  /// In id, this message translates to:
  /// **'CCW ↺'**
  String get stepperDirCcw;

  /// No description provided for @telemetryTitle.
  ///
  /// In id, this message translates to:
  /// **'TELEMETRY & OSCILLOSCOPE'**
  String get telemetryTitle;

  /// No description provided for @telemetryPwmServo.
  ///
  /// In id, this message translates to:
  /// **'PWM 50 Hz (Periode 20 ms)'**
  String get telemetryPwmServo;

  /// No description provided for @telemetryPwmDc.
  ///
  /// In id, this message translates to:
  /// **'PWM ~490 Hz (Pin D5)'**
  String get telemetryPwmDc;

  /// No description provided for @telemetryStepSequence.
  ///
  /// In id, this message translates to:
  /// **'4-Coil Step Sequence (IN1–IN4)'**
  String get telemetryStepSequence;

  /// No description provided for @telemetryActualAngle.
  ///
  /// In id, this message translates to:
  /// **'Sudut Aktual'**
  String get telemetryActualAngle;

  /// No description provided for @telemetryTargetAngle.
  ///
  /// In id, this message translates to:
  /// **'Sudut Target'**
  String get telemetryTargetAngle;

  /// No description provided for @telemetryPulseWidth.
  ///
  /// In id, this message translates to:
  /// **'Lebar Pulsa'**
  String get telemetryPulseWidth;

  /// No description provided for @telemetryFrequency.
  ///
  /// In id, this message translates to:
  /// **'Frekuensi'**
  String get telemetryFrequency;

  /// No description provided for @telemetryPwm.
  ///
  /// In id, this message translates to:
  /// **'PWM'**
  String get telemetryPwm;

  /// No description provided for @telemetryDutyCycle.
  ///
  /// In id, this message translates to:
  /// **'Duty Cycle'**
  String get telemetryDutyCycle;

  /// No description provided for @telemetryRpm.
  ///
  /// In id, this message translates to:
  /// **'RPM'**
  String get telemetryRpm;

  /// No description provided for @telemetryDirection.
  ///
  /// In id, this message translates to:
  /// **'Arah'**
  String get telemetryDirection;

  /// No description provided for @telemetryDirectionCw.
  ///
  /// In id, this message translates to:
  /// **'CW (Maju)'**
  String get telemetryDirectionCw;

  /// No description provided for @telemetryDirectionCcw.
  ///
  /// In id, this message translates to:
  /// **'CCW (Mundur)'**
  String get telemetryDirectionCcw;

  /// No description provided for @telemetryDirectionStall.
  ///
  /// In id, this message translates to:
  /// **'STALL'**
  String get telemetryDirectionStall;

  /// No description provided for @telemetryDirectionStop.
  ///
  /// In id, this message translates to:
  /// **'STOP'**
  String get telemetryDirectionStop;

  /// No description provided for @telemetryStepCounter.
  ///
  /// In id, this message translates to:
  /// **'Step Counter'**
  String get telemetryStepCounter;

  /// No description provided for @telemetryStepperAngle.
  ///
  /// In id, this message translates to:
  /// **'Sudut'**
  String get telemetryStepperAngle;

  /// No description provided for @telemetryStepperCoils.
  ///
  /// In id, this message translates to:
  /// **'Kumparan ABCD'**
  String get telemetryStepperCoils;

  /// No description provided for @telemetryStepperSpeed.
  ///
  /// In id, this message translates to:
  /// **'Kecepatan'**
  String get telemetryStepperSpeed;

  /// No description provided for @potentiometerTitle.
  ///
  /// In id, this message translates to:
  /// **'Potensiometer Rotary (A0)'**
  String get potentiometerTitle;

  /// No description provided for @ohmCalcTitle.
  ///
  /// In id, this message translates to:
  /// **'Kalkulator Hukum Ohm'**
  String get ohmCalcTitle;

  /// No description provided for @ohmCalcVoltageLabel.
  ///
  /// In id, this message translates to:
  /// **'Tegangan (V)'**
  String get ohmCalcVoltageLabel;

  /// No description provided for @ohmCalcCurrentLabel.
  ///
  /// In id, this message translates to:
  /// **'Arus (I)'**
  String get ohmCalcCurrentLabel;

  /// No description provided for @ohmCalcResistanceLabel.
  ///
  /// In id, this message translates to:
  /// **'Hambatan (R)'**
  String get ohmCalcResistanceLabel;

  /// No description provided for @ohmCalcVoltageUnit.
  ///
  /// In id, this message translates to:
  /// **'Volt (V)'**
  String get ohmCalcVoltageUnit;

  /// No description provided for @ohmCalcCurrentUnit.
  ///
  /// In id, this message translates to:
  /// **'Ampere (A)'**
  String get ohmCalcCurrentUnit;

  /// No description provided for @ohmCalcResistanceUnit.
  ///
  /// In id, this message translates to:
  /// **'Ohm (Ω)'**
  String get ohmCalcResistanceUnit;

  /// No description provided for @ohmCalcAutoResult.
  ///
  /// In id, this message translates to:
  /// **'Hasil otomatis'**
  String get ohmCalcAutoResult;

  /// No description provided for @ohmCalcHintValue.
  ///
  /// In id, this message translates to:
  /// **'0'**
  String get ohmCalcHintValue;

  /// No description provided for @ohmCalcErrRZero.
  ///
  /// In id, this message translates to:
  /// **'Hambatan (R) tidak boleh 0'**
  String get ohmCalcErrRZero;

  /// No description provided for @ohmCalcErrIZero.
  ///
  /// In id, this message translates to:
  /// **'Arus (I) tidak boleh 0'**
  String get ohmCalcErrIZero;

  /// No description provided for @ohmCalcDesc.
  ///
  /// In id, this message translates to:
  /// **'Isi 2 nilai, nilai ketiga dihitung otomatis'**
  String get ohmCalcDesc;

  /// No description provided for @ohmCalcBasicFormulas.
  ///
  /// In id, this message translates to:
  /// **'Rumus Dasar'**
  String get ohmCalcBasicFormulas;

  /// No description provided for @ohmCalcResetButton.
  ///
  /// In id, this message translates to:
  /// **'Reset'**
  String get ohmCalcResetButton;

  /// No description provided for @authErrNameRequired.
  ///
  /// In id, this message translates to:
  /// **'Nama lengkap wajib diisi'**
  String get authErrNameRequired;

  /// No description provided for @authErrNameMin.
  ///
  /// In id, this message translates to:
  /// **'Nama lengkap minimal 2 karakter'**
  String get authErrNameMin;

  /// No description provided for @authErrEmailRequired.
  ///
  /// In id, this message translates to:
  /// **'Email wajib diisi'**
  String get authErrEmailRequired;

  /// No description provided for @authErrEmailInvalid.
  ///
  /// In id, this message translates to:
  /// **'Format email tidak valid'**
  String get authErrEmailInvalid;

  /// No description provided for @authErrPasswordRequired.
  ///
  /// In id, this message translates to:
  /// **'Password wajib diisi'**
  String get authErrPasswordRequired;

  /// No description provided for @authErrPasswordMin.
  ///
  /// In id, this message translates to:
  /// **'Password minimal 6 karakter'**
  String get authErrPasswordMin;

  /// No description provided for @authErrConfirmPasswordRequired.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi password wajib diisi'**
  String get authErrConfirmPasswordRequired;

  /// No description provided for @authErrConfirmPasswordMismatch.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi password tidak cocok'**
  String get authErrConfirmPasswordMismatch;

  /// No description provided for @authErrTeacherCodeRequired.
  ///
  /// In id, this message translates to:
  /// **'Kode Verifikasi wajib diisi'**
  String get authErrTeacherCodeRequired;

  /// No description provided for @authErrTeacherCodeNotFound.
  ///
  /// In id, this message translates to:
  /// **'Kode Verifikasi Guru tidak ditemukan.'**
  String get authErrTeacherCodeNotFound;

  /// No description provided for @authErrTeacherCodeInvalid.
  ///
  /// In id, this message translates to:
  /// **'Kode Verifikasi Guru tidak valid (isValid = false).'**
  String get authErrTeacherCodeInvalid;

  /// No description provided for @authErrTeacherCodePermissionDenied.
  ///
  /// In id, this message translates to:
  /// **'Gagal memeriksa kode (Akses Ditolak). Pastikan Firestore Rules sudah benar.'**
  String get authErrTeacherCodePermissionDenied;

  /// No description provided for @registerNameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama Lengkap'**
  String get registerNameLabel;

  /// No description provided for @registerNameHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan nama lengkap Anda'**
  String get registerNameHint;

  /// No description provided for @registerEmailHint.
  ///
  /// In id, this message translates to:
  /// **'nama@sekolah.sch.id'**
  String get registerEmailHint;

  /// No description provided for @registerPasswordHint.
  ///
  /// In id, this message translates to:
  /// **'Minimal 6 karakter'**
  String get registerPasswordHint;

  /// No description provided for @registerConfirmPasswordLabel.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Password'**
  String get registerConfirmPasswordLabel;

  /// No description provided for @registerConfirmPasswordHint.
  ///
  /// In id, this message translates to:
  /// **'Ulangi password Anda'**
  String get registerConfirmPasswordHint;

  /// No description provided for @registerRoleStudent.
  ///
  /// In id, this message translates to:
  /// **'Siswa'**
  String get registerRoleStudent;

  /// No description provided for @registerRoleTeacher.
  ///
  /// In id, this message translates to:
  /// **'Guru'**
  String get registerRoleTeacher;

  /// No description provided for @registerTeacherCodeLabel.
  ///
  /// In id, this message translates to:
  /// **'Kode Verifikasi Guru'**
  String get registerTeacherCodeLabel;

  /// No description provided for @registerTeacherCodeHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kode verifikasi'**
  String get registerTeacherCodeHint;

  /// No description provided for @registerTeacherCodeDescription.
  ///
  /// In id, this message translates to:
  /// **'Kode verifikasi diberikan oleh pihak Admin. Jangan bagikan kode kepada siswa.'**
  String get registerTeacherCodeDescription;

  /// No description provided for @authErrEmailAlreadyInUse.
  ///
  /// In id, this message translates to:
  /// **'Email ini sudah terdaftar. Coba masuk atau gunakan email lain.'**
  String get authErrEmailAlreadyInUse;

  /// No description provided for @authErrWeakPassword.
  ///
  /// In id, this message translates to:
  /// **'Kata sandi terlalu lemah. Gunakan minimal 8 karakter.'**
  String get authErrWeakPassword;

  /// No description provided for @authErrNetworkFailed.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada koneksi internet. Periksa jaringanmu lalu coba lagi.'**
  String get authErrNetworkFailed;

  /// No description provided for @authErrTooManyRequests.
  ///
  /// In id, this message translates to:
  /// **'Terlalu banyak percobaan. Tunggu beberapa menit lalu coba lagi.'**
  String get authErrTooManyRequests;

  /// No description provided for @authErrOperationNotAllowed.
  ///
  /// In id, this message translates to:
  /// **'Pendaftaran email sedang dinonaktifkan. Hubungi admin.'**
  String get authErrOperationNotAllowed;

  /// No description provided for @authErrSessionExpired.
  ///
  /// In id, this message translates to:
  /// **'Sesi kamu berakhir. Silakan masuk kembali.'**
  String get authErrSessionExpired;

  /// No description provided for @authErrInvalidCredentials.
  ///
  /// In id, this message translates to:
  /// **'Email atau password salah.'**
  String get authErrInvalidCredentials;

  /// No description provided for @authErrServerBusy.
  ///
  /// In id, this message translates to:
  /// **'Server sedang sibuk atau koneksi terputus. Coba lagi sebentar.'**
  String get authErrServerBusy;

  /// No description provided for @authErrPermissionDenied.
  ///
  /// In id, this message translates to:
  /// **'Kamu tidak punya izin untuk tindakan ini.'**
  String get authErrPermissionDenied;

  /// No description provided for @authErrUnknown.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan. Silakan coba lagi.'**
  String get authErrUnknown;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In id, this message translates to:
  /// **'Lemah'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthMedium.
  ///
  /// In id, this message translates to:
  /// **'Sedang'**
  String get passwordStrengthMedium;

  /// No description provided for @passwordStrengthStrong.
  ///
  /// In id, this message translates to:
  /// **'Kuat'**
  String get passwordStrengthStrong;

  /// No description provided for @resistorCalcSheetTitle.
  ///
  /// In id, this message translates to:
  /// **'Alat Bantu Cepat'**
  String get resistorCalcSheetTitle;

  /// No description provided for @resistorCalcCloseTooltip.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get resistorCalcCloseTooltip;

  /// No description provided for @authLoadingPreparing.
  ///
  /// In id, this message translates to:
  /// **'Menyiapkan akunmu...'**
  String get authLoadingPreparing;

  /// No description provided for @authLoadingWaitMessage.
  ///
  /// In id, this message translates to:
  /// **'Mohon tunggu sebentar, sedang memuat data peran akun.'**
  String get authLoadingWaitMessage;

  /// No description provided for @authLoadingFailedTitle.
  ///
  /// In id, this message translates to:
  /// **'Gagal Menyiapkan Akun'**
  String get authLoadingFailedTitle;

  /// No description provided for @authLoadingFailedMessage.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kendala saat memuat peran akun. Periksa koneksi internet Anda.'**
  String get authLoadingFailedMessage;

  /// No description provided for @authLoadingRetrying.
  ///
  /// In id, this message translates to:
  /// **'Mencoba...'**
  String get authLoadingRetrying;

  /// No description provided for @authLoadingRetry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get authLoadingRetry;

  /// No description provided for @authLoadingLoggingOut.
  ///
  /// In id, this message translates to:
  /// **'Keluar...'**
  String get authLoadingLoggingOut;

  /// No description provided for @authLoadingLogout.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get authLoadingLogout;

  /// No description provided for @verificationPendingHeader.
  ///
  /// In id, this message translates to:
  /// **'Cek Email Kamu!'**
  String get verificationPendingHeader;

  /// No description provided for @verificationPendingSpamHint.
  ///
  /// In id, this message translates to:
  /// **'Tidak ketemu? Cek folder Spam atau Promosi.'**
  String get verificationPendingSpamHint;

  /// No description provided for @verificationPendingResending.
  ///
  /// In id, this message translates to:
  /// **'Mengirim...'**
  String get verificationPendingResending;

  /// No description provided for @verificationPendingCheckButton.
  ///
  /// In id, this message translates to:
  /// **'Saya sudah verifikasi'**
  String get verificationPendingCheckButton;

  /// No description provided for @verificationPendingLoggingOut.
  ///
  /// In id, this message translates to:
  /// **'Keluar...'**
  String get verificationPendingLoggingOut;

  /// No description provided for @verificationPendingBackToLogin.
  ///
  /// In id, this message translates to:
  /// **'Kembali ke Login'**
  String get verificationPendingBackToLogin;

  /// No description provided for @verificationPendingErrorDefault.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kendala saat memuat peran akun. Periksa koneksi internet Anda.'**
  String get verificationPendingErrorDefault;

  /// No description provided for @verificationPendingResent.
  ///
  /// In id, this message translates to:
  /// **'Email verifikasi telah dikirim ulang.'**
  String get verificationPendingResent;

  /// No description provided for @verificationPendingNotVerified.
  ///
  /// In id, this message translates to:
  /// **'Email kamu belum terverifikasi. Silakan klik link di email.'**
  String get verificationPendingNotVerified;

  /// No description provided for @verificationPendingDescEmailPrefix.
  ///
  /// In id, this message translates to:
  /// **'Kami telah mengirim link verifikasi ke: '**
  String get verificationPendingDescEmailPrefix;

  /// No description provided for @verificationPendingDescEmailSuffix.
  ///
  /// In id, this message translates to:
  /// **'. Silakan buka email dan klik link tersebut untuk mengaktifkan akun.'**
  String get verificationPendingDescEmailSuffix;

  /// No description provided for @verificationPendingDescGeneric.
  ///
  /// In id, this message translates to:
  /// **'Kami telah mengirim link verifikasi ke email kamu. Silakan buka email dan klik link tersebut untuk mengaktifkan akun.'**
  String get verificationPendingDescGeneric;

  /// No description provided for @verificationPendingResendCooldown.
  ///
  /// In id, this message translates to:
  /// **'Kirim Ulang ({seconds}s)'**
  String verificationPendingResendCooldown(Object seconds);

  /// No description provided for @verificationPendingResendLabel.
  ///
  /// In id, this message translates to:
  /// **'Kirim Ulang Email Verifikasi'**
  String get verificationPendingResendLabel;

  /// No description provided for @verificationPendingResendingEn.
  ///
  /// In id, this message translates to:
  /// **'Mengirim...'**
  String get verificationPendingResendingEn;

  /// No description provided for @gameCableConnectTooltipBack.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get gameCableConnectTooltipBack;

  /// No description provided for @gameCableConnectTooltipRedo.
  ///
  /// In id, this message translates to:
  /// **'Ulang Jalur'**
  String get gameCableConnectTooltipRedo;

  /// No description provided for @gameCableConnectCircuitClosed.
  ///
  /// In id, this message translates to:
  /// **'Rangkaian Tertutup'**
  String get gameCableConnectCircuitClosed;

  /// No description provided for @gameCableConnectExit.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get gameCableConnectExit;

  /// No description provided for @gameCableConnectTimeUp.
  ///
  /// In id, this message translates to:
  /// **'Waktu Habis'**
  String get gameCableConnectTimeUp;

  /// No description provided for @gameCableConnectTryAgain.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get gameCableConnectTryAgain;

  /// No description provided for @gameCableConnectNextLevel.
  ///
  /// In id, this message translates to:
  /// **'Level Berikutnya (+10s)'**
  String get gameCableConnectNextLevel;

  /// No description provided for @gameCableConnectFeedback.
  ///
  /// In id, this message translates to:
  /// **'Tarik kawat dari (+) melewati semua komponen ke (-).'**
  String get gameCableConnectFeedback;

  /// No description provided for @gameCableConnectChipCurrent.
  ///
  /// In id, this message translates to:
  /// **'Arus Mengalir!'**
  String get gameCableConnectChipCurrent;

  /// No description provided for @gameCircuitRushTooltipBack.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get gameCircuitRushTooltipBack;

  /// No description provided for @gameCircuitRushTooltipResume.
  ///
  /// In id, this message translates to:
  /// **'Lanjut'**
  String get gameCircuitRushTooltipResume;

  /// No description provided for @gameCircuitRushTooltipPause.
  ///
  /// In id, this message translates to:
  /// **'Jeda'**
  String get gameCircuitRushTooltipPause;

  /// No description provided for @gameCircuitRushTitle.
  ///
  /// In id, this message translates to:
  /// **'Sirkuit Kilat'**
  String get gameCircuitRushTitle;

  /// No description provided for @gameCircuitRushStart.
  ///
  /// In id, this message translates to:
  /// **'Mulai Main'**
  String get gameCircuitRushStart;

  /// No description provided for @gameCircuitRushPaused.
  ///
  /// In id, this message translates to:
  /// **'Permainan Dijeda'**
  String get gameCircuitRushPaused;

  /// No description provided for @gameCircuitRushResumeBtn.
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan'**
  String get gameCircuitRushResumeBtn;

  /// No description provided for @gameCircuitRushRestartBtn.
  ///
  /// In id, this message translates to:
  /// **'Ulangi'**
  String get gameCircuitRushRestartBtn;

  /// No description provided for @gameCircuitRushExitBtn.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get gameCircuitRushExitBtn;

  /// No description provided for @gameCircuitRushShortCircuit.
  ///
  /// In id, this message translates to:
  /// **'Arus Terputus'**
  String get gameCircuitRushShortCircuit;

  /// No description provided for @gameCircuitRushGameOverRetry.
  ///
  /// In id, this message translates to:
  /// **'Main Lagi'**
  String get gameCircuitRushGameOverRetry;

  /// No description provided for @gameGuessLevel.
  ///
  /// In id, this message translates to:
  /// **'Level {level}'**
  String gameGuessLevel(Object level);

  /// No description provided for @gameCircuitRushChipShort.
  ///
  /// In id, this message translates to:
  /// **'Korsleting!'**
  String get gameCircuitRushChipShort;

  /// No description provided for @gameCircuitRushReadyDesc.
  ///
  /// In id, this message translates to:
  /// **'Ketuk layar untuk melompat melewati celah resistor dan kumpulkan koin voltase!'**
  String get gameCircuitRushReadyDesc;

  /// No description provided for @simulasiTitle.
  ///
  /// In id, this message translates to:
  /// **'Simulasi'**
  String get simulasiTitle;

  /// No description provided for @simulasiNewProject.
  ///
  /// In id, this message translates to:
  /// **'Buka Project Baru'**
  String get simulasiNewProject;

  /// No description provided for @simulasiExistingProjects.
  ///
  /// In id, this message translates to:
  /// **'Project yang sudah ada'**
  String get simulasiExistingProjects;

  /// No description provided for @simulasiLedBlinkerTitle.
  ///
  /// In id, this message translates to:
  /// **'LED Blinker'**
  String get simulasiLedBlinkerTitle;

  /// No description provided for @simulasiLedBlinkerDesc.
  ///
  /// In id, this message translates to:
  /// **'Simulasi kedip LED dasar Arduino'**
  String get simulasiLedBlinkerDesc;

  /// No description provided for @simulasiTooltipBack.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get simulasiTooltipBack;

  /// No description provided for @simulasiDebugAvrTitle.
  ///
  /// In id, this message translates to:
  /// **'Debug AVR'**
  String get simulasiDebugAvrTitle;

  /// No description provided for @simulasiSimMachine.
  ///
  /// In id, this message translates to:
  /// **'Mesin simulasi'**
  String get simulasiSimMachine;

  /// No description provided for @simulasiModeIsolate.
  ///
  /// In id, this message translates to:
  /// **'Isolate'**
  String get simulasiModeIsolate;

  /// No description provided for @simulasiModeTimer.
  ///
  /// In id, this message translates to:
  /// **'Timer'**
  String get simulasiModeTimer;

  /// No description provided for @simulasiStopped.
  ///
  /// In id, this message translates to:
  /// **'Berhenti'**
  String get simulasiStopped;

  /// No description provided for @simulasiBtnStart.
  ///
  /// In id, this message translates to:
  /// **'Start'**
  String get simulasiBtnStart;

  /// No description provided for @simulasiBtnStop.
  ///
  /// In id, this message translates to:
  /// **'Stop'**
  String get simulasiBtnStop;

  /// No description provided for @simulasiBlinkCircuit.
  ///
  /// In id, this message translates to:
  /// **'Rangkaian Blink'**
  String get simulasiBlinkCircuit;

  /// No description provided for @simulasiLedOn.
  ///
  /// In id, this message translates to:
  /// **'menyala'**
  String get simulasiLedOn;

  /// No description provided for @simulasiLedOff.
  ///
  /// In id, this message translates to:
  /// **'mati'**
  String get simulasiLedOff;

  /// No description provided for @simulasiEditorDefaultName.
  ///
  /// In id, this message translates to:
  /// **'Simulator Velxio'**
  String get simulasiEditorDefaultName;

  /// No description provided for @simulasiBtnReload.
  ///
  /// In id, this message translates to:
  /// **'Muat Ulang'**
  String get simulasiBtnReload;

  /// No description provided for @simulasiConnDisconnected.
  ///
  /// In id, this message translates to:
  /// **'Koneksi Terputus'**
  String get simulasiConnDisconnected;

  /// No description provided for @simulasiBtnRetry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get simulasiBtnRetry;

  /// No description provided for @simulasiSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Rancang dan uji sirkuit virtual langsung di browser.'**
  String get simulasiSubtitle;

  /// No description provided for @simulasiTrafficLightTitle.
  ///
  /// In id, this message translates to:
  /// **'4-Way Traffic Light'**
  String get simulasiTrafficLightTitle;

  /// No description provided for @simulasiTrafficLightDesc.
  ///
  /// In id, this message translates to:
  /// **'Simulasi lampu lalu lintas 4 arah'**
  String get simulasiTrafficLightDesc;

  /// No description provided for @simulasiCanvas2dTitle.
  ///
  /// In id, this message translates to:
  /// **'Canvas 2D'**
  String get simulasiCanvas2dTitle;

  /// No description provided for @kelasJoinSuccess.
  ///
  /// In id, this message translates to:
  /// **'Berhasil bergabung ke kelas!'**
  String get kelasJoinSuccess;

  /// No description provided for @kelasNoClassYet.
  ///
  /// In id, this message translates to:
  /// **'Belum Punya Kelas?'**
  String get kelasNoClassYet;

  /// No description provided for @kelasTabForum.
  ///
  /// In id, this message translates to:
  /// **'Forum'**
  String get kelasTabForum;

  /// No description provided for @kelasTabTugas.
  ///
  /// In id, this message translates to:
  /// **'Tugas'**
  String get kelasTabTugas;

  /// No description provided for @kelasTabOrang.
  ///
  /// In id, this message translates to:
  /// **'Orang'**
  String get kelasTabOrang;

  /// No description provided for @postDetailTaskMarkedComplete.
  ///
  /// In id, this message translates to:
  /// **'Tugas ditandai selesai'**
  String get postDetailTaskMarkedComplete;

  /// No description provided for @postDetailSubmissionCancelled.
  ///
  /// In id, this message translates to:
  /// **'Penyaluran dibatalkan'**
  String get postDetailSubmissionCancelled;

  /// No description provided for @postDetailDeleteTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus {type}?'**
  String postDetailDeleteTitle(Object type);

  /// No description provided for @postDetailDeleteConfirm.
  ///
  /// In id, this message translates to:
  /// **'Tindakan ini tidak dapat dibatalkan.'**
  String get postDetailDeleteConfirm;

  /// No description provided for @postDetailCancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get postDetailCancel;

  /// No description provided for @postDetailDelete.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get postDetailDelete;

  /// No description provided for @postDetailDeleted.
  ///
  /// In id, this message translates to:
  /// **'Berhasil dihapus'**
  String get postDetailDeleted;

  /// No description provided for @postDetailEditComingSoon.
  ///
  /// In id, this message translates to:
  /// **'Edit postingan segera hadir'**
  String get postDetailEditComingSoon;

  /// No description provided for @postDetailUser.
  ///
  /// In id, this message translates to:
  /// **'Pengguna'**
  String get postDetailUser;

  /// No description provided for @postDetailEdited.
  ///
  /// In id, this message translates to:
  /// **'diedit'**
  String get postDetailEdited;

  /// No description provided for @postDetailNoDeadline.
  ///
  /// In id, this message translates to:
  /// **'Tanpa deadline'**
  String get postDetailNoDeadline;

  /// No description provided for @postDetailDeadline.
  ///
  /// In id, this message translates to:
  /// **'Deadline: {date}'**
  String postDetailDeadline(Object date);

  /// No description provided for @postDetailOverdue.
  ///
  /// In id, this message translates to:
  /// **'Lewat deadline'**
  String get postDetailOverdue;

  /// No description provided for @postDetailComments.
  ///
  /// In id, this message translates to:
  /// **'Komentar ({count})'**
  String postDetailComments(Object count);

  /// No description provided for @postDetailNoComments.
  ///
  /// In id, this message translates to:
  /// **'Belum ada komentar. Jadilah yang pertama!'**
  String get postDetailNoComments;

  /// No description provided for @postDetailCommentsDisabled.
  ///
  /// In id, this message translates to:
  /// **'Komentar dinonaktifkan oleh guru.'**
  String get postDetailCommentsDisabled;

  /// No description provided for @postDetailCommentHint.
  ///
  /// In id, this message translates to:
  /// **'Tulis komentar...'**
  String get postDetailCommentHint;

  /// No description provided for @postDetailSend.
  ///
  /// In id, this message translates to:
  /// **'Kirim'**
  String get postDetailSend;

  /// No description provided for @postDetailViewCompleted.
  ///
  /// In id, this message translates to:
  /// **'Lihat Siswa yang Selesai'**
  String get postDetailViewCompleted;

  /// No description provided for @postDetailCompleted.
  ///
  /// In id, this message translates to:
  /// **'✓ Selesai'**
  String get postDetailCompleted;

  /// No description provided for @postDetailCancelSubmission.
  ///
  /// In id, this message translates to:
  /// **'Batalkan'**
  String get postDetailCancelSubmission;

  /// No description provided for @postDetailSubmittedLate.
  ///
  /// In id, this message translates to:
  /// **'Dikumpulkan setelah deadline'**
  String get postDetailSubmittedLate;

  /// No description provided for @postDetailSubmitLate.
  ///
  /// In id, this message translates to:
  /// **'Kumpulkan (Terlambat)'**
  String get postDetailSubmitLate;

  /// No description provided for @postDetailMarkComplete.
  ///
  /// In id, this message translates to:
  /// **'Tandai Selesai'**
  String get postDetailMarkComplete;

  /// No description provided for @postDetailUploadFile.
  ///
  /// In id, this message translates to:
  /// **'Upload File'**
  String get postDetailUploadFile;

  /// No description provided for @postDetailUploadComingSoon.
  ///
  /// In id, this message translates to:
  /// **'Fitur upload segera hadir'**
  String get postDetailUploadComingSoon;

  /// No description provided for @postDetailDetailTask.
  ///
  /// In id, this message translates to:
  /// **'Detail Tugas'**
  String get postDetailDetailTask;

  /// No description provided for @postDetailDetailAnnouncement.
  ///
  /// In id, this message translates to:
  /// **'Detail Pengumuman'**
  String get postDetailDetailAnnouncement;

  /// No description provided for @postDetailEditMenu.
  ///
  /// In id, this message translates to:
  /// **'Edit'**
  String get postDetailEditMenu;

  /// No description provided for @postDetailDeleteMenu.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get postDetailDeleteMenu;

  /// No description provided for @postDetailFailedLoadComments.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat komentar'**
  String get postDetailFailedLoadComments;

  /// No description provided for @postDetailFailedLoad.
  ///
  /// In id, this message translates to:
  /// **'Gagal Memuat'**
  String get postDetailFailedLoad;

  /// No description provided for @postDetailRetry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get postDetailRetry;

  /// No description provided for @postDetailNotFound.
  ///
  /// In id, this message translates to:
  /// **'Postingan Tidak Ditemukan'**
  String get postDetailNotFound;

  /// No description provided for @postDetailNotFoundMsg.
  ///
  /// In id, this message translates to:
  /// **'Postingan tidak ditemukan atau sudah dihapus.'**
  String get postDetailNotFoundMsg;

  /// No description provided for @postDetailBack.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get postDetailBack;

  /// No description provided for @postDetailStudentsCompleted.
  ///
  /// In id, this message translates to:
  /// **'Siswa yang Selesai'**
  String get postDetailStudentsCompleted;

  /// No description provided for @postDetailNoStudentsCompleted.
  ///
  /// In id, this message translates to:
  /// **'Belum ada siswa yang menyelesaikan tugas ini.'**
  String get postDetailNoStudentsCompleted;

  /// No description provided for @postDetailCompletedAt.
  ///
  /// In id, this message translates to:
  /// **'Selesai: {date}'**
  String postDetailCompletedAt(Object date);

  /// No description provided for @postDetailClose.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get postDetailClose;

  /// No description provided for @postDetailYou.
  ///
  /// In id, this message translates to:
  /// **'Anda'**
  String get postDetailYou;

  /// No description provided for @postDetailDeleteComment.
  ///
  /// In id, this message translates to:
  /// **'Hapus Komentar?'**
  String get postDetailDeleteComment;

  /// No description provided for @postDetailFailedSendComment.
  ///
  /// In id, this message translates to:
  /// **'Gagal mengirim komentar: {error}'**
  String postDetailFailedSendComment(Object error);

  /// No description provided for @postDetailFailedUpdateStatus.
  ///
  /// In id, this message translates to:
  /// **'Gagal memperbarui status: {error}'**
  String postDetailFailedUpdateStatus(Object error);

  /// No description provided for @postDetailFailedDelete.
  ///
  /// In id, this message translates to:
  /// **'Gagal menghapus: {error}'**
  String postDetailFailedDelete(Object error);

  /// No description provided for @createPostAnnouncementPosted.
  ///
  /// In id, this message translates to:
  /// **'Pengumuman berhasil diposting'**
  String get createPostAnnouncementPosted;

  /// No description provided for @createPostCreateAssignment.
  ///
  /// In id, this message translates to:
  /// **'Buat Tugas Baru'**
  String get createPostCreateAssignment;

  /// No description provided for @createPostAssignmentDescription.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi Tugas'**
  String get createPostAssignmentDescription;

  /// No description provided for @editPostEditAssignment.
  ///
  /// In id, this message translates to:
  /// **'Edit Tugas'**
  String get editPostEditAssignment;

  /// No description provided for @editPostEditAnnouncement.
  ///
  /// In id, this message translates to:
  /// **'Edit Pengumuman'**
  String get editPostEditAnnouncement;

  /// No description provided for @editPostTitle.
  ///
  /// In id, this message translates to:
  /// **'Judul'**
  String get editPostTitle;

  /// No description provided for @editPostAssignmentTitle.
  ///
  /// In id, this message translates to:
  /// **'Judul Tugas'**
  String get editPostAssignmentTitle;

  /// No description provided for @editPostTitleOptional.
  ///
  /// In id, this message translates to:
  /// **'Judul (Opsional)'**
  String get editPostTitleOptional;

  /// No description provided for @editPostDeadline.
  ///
  /// In id, this message translates to:
  /// **'Deadline'**
  String get editPostDeadline;

  /// No description provided for @editPostSelectDeadline.
  ///
  /// In id, this message translates to:
  /// **'Pilih deadline'**
  String get editPostSelectDeadline;

  /// No description provided for @editPostAllowComments.
  ///
  /// In id, this message translates to:
  /// **'Izinkan komentar'**
  String get editPostAllowComments;

  /// No description provided for @editPostCancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get editPostCancel;

  /// No description provided for @editPostSaving.
  ///
  /// In id, this message translates to:
  /// **'Menyimpan...'**
  String get editPostSaving;

  /// No description provided for @editPostSave.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get editPostSave;

  /// No description provided for @editPostContentEmpty.
  ///
  /// In id, this message translates to:
  /// **'Isi tidak boleh kosong'**
  String get editPostContentEmpty;

  /// No description provided for @editPostUpdated.
  ///
  /// In id, this message translates to:
  /// **'Berhasil diperbarui'**
  String get editPostUpdated;

  /// No description provided for @guruKelasCardSiswa.
  ///
  /// In id, this message translates to:
  /// **'{count} siswa'**
  String guruKelasCardSiswa(Object count);

  /// No description provided for @profilStatClasses.
  ///
  /// In id, this message translates to:
  /// **'Kelas'**
  String get profilStatClasses;

  /// No description provided for @profilStatStudents.
  ///
  /// In id, this message translates to:
  /// **'Siswa'**
  String get profilStatStudents;

  /// No description provided for @profilStatAssignments.
  ///
  /// In id, this message translates to:
  /// **'Tugas'**
  String get profilStatAssignments;

  /// No description provided for @profilMenuEditProfil.
  ///
  /// In id, this message translates to:
  /// **'Edit Profil'**
  String get profilMenuEditProfil;

  /// No description provided for @profilMenuEditProfilSub.
  ///
  /// In id, this message translates to:
  /// **'Ubah nama, foto, dan informasi akun'**
  String get profilMenuEditProfilSub;

  /// No description provided for @profilMenuNotifikasi.
  ///
  /// In id, this message translates to:
  /// **'Notifikasi'**
  String get profilMenuNotifikasi;

  /// No description provided for @profilMenuNotifikasiSub.
  ///
  /// In id, this message translates to:
  /// **'Kelola preferensi notifikasi'**
  String get profilMenuNotifikasiSub;

  /// No description provided for @profilMenuBantuan.
  ///
  /// In id, this message translates to:
  /// **'Bantuan & Dukungan'**
  String get profilMenuBantuan;

  /// No description provided for @profilMenuBantuanSub.
  ///
  /// In id, this message translates to:
  /// **'FAQ, panduan, dan hubungi kami'**
  String get profilMenuBantuanSub;

  /// No description provided for @profilMenuKeamanan.
  ///
  /// In id, this message translates to:
  /// **'Keamanan'**
  String get profilMenuKeamanan;

  /// No description provided for @profilMenuKeamananSub.
  ///
  /// In id, this message translates to:
  /// **'Ubah kata sandi dan keamanan akun'**
  String get profilMenuKeamananSub;

  /// No description provided for @profilMenuBahasa.
  ///
  /// In id, this message translates to:
  /// **'Bahasa / Language'**
  String get profilMenuBahasa;

  /// No description provided for @profilMenuBahasaSub.
  ///
  /// In id, this message translates to:
  /// **'Ganti bahasa aplikasi'**
  String get profilMenuBahasaSub;

  /// No description provided for @profilComingSoon.
  ///
  /// In id, this message translates to:
  /// **'Fitur segera hadir'**
  String get profilComingSoon;

  /// No description provided for @profilLogout.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get profilLogout;

  /// No description provided for @profilLogoutConfirmTitle.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Keluar'**
  String get profilLogoutConfirmTitle;

  /// No description provided for @profilLogoutConfirmMsg.
  ///
  /// In id, this message translates to:
  /// **'Apakah kamu yakin ingin keluar?'**
  String get profilLogoutConfirmMsg;

  /// No description provided for @profilCancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get profilCancel;

  /// No description provided for @profilLogoutYes.
  ///
  /// In id, this message translates to:
  /// **'Ya, Keluar'**
  String get profilLogoutYes;

  /// No description provided for @profilLogoutFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal keluar dari akun. Silakan coba lagi.'**
  String get profilLogoutFailed;

  /// No description provided for @profilLoadFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat profil'**
  String get profilLoadFailed;

  /// No description provided for @profilLoadFailedMsg.
  ///
  /// In id, this message translates to:
  /// **'Periksa koneksi internet Anda'**
  String get profilLoadFailedMsg;

  /// No description provided for @profilFallbackName.
  ///
  /// In id, this message translates to:
  /// **'Guru'**
  String get profilFallbackName;

  /// No description provided for @profilFallbackRoleLabel.
  ///
  /// In id, this message translates to:
  /// **'Guru'**
  String get profilFallbackRoleLabel;

  /// No description provided for @profilNIPUnavailable.
  ///
  /// In id, this message translates to:
  /// **'NIP tidak tersedia'**
  String get profilNIPUnavailable;

  /// No description provided for @profilLanguageDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Pilih Bahasa'**
  String get profilLanguageDialogTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
