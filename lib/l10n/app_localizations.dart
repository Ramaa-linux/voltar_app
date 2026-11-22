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
  /// **'Â© 2024 EduVolt. All rights reserved.'**
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
  /// **'Belajar listrik jadi seru âš¡'**
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
  /// **'Semua Tugas Selesai! ðŸŽ‰'**
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
  /// **'â€¢ 4 Gelang: Digit 1, Digit 2, Pengali, Toleransi\\nâ€¢ 5 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi\\nâ€¢ 6 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi, Koef. Suhu\\n\\nContoh 220 Î© Â±5%: Merah (2) - Merah (2) - Cokelat (Ã—10) - Emas (Â±5%)'**
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
  /// **'Hambatan: {r} Î©'**
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
  /// **'Suhu: {t} Â°C'**
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
  /// **'Toleransi: Â±{t}%'**
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
  /// **'Mengukur suhu & kelembapan udara. Jika suhu > 30Â°C, kipas pendingin menyala.'**
  String get sensorDht11Desc;

  /// No description provided for @sensorDht11Panel.
  ///
  /// In id, this message translates to:
  /// **'Suhu (20Â°C - 40Â°C) & Kelembapan (0% - 100%)'**
  String get sensorDht11Panel;

  /// No description provided for @sensorDht11Status.
  ///
  /// In id, this message translates to:
  /// **'Suhu: {t}Â°C | Kelembapan: {h}%'**
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
  /// **'A0 â†’ Output'**
  String get motorInputA0;

  /// No description provided for @motorInputD2D3.
  ///
  /// In id, this message translates to:
  /// **'D2/D3 â†’ Output'**
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
  /// **'GAS â–² (Tahan)'**
  String get motorDcGas;

  /// No description provided for @motorDcBrake.
  ///
  /// In id, this message translates to:
  /// **'REM â–¼ (Tahan)'**
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
  /// **'Analog input (ADC 0â€“1023)'**
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
  /// **'Mode Sweep (0Â° â†” 180Â°)'**
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
  /// **'Rotor ({angle}Â°/step)'**
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
  /// **'Â½ Putaran (180Â°)'**
  String get stepperHalfRev;

  /// No description provided for @stepperFullRev.
  ///
  /// In id, this message translates to:
  /// **'1 Putaran (360Â°)'**
  String get stepperFullRev;

  /// No description provided for @stepperResetZero.
  ///
  /// In id, this message translates to:
  /// **'Reset 0Â°'**
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
  /// **'CW â†»'**
  String get stepperDirCw;

  /// No description provided for @stepperDirCcw.
  ///
  /// In id, this message translates to:
  /// **'CCW â†º'**
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
  /// **'4-Coil Step Sequence (IN1â€“IN4)'**
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
  /// **'Ohm (Î©)'**
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
  /// **'âœ“ Selesai'**
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

  /// No description provided for @homeProgressCaption.
  ///
  /// In id, this message translates to:
  /// **'{completed} dari {total} materi selesai'**
  String homeProgressCaption(Object completed, Object total);

  /// No description provided for @homeCoinsCount.
  ///
  /// In id, this message translates to:
  /// **'{coins} Koin'**
  String homeCoinsCount(Object coins);

  /// No description provided for @homeProgressSemantics.
  ///
  /// In id, this message translates to:
  /// **'Progres belajar {percent} persen, {completed} dari {total} materi selesai'**
  String homeProgressSemantics(Object completed, Object percent, Object total);

  /// No description provided for @homeAllCompleted.
  ///
  /// In id, this message translates to:
  /// **'Semua materi selesai ðŸŽ‰'**
  String get homeAllCompleted;

  /// No description provided for @homeSubtitleDone.
  ///
  /// In id, this message translates to:
  /// **'Level {level} â€¢ Semua modul tuntas'**
  String homeSubtitleDone(Object level);

  /// No description provided for @homeSubtitleStart.
  ///
  /// In id, this message translates to:
  /// **'Level {level} â€¢ Mulai Belajar'**
  String homeSubtitleStart(Object level);

  /// No description provided for @homeSubtitleProgress.
  ///
  /// In id, this message translates to:
  /// **'Level {level} â€¢ {completed} dari {total} materi'**
  String homeSubtitleProgress(Object completed, Object level, Object total);

  /// No description provided for @homeSubtitleNext.
  ///
  /// In id, this message translates to:
  /// **'Level {level} â€¢ Materi berikutnya'**
  String homeSubtitleNext(Object level);

  /// No description provided for @materiGagalMemuatLevel.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat level: {error}'**
  String materiGagalMemuatLevel(Object error);

  /// No description provided for @homeLevelLocked.
  ///
  /// In id, this message translates to:
  /// **'Level {level}, terkunci'**
  String homeLevelLocked(Object level);

  /// No description provided for @materiLevelHeader.
  ///
  /// In id, this message translates to:
  /// **'LEVEL {level}'**
  String materiLevelHeader(Object level);

  /// No description provided for @materiChipBelajar.
  ///
  /// In id, this message translates to:
  /// **'Sedang Belajar'**
  String get materiChipBelajar;

  /// No description provided for @materiChipLocked.
  ///
  /// In id, this message translates to:
  /// **'Terkunci'**
  String get materiChipLocked;

  /// No description provided for @materiGambarTidakDitemukan.
  ///
  /// In id, this message translates to:
  /// **'Gambar tidak ditemukan'**
  String get materiGambarTidakDitemukan;

  /// No description provided for @materiTabBacaan.
  ///
  /// In id, this message translates to:
  /// **'Bacaan'**
  String get materiTabBacaan;

  /// No description provided for @materiTabVideo.
  ///
  /// In id, this message translates to:
  /// **'Video'**
  String get materiTabVideo;

  /// No description provided for @materiTabPraktik.
  ///
  /// In id, this message translates to:
  /// **'Praktik'**
  String get materiTabPraktik;

  /// No description provided for @levelCaption.
  ///
  /// In id, this message translates to:
  /// **'{totalMateri} materi â€¢ {totalMinutes} menit'**
  String levelCaption(Object totalMateri, Object totalMinutes);

  /// No description provided for @levelCaptionEmpty.
  ///
  /// In id, this message translates to:
  /// **'Belum ada materi'**
  String get levelCaptionEmpty;

  /// No description provided for @estimatedTimeShort.
  ///
  /// In id, this message translates to:
  /// **'{value} menit'**
  String estimatedTimeShort(Object value);

  /// No description provided for @estimatedTimeMedium.
  ///
  /// In id, this message translates to:
  /// **'{value} menit'**
  String estimatedTimeMedium(Object value);

  /// No description provided for @estimatedTimeLong.
  ///
  /// In id, this message translates to:
  /// **'{value} menit'**
  String estimatedTimeLong(Object value);

  /// No description provided for @dayMinggu.
  ///
  /// In id, this message translates to:
  /// **'Minggu'**
  String get dayMinggu;

  /// No description provided for @daySenin.
  ///
  /// In id, this message translates to:
  /// **'Senin'**
  String get daySenin;

  /// No description provided for @daySelasa.
  ///
  /// In id, this message translates to:
  /// **'Selasa'**
  String get daySelasa;

  /// No description provided for @dayRabu.
  ///
  /// In id, this message translates to:
  /// **'Rabu'**
  String get dayRabu;

  /// No description provided for @dayKamis.
  ///
  /// In id, this message translates to:
  /// **'Kamis'**
  String get dayKamis;

  /// No description provided for @dayJumat.
  ///
  /// In id, this message translates to:
  /// **'Jumat'**
  String get dayJumat;

  /// No description provided for @daySabtu.
  ///
  /// In id, this message translates to:
  /// **'Sabtu'**
  String get daySabtu;

  /// No description provided for @monthJan.
  ///
  /// In id, this message translates to:
  /// **'Januari'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In id, this message translates to:
  /// **'Februari'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In id, this message translates to:
  /// **'Maret'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In id, this message translates to:
  /// **'April'**
  String get monthApr;

  /// No description provided for @monthMei.
  ///
  /// In id, this message translates to:
  /// **'Mei'**
  String get monthMei;

  /// No description provided for @monthJun.
  ///
  /// In id, this message translates to:
  /// **'Juni'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In id, this message translates to:
  /// **'Juli'**
  String get monthJul;

  /// No description provided for @monthAgu.
  ///
  /// In id, this message translates to:
  /// **'Agustus'**
  String get monthAgu;

  /// No description provided for @monthSep.
  ///
  /// In id, this message translates to:
  /// **'September'**
  String get monthSep;

  /// No description provided for @monthOkt.
  ///
  /// In id, this message translates to:
  /// **'Oktober'**
  String get monthOkt;

  /// No description provided for @monthNov.
  ///
  /// In id, this message translates to:
  /// **'November'**
  String get monthNov;

  /// No description provided for @monthDes.
  ///
  /// In id, this message translates to:
  /// **'Desember'**
  String get monthDes;

  /// No description provided for @materiKomponenL1KomBreadboardEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiKomponenL1KomBreadboardEstimatedTime;

  /// No description provided for @materiKomponenL1KomBreadboardTitle.
  ///
  /// In id, this message translates to:
  /// **'Breadboard'**
  String get materiKomponenL1KomBreadboardTitle;

  /// No description provided for @materiKomponenL1KomHukumOhmEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiKomponenL1KomHukumOhmEstimatedTime;

  /// No description provided for @materiKomponenL1KomHukumOhmTitle.
  ///
  /// In id, this message translates to:
  /// **'Hukum Ohm'**
  String get materiKomponenL1KomHukumOhmTitle;

  /// No description provided for @materiKomponenL1KomKapasitorEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiKomponenL1KomKapasitorEstimatedTime;

  /// No description provided for @materiKomponenL1KomKapasitorTitle.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor'**
  String get materiKomponenL1KomKapasitorTitle;

  /// No description provided for @materiKomponenL1KomLedEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiKomponenL1KomLedEstimatedTime;

  /// No description provided for @materiKomponenL1KomLedTitle.
  ///
  /// In id, this message translates to:
  /// **'LED (Light Emitting Diode)'**
  String get materiKomponenL1KomLedTitle;

  /// No description provided for @materiKomponenL1KomResistorEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiKomponenL1KomResistorEstimatedTime;

  /// No description provided for @materiKomponenL1KomTactileSwitchEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiKomponenL1KomTactileSwitchEstimatedTime;

  /// No description provided for @materiL1L1KomBreadboardEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiL1L1KomBreadboardEstimatedTime;

  /// No description provided for @materiL1L1KomBreadboardTitle.
  ///
  /// In id, this message translates to:
  /// **'Breadboard'**
  String get materiL1L1KomBreadboardTitle;

  /// No description provided for @materiL1L1KomHukumOhmEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiL1L1KomHukumOhmEstimatedTime;

  /// No description provided for @materiL1L1KomHukumOhmTitle.
  ///
  /// In id, this message translates to:
  /// **'Hukum Ohm'**
  String get materiL1L1KomHukumOhmTitle;

  /// No description provided for @materiL1L1KomHukumOhmVideoSummary5Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Contoh Soal'**
  String get materiL1L1KomHukumOhmVideoSummary5Heading;

  /// No description provided for @materiL1L1KomKapasitorEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiL1L1KomKapasitorEstimatedTime;

  /// No description provided for @materiL1L1KomKapasitorTitle.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor'**
  String get materiL1L1KomKapasitorTitle;

  /// No description provided for @materiL1L1KomLedEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiL1L1KomLedEstimatedTime;

  /// No description provided for @materiL1L1KomLedTitle.
  ///
  /// In id, this message translates to:
  /// **'LED (Light Emitting Diode)'**
  String get materiL1L1KomLedTitle;

  /// No description provided for @materiL1L1KomLedVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Pengenalan LED'**
  String get materiL1L1KomLedVideoSummary0Heading;

  /// No description provided for @materiL1L1KomLedVideoSummary5Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Jenis-Jenis LED'**
  String get materiL1L1KomLedVideoSummary5Heading;

  /// No description provided for @materiL1L1KomResistorEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiL1L1KomResistorEstimatedTime;

  /// No description provided for @materiL1L1KomResistorTitle.
  ///
  /// In id, this message translates to:
  /// **'Resistor (Cara Menghitung Nilai)'**
  String get materiL1L1KomResistorTitle;

  /// No description provided for @materiL1L1KomTactileSwitchEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'5 menit'**
  String get materiL1L1KomTactileSwitchEstimatedTime;

  /// No description provided for @materiL1L1KomTactileSwitchTitle.
  ///
  /// In id, this message translates to:
  /// **'Tactile Switch (Push Button)'**
  String get materiL1L1KomTactileSwitchTitle;

  /// No description provided for @materiL1L1KomponenFolderTitle.
  ///
  /// In id, this message translates to:
  /// **'Pengenalan Komponen'**
  String get materiL1L1KomponenFolderTitle;

  /// No description provided for @materiL1L1PosttestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'V = I / R'**
  String get materiL1L1PosttestQQ1Option0;

  /// No description provided for @materiL1L1PosttestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'V = I Ã— R'**
  String get materiL1L1PosttestQQ1Option1;

  /// No description provided for @materiL1L1PosttestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'R = V Ã— I'**
  String get materiL1L1PosttestQQ1Option2;

  /// No description provided for @materiL1L1PosttestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'I = V Ã— R'**
  String get materiL1L1PosttestQQ1Option3;

  /// No description provided for @materiL1L1PosttestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Rumus hukum Ohm adalah...'**
  String get materiL1L1PosttestQQ1Question;

  /// No description provided for @materiL1L1PosttestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'10 Î©'**
  String get materiL1L1PosttestQQ2Option0;

  /// No description provided for @materiL1L1PosttestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'150 Î©'**
  String get materiL1L1PosttestQQ2Option1;

  /// No description provided for @materiL1L1PosttestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'220 Î©'**
  String get materiL1L1PosttestQQ2Option2;

  /// No description provided for @materiL1L1PosttestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'10 kÎ©'**
  String get materiL1L1PosttestQQ2Option3;

  /// No description provided for @materiL1L1PosttestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'13,6 mA'**
  String get materiL1L1PosttestQQ3Option0;

  /// No description provided for @materiL1L1PosttestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'20 mA'**
  String get materiL1L1PosttestQQ3Option1;

  /// No description provided for @materiL1L1PosttestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'36 mA'**
  String get materiL1L1PosttestQQ3Option2;

  /// No description provided for @materiL1L1PosttestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'1,36 A'**
  String get materiL1L1PosttestQQ3Option3;

  /// No description provided for @materiL1L1PosttestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'5 mA'**
  String get materiL1L1PosttestQQ4Option0;

  /// No description provided for @materiL1L1PosttestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'20 mA'**
  String get materiL1L1PosttestQQ4Option1;

  /// No description provided for @materiL1L1PosttestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'200 mA'**
  String get materiL1L1PosttestQQ4Option2;

  /// No description provided for @materiL1L1PosttestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'1 A'**
  String get materiL1L1PosttestQQ4Option3;

  /// No description provided for @materiL1L1PosttestQQ5Option0.
  ///
  /// In id, this message translates to:
  /// **'D13'**
  String get materiL1L1PosttestQQ5Option0;

  /// No description provided for @materiL1L1PosttestQQ5Option1.
  ///
  /// In id, this message translates to:
  /// **'D8'**
  String get materiL1L1PosttestQQ5Option1;

  /// No description provided for @materiL1L1PosttestQQ5Option2.
  ///
  /// In id, this message translates to:
  /// **'D2'**
  String get materiL1L1PosttestQQ5Option2;

  /// No description provided for @materiL1L1PosttestQQ5Option3.
  ///
  /// In id, this message translates to:
  /// **'A0'**
  String get materiL1L1PosttestQQ5Option3;

  /// No description provided for @materiL1L1PosttestTitle.
  ///
  /// In id, this message translates to:
  /// **'Post-Test Level 1'**
  String get materiL1L1PosttestTitle;

  /// No description provided for @materiL1L1PretestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'Hambatan'**
  String get materiL1L1PretestQQ1Option0;

  /// No description provided for @materiL1L1PretestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'Tegangan'**
  String get materiL1L1PretestQQ1Option1;

  /// No description provided for @materiL1L1PretestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'Daya'**
  String get materiL1L1PretestQQ1Option2;

  /// No description provided for @materiL1L1PretestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'Frekuensi'**
  String get materiL1L1PretestQQ1Option3;

  /// No description provided for @materiL1L1PretestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'Volt'**
  String get materiL1L1PretestQQ2Option0;

  /// No description provided for @materiL1L1PretestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'Ampere'**
  String get materiL1L1PretestQQ2Option1;

  /// No description provided for @materiL1L1PretestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'Ohm'**
  String get materiL1L1PretestQQ2Option2;

  /// No description provided for @materiL1L1PretestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'Watt'**
  String get materiL1L1PretestQQ2Option3;

  /// No description provided for @materiL1L1PretestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'Katoda (âˆ’)'**
  String get materiL1L1PretestQQ3Option0;

  /// No description provided for @materiL1L1PretestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'Anoda (+)'**
  String get materiL1L1PretestQQ3Option1;

  /// No description provided for @materiL1L1PretestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'Ground'**
  String get materiL1L1PretestQQ3Option2;

  /// No description provided for @materiL1L1PretestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'Kaki tengah'**
  String get materiL1L1PretestQQ3Option3;

  /// No description provided for @materiL1L1PretestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'ATmega328P'**
  String get materiL1L1PretestQQ4Option0;

  /// No description provided for @materiL1L1PretestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'ESP32'**
  String get materiL1L1PretestQQ4Option1;

  /// No description provided for @materiL1L1PretestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'STM32'**
  String get materiL1L1PretestQQ4Option2;

  /// No description provided for @materiL1L1PretestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'PIC16F'**
  String get materiL1L1PretestQQ4Option3;

  /// No description provided for @materiL1L1PretestTitle.
  ///
  /// In id, this message translates to:
  /// **'Pre-Test Level 1'**
  String get materiL1L1PretestTitle;

  /// No description provided for @materiL2L2ArrayPointerEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'8 menit'**
  String get materiL2L2ArrayPointerEstimatedTime;

  /// No description provided for @materiL2L2ArrayPointerTitle.
  ///
  /// In id, this message translates to:
  /// **'Array & Pointer'**
  String get materiL2L2ArrayPointerTitle;

  /// No description provided for @materiL2L2ArrayPointerVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL2L2ArrayPointerVideoSummary0Heading;

  /// No description provided for @materiL2L2ArrayPointerVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Sorotan Utama'**
  String get materiL2L2ArrayPointerVideoSummary2Heading;

  /// No description provided for @materiL2L2ArrayPointerVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Kunci'**
  String get materiL2L2ArrayPointerVideoSummary4Heading;

  /// No description provided for @materiL2L2InputOutputEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL2L2InputOutputEstimatedTime;

  /// No description provided for @materiL2L2InputOutputTitle.
  ///
  /// In id, this message translates to:
  /// **'Input & Output Digital'**
  String get materiL2L2InputOutputTitle;

  /// No description provided for @materiL2L2InputOutputVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL2L2InputOutputVideoSummary0Heading;

  /// No description provided for @materiL2L2InputOutputVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Sorotan Utama'**
  String get materiL2L2InputOutputVideoSummary2Heading;

  /// No description provided for @materiL2L2InputOutputVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Kunci'**
  String get materiL2L2InputOutputVideoSummary4Heading;

  /// No description provided for @materiL2L2InputOutputVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Alur Program'**
  String get materiL2L2InputOutputVideoSummary6Heading;

  /// No description provided for @materiL2L2OperatorPercabanganEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL2L2OperatorPercabanganEstimatedTime;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL2L2OperatorPercabanganVideoSummary0Heading;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary8Heading.
  ///
  /// In id, this message translates to:
  /// **'Penutup'**
  String get materiL2L2OperatorPercabanganVideoSummary8Heading;

  /// No description provided for @materiL2L2PosttestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'Sekali saat board menyala'**
  String get materiL2L2PosttestQQ1Option0;

  /// No description provided for @materiL2L2PosttestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'Berulang selama Arduino menyala'**
  String get materiL2L2PosttestQQ1Option1;

  /// No description provided for @materiL2L2PosttestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'Hanya saat terjadi error'**
  String get materiL2L2PosttestQQ1Option2;

  /// No description provided for @materiL2L2PosttestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'Ketika dikompilasi'**
  String get materiL2L2PosttestQQ1Option3;

  /// No description provided for @materiL2L2PosttestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'||'**
  String get materiL2L2PosttestQQ2Option0;

  /// No description provided for @materiL2L2PosttestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'&&'**
  String get materiL2L2PosttestQQ2Option1;

  /// No description provided for @materiL2L2PosttestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'!'**
  String get materiL2L2PosttestQQ2Option2;

  /// No description provided for @materiL2L2PosttestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'=='**
  String get materiL2L2PosttestQQ2Option3;

  /// No description provided for @materiL2L2PosttestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Operator logika AND ditulis...'**
  String get materiL2L2PosttestQQ2Question;

  /// No description provided for @materiL2L2PosttestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'NC (Normally Close)'**
  String get materiL2L2PosttestQQ3Option0;

  /// No description provided for @materiL2L2PosttestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'NO (Normally Open)'**
  String get materiL2L2PosttestQQ3Option1;

  /// No description provided for @materiL2L2PosttestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'GND'**
  String get materiL2L2PosttestQQ3Option2;

  /// No description provided for @materiL2L2PosttestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'VCC'**
  String get materiL2L2PosttestQQ3Option3;

  /// No description provided for @materiL2L2PosttestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'digitalWrite()'**
  String get materiL2L2PosttestQQ4Option0;

  /// No description provided for @materiL2L2PosttestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'digitalRead()'**
  String get materiL2L2PosttestQQ4Option1;

  /// No description provided for @materiL2L2PosttestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'analogWrite()'**
  String get materiL2L2PosttestQQ4Option2;

  /// No description provided for @materiL2L2PosttestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'pinMode()'**
  String get materiL2L2PosttestQQ4Option3;

  /// No description provided for @materiL2L2PosttestQQ5Option0.
  ///
  /// In id, this message translates to:
  /// **'//'**
  String get materiL2L2PosttestQQ5Option0;

  /// No description provided for @materiL2L2PosttestQQ5Option1.
  ///
  /// In id, this message translates to:
  /// **'##'**
  String get materiL2L2PosttestQQ5Option1;

  /// No description provided for @materiL2L2PosttestQQ5Option2.
  ///
  /// In id, this message translates to:
  /// **'--'**
  String get materiL2L2PosttestQQ5Option2;

  /// No description provided for @materiL2L2PosttestQQ5Option3.
  ///
  /// In id, this message translates to:
  /// **'<!--'**
  String get materiL2L2PosttestQQ5Option3;

  /// No description provided for @materiL2L2PosttestTitle.
  ///
  /// In id, this message translates to:
  /// **'Post-Test Level 2'**
  String get materiL2L2PosttestTitle;

  /// No description provided for @materiL2L2PretestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'Berulang tanpa henti'**
  String get materiL2L2PretestQQ1Option0;

  /// No description provided for @materiL2L2PretestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'Sekali saat board menyala'**
  String get materiL2L2PretestQQ1Option1;

  /// No description provided for @materiL2L2PretestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'Setiap tombol ditekan'**
  String get materiL2L2PretestQQ1Option2;

  /// No description provided for @materiL2L2PretestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'Tidak pernah'**
  String get materiL2L2PretestQQ1Option3;

  /// No description provided for @materiL2L2PretestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'int'**
  String get materiL2L2PretestQQ2Option0;

  /// No description provided for @materiL2L2PretestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'bool'**
  String get materiL2L2PretestQQ2Option1;

  /// No description provided for @materiL2L2PretestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'float'**
  String get materiL2L2PretestQQ2Option2;

  /// No description provided for @materiL2L2PretestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'char'**
  String get materiL2L2PretestQQ2Option3;

  /// No description provided for @materiL2L2PretestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'HIGH dan LOW'**
  String get materiL2L2PretestQQ3Option0;

  /// No description provided for @materiL2L2PretestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'ON dan 0'**
  String get materiL2L2PretestQQ3Option1;

  /// No description provided for @materiL2L2PretestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'1 dan 2'**
  String get materiL2L2PretestQQ3Option2;

  /// No description provided for @materiL2L2PretestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'VCC dan AC'**
  String get materiL2L2PretestQQ3Option3;

  /// No description provided for @materiL2L2PretestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'1'**
  String get materiL2L2PretestQQ4Option0;

  /// No description provided for @materiL2L2PretestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'0'**
  String get materiL2L2PretestQQ4Option1;

  /// No description provided for @materiL2L2PretestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'-1'**
  String get materiL2L2PretestQQ4Option2;

  /// No description provided for @materiL2L2PretestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'Tergantung tipe data'**
  String get materiL2L2PretestQQ4Option3;

  /// No description provided for @materiL2L2PretestTitle.
  ///
  /// In id, this message translates to:
  /// **'Pre-Test Level 2'**
  String get materiL2L2PretestTitle;

  /// No description provided for @materiL2L2RelayEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'8 menit'**
  String get materiL2L2RelayEstimatedTime;

  /// No description provided for @materiL2L2RelayTitle.
  ///
  /// In id, this message translates to:
  /// **'Relay'**
  String get materiL2L2RelayTitle;

  /// No description provided for @materiL2L2RelayVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL2L2RelayVideoSummary0Heading;

  /// No description provided for @materiL2L2RelayVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Sorotan Utama'**
  String get materiL2L2RelayVideoSummary2Heading;

  /// No description provided for @materiL2L2RelayVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Kunci'**
  String get materiL2L2RelayVideoSummary4Heading;

  /// No description provided for @materiL2L2StrukturSketchEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'8 menit'**
  String get materiL2L2StrukturSketchEstimatedTime;

  /// No description provided for @materiL2L2StrukturSketchVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL2L2StrukturSketchVideoSummary0Heading;

  /// No description provided for @materiL2L2StrukturSketchVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Sorotan Utama'**
  String get materiL2L2StrukturSketchVideoSummary2Heading;

  /// No description provided for @materiL2L2StrukturSketchVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Kunci'**
  String get materiL2L2StrukturSketchVideoSummary4Heading;

  /// No description provided for @materiL2L2StrukturSketchVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Penutup'**
  String get materiL2L2StrukturSketchVideoSummary6Heading;

  /// No description provided for @materiL3L3AdcEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL3L3AdcEstimatedTime;

  /// No description provided for @materiL3L3AdcTitle.
  ///
  /// In id, this message translates to:
  /// **'ADC (Analog to Digital Converter)'**
  String get materiL3L3AdcTitle;

  /// No description provided for @materiL3L3AdcVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL3L3AdcVideoSummary0Heading;

  /// No description provided for @materiL3L3AdcVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Sorotan Utama'**
  String get materiL3L3AdcVideoSummary2Heading;

  /// No description provided for @materiL3L3AdcVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Penting'**
  String get materiL3L3AdcVideoSummary4Heading;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'8 menit'**
  String get materiL3L3JenisPrinsipKerjaSensorEstimatedTime;

  /// No description provided for @materiL3L3PosttestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'V = (nilai ADC / 255) Ã— 5 V'**
  String get materiL3L3PosttestQQ1Option0;

  /// No description provided for @materiL3L3PosttestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'V = (nilai ADC / 1023) Ã— 5 V'**
  String get materiL3L3PosttestQQ1Option1;

  /// No description provided for @materiL3L3PosttestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'V = nilai ADC Ã— 5 V'**
  String get materiL3L3PosttestQQ1Option2;

  /// No description provided for @materiL3L3PosttestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'V = 1023 / nilai ADC'**
  String get materiL3L3PosttestQQ1Option3;

  /// No description provided for @materiL3L3PosttestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'1,25 V'**
  String get materiL3L3PosttestQQ2Option0;

  /// No description provided for @materiL3L3PosttestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'2,5 V'**
  String get materiL3L3PosttestQQ2Option1;

  /// No description provided for @materiL3L3PosttestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'5 V'**
  String get materiL3L3PosttestQQ2Option2;

  /// No description provided for @materiL3L3PosttestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'0 V'**
  String get materiL3L3PosttestQQ2Option3;

  /// No description provided for @materiL3L3PosttestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'D2'**
  String get materiL3L3PosttestQQ3Option0;

  /// No description provided for @materiL3L3PosttestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'D4'**
  String get materiL3L3PosttestQQ3Option1;

  /// No description provided for @materiL3L3PosttestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'D9'**
  String get materiL3L3PosttestQQ3Option2;

  /// No description provided for @materiL3L3PosttestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'A0'**
  String get materiL3L3PosttestQQ3Option3;

  /// No description provided for @materiL3L3PosttestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'digitalWrite()'**
  String get materiL3L3PosttestQQ4Option0;

  /// No description provided for @materiL3L3PosttestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'analogWrite()'**
  String get materiL3L3PosttestQQ4Option1;

  /// No description provided for @materiL3L3PosttestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'analogRead()'**
  String get materiL3L3PosttestQQ4Option2;

  /// No description provided for @materiL3L3PosttestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'digitalRead()'**
  String get materiL3L3PosttestQQ4Option3;

  /// No description provided for @materiL3L3PosttestQQ5Option2.
  ///
  /// In id, this message translates to:
  /// **'Menggantikan catu daya utama'**
  String get materiL3L3PosttestQQ5Option2;

  /// No description provided for @materiL3L3PosttestQQ5Option3.
  ///
  /// In id, this message translates to:
  /// **'Memutus arus saat korsleting'**
  String get materiL3L3PosttestQQ5Option3;

  /// No description provided for @materiL3L3PosttestTitle.
  ///
  /// In id, this message translates to:
  /// **'Post-Test Level 3'**
  String get materiL3L3PosttestTitle;

  /// No description provided for @materiL3L3PretestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'D0â€“D13'**
  String get materiL3L3PretestQQ1Option0;

  /// No description provided for @materiL3L3PretestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'A0â€“A5'**
  String get materiL3L3PretestQQ1Option1;

  /// No description provided for @materiL3L3PretestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'RX/TX'**
  String get materiL3L3PretestQQ1Option2;

  /// No description provided for @materiL3L3PretestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'RESET'**
  String get materiL3L3PretestQQ1Option3;

  /// No description provided for @materiL3L3PretestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'0â€“100'**
  String get materiL3L3PretestQQ2Option0;

  /// No description provided for @materiL3L3PretestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'0â€“255'**
  String get materiL3L3PretestQQ2Option1;

  /// No description provided for @materiL3L3PretestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'0â€“1023'**
  String get materiL3L3PretestQQ2Option2;

  /// No description provided for @materiL3L3PretestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'0â€“5'**
  String get materiL3L3PretestQQ2Option3;

  /// No description provided for @materiL3L3PretestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'0â€“100'**
  String get materiL3L3PretestQQ3Option0;

  /// No description provided for @materiL3L3PretestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'0â€“255'**
  String get materiL3L3PretestQQ3Option1;

  /// No description provided for @materiL3L3PretestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'0â€“1023'**
  String get materiL3L3PretestQQ3Option2;

  /// No description provided for @materiL3L3PretestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'0â€“5'**
  String get materiL3L3PretestQQ3Option3;

  /// No description provided for @materiL3L3PretestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'map()'**
  String get materiL3L3PretestQQ4Option0;

  /// No description provided for @materiL3L3PretestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'delay()'**
  String get materiL3L3PretestQQ4Option1;

  /// No description provided for @materiL3L3PretestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'pinMode()'**
  String get materiL3L3PretestQQ4Option2;

  /// No description provided for @materiL3L3PretestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'Serial.begin()'**
  String get materiL3L3PretestQQ4Option3;

  /// No description provided for @materiL3L3PretestTitle.
  ///
  /// In id, this message translates to:
  /// **'Pre-Test Level 3'**
  String get materiL3L3PretestTitle;

  /// No description provided for @materiL3L3PwmEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL3L3PwmEstimatedTime;

  /// No description provided for @materiL3L3PwmTitle.
  ///
  /// In id, this message translates to:
  /// **'PWM (Pulse Width Modulation)'**
  String get materiL3L3PwmTitle;

  /// No description provided for @materiL3L3PwmVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL3L3PwmVideoSummary0Heading;

  /// No description provided for @materiL3L3PwmVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Poin-poin Penting'**
  String get materiL3L3PwmVideoSummary2Heading;

  /// No description provided for @materiL3L3PwmVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Insight Kunci'**
  String get materiL3L3PwmVideoSummary4Heading;

  /// No description provided for @materiL4L4DebouncingEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'8 menit'**
  String get materiL4L4DebouncingEstimatedTime;

  /// No description provided for @materiL4L4DebouncingTitle.
  ///
  /// In id, this message translates to:
  /// **'Debouncing'**
  String get materiL4L4DebouncingTitle;

  /// No description provided for @materiL4L4DebouncingVideoSummary8Heading.
  ///
  /// In id, this message translates to:
  /// **'Kesimpulan'**
  String get materiL4L4DebouncingVideoSummary8Heading;

  /// No description provided for @materiL4L4InterruptEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL4L4InterruptEstimatedTime;

  /// No description provided for @materiL4L4InterruptTitle.
  ///
  /// In id, this message translates to:
  /// **'Interrupt'**
  String get materiL4L4InterruptTitle;

  /// No description provided for @materiL4L4InterruptVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL4L4InterruptVideoSummary0Heading;

  /// No description provided for @materiL4L4InterruptVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Contoh Implementasi'**
  String get materiL4L4InterruptVideoSummary2Heading;

  /// No description provided for @materiL4L4InterruptVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Sorotan'**
  String get materiL4L4InterruptVideoSummary4Heading;

  /// No description provided for @materiL4L4InterruptVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Kunci'**
  String get materiL4L4InterruptVideoSummary6Heading;

  /// No description provided for @materiL4L4InterruptVideoSummary8Heading.
  ///
  /// In id, this message translates to:
  /// **'Kesimpulan'**
  String get materiL4L4InterruptVideoSummary8Heading;

  /// No description provided for @materiL4L4JenisMotorEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL4L4JenisMotorEstimatedTime;

  /// No description provided for @materiL4L4JenisMotorTitle.
  ///
  /// In id, this message translates to:
  /// **'Jenis Motor: Servo'**
  String get materiL4L4JenisMotorTitle;

  /// No description provided for @materiL4L4JenisMotorVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL4L4JenisMotorVideoSummary0Heading;

  /// No description provided for @materiL4L4JenisMotorVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Poin-poin Penting'**
  String get materiL4L4JenisMotorVideoSummary2Heading;

  /// No description provided for @materiL4L4JenisMotorVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Insight Utama'**
  String get materiL4L4JenisMotorVideoSummary4Heading;

  /// No description provided for @materiL4L4PosttestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'ADC'**
  String get materiL4L4PosttestQQ1Option0;

  /// No description provided for @materiL4L4PosttestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'PWM'**
  String get materiL4L4PosttestQQ1Option1;

  /// No description provided for @materiL4L4PosttestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'I2C'**
  String get materiL4L4PosttestQQ1Option2;

  /// No description provided for @materiL4L4PosttestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'UART'**
  String get materiL4L4PosttestQQ1Option3;

  /// No description provided for @materiL4L4PosttestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'Jam dan tanggal sebenarnya'**
  String get materiL4L4PosttestQQ2Option1;

  /// No description provided for @materiL4L4PosttestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'Nilai ADC terakhir'**
  String get materiL4L4PosttestQQ2Option2;

  /// No description provided for @materiL4L4PosttestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'Duty cycle PWM'**
  String get materiL4L4PosttestQQ2Option3;

  /// No description provided for @materiL4L4PosttestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'Konsumsi memori menjadi nol'**
  String get materiL4L4PosttestQQ3Option1;

  /// No description provided for @materiL4L4PosttestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'Tidak membutuhkan fungsi loop()'**
  String get materiL4L4PosttestQQ3Option2;

  /// No description provided for @materiL4L4PosttestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'Tegangan pin menjadi 12 V'**
  String get materiL4L4PosttestQQ3Option3;

  /// No description provided for @materiL4L4PosttestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'Polling'**
  String get materiL4L4PosttestQQ4Option0;

  /// No description provided for @materiL4L4PosttestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'Interrupt'**
  String get materiL4L4PosttestQQ4Option1;

  /// No description provided for @materiL4L4PosttestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'Debouncing'**
  String get materiL4L4PosttestQQ4Option2;

  /// No description provided for @materiL4L4PosttestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'Mapping'**
  String get materiL4L4PosttestQQ4Option3;

  /// No description provided for @materiL4L4PosttestQQ5Option0.
  ///
  /// In id, this message translates to:
  /// **'Memakai delay(5000)'**
  String get materiL4L4PosttestQQ5Option0;

  /// No description provided for @materiL4L4PosttestQQ5Option2.
  ///
  /// In id, this message translates to:
  /// **'Menghapus fungsi setup()'**
  String get materiL4L4PosttestQQ5Option2;

  /// No description provided for @materiL4L4PosttestQQ5Option3.
  ///
  /// In id, this message translates to:
  /// **'Mengganti board Arduino'**
  String get materiL4L4PosttestQQ5Option3;

  /// No description provided for @materiL4L4PosttestTitle.
  ///
  /// In id, this message translates to:
  /// **'Post-Test Level 4'**
  String get materiL4L4PosttestTitle;

  /// No description provided for @materiL4L4PretestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'Putaran kontinu tanpa batas'**
  String get materiL4L4PretestQQ1Option0;

  /// No description provided for @materiL4L4PretestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'Menyambung beban AC'**
  String get materiL4L4PretestQQ1Option2;

  /// No description provided for @materiL4L4PretestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'Mengukur suhu'**
  String get materiL4L4PretestQQ1Option3;

  /// No description provided for @materiL4L4PretestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Servo digunakan untuk...'**
  String get materiL4L4PretestQQ1Question;

  /// No description provided for @materiL4L4PretestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'VCC 5V'**
  String get materiL4L4PretestQQ2Option0;

  /// No description provided for @materiL4L4PretestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'Ground'**
  String get materiL4L4PretestQQ2Option1;

  /// No description provided for @materiL4L4PretestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'Pin Reset'**
  String get materiL4L4PretestQQ2Option2;

  /// No description provided for @materiL4L4PretestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'Pin RX'**
  String get materiL4L4PretestQQ2Option3;

  /// No description provided for @materiL4L4PretestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'Bekerja lebih cepat'**
  String get materiL4L4PretestQQ3Option1;

  /// No description provided for @materiL4L4PretestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'Menghemat daya otomatis'**
  String get materiL4L4PretestQQ3Option2;

  /// No description provided for @materiL4L4PretestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'Mengaktifkan PWM'**
  String get materiL4L4PretestQQ3Option3;

  /// No description provided for @materiL4L4PretestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'Bouncing'**
  String get materiL4L4PretestQQ4Option0;

  /// No description provided for @materiL4L4PretestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'Floating'**
  String get materiL4L4PretestQQ4Option1;

  /// No description provided for @materiL4L4PretestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'Overflow'**
  String get materiL4L4PretestQQ4Option2;

  /// No description provided for @materiL4L4PretestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'Polling'**
  String get materiL4L4PretestQQ4Option3;

  /// No description provided for @materiL4L4PretestTitle.
  ///
  /// In id, this message translates to:
  /// **'Pre-Test Level 4'**
  String get materiL4L4PretestTitle;

  /// No description provided for @materiL4L4TimerTanpaHentiEstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL4L4TimerTanpaHentiEstimatedTime;

  /// No description provided for @materiL4L4TimerTanpaHentiTitle.
  ///
  /// In id, this message translates to:
  /// **'Timer Tanpa Henti (millis)'**
  String get materiL4L4TimerTanpaHentiTitle;

  /// No description provided for @materiL4L4TimerTanpaHentiVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL4L4TimerTanpaHentiVideoSummary0Heading;

  /// No description provided for @materiL4L4TimerTanpaHentiVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Sorotan Utama'**
  String get materiL4L4TimerTanpaHentiVideoSummary4Heading;

  /// No description provided for @materiL4L4TimerTanpaHentiVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Kunci'**
  String get materiL4L4TimerTanpaHentiVideoSummary6Heading;

  /// No description provided for @materiL5L5M1EstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'8 menit'**
  String get materiL5L5M1EstimatedTime;

  /// No description provided for @materiL5L5M1Title.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi Proyek & Histeresis'**
  String get materiL5L5M1Title;

  /// No description provided for @materiL5L5M2EstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL5L5M2EstimatedTime;

  /// No description provided for @materiL5L5M2Title.
  ///
  /// In id, this message translates to:
  /// **'Rangkaian Lengkap'**
  String get materiL5L5M2Title;

  /// No description provided for @materiL5L5M3EstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'15 menit'**
  String get materiL5L5M3EstimatedTime;

  /// No description provided for @materiL5L5M3Title.
  ///
  /// In id, this message translates to:
  /// **'Kode Program Kipas Otomatis'**
  String get materiL5L5M3Title;

  /// No description provided for @materiL5L5M4EstimatedTime.
  ///
  /// In id, this message translates to:
  /// **'10 menit'**
  String get materiL5L5M4EstimatedTime;

  /// No description provided for @materiL5L5M4Title.
  ///
  /// In id, this message translates to:
  /// **'Pengujian & Pengembangan'**
  String get materiL5L5M4Title;

  /// No description provided for @materiL5L5PosttestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'Mempercepat pembacaan sensor'**
  String get materiL5L5PosttestQQ1Option1;

  /// No description provided for @materiL5L5PosttestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'Menghemat memori'**
  String get materiL5L5PosttestQQ1Option2;

  /// No description provided for @materiL5L5PosttestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'Mengganti sensor'**
  String get materiL5L5PosttestQQ1Option3;

  /// No description provided for @materiL5L5PosttestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'â‰¤ 28 Â°C'**
  String get materiL5L5PosttestQQ2Option0;

  /// No description provided for @materiL5L5PosttestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'â‰¥ 30 Â°C'**
  String get materiL5L5PosttestQQ2Option1;

  /// No description provided for @materiL5L5PosttestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'Tepat 29 Â°C'**
  String get materiL5L5PosttestQQ2Option2;

  /// No description provided for @materiL5L5PosttestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'Tidak terbaca'**
  String get materiL5L5PosttestQQ2Option3;

  /// No description provided for @materiL5L5PosttestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'Lebih murah'**
  String get materiL5L5PosttestQQ3Option1;

  /// No description provided for @materiL5L5PosttestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'Lebih cepat'**
  String get materiL5L5PosttestQQ3Option2;

  /// No description provided for @materiL5L5PosttestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'Terminal NC pasti rusak'**
  String get materiL5L5PosttestQQ3Option3;

  /// No description provided for @materiL5L5PosttestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'Pembacaan sensor gagal'**
  String get materiL5L5PosttestQQ4Option0;

  /// No description provided for @materiL5L5PosttestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'Suhu sangat tinggi'**
  String get materiL5L5PosttestQQ4Option1;

  /// No description provided for @materiL5L5PosttestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'Kipas sedang ON'**
  String get materiL5L5PosttestQQ4Option2;

  /// No description provided for @materiL5L5PosttestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'OLED rusak'**
  String get materiL5L5PosttestQQ4Option3;

  /// No description provided for @materiL5L5PosttestQQ5Option0.
  ///
  /// In id, this message translates to:
  /// **'Galat mutlak / pembanding Ã— 100%'**
  String get materiL5L5PosttestQQ5Option0;

  /// No description provided for @materiL5L5PosttestQQ5Option1.
  ///
  /// In id, this message translates to:
  /// **'Pembanding / galat mutlak'**
  String get materiL5L5PosttestQQ5Option1;

  /// No description provided for @materiL5L5PosttestQQ5Option2.
  ///
  /// In id, this message translates to:
  /// **'DHT11 Ã— 100%'**
  String get materiL5L5PosttestQQ5Option2;

  /// No description provided for @materiL5L5PosttestQQ5Option3.
  ///
  /// In id, this message translates to:
  /// **'Galat mutlak âˆ’ pembanding'**
  String get materiL5L5PosttestQQ5Option3;

  /// No description provided for @materiL5L5PosttestTitle.
  ///
  /// In id, this message translates to:
  /// **'Post-Test Level 5'**
  String get materiL5L5PosttestTitle;

  /// No description provided for @materiL5L5PretestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'Penguat suara'**
  String get materiL5L5PretestQQ1Option1;

  /// No description provided for @materiL5L5PretestQQ1Option2.
  ///
  /// In id, this message translates to:
  /// **'Sensor suhu'**
  String get materiL5L5PretestQQ1Option2;

  /// No description provided for @materiL5L5PretestQQ1Option3.
  ///
  /// In id, this message translates to:
  /// **'Penyimpan data'**
  String get materiL5L5PretestQQ1Option3;

  /// No description provided for @materiL5L5PretestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Relay berfungsi sebagai...'**
  String get materiL5L5PretestQQ1Question;

  /// No description provided for @materiL5L5PretestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'Suhu dan kelembaban'**
  String get materiL5L5PretestQQ2Option0;

  /// No description provided for @materiL5L5PretestQQ2Option1.
  ///
  /// In id, this message translates to:
  /// **'Jarak'**
  String get materiL5L5PretestQQ2Option1;

  /// No description provided for @materiL5L5PretestQQ2Option2.
  ///
  /// In id, this message translates to:
  /// **'Kadar gas'**
  String get materiL5L5PretestQQ2Option2;

  /// No description provided for @materiL5L5PretestQQ2Option3.
  ///
  /// In id, this message translates to:
  /// **'Cahaya'**
  String get materiL5L5PretestQQ2Option3;

  /// No description provided for @materiL5L5PretestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Sensor DHT11 mengukur...'**
  String get materiL5L5PretestQQ2Question;

  /// No description provided for @materiL5L5PretestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'A4 (SDA) dan A5 (SCL)'**
  String get materiL5L5PretestQQ3Option0;

  /// No description provided for @materiL5L5PretestQQ3Option1.
  ///
  /// In id, this message translates to:
  /// **'D0 dan D1'**
  String get materiL5L5PretestQQ3Option1;

  /// No description provided for @materiL5L5PretestQQ3Option2.
  ///
  /// In id, this message translates to:
  /// **'D2 dan D3'**
  String get materiL5L5PretestQQ3Option2;

  /// No description provided for @materiL5L5PretestQQ3Option3.
  ///
  /// In id, this message translates to:
  /// **'A0 dan A1'**
  String get materiL5L5PretestQQ3Option3;

  /// No description provided for @materiL5L5PretestQQ4Option0.
  ///
  /// In id, this message translates to:
  /// **'0x3C'**
  String get materiL5L5PretestQQ4Option0;

  /// No description provided for @materiL5L5PretestQQ4Option1.
  ///
  /// In id, this message translates to:
  /// **'0xFF'**
  String get materiL5L5PretestQQ4Option1;

  /// No description provided for @materiL5L5PretestQQ4Option2.
  ///
  /// In id, this message translates to:
  /// **'0x00'**
  String get materiL5L5PretestQQ4Option2;

  /// No description provided for @materiL5L5PretestQQ4Option3.
  ///
  /// In id, this message translates to:
  /// **'0x68'**
  String get materiL5L5PretestQQ4Option3;

  /// No description provided for @materiL5L5PretestTitle.
  ///
  /// In id, this message translates to:
  /// **'Pre-Test Level 5'**
  String get materiL5L5PretestTitle;

  /// No description provided for @materiKomponenL1KomBreadboardContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Breadboard adalah alat prototipe untuk merangkai rangkaian elektronik tanpa menyolder. Memahami pola koneksinya penting agar rangkaian tidak salah sambung.'**
  String get materiKomponenL1KomBreadboardContent0Text;

  /// No description provided for @materiKomponenL1KomBreadboardContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Jalur biru dan merah menandai baris yang terhubung.\n- Celah tengah memisahkan dua sisi, cocok untuk memasang IC.\n- Pin berdekatan belum tentu terhubung, periksa polanya.\n- Gunakan avometer mode continuity untuk menguji koneksi.\n- Tersedia tipe 400 dan 830 pin.'**
  String get materiKomponenL1KomBreadboardContent1Text;

  /// No description provided for @materiKomponenL1KomBreadboardDescription.
  ///
  /// In id, this message translates to:
  /// **'Breadboard adalah papan untuk merangkai komponen elektronik tanpa solder, dengan pola koneksi pin yang sudah ditentukan.'**
  String get materiKomponenL1KomBreadboardDescription;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Struktur Breadboard'**
  String get materiKomponenL1KomBreadboardVideoSummary0Heading;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Breadboard terdiri dari deretan pin yang terhubung secara internal dengan pola tertentu. Jalur berwarna biru dan merah menunjukkan baris yang saling terhubung.'**
  String get materiKomponenL1KomBreadboardVideoSummary1Text;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Terdapat dua tipe breadboard dengan jumlah pin berbeda, sekitar 400 pin dan 830 pin, tetapi prinsip kerjanya sama.'**
  String get materiKomponenL1KomBreadboardVideoSummary2Text;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Pola Koneksi dan Celah Tengah'**
  String get materiKomponenL1KomBreadboardVideoSummary3Heading;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Pin yang berdekatan belum tentu terhubung karena ada celah pembatas di bagian tengah. Jalur koneksi umumnya horizontal di sisi pinggir dan vertikal di bagian tengah.'**
  String get materiKomponenL1KomBreadboardVideoSummary4Text;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Celah tengah dimanfaatkan untuk memasang IC agar pin kiri dan kanan IC tidak saling terhubung.'**
  String get materiKomponenL1KomBreadboardVideoSummary5Text;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Pengujian dan Penggunaan'**
  String get materiKomponenL1KomBreadboardVideoSummary6Heading;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Multimeter (avometer) dengan fungsi continuity test dapat digunakan untuk memeriksa apakah pin-pin breadboard saling terhubung.'**
  String get materiKomponenL1KomBreadboardVideoSummary7Text;

  /// No description provided for @materiKomponenL1KomBreadboardVideoSummary8Text.
  ///
  /// In id, this message translates to:
  /// **'Breadboard digunakan untuk membuat prototipe rangkaian tanpa menyolder, sehingga memudahkan perubahan dan pengujian.'**
  String get materiKomponenL1KomBreadboardVideoSummary8Text;

  /// No description provided for @materiKomponenL1KomHukumOhmContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Hukum Ohm menghubungkan arus, tegangan, dan hambatan dalam rangkaian listrik. Rumus dasarnya: I = V / R.'**
  String get materiKomponenL1KomHukumOhmContent0Text;

  /// No description provided for @materiKomponenL1KomHukumOhmContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Arus berbanding lurus dengan tegangan.\n- Arus berbanding terbalik dengan hambatan.\n- Satuan: I (ampere), V (volt), R (ohm).\n- Dapat dipakai untuk menghitung salah satu nilai jika dua lainnya diketahui.'**
  String get materiKomponenL1KomHukumOhmContent1Text;

  /// No description provided for @materiKomponenL1KomHukumOhmDescription.
  ///
  /// In id, this message translates to:
  /// **'Hukum Ohm menjelaskan hubungan antara arus, tegangan, dan hambatan dalam rangkaian listrik, dengan rumus I = V / R.'**
  String get materiKomponenL1KomHukumOhmDescription;

  /// No description provided for @materiKomponenL1KomHukumOhmVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Pengertian Hukum Ohm'**
  String get materiKomponenL1KomHukumOhmVideoSummary0Heading;

  /// No description provided for @materiKomponenL1KomHukumOhmVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Hukum Ohm adalah prinsip dasar elektronika yang menjelaskan hubungan antara arus listrik (I), tegangan (V), dan hambatan (R) dalam suatu rangkaian.'**
  String get materiKomponenL1KomHukumOhmVideoSummary1Text;

  /// No description provided for @materiKomponenL1KomHukumOhmVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Arus yang mengalir melalui konduktor berbanding lurus dengan tegangan yang diberikan dan berbanding terbalik dengan hambatannya.'**
  String get materiKomponenL1KomHukumOhmVideoSummary2Text;

  /// No description provided for @materiKomponenL1KomHukumOhmVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Rumus Hukum Ohm'**
  String get materiKomponenL1KomHukumOhmVideoSummary3Heading;

  /// No description provided for @materiKomponenL1KomHukumOhmVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Rumusnya adalah I = V / R, dengan I dalam ampere, V dalam volt, dan R dalam ohm.'**
  String get materiKomponenL1KomHukumOhmVideoSummary4Text;

  /// No description provided for @materiKomponenL1KomHukumOhmVideoSummary5Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Contoh Soal'**
  String get materiKomponenL1KomHukumOhmVideoSummary5Heading;

  /// No description provided for @materiKomponenL1KomHukumOhmVideoSummary6Text.
  ///
  /// In id, this message translates to:
  /// **'Contoh pertama adalah menghitung arus yang mengalir melalui sebuah lampu dengan hambatan dan tegangan tertentu.'**
  String get materiKomponenL1KomHukumOhmVideoSummary6Text;

  /// No description provided for @materiKomponenL1KomHukumOhmVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Contoh kedua adalah menghitung tegangan yang dibutuhkan untuk menghasilkan arus tertentu pada hambatan tertentu.'**
  String get materiKomponenL1KomHukumOhmVideoSummary7Text;

  /// No description provided for @materiKomponenL1KomKapasitorContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor menyimpan dan melepaskan energi listrik. Fungsinya antara lain menjaga kestabilan tegangan, menyaring sinyal, dan penyetelan frekuensi.'**
  String get materiKomponenL1KomKapasitorContent0Text;

  /// No description provided for @materiKomponenL1KomKapasitorContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Struktur: dua pelat logam dengan bahan dielektrik di antaranya.\n- Jenis keramik untuk kapasitansi kecil dan frekuensi tinggi.\n- Jenis poliester untuk audio.\n- Elco dan solid capacitor berpolaritas, pasang sesuai kaki positif dan negatif.\n- Variable capacitor untuk penyetelan frekuensi radio.\n- Rentang nilai dari pF hingga F.'**
  String get materiKomponenL1KomKapasitorContent1Text;

  /// No description provided for @materiKomponenL1KomKapasitorDescription.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor adalah komponen yang menyimpan dan melepaskan energi listrik dengan cepat, dengan jenis yang ditentukan oleh bahan dielektriknya.'**
  String get materiKomponenL1KomKapasitorDescription;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Pengertian Kapasitor'**
  String get materiKomponenL1KomKapasitorVideoSummary0Heading;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary10Text.
  ///
  /// In id, this message translates to:
  /// **'Pemasangan kapasitor berpolaritas dengan terbalik dapat menyebabkan kerusakan, bahkan ledakan.'**
  String get materiKomponenL1KomKapasitorVideoSummary10Text;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor adalah komponen elektronik yang mampu menyimpan dan melepas energi listrik secara cepat. Komponen ini terdiri dari dua pelat logam yang dipisahkan oleh bahan dielektrik yang tidak menghantarkan listrik.'**
  String get materiKomponenL1KomKapasitorVideoSummary1Text;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Bahan dielektrik menentukan jenis kapasitor, misalnya keramik, kertas, atau poliester.'**
  String get materiKomponenL1KomKapasitorVideoSummary2Text;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Jenis-Jenis Kapasitor'**
  String get materiKomponenL1KomKapasitorVideoSummary3Heading;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor keramik umum ditemui, berkapasitansi kecil, dan sering dipakai untuk frekuensi tinggi. Kapasitor poliester banyak dipakai pada aplikasi audio.'**
  String get materiKomponenL1KomKapasitorVideoSummary4Text;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor elektrolitik (Elco) dan solid capacitor memiliki kapasitansi besar dan berpolaritas, sehingga harus dipasang dengan benar. Solid capacitor lebih tahan panas dan awet, banyak dipakai di motherboard komputer.'**
  String get materiKomponenL1KomKapasitorVideoSummary5Text;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary6Text.
  ///
  /// In id, this message translates to:
  /// **'Variable capacitor dapat diatur nilainya secara mekanis dan sering dipakai untuk penyetelan frekuensi pada radio.'**
  String get materiKomponenL1KomKapasitorVideoSummary6Text;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Superkapasitor memiliki kapasitansi hingga ratusan farad dan berpotensi menggantikan baterai pada beberapa aplikasi.'**
  String get materiKomponenL1KomKapasitorVideoSummary7Text;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary8Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Rentang Kapasitansi dan Keselamatan'**
  String get materiKomponenL1KomKapasitorVideoSummary8Heading;

  /// No description provided for @materiKomponenL1KomKapasitorVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitansi kapasitor bervariasi dari beberapa pikofarad (pF) hingga ratusan farad (F).'**
  String get materiKomponenL1KomKapasitorVideoSummary9Text;

  /// No description provided for @materiKomponenL1KomLedContent0Text.
  ///
  /// In id, this message translates to:
  /// **'LED (Light Emitting Diode) adalah dioda yang memancarkan cahaya. Berbeda dengan lampu pijar, LED menghasilkan cahaya melalui rekombinasi elektron dan lubang muatan di dalam semikonduktor, sehingga lebih efisien dan lebih tahan lama.'**
  String get materiKomponenL1KomLedContent0Text;

  /// No description provided for @materiKomponenL1KomLedContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Warna LED ditentukan oleh bahan semikonduktor.\n- Tegangan maju (Vf) berbeda untuk setiap warna.\n- Sudut pancaran dan intensitas cahaya dapat dipilih sesuai kebutuhan.\n- Kaki LED memiliki polaritas, dan kaki panjang umumnya adalah anoda.'**
  String get materiKomponenL1KomLedContent1Text;

  /// No description provided for @materiKomponenL1KomLedContent2Text.
  ///
  /// In id, this message translates to:
  /// **'Jenis LED: through-hole (umum, 5 mm), SMD (kecil dan tipis), berdaya tinggi (perlu pendingin), COB (banyak chip dalam satu modul), RGB (multi-warna), dan alfanumerik (display angka dan huruf).'**
  String get materiKomponenL1KomLedContent2Text;

  /// No description provided for @materiKomponenL1KomLedDescription.
  ///
  /// In id, this message translates to:
  /// **'LED adalah dioda yang memancarkan cahaya saat dialiri listrik, dengan warna dan tegangan kerja yang ditentukan oleh bahan semikonduktornya.'**
  String get materiKomponenL1KomLedDescription;

  /// No description provided for @materiKomponenL1KomLedVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Pengenalan LED'**
  String get materiKomponenL1KomLedVideoSummary0Heading;

  /// No description provided for @materiKomponenL1KomLedVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'LED bukan lampu biasa seperti lampu pijar, melainkan jenis dioda yang memancarkan cahaya ketika dialiri listrik. LED terbuat dari bahan semikonduktor tipe P dan tipe N, dan cahaya dihasilkan saat elektron dan lubang muatan bertemu.'**
  String get materiKomponenL1KomLedVideoSummary1Text;

  /// No description provided for @materiKomponenL1KomLedVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Warna, Tegangan, dan Karakteristik'**
  String get materiKomponenL1KomLedVideoSummary2Heading;

  /// No description provided for @materiKomponenL1KomLedVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'Warna cahaya LED ditentukan oleh bahan pembuatnya, yang juga menentukan panjang gelombang dan tegangan kerja. Contohnya, LED biru biasanya membutuhkan tegangan maju lebih tinggi dibanding LED merah.'**
  String get materiKomponenL1KomLedVideoSummary3Text;

  /// No description provided for @materiKomponenL1KomLedVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Karakteristik lain yang perlu diperhatikan adalah sudut pancaran cahaya (sekitar 10° sampai 120°) dan intensitas cahaya yang diukur dalam millicandela.'**
  String get materiKomponenL1KomLedVideoSummary4Text;

  /// No description provided for @materiKomponenL1KomLedVideoSummary5Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Jenis-Jenis LED'**
  String get materiKomponenL1KomLedVideoSummary5Heading;

  /// No description provided for @materiKomponenL1KomLedVideoSummary6Text.
  ///
  /// In id, this message translates to:
  /// **'LED through-hole adalah tipe yang umum dengan ukuran paling sering 5 mm, mudah dipasang, dan polaritasnya mudah dikenali dari panjang kaki.'**
  String get materiKomponenL1KomLedVideoSummary6Text;

  /// No description provided for @materiKomponenL1KomLedVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'LED SMD berukuran sangat kecil dan tipis, cocok untuk pemasangan massal pada ruang terbatas. LED berdaya tinggi sangat terang tetapi menghasilkan panas sehingga memerlukan heatsink.'**
  String get materiKomponenL1KomLedVideoSummary7Text;

  /// No description provided for @materiKomponenL1KomLedVideoSummary8Text.
  ///
  /// In id, this message translates to:
  /// **'LED COB menggabungkan banyak chip dalam satu modul kecil. LED RGB terdiri dari tiga warna dasar merah, hijau, dan biru yang dapat dikontrol secara independen untuk menghasilkan berbagai warna.'**
  String get materiKomponenL1KomLedVideoSummary8Text;

  /// No description provided for @materiKomponenL1KomLedVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'LED alfanumerik digunakan sebagai tampilan angka dan huruf pada berbagai alat elektronik.'**
  String get materiKomponenL1KomLedVideoSummary9Text;

  /// No description provided for @materiKomponenL1KomResistorContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Nilai resistor dibaca dari kode warna gelang. Untuk resistor di bawah 1 ohm, gelang pengali bernilai pecahan, sehingga nilai akhirnya bisa berupa desimal.'**
  String get materiKomponenL1KomResistorContent0Text;

  /// No description provided for @materiKomponenL1KomResistorContent2Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Dua gelang pertama adalah digit signifikan.\n- Gelang ketiga adalah pengali.\n- Gelang emas menandakan toleransi 5%.\n- Metode yang sama berlaku dari 1 kiloohm hingga 1 gigaohm.'**
  String get materiKomponenL1KomResistorContent2Text;

  /// No description provided for @materiKomponenL1KomResistorDescription.
  ///
  /// In id, this message translates to:
  /// **'Cara menghitung nilai resistor dengan kode warna, termasuk resistor di bawah 1 ohm menggunakan metode kedua.'**
  String get materiKomponenL1KomResistorDescription;

  /// No description provided for @materiKomponenL1KomResistorTitle.
  ///
  /// In id, this message translates to:
  /// **'Resistor (Cara Menghitung Nilai)'**
  String get materiKomponenL1KomResistorTitle;

  /// No description provided for @materiKomponenL1KomResistorVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Metode Kedua untuk Resistor'**
  String get materiKomponenL1KomResistorVideoSummary0Heading;

  /// No description provided for @materiKomponenL1KomResistorVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini membahas cara kedua menghitung nilai resistor, khususnya resistor dengan nilai di bawah 1 ohm, menggunakan tabel khusus.'**
  String get materiKomponenL1KomResistorVideoSummary1Text;

  /// No description provided for @materiKomponenL1KomResistorVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Metode ini menyediakan dua cara perhitungan, yaitu cara konvensional dan cara menggunakan bilangan berpangkat. Hasil keduanya sama.'**
  String get materiKomponenL1KomResistorVideoSummary2Text;

  /// No description provided for @materiKomponenL1KomResistorVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Contoh Perhitungan'**
  String get materiKomponenL1KomResistorVideoSummary3Heading;

  /// No description provided for @materiKomponenL1KomResistorVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Contohnya adalah resistor dengan gelang hijau, hitam, silver, dan emas. Warna hijau bernilai 5, hitam bernilai 0, dan silver sebagai pengali bernilai 0,01.'**
  String get materiKomponenL1KomResistorVideoSummary4Text;

  /// No description provided for @materiKomponenL1KomResistorVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Perhitungannya adalah 50 x 0,01 = 0,5 ohm, dengan toleransi 5% yang ditandai gelang emas.'**
  String get materiKomponenL1KomResistorVideoSummary5Text;

  /// No description provided for @materiKomponenL1KomResistorVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Cakupan Metode'**
  String get materiKomponenL1KomResistorVideoSummary6Heading;

  /// No description provided for @materiKomponenL1KomResistorVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Metode ini juga berlaku untuk semua resistor dengan rentang nilai dari 1 kiloohm sampai 1 gigaohm.'**
  String get materiKomponenL1KomResistorVideoSummary7Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Tactile switch adalah push button kecil yang memberikan sinyal on saat ditekan dan off saat dilepas. Cocok untuk input tombol pada rangkaian elektronik kecil.'**
  String get materiKomponenL1KomTactileSwitchContent0Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Sifatnya momentary (tekan untuk on, lepas untuk off).\n- Tegangan kerja DC sekitar 4,5 sampai 12 V.\n- Arus maksimum sekitar 100 mA.\n- Tidak disarankan untuk rangkaian AC.\n- Umum dipakai pada remote control dan perangkat elektronik kecil.'**
  String get materiKomponenL1KomTactileSwitchContent1Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchDescription.
  ///
  /// In id, this message translates to:
  /// **'Tactile switch adalah saklar tekan kecil yang aktif saat ditekan dan mati saat dilepas, umum dipakai pada rangkaian DC tegangan rendah.'**
  String get materiKomponenL1KomTactileSwitchDescription;

  /// No description provided for @materiKomponenL1KomTactileSwitchTitle.
  ///
  /// In id, this message translates to:
  /// **'Tactile Switch (Push Button)'**
  String get materiKomponenL1KomTactileSwitchTitle;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Pengenalan Saklar Mini Tactile'**
  String get materiKomponenL1KomTactileSwitchVideoSummary0Heading;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar mini atau tactile switch, juga dikenal sebagai micro switch, berukuran sangat kecil dan berfungsi sebagai saklar tekan (push button).'**
  String get materiKomponenL1KomTactileSwitchVideoSummary1Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar ini bekerja secara momentary: on saat ditekan dan off saat dilepas.'**
  String get materiKomponenL1KomTactileSwitchVideoSummary2Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Pin dan Prinsip Kerja'**
  String get materiKomponenL1KomTactileSwitchVideoSummary3Heading;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar ini umumnya memiliki empat pin, tetapi prinsip kerjanya sederhana dengan dua kutub. Dua pin biasanya berpasangan secara paralel sehingga stabil secara mekanis dan listrik.'**
  String get materiKomponenL1KomTactileSwitchVideoSummary4Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Terdapat variasi bentuk batang, dari panjang, pendek, hingga pipih, sesuai kebutuhan desain.'**
  String get materiKomponenL1KomTactileSwitchVideoSummary5Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Batasan dan Aplikasi'**
  String get materiKomponenL1KomTactileSwitchVideoSummary6Heading;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar digunakan pada rangkaian DC dengan tegangan sekitar 4,5 sampai 12 volt dan arus maksimum sekitar 100 mA.'**
  String get materiKomponenL1KomTactileSwitchVideoSummary7Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary8Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar ini jarang digunakan pada rangkaian AC karena alasan keselamatan dan peruntukannya untuk sirkuit DC kecil.'**
  String get materiKomponenL1KomTactileSwitchVideoSummary8Text;

  /// No description provided for @materiKomponenL1KomTactileSwitchVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar ditemukan pada remote control, TV lama, dan set-top box. Pemasangannya dilakukan pada PCB, atau breadboard untuk eksperimen.'**
  String get materiKomponenL1KomTactileSwitchVideoSummary9Text;

  /// No description provided for @materiL1L1KomBreadboardContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Breadboard adalah alat prototipe untuk merangkai rangkaian elektronik tanpa menyolder. Memahami pola koneksinya penting agar rangkaian tidak salah sambung.'**
  String get materiL1L1KomBreadboardContent0Text;

  /// No description provided for @materiL1L1KomBreadboardContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Jalur biru dan merah menandai baris yang terhubung.\n- Celah tengah memisahkan dua sisi, cocok untuk memasang IC.\n- Pin berdekatan belum tentu terhubung, periksa polanya.\n- Gunakan avometer mode continuity untuk menguji koneksi.\n- Tersedia tipe 400 dan 830 pin.'**
  String get materiL1L1KomBreadboardContent1Text;

  /// No description provided for @materiL1L1KomBreadboardDescription.
  ///
  /// In id, this message translates to:
  /// **'Breadboard adalah papan untuk merangkai komponen elektronik tanpa solder, dengan pola koneksi pin yang sudah ditentukan.'**
  String get materiL1L1KomBreadboardDescription;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Struktur Breadboard'**
  String get materiL1L1KomBreadboardVideoSummary0Heading;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Breadboard terdiri dari deretan pin yang terhubung secara internal dengan pola tertentu. Jalur berwarna biru dan merah menunjukkan baris yang saling terhubung.'**
  String get materiL1L1KomBreadboardVideoSummary1Text;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Terdapat dua tipe breadboard dengan jumlah pin berbeda, sekitar 400 pin dan 830 pin, tetapi prinsip kerjanya sama.'**
  String get materiL1L1KomBreadboardVideoSummary2Text;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Pola Koneksi dan Celah Tengah'**
  String get materiL1L1KomBreadboardVideoSummary3Heading;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Pin yang berdekatan belum tentu terhubung karena ada celah pembatas di bagian tengah. Jalur koneksi umumnya horizontal di sisi pinggir dan vertikal di bagian tengah.'**
  String get materiL1L1KomBreadboardVideoSummary4Text;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Celah tengah dimanfaatkan untuk memasang IC agar pin kiri dan kanan IC tidak saling terhubung.'**
  String get materiL1L1KomBreadboardVideoSummary5Text;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Pengujian dan Penggunaan'**
  String get materiL1L1KomBreadboardVideoSummary6Heading;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Multimeter (avometer) dengan fungsi continuity test dapat digunakan untuk memeriksa apakah pin-pin breadboard saling terhubung.'**
  String get materiL1L1KomBreadboardVideoSummary7Text;

  /// No description provided for @materiL1L1KomBreadboardVideoSummary8Text.
  ///
  /// In id, this message translates to:
  /// **'Breadboard digunakan untuk membuat prototipe rangkaian tanpa menyolder, sehingga memudahkan perubahan dan pengujian.'**
  String get materiL1L1KomBreadboardVideoSummary8Text;

  /// No description provided for @materiL1L1KomHukumOhmContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Hukum Ohm menghubungkan arus, tegangan, dan hambatan dalam rangkaian listrik. Rumus dasarnya: I = V / R.'**
  String get materiL1L1KomHukumOhmContent0Text;

  /// No description provided for @materiL1L1KomHukumOhmContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Arus berbanding lurus dengan tegangan.\n- Arus berbanding terbalik dengan hambatan.\n- Satuan: I (ampere), V (volt), R (ohm).\n- Dapat dipakai untuk menghitung salah satu nilai jika dua lainnya diketahui.'**
  String get materiL1L1KomHukumOhmContent1Text;

  /// No description provided for @materiL1L1KomHukumOhmDescription.
  ///
  /// In id, this message translates to:
  /// **'Hukum Ohm menjelaskan hubungan antara arus, tegangan, dan hambatan dalam rangkaian listrik, dengan rumus I = V / R.'**
  String get materiL1L1KomHukumOhmDescription;

  /// No description provided for @materiL1L1KomHukumOhmVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Pengertian Hukum Ohm'**
  String get materiL1L1KomHukumOhmVideoSummary0Heading;

  /// No description provided for @materiL1L1KomHukumOhmVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Hukum Ohm adalah prinsip dasar elektronika yang menjelaskan hubungan antara arus listrik (I), tegangan (V), dan hambatan (R) dalam suatu rangkaian.'**
  String get materiL1L1KomHukumOhmVideoSummary1Text;

  /// No description provided for @materiL1L1KomHukumOhmVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Arus yang mengalir melalui konduktor berbanding lurus dengan tegangan yang diberikan dan berbanding terbalik dengan hambatannya.'**
  String get materiL1L1KomHukumOhmVideoSummary2Text;

  /// No description provided for @materiL1L1KomHukumOhmVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Rumus Hukum Ohm'**
  String get materiL1L1KomHukumOhmVideoSummary3Heading;

  /// No description provided for @materiL1L1KomHukumOhmVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Rumusnya adalah I = V / R, dengan I dalam ampere, V dalam volt, dan R dalam ohm.'**
  String get materiL1L1KomHukumOhmVideoSummary4Text;

  /// No description provided for @materiL1L1KomHukumOhmVideoSummary6Text.
  ///
  /// In id, this message translates to:
  /// **'Contoh pertama adalah menghitung arus yang mengalir melalui sebuah lampu dengan hambatan dan tegangan tertentu.'**
  String get materiL1L1KomHukumOhmVideoSummary6Text;

  /// No description provided for @materiL1L1KomHukumOhmVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Contoh kedua adalah menghitung tegangan yang dibutuhkan untuk menghasilkan arus tertentu pada hambatan tertentu.'**
  String get materiL1L1KomHukumOhmVideoSummary7Text;

  /// No description provided for @materiL1L1KomKapasitorContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor menyimpan dan melepaskan energi listrik. Fungsinya antara lain menjaga kestabilan tegangan, menyaring sinyal, dan penyetelan frekuensi.'**
  String get materiL1L1KomKapasitorContent0Text;

  /// No description provided for @materiL1L1KomKapasitorContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Struktur: dua pelat logam dengan bahan dielektrik di antaranya.\n- Jenis keramik untuk kapasitansi kecil dan frekuensi tinggi.\n- Jenis poliester untuk audio.\n- Elco dan solid capacitor berpolaritas, pasang sesuai kaki positif dan negatif.\n- Variable capacitor untuk penyetelan frekuensi radio.\n- Rentang nilai dari pF hingga F.'**
  String get materiL1L1KomKapasitorContent1Text;

  /// No description provided for @materiL1L1KomKapasitorDescription.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor adalah komponen yang menyimpan dan melepaskan energi listrik dengan cepat, dengan jenis yang ditentukan oleh bahan dielektriknya.'**
  String get materiL1L1KomKapasitorDescription;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Pengertian Kapasitor'**
  String get materiL1L1KomKapasitorVideoSummary0Heading;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary10Text.
  ///
  /// In id, this message translates to:
  /// **'Pemasangan kapasitor berpolaritas dengan terbalik dapat menyebabkan kerusakan, bahkan ledakan.'**
  String get materiL1L1KomKapasitorVideoSummary10Text;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor adalah komponen elektronik yang mampu menyimpan dan melepas energi listrik secara cepat. Komponen ini terdiri dari dua pelat logam yang dipisahkan oleh bahan dielektrik yang tidak menghantarkan listrik.'**
  String get materiL1L1KomKapasitorVideoSummary1Text;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Bahan dielektrik menentukan jenis kapasitor, misalnya keramik, kertas, atau poliester.'**
  String get materiL1L1KomKapasitorVideoSummary2Text;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Jenis-Jenis Kapasitor'**
  String get materiL1L1KomKapasitorVideoSummary3Heading;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor keramik umum ditemui, berkapasitansi kecil, dan sering dipakai untuk frekuensi tinggi. Kapasitor poliester banyak dipakai pada aplikasi audio.'**
  String get materiL1L1KomKapasitorVideoSummary4Text;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitor elektrolitik (Elco) dan solid capacitor memiliki kapasitansi besar dan berpolaritas, sehingga harus dipasang dengan benar. Solid capacitor lebih tahan panas dan awet, banyak dipakai di motherboard komputer.'**
  String get materiL1L1KomKapasitorVideoSummary5Text;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary6Text.
  ///
  /// In id, this message translates to:
  /// **'Variable capacitor dapat diatur nilainya secara mekanis dan sering dipakai untuk penyetelan frekuensi pada radio.'**
  String get materiL1L1KomKapasitorVideoSummary6Text;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Superkapasitor memiliki kapasitansi hingga ratusan farad dan berpotensi menggantikan baterai pada beberapa aplikasi.'**
  String get materiL1L1KomKapasitorVideoSummary7Text;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary8Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Rentang Kapasitansi dan Keselamatan'**
  String get materiL1L1KomKapasitorVideoSummary8Heading;

  /// No description provided for @materiL1L1KomKapasitorVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'Kapasitansi kapasitor bervariasi dari beberapa pikofarad (pF) hingga ratusan farad (F).'**
  String get materiL1L1KomKapasitorVideoSummary9Text;

  /// No description provided for @materiL1L1KomLedContent0Text.
  ///
  /// In id, this message translates to:
  /// **'LED (Light Emitting Diode) adalah dioda yang memancarkan cahaya. Berbeda dengan lampu pijar, LED menghasilkan cahaya melalui rekombinasi elektron dan lubang muatan di dalam semikonduktor, sehingga lebih efisien dan lebih tahan lama.'**
  String get materiL1L1KomLedContent0Text;

  /// No description provided for @materiL1L1KomLedContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Warna LED ditentukan oleh bahan semikonduktor.\n- Tegangan maju (Vf) berbeda untuk setiap warna.\n- Sudut pancaran dan intensitas cahaya dapat dipilih sesuai kebutuhan.\n- Kaki LED memiliki polaritas, dan kaki panjang umumnya adalah anoda.'**
  String get materiL1L1KomLedContent1Text;

  /// No description provided for @materiL1L1KomLedContent2Text.
  ///
  /// In id, this message translates to:
  /// **'Jenis LED: through-hole (umum, 5 mm), SMD (kecil dan tipis), berdaya tinggi (perlu pendingin), COB (banyak chip dalam satu modul), RGB (multi-warna), dan alfanumerik (display angka dan huruf).'**
  String get materiL1L1KomLedContent2Text;

  /// No description provided for @materiL1L1KomLedDescription.
  ///
  /// In id, this message translates to:
  /// **'LED adalah dioda yang memancarkan cahaya saat dialiri listrik, dengan warna dan tegangan kerja yang ditentukan oleh bahan semikonduktornya.'**
  String get materiL1L1KomLedDescription;

  /// No description provided for @materiL1L1KomLedVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'LED bukan lampu biasa seperti lampu pijar, melainkan jenis dioda yang memancarkan cahaya ketika dialiri listrik. LED terbuat dari bahan semikonduktor tipe P dan tipe N, dan cahaya dihasilkan saat elektron dan lubang muatan bertemu.'**
  String get materiL1L1KomLedVideoSummary1Text;

  /// No description provided for @materiL1L1KomLedVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Warna, Tegangan, dan Karakteristik'**
  String get materiL1L1KomLedVideoSummary2Heading;

  /// No description provided for @materiL1L1KomLedVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'Warna cahaya LED ditentukan oleh bahan pembuatnya, yang juga menentukan panjang gelombang dan tegangan kerja. Contohnya, LED biru biasanya membutuhkan tegangan maju lebih tinggi dibanding LED merah.'**
  String get materiL1L1KomLedVideoSummary3Text;

  /// No description provided for @materiL1L1KomLedVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Karakteristik lain yang perlu diperhatikan adalah sudut pancaran cahaya (sekitar 10° sampai 120°) dan intensitas cahaya yang diukur dalam millicandela.'**
  String get materiL1L1KomLedVideoSummary4Text;

  /// No description provided for @materiL1L1KomLedVideoSummary6Text.
  ///
  /// In id, this message translates to:
  /// **'LED through-hole adalah tipe yang umum dengan ukuran paling sering 5 mm, mudah dipasang, dan polaritasnya mudah dikenali dari panjang kaki.'**
  String get materiL1L1KomLedVideoSummary6Text;

  /// No description provided for @materiL1L1KomLedVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'LED SMD berukuran sangat kecil dan tipis, cocok untuk pemasangan massal pada ruang terbatas. LED berdaya tinggi sangat terang tetapi menghasilkan panas sehingga memerlukan heatsink.'**
  String get materiL1L1KomLedVideoSummary7Text;

  /// No description provided for @materiL1L1KomLedVideoSummary8Text.
  ///
  /// In id, this message translates to:
  /// **'LED COB menggabungkan banyak chip dalam satu modul kecil. LED RGB terdiri dari tiga warna dasar merah, hijau, dan biru yang dapat dikontrol secara independen untuk menghasilkan berbagai warna.'**
  String get materiL1L1KomLedVideoSummary8Text;

  /// No description provided for @materiL1L1KomLedVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'LED alfanumerik digunakan sebagai tampilan angka dan huruf pada berbagai alat elektronik.'**
  String get materiL1L1KomLedVideoSummary9Text;

  /// No description provided for @materiL1L1KomResistorContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Nilai resistor dibaca dari kode warna gelang. Untuk resistor di bawah 1 ohm, gelang pengali bernilai pecahan, sehingga nilai akhirnya bisa berupa desimal.'**
  String get materiL1L1KomResistorContent0Text;

  /// No description provided for @materiL1L1KomResistorContent2Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Dua gelang pertama adalah digit signifikan.\n- Gelang ketiga adalah pengali.\n- Gelang emas menandakan toleransi 5%.\n- Metode yang sama berlaku dari 1 kiloohm hingga 1 gigaohm.'**
  String get materiL1L1KomResistorContent2Text;

  /// No description provided for @materiL1L1KomResistorDescription.
  ///
  /// In id, this message translates to:
  /// **'Cara menghitung nilai resistor dengan kode warna, termasuk resistor di bawah 1 ohm menggunakan metode kedua.'**
  String get materiL1L1KomResistorDescription;

  /// No description provided for @materiL1L1KomResistorVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Metode Kedua untuk Resistor'**
  String get materiL1L1KomResistorVideoSummary0Heading;

  /// No description provided for @materiL1L1KomResistorVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini membahas cara kedua menghitung nilai resistor, khususnya resistor dengan nilai di bawah 1 ohm, menggunakan tabel khusus.'**
  String get materiL1L1KomResistorVideoSummary1Text;

  /// No description provided for @materiL1L1KomResistorVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Metode ini menyediakan dua cara perhitungan, yaitu cara konvensional dan cara menggunakan bilangan berpangkat. Hasil keduanya sama.'**
  String get materiL1L1KomResistorVideoSummary2Text;

  /// No description provided for @materiL1L1KomResistorVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Contoh Perhitungan'**
  String get materiL1L1KomResistorVideoSummary3Heading;

  /// No description provided for @materiL1L1KomResistorVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Contohnya adalah resistor dengan gelang hijau, hitam, silver, dan emas. Warna hijau bernilai 5, hitam bernilai 0, dan silver sebagai pengali bernilai 0,01.'**
  String get materiL1L1KomResistorVideoSummary4Text;

  /// No description provided for @materiL1L1KomResistorVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Perhitungannya adalah 50 x 0,01 = 0,5 ohm, dengan toleransi 5% yang ditandai gelang emas.'**
  String get materiL1L1KomResistorVideoSummary5Text;

  /// No description provided for @materiL1L1KomResistorVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Cakupan Metode'**
  String get materiL1L1KomResistorVideoSummary6Heading;

  /// No description provided for @materiL1L1KomResistorVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Metode ini juga berlaku untuk semua resistor dengan rentang nilai dari 1 kiloohm sampai 1 gigaohm.'**
  String get materiL1L1KomResistorVideoSummary7Text;

  /// No description provided for @materiL1L1KomTactileSwitchContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Tactile switch adalah push button kecil yang memberikan sinyal on saat ditekan dan off saat dilepas. Cocok untuk input tombol pada rangkaian elektronik kecil.'**
  String get materiL1L1KomTactileSwitchContent0Text;

  /// No description provided for @materiL1L1KomTactileSwitchContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n- Sifatnya momentary (tekan untuk on, lepas untuk off).\n- Tegangan kerja DC sekitar 4,5 sampai 12 V.\n- Arus maksimum sekitar 100 mA.\n- Tidak disarankan untuk rangkaian AC.\n- Umum dipakai pada remote control dan perangkat elektronik kecil.'**
  String get materiL1L1KomTactileSwitchContent1Text;

  /// No description provided for @materiL1L1KomTactileSwitchDescription.
  ///
  /// In id, this message translates to:
  /// **'Tactile switch adalah saklar tekan kecil yang aktif saat ditekan dan mati saat dilepas, umum dipakai pada rangkaian DC tegangan rendah.'**
  String get materiL1L1KomTactileSwitchDescription;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 1: Pengenalan Saklar Mini Tactile'**
  String get materiL1L1KomTactileSwitchVideoSummary0Heading;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar mini atau tactile switch, juga dikenal sebagai micro switch, berukuran sangat kecil dan berfungsi sebagai saklar tekan (push button).'**
  String get materiL1L1KomTactileSwitchVideoSummary1Text;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary2Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar ini bekerja secara momentary: on saat ditekan dan off saat dilepas.'**
  String get materiL1L1KomTactileSwitchVideoSummary2Text;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary3Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 2: Pin dan Prinsip Kerja'**
  String get materiL1L1KomTactileSwitchVideoSummary3Heading;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary4Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar ini umumnya memiliki empat pin, tetapi prinsip kerjanya sederhana dengan dua kutub. Dua pin biasanya berpasangan secara paralel sehingga stabil secara mekanis dan listrik.'**
  String get materiL1L1KomTactileSwitchVideoSummary4Text;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Terdapat variasi bentuk batang, dari panjang, pendek, hingga pipih, sesuai kebutuhan desain.'**
  String get materiL1L1KomTactileSwitchVideoSummary5Text;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Bab 3: Batasan dan Aplikasi'**
  String get materiL1L1KomTactileSwitchVideoSummary6Heading;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar digunakan pada rangkaian DC dengan tegangan sekitar 4,5 sampai 12 volt dan arus maksimum sekitar 100 mA.'**
  String get materiL1L1KomTactileSwitchVideoSummary7Text;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary8Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar ini jarang digunakan pada rangkaian AC karena alasan keselamatan dan peruntukannya untuk sirkuit DC kecil.'**
  String get materiL1L1KomTactileSwitchVideoSummary8Text;

  /// No description provided for @materiL1L1KomTactileSwitchVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'Saklar ditemukan pada remote control, TV lama, dan set-top box. Pemasangannya dilakukan pada PCB, atau breadboard untuk eksperimen.'**
  String get materiL1L1KomTactileSwitchVideoSummary9Text;

  /// No description provided for @materiL1L1KomponenFolderDescription.
  ///
  /// In id, this message translates to:
  /// **'Pelajari komponen-komponen dasar elektronika beserta fungsi dan karakteristiknya.'**
  String get materiL1L1KomponenFolderDescription;

  /// No description provided for @materiL1L1PosttestDescription.
  ///
  /// In id, this message translates to:
  /// **'Uji pemahamanmu setelah belajar.'**
  String get materiL1L1PosttestDescription;

  /// No description provided for @materiL1L1PosttestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Hasil hitung resistor LED adalah 150 Ω. Nilai standar aman yang dipilih pada modul adalah...'**
  String get materiL1L1PosttestQQ2Question;

  /// No description provided for @materiL1L1PosttestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Arus LED 2 V dengan resistor 220 Ω pada catu 5 V adalah sekitar...'**
  String get materiL1L1PosttestQQ3Question;

  /// No description provided for @materiL1L1PosttestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Batas arus yang aman per pin Arduino Uno adalah sekitar...'**
  String get materiL1L1PosttestQQ4Question;

  /// No description provided for @materiL1L1PosttestQQ5Question.
  ///
  /// In id, this message translates to:
  /// **'Pada praktikum LED eksternal, resistor dan LED dihubungkan ke pin...'**
  String get materiL1L1PosttestQQ5Question;

  /// No description provided for @materiL1L1PretestDescription.
  ///
  /// In id, this message translates to:
  /// **'Ukur pengetahuan awalmu tentang dasar elektronika.'**
  String get materiL1L1PretestDescription;

  /// No description provided for @materiL1L1PretestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Besaran yang mendorong muatan listrik mengalir disebut...'**
  String get materiL1L1PretestQQ1Question;

  /// No description provided for @materiL1L1PretestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Satuan hambatan listrik adalah...'**
  String get materiL1L1PretestQQ2Question;

  /// No description provided for @materiL1L1PretestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Pada LED, kaki yang lebih panjang adalah...'**
  String get materiL1L1PretestQQ3Question;

  /// No description provided for @materiL1L1PretestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Chip mikrokontroler yang digunakan Arduino Uno adalah...'**
  String get materiL1L1PretestQQ4Question;

  /// No description provided for @materiL2L2ArrayPointerContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Array menyimpan banyak nilai dalam satu variabel; array multidimensi seperti tabel baris dan kolom.\n• Indeks array dimulai dari 0, jadi tambahkan 1 saat menampilkan nomor agar mudah dibaca.\n• Batasi indeks agar tidak melewati ukuran array.\n• Gunakan fungsi terpisah untuk mengisi data dan mencari nilai tertentu.'**
  String get materiL2L2ArrayPointerContent0Text;

  /// No description provided for @materiL2L2ArrayPointerContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Cara mencari nilai terendah:\n1. Mulai dari nilai awal yang besar (contoh 100).\n2. Bandingkan setiap elemen array dengan nilai tersebut.\n3. Jika ada elemen yang lebih kecil, ganti nilai terendah.\n4. Setelah semua elemen diperiksa, nilai yang tersisa adalah yang terendah.'**
  String get materiL2L2ArrayPointerContent1Text;

  /// No description provided for @materiL2L2ArrayPointerDescription.
  ///
  /// In id, this message translates to:
  /// **'Mengelola data berbentuk tabel dengan array satu dimensi dan multidimensi, lengkap dengan fungsi dan pembatasan indeks.'**
  String get materiL2L2ArrayPointerDescription;

  /// No description provided for @materiL2L2ArrayPointerVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini melanjutkan seri belajar Arduino dengan fokus pada array satu dimensi dan multidimensi. Array multidimensi dijelaskan sebagai data tabel seperti di Excel, misalnya nilai beberapa siswa pada beberapa mata pelajaran. Program mengisi nilai ke dalam array, lalu mencari nilai matematika terendah, nilai IPA tertinggi, dan nilai rata-rata tertinggi. Serial monitor dipakai untuk memantau nilai dan proses perhitungan langkah demi langkah.'**
  String get materiL2L2ArrayPointerVideoSummary1Text;

  /// No description provided for @materiL2L2ArrayPointerVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• Array multidimensi untuk merepresentasikan data tabel seperti nilai siswa.\n• Pengisian data nilai siswa ke dalam array multidimensi.\n• Fungsi khusus untuk mencari nilai terendah, tertinggi, dan rata-rata tertinggi.\n• Pembatasan indeks array agar tidak terjadi error saat indeks melebihi batas data.\n• Serial monitor untuk debugging dan memantau perhitungan secara real-time.\n• Variabel, fungsi, dan array digabung dalam satu program yang relatif lengkap.'**
  String get materiL2L2ArrayPointerVideoSummary3Text;

  /// No description provided for @materiL2L2ArrayPointerVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• Array multidimensi memudahkan pengelolaan data kompleks, terutama saat satu operasi melibatkan banyak data sekaligus.\n• Fungsi membuat kode modular: misalnya satu fungsi untuk mengisi nilai dan satu fungsi untuk mencari nilai terendah, sehingga kode lebih rapi dan mudah di-debug.\n• Pembatasan indeks krusial: array punya batas indeks tetap, jadi program harus memeriksa indeks agar tidak melebihi jumlah data dan menghindari error runtime.\n• Serial monitor menampilkan nilai dan hasil hitung berurutan, sehingga logika program mudah dipahami langkah demi langkah.\n• Penomoran ramah pengguna: menambah 1 pada indeks membuat nomor siswa dimulai dari 1, bukan 0.\n• Mencari nilai minimum atau maksimum: tentukan nilai awal (misalnya 100 untuk nilai terendah), bandingkan satu per satu, dan perbarui nilainya sampai ditemukan hasil yang dicari.'**
  String get materiL2L2ArrayPointerVideoSummary5Text;

  /// No description provided for @materiL2L2InputOutputContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Rangkaian:\n• Empat LED di pin digital 9 sampai 12.\n• Push button di pin analog 4.'**
  String get materiL2L2InputOutputContent0Text;

  /// No description provided for @materiL2L2InputOutputContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Simpan pin LED dalam array konstan, lalu atur semuanya sebagai output dengan perulangan for.\n• Pin push button diatur sebagai input dan dibaca dengan digitalRead().\n• Setiap tekanan menambah penghitung x; switch case memilih LED yang menyala sesuai nilai x.\n• Saat x mencapai 4, reset ke 0 agar urutan kembali ke LED pertama.\n• Delay 300 ms mencegah pembacaan ganda akibat bouncing.'**
  String get materiL2L2InputOutputContent1Text;

  /// No description provided for @materiL2L2InputOutputDescription.
  ///
  /// In id, this message translates to:
  /// **'Mengontrol empat LED secara bergantian dengan satu push button memakai array, perulangan for, dan switch case.'**
  String get materiL2L2InputOutputDescription;

  /// No description provided for @materiL2L2InputOutputVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini menjawab pertanyaan: bisakah satu push button mengontrol beberapa LED secara bergantian? Empat LED dipasang di pin digital 9 sampai 12, dan push button di pin analog 4. Pin LED disimpan dalam array konstan dan diinisialisasi dengan perulangan for. Setiap kali tombol ditekan, variabel penghitung x bertambah satu, dan nilai x menentukan LED mana yang menyala lewat switch case. Setelah LED keempat, x kembali ke 0 sehingga urutan berulang.'**
  String get materiL2L2InputOutputVideoSummary1Text;

  /// No description provided for @materiL2L2InputOutputVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• Satu push button dapat mengontrol empat LED secara bergantian.\n• Array pin LED membuat kode rapi dan mudah ditambah.\n• Perulangan for dan switch case mengatur LED yang aktif.\n• Pin tombol harus diatur sebagai input dengan pinMode() dan dibaca dengan digitalRead().\n• Penghitung x di-reset ke 0 saat mencapai 4 agar siklus berulang.\n• Jeda 300 ms mencegah pembacaan ganda akibat bouncing tombol.'**
  String get materiL2L2InputOutputVideoSummary3Text;

  /// No description provided for @materiL2L2InputOutputVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• Array konstan untuk pin LED membuat program skalabel: menambah LED tidak perlu banyak mengubah kode.\n• Perulangan for dan switch case menghemat kode dan menghindari if-else yang rumit; nilai x langsung menentukan LED aktif.\n• Pin Arduino harus diset sebagai input secara eksplisit dengan pinMode(), lalu status tombol dibaca dengan digitalRead().\n• Mereset penghitung saat mencapai 4 adalah contoh sederhana pengendalian state yang berulang (siklik) dan sering dipakai di sistem embedded.\n• Delay 300 ms setelah pembacaan tombol meredam bouncing sehingga satu tekanan tidak terbaca berkali-kali.'**
  String get materiL2L2InputOutputVideoSummary5Text;

  /// No description provided for @materiL2L2InputOutputVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'1. Inisialisasi array pin LED: LED[0] = 12, LED[1] = 11, LED[2] = 10, LED[3] = 9.\n2. Atur pin push button sebagai input.\n3. Baca status push button dengan digitalRead().\n4. Jika tombol ditekan (status == 1), tambahkan x = x + 1.\n5. Gunakan switch case pada x: 0 menyalakan LED 1, 1 menyalakan LED 2, 2 menyalakan LED 3, 3 menyalakan LED 4 (LED lain mati), dan 4 mereset x menjadi 0.\n6. Beri delay 300 ms sebelum membaca input lagi.\n7. Ulangi dari langkah 3.'**
  String get materiL2L2InputOutputVideoSummary7Text;

  /// No description provided for @materiL2L2OperatorPercabanganContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Fungsi yang dipakai: setup(), loop(), digitalWrite(), delay(), dan digitalRead().\n• LED harus dipasang dengan resistor (contoh 220 ohm) agar arus aman.\n• Push button dibaca dengan digitalRead(); hasilnya diproses dengan if-else.\n• Contoh logika: jika tombol ditekan, kedipkan LED lebih cepat; jika tidak, kembali ke kecepatan normal.\n• Serial monitor membantu memantau status tombol saat debugging.'**
  String get materiL2L2OperatorPercabanganContent0Text;

  /// No description provided for @materiL2L2OperatorPercabanganContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Alur praktik:\n1. Kedipkan LED bawaan Arduino.\n2. Pindahkan ke LED eksternal di breadboard.\n3. Tambahkan LED kedua agar berkedip bergantian.\n4. Tambahkan push button untuk mengubah kecepatan kedip.'**
  String get materiL2L2OperatorPercabanganContent1Text;

  /// No description provided for @materiL2L2OperatorPercabanganDescription.
  ///
  /// In id, this message translates to:
  /// **'Praktik membuat LED berkedip dan mengubah kecepatan kedipnya dengan push button memakai digitalRead() dan if-else.'**
  String get materiL2L2OperatorPercabanganDescription;

  /// No description provided for @materiL2L2OperatorPercabanganTitle.
  ///
  /// In id, this message translates to:
  /// **'Operator & Percabangan (Simulasi LED)'**
  String get materiL2L2OperatorPercabanganTitle;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Tutorial pengantar untuk pemula yang belajar Arduino dari nol. Video memakai Arduino Uno R3, breadboard, LED, resistor, dan push button. Alurnya: instalasi Arduino IDE, memasang komponen, membuat program LED berkedip, lalu membuat mode kecepatan kedip yang diubah dengan push button. Video juga menekankan kesabaran, eksplorasi mandiri, dan belajar bersama komunitas.'**
  String get materiL2L2OperatorPercabanganVideoSummary1Text;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Sorotan Utama'**
  String get materiL2L2OperatorPercabanganVideoSummary2Heading;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• Panduan memulai Arduino dari nol tanpa asumsi pengetahuan teknis.\n• Komponen yang dibahas: Arduino Uno R3, breadboard, LED, resistor, kabel jumper, dan push button.\n• Instalasi dan penggunaan Arduino IDE untuk pemrograman dasar LED.\n• Rangkaian LED sederhana yang berkedip dengan interval yang bisa diubah.\n• Dua LED berkedip bergantian pada breadboard.\n• Push button dipakai untuk mengubah kecepatan kedip LED secara interaktif.'**
  String get materiL2L2OperatorPercabanganVideoSummary3Text;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Kunci'**
  String get materiL2L2OperatorPercabanganVideoSummary4Heading;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• Arduino sebagai otak rangkaian: program yang di-upload mengatur cara kerja komponen elektronik. Banyaknya pin I/O memudahkan sambungan ke sensor dan modul lain.\n• Breadboard: memudahkan merangkai tanpa solder. Jalur positif (garis merah) dan negatif (garis biru) serta jalur horizontal perlu dipahami agar tidak salah menyusun rangkaian.\n• Resistor: menghambat arus agar LED tidak rusak karena kelebihan arus. Resistor 220 ohm menjadi contoh paling dasar.\n• Arduino IDE dan bahasa Arduino (mirip C/C++): setup() untuk inisialisasi sekali, loop() untuk perintah berulang, serta digitalWrite() dan delay() untuk mengatur pin dan waktu.\n• Push button sebagai input: digitalRead() membaca status tombol, lalu if-else mengubah kecepatan kedip LED. Serial monitor dipakai untuk memantau status tombol (debugging).\n• Praktik langsung: unggah program, lalu coba modifikasi seperti mengubah nilai delay agar pemahaman lebih dalam.'**
  String get materiL2L2OperatorPercabanganVideoSummary5Text;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Langkah-langkah Penting'**
  String get materiL2L2OperatorPercabanganVideoSummary6Heading;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'1. Siapkan peralatan dan komponen sesuai daftar.\n2. Pahami fungsi breadboard dan aturan jalur listriknya (merah positif, biru negatif).\n3. Pasang Arduino IDE versi terbaru dan sambungkan Arduino ke PC dengan kabel USB.\n4. Buat program pertama: LED bawaan Arduino berkedip dengan delay yang bisa diatur.\n5. Pasang LED di breadboard dengan resistor dan sambungkan ke pin digital Arduino.\n6. Ubah program agar mengendalikan LED eksternal pada pin yang sesuai, lalu uji.\n7. Tambahkan LED kedua untuk kedip bergantian.\n8. Pasang push button di breadboard dan sambungkan ke pin digital sebagai input.\n9. Program kecepatan kedip agar berubah saat tombol ditekan memakai digitalRead() dan if-else.\n10. Gunakan serial monitor untuk memantau status tombol.'**
  String get materiL2L2OperatorPercabanganVideoSummary7Text;

  /// No description provided for @materiL2L2OperatorPercabanganVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'Dengan biaya sekitar 100 ribu rupiah, siapa pun bisa mulai belajar Arduino. Pesan pembuat video: jangan cepat menyerah, terus bereksplorasi, dan berbagi di komunitas.'**
  String get materiL2L2OperatorPercabanganVideoSummary9Text;

  /// No description provided for @materiL2L2PosttestDescription.
  ///
  /// In id, this message translates to:
  /// **'Uji pemahamanmu setelah belajar.'**
  String get materiL2L2PosttestDescription;

  /// No description provided for @materiL2L2PosttestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Fungsi loop() pada sketch Arduino dijalankan...'**
  String get materiL2L2PosttestQQ1Question;

  /// No description provided for @materiL2L2PosttestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Terminal relay yang terhubung ke COM hanya saat relay aktif (ON) adalah...'**
  String get materiL2L2PosttestQQ3Question;

  /// No description provided for @materiL2L2PosttestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Perintah untuk membaca status tombol pada pin digital adalah...'**
  String get materiL2L2PosttestQQ4Question;

  /// No description provided for @materiL2L2PosttestQQ5Question.
  ///
  /// In id, this message translates to:
  /// **'Cara menulis komentar satu baris pada kode Arduino adalah menggunakan...'**
  String get materiL2L2PosttestQQ5Question;

  /// No description provided for @materiL2L2PretestDescription.
  ///
  /// In id, this message translates to:
  /// **'Ukur pengetahuan awalmu tentang pemrograman Arduino.'**
  String get materiL2L2PretestDescription;

  /// No description provided for @materiL2L2PretestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Fungsi setup() pada sketch Arduino dijalankan...'**
  String get materiL2L2PretestQQ1Question;

  /// No description provided for @materiL2L2PretestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Tipe data untuk bilangan desimal adalah...'**
  String get materiL2L2PretestQQ2Question;

  /// No description provided for @materiL2L2PretestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Dua keadaan pin digital adalah...'**
  String get materiL2L2PretestQQ3Question;

  /// No description provided for @materiL2L2PretestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Indeks elemen pertama sebuah array adalah...'**
  String get materiL2L2PretestQQ4Question;

  /// No description provided for @materiL2L2RelayContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Pin relay:\n• COM (Common): terminal bersama.\n• NO (Normally Open): terhubung ke COM hanya saat relay ON.\n• NC (Normally Close): terhubung ke COM saat relay OFF.'**
  String get materiL2L2RelayContent0Text;

  /// No description provided for @materiL2L2RelayContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Relay memisahkan sisi kontrol (5V Arduino) dari sisi beban.\n• Kendalikan relay dengan pinMode(pin, OUTPUT) dan digitalWrite() HIGH atau LOW.\n• Atur siklus ON/OFF dengan delay, misalnya ON 5 detik lalu OFF 1 detik.\n• Menukar sambungan NO dan NC membalik pola hidup-mati beban.\n• Kemampuan relay pada video: AC hingga 250 volt, arus maksimal 10-15 ampere.'**
  String get materiL2L2RelayContent1Text;

  /// No description provided for @materiL2L2RelayDescription.
  ///
  /// In id, this message translates to:
  /// **'Cara kerja relay 5V DC, fungsi pin COM, NO, dan NC, serta cara memprogramnya dengan Arduino.'**
  String get materiL2L2RelayDescription;

  /// No description provided for @materiL2L2RelayVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini menjelaskan relay 5 volt DC dengan tiga pin utama: COM (Common), NO (Normally Open), dan NC (Normally Close). Relay bekerja sebagai saklar elektromagnetik yang menyambung atau memutus koneksi antar pin sesuai kondisi ON/OFF. Pembahasan mencakup fungsi tiap pin, pengkabelan relay dengan Arduino Nano, pemrograman sederhana lewat pin digital dengan interval waktu tertentu, dan demo pengendalian kipas DC 12 volt memakai pin NO dan NC. Relay ini juga dapat dipakai pada tegangan AC hingga 250 volt dengan arus maksimal 10-15 ampere.'**
  String get materiL2L2RelayVideoSummary1Text;

  /// No description provided for @materiL2L2RelayVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• Fungsi pin COM, NO, dan NC pada relay 5V DC.\n• Relay dihubungkan ke Arduino Nano lewat pin digital dan ground.\n• Pemrograman dasar relay tidak membutuhkan library khusus.\n• Waktu hidup-mati relay diatur dengan delay.\n• Demo kipas DC 12 volt, termasuk perbedaan kerja relay saat memakai NO dan NC.\n• Relay dapat mengendalikan beban AC hingga 250 volt dan maksimal 10-15 ampere.'**
  String get materiL2L2RelayVideoSummary3Text;

  /// No description provided for @materiL2L2RelayVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• NO dan NC: NO hanya terhubung dengan COM saat relay aktif (ON), sedangkan NC terhubung saat relay OFF. Dengan demikian ada dua skenario kendali beban tanpa mengubah rangkaian lain.\n• Relay sebagai saklar elektromagnetik: tegangan rendah (5V dari Arduino) dapat mengendalikan beban bertegangan tinggi atau arus besar karena sisi kontrol dan sisi beban terpisah.\n• Tanpa library khusus: cukup atur pin digital sebagai output lalu beri sinyal HIGH atau LOW.\n• Pengaturan waktu dengan delay: misalnya kipas menyala 5 detik, mati 1 detik, lalu berulang.\n• Menukar sambungan dari NO ke NC akan membalik pola hidup-mati perangkat tanpa mengubah kode.\n• Relay ini cocok untuk peralatan rumah tangga seperti lampu, kipas angin, atau mesin dengan tegangan AC standar.'**
  String get materiL2L2RelayVideoSummary5Text;

  /// No description provided for @materiL2L2StrukturSketchContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• setup(): berjalan sekali saat Arduino menyala, dipakai untuk inisialisasi.\n• loop(): berjalan berulang selama Arduino menyala.\n• Variabel: tanpa spasi, tidak diawali angka.\n• Tipe data umum: boolean, byte, char, int, unsigned int, long, unsigned long, float, double, String.\n• Komentar: // untuk satu baris, /* ... */ untuk blok.'**
  String get materiL2L2StrukturSketchContent0Text;

  /// No description provided for @materiL2L2StrukturSketchDescription.
  ///
  /// In id, this message translates to:
  /// **'Mengenal fungsi setup() dan loop(), aturan penulisan variabel, tipe data umum, dan komentar pada program Arduino.'**
  String get materiL2L2StrukturSketchDescription;

  /// No description provided for @materiL2L2StrukturSketchTitle.
  ///
  /// In id, this message translates to:
  /// **'Struktur Sketch, Variabel & Tipe Data'**
  String get materiL2L2StrukturSketchTitle;

  /// No description provided for @materiL2L2StrukturSketchVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini membahas dasar pemrograman Arduino: struktur program, penulisan variabel, tipe data yang umum dipakai, dan cara menulis komentar. Fungsi setup() berjalan sekali saat program dijalankan, sedangkan loop() berjalan berulang selama alat menyala. Tipe data dipilih sesuai kebutuhan penyimpanan angka, karakter, hingga kalimat. Di akhir dijelaskan dua bentuk komentar: satu baris dengan // dan blok dengan /* ... */.'**
  String get materiL2L2StrukturSketchVideoSummary1Text;

  /// No description provided for @materiL2L2StrukturSketchVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• setup() dan loop() adalah fungsi wajib dalam semua program Arduino.\n• Nama variabel tidak boleh mengandung spasi dan tidak boleh diawali angka.\n• int, long, dan versi unsigned-nya menyimpan bilangan bulat dengan rentang memori berbeda.\n• char dan String menyimpan karakter dan kalimat; boolean menyimpan true/false.\n• Komentar menjelaskan kode tanpa memengaruhi eksekusi program.'**
  String get materiL2L2StrukturSketchVideoSummary3Text;

  /// No description provided for @materiL2L2StrukturSketchVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• Setup dan loop: setup() bekerja sekali di awal untuk inisialisasi, sedangkan loop() mengulang perintah terus-menerus sehingga Arduino berjalan tanpa henti.\n• Aturan penamaan variabel: tanpa spasi dan tidak diawali angka agar kode bebas error dan mudah dibaca. Underscore atau gabungan kata tanpa spasi membantu keterbacaan.\n• Pilihan tipe data: byte untuk angka kecil tanpa tanda, int dan long untuk bilangan bulat yang lebih besar, float dan double untuk bilangan pecahan. Pilih sesuai kebutuhan agar memori efisien dan data akurat.\n• Boolean: hanya bernilai true atau false, cocok untuk kondisi logika seperti sensor digital yang hanya punya dua keadaan.\n• Komentar satu baris (//) cocok untuk penjelasan singkat, sedangkan komentar blok (/* ... */) cocok untuk catatan panjang atau menonaktifkan banyak baris kode sekaligus.'**
  String get materiL2L2StrukturSketchVideoSummary5Text;

  /// No description provided for @materiL2L2StrukturSketchVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini adalah pertemuan pertama dari seri belajar Arduino. Memahami struktur dasar, tipe data, dan komentar adalah fondasi sebelum membuat proyek yang lebih kompleks.'**
  String get materiL2L2StrukturSketchVideoSummary7Text;

  /// No description provided for @materiL3L3AdcContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Pin digital: hanya HIGH (1) atau LOW (0).\n• Pin analog: membaca tegangan 0-5 V sebagai angka 0-1023 (ADC 10-bit).\n• Potensiometer menghasilkan tegangan yang berubah saat knob diputar.\n• Arduino Uno punya enam pin analog; Arduino Mega punya lebih banyak.'**
  String get materiL3L3AdcContent0Text;

  /// No description provided for @materiL3L3AdcContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Rumus konversi:\nV = (nilai ADC / 1023) × 5 V\n\nContoh pengondisian LED:\n• ADC < 350: LED merah menyala\n• ADC 351-700: LED kuning menyala\n• ADC > 700: LED hijau menyala'**
  String get materiL3L3AdcContent1Text;

  /// No description provided for @materiL3L3AdcDescription.
  ///
  /// In id, this message translates to:
  /// **'Memahami input analog Arduino, konversi ADC 0-1023, dan membaca potensiometer untuk mengendalikan LED indikator.'**
  String get materiL3L3AdcDescription;

  /// No description provided for @materiL3L3AdcVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini membahas pin analog Arduino Uno dengan potensiometer sebagai input dan LED sebagai indikator. Dimulai dari perbedaan pin digital dan analog, konsep Analog to Digital Converter (ADC), hingga cara membaca tegangan potensiometer menjadi nilai digital 0 sampai 1023. Nilai itu dipakai untuk menyalakan LED sesuai rentang tegangan. Pin analog penting untuk sensor yang mengeluarkan tegangan kontinu, berbeda dengan sinyal digital yang hanya bernilai 0 dan 1.'**
  String get materiL3L3AdcVideoSummary1Text;

  /// No description provided for @materiL3L3AdcVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• Input digital hanya 0 dan 1, sedangkan input analog bernilai kontinu antara 0 sampai 5 Volt.\n• ADC Arduino mengubah sinyal analog menjadi nilai digital 0 sampai 1023.\n• Potensiometer adalah sensor analog yang tegangan keluarannya bisa diatur manual.\n• Rumus tegangan: V = (nilai ADC / 1023) × 5 V.\n• Struktur if-else mengatur LED sesuai rentang nilai analog.\n• Pilih jenis Arduino dengan jumlah pin analog sesuai kebutuhan, misalnya Arduino Mega untuk banyak sensor.'**
  String get materiL3L3AdcVideoSummary3Text;

  /// No description provided for @materiL3L3AdcVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• ADC itu esensial: ADC 10-bit mengubah tegangan kontinu menjadi angka 0-1023. Tanpa ADC, Arduino hanya paham nyala atau mati.\n• Potensiometer cocok untuk belajar: memutar knob membuat nilai ADC di serial monitor naik atau turun sehingga hubungan tegangan dan nilai terbaca mudah dipahami.\n• Rumus konversi: Tegangan input = (nilai ADC / 1023) × 5 Volt, dipakai untuk mengubah angka digital menjadi besaran tegangan nyata.\n• Pengkondisian LED: contoh if-else dengan nilai ADC di bawah 350 menyalakan LED merah, 351-700 kuning, dan di atas 700 hijau.\n• Batasan pin: Arduino Uno hanya punya enam pin analog. Arduino Mega punya lebih banyak untuk kebutuhan yang lebih kompleks.\n• Hardware dan software harus sejalan: pemasangan potensiometer, resistor, dan LED yang benar dipadukan dengan program yang logis.\n• Banyak sensor fisik (suhu, arus, tegangan, posisi) memberi keluaran analog, sehingga materi ini menjadi dasar untuk IoT, robotika, dan otomasi.'**
  String get materiL3L3AdcVideoSummary5Text;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Sensor mengubah kondisi fisik (cahaya, suhu, jarak, suara, magnet) menjadi sinyal listrik yang dibaca mikrokontroler.\n• Ada sensor analog dan digital; sebagian sensor sama fungsinya tetapi berbeda bentuk dan ukuran modul.\n• Sensor suhu: termistor NTC dan sensor analog; ada juga sensor kelembaban.\n• Sensor garis dan laser dipakai untuk robot dan pengindraan jarak.\n• Sensor magnetik mendeteksi magnet atau logam; sensor sentuh dipakai sebagai pengganti tombol.'**
  String get materiL3L3JenisPrinsipKerjaSensorContent0Text;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Contoh sensor yang dibahas: joystick, modul suara, sensor garis, sensor jarak, sensor suhu, sensor sentuh, sensor magnetik, LED RGB, sensor laser, potensiometer, dan fotoresistor.'**
  String get materiL3L3JenisPrinsipKerjaSensorContent1Text;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorDescription.
  ///
  /// In id, this message translates to:
  /// **'Mengenal berbagai jenis sensor untuk belajar elektronika, dari joystick dan sensor suhu hingga sensor garis dan laser.'**
  String get materiL3L3JenisPrinsipKerjaSensorDescription;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorTitle.
  ///
  /// In id, this message translates to:
  /// **'Jenis & Prinsip Kerja Sensor'**
  String get materiL3L3JenisPrinsipKerjaSensorTitle;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary0Heading;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini memperkenalkan 37 jenis sensor untuk belajar elektronika dan mengembangkan aplikasi mikrokontroler. Pembicara menunjukkan sensor satu per satu sambil menguji fungsinya. Sebagian sudah dicoba, sebagian masih dievaluasi. Video memberi gambaran fungsi dasar maupun khusus berbagai sensor yang cocok untuk eksperimen pemula dan hobiis.'**
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary1Text;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Sensor yang Ditampilkan'**
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary2Heading;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• Joystick\n• Modul sensor suara (besar dan kecil)\n• Sensor garis (line tracking)\n• Sensor jarak\n• Sensor suhu dan kelembaban (termistor NTC dan analog)\n• Sensor sentuh (metal touch)\n• Sensor magnetik\n• LED RGB dan LED dua warna\n• Sensor laser\n• Potensiometer rotary\n• Sensor fotoresistor'**
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary3Text;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Wawasan Kunci'**
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary4Heading;

  /// No description provided for @materiL3L3JenisPrinsipKerjaSensorVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• Paket sensor lengkap mempercepat belajar karena bisa langsung dicoba, dari input analog hingga digital. Paket 37 sensor ini sekitar Rp190.000.\n• Ada sensor dengan fungsi sama tetapi bentuk dan ukuran modul berbeda (misalnya modul suara besar dan kecil), sehingga bisa disesuaikan dengan ruang proyek.\n• Sensor magnetik mendeteksi magnet atau logam; sensor metal touch dapat dipakai untuk kontak sentuh tanpa tombol fisik.\n• LED RGB dan LED dua warna memungkinkan eksperimen pengaturan warna dengan mikrokontroler.\n• Sensor suhu (termistor NTC maupun analog) dan sensor kelembaban penting untuk monitoring lingkungan dan IoT.\n• Sensor garis dan sensor laser berguna untuk robot bergerak otomatis dan pengindraan jarak.\n• Sensor banyak dipakai pada aplikasi robotik dan kontrol otomatis.'**
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary5Text;

  /// No description provided for @materiL3L3PosttestDescription.
  ///
  /// In id, this message translates to:
  /// **'Uji pemahamanmu setelah belajar.'**
  String get materiL3L3PosttestDescription;

  /// No description provided for @materiL3L3PosttestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Rumus konversi nilai ADC menjadi tegangan (dengan referensi 5 V) adalah...'**
  String get materiL3L3PosttestQQ1Question;

  /// No description provided for @materiL3L3PosttestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Jika analogRead menghasilkan sekitar 512, tegangan yang dibaca mendekati...'**
  String get materiL3L3PosttestQQ2Question;

  /// No description provided for @materiL3L3PosttestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Pin berikut yang mendukung keluaran PWM adalah...'**
  String get materiL3L3PosttestQQ3Question;

  /// No description provided for @materiL3L3PosttestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Perintah untuk mengatur kecerahan LED melalui sinyal PWM adalah...'**
  String get materiL3L3PosttestQQ4Question;

  /// No description provided for @materiL3L3PosttestQQ5Option0.
  ///
  /// In id, this message translates to:
  /// **'Mengubah kondisi fisik menjadi sinyal listrik'**
  String get materiL3L3PosttestQQ5Option0;

  /// No description provided for @materiL3L3PosttestQQ5Option1.
  ///
  /// In id, this message translates to:
  /// **'Menyimpan program secara permanen'**
  String get materiL3L3PosttestQQ5Option1;

  /// No description provided for @materiL3L3PosttestQQ5Question.
  ///
  /// In id, this message translates to:
  /// **'Fungsi utama sensor dalam sistem mikrokontroler adalah...'**
  String get materiL3L3PosttestQQ5Question;

  /// No description provided for @materiL3L3PretestDescription.
  ///
  /// In id, this message translates to:
  /// **'Ukur pengetahuan awalmu tentang input analog dan sensor.'**
  String get materiL3L3PretestDescription;

  /// No description provided for @materiL3L3PretestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Pin input analog pada Arduino Uno adalah...'**
  String get materiL3L3PretestQQ1Question;

  /// No description provided for @materiL3L3PretestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Rentang nilai hasil konversi ADC 10-bit pada Arduino adalah...'**
  String get materiL3L3PretestQQ2Question;

  /// No description provided for @materiL3L3PretestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Rentang nilai pada analogWrite() untuk PWM adalah...'**
  String get materiL3L3PretestQQ3Question;

  /// No description provided for @materiL3L3PretestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Fungsi yang digunakan untuk memetakan rentang nilai 0–1023 ke 0–255 adalah...'**
  String get materiL3L3PretestQQ4Question;

  /// No description provided for @materiL3L3PwmContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• PWM meniru tegangan analog dengan menyalakan dan mematikan sinyal digital secara cepat.\n• analogWrite(pin, nilai) dengan nilai 0-255.\n• Gunakan hanya pin PWM (3, 5, 6, 9, 10, 11 pada Arduino Nano).\n• map(nilai, 0, 1023, 0, 255) menyesuaikan nilai potensiometer ke rentang PWM.'**
  String get materiL3L3PwmContent0Text;

  /// No description provided for @materiL3L3PwmContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Alur program:\n1. Baca potensiometer dengan analogRead() (0-1023).\n2. Ubah ke 0-255 dengan map().\n3. Kirim hasilnya ke LED dengan analogWrite().\n4. Tampilkan nilai input dan output di serial monitor.'**
  String get materiL3L3PwmContent1Text;

  /// No description provided for @materiL3L3PwmDescription.
  ///
  /// In id, this message translates to:
  /// **'Mengatur kecerahan LED dengan PWM, analogWrite(), dan potensiometer menggunakan fungsi map().'**
  String get materiL3L3PwmDescription;

  /// No description provided for @materiL3L3PwmVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini menjelaskan konsep Pulse Width Modulation (PWM) dan penerapannya untuk mengatur kecerahan LED. Dengan PWM, Arduino dapat menghasilkan berbagai nilai tegangan antara 0 sampai 5 volt lewat pin digital yang mendukung PWM, tidak hanya 0 atau 5 volt. Pada contoh praktik, nilai analog potensiometer (0-1023) dikonversi dengan map() menjadi 0-255, lalu dipakai sebagai parameter analogWrite() untuk mengatur intensitas LED. Nilai input dan output dipantau di serial monitor.'**
  String get materiL3L3PwmVideoSummary1Text;

  /// No description provided for @materiL3L3PwmVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• PWM memungkinkan tegangan variatif (0-5 V) pada pin digital Arduino.\n• analogWrite() menerima nilai 0-255 untuk mengatur output PWM.\n• Potensiometer memberi nilai analog 0-1023.\n• map() mengubah nilai analog menjadi rentang PWM 0-255.\n• Arduino Nano mendukung PWM di pin digital 3, 5, 6, 9, 10, dan 11.\n• Kecerahan LED berubah real-time sesuai putaran potensiometer.\n• Serial monitor menampilkan nilai input potensiometer dan output PWM.'**
  String get materiL3L3PwmVideoSummary3Text;

  /// No description provided for @materiL3L3PwmVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• PWM efisien untuk kontrol tegangan: sinyal digital dihidupkan dan dimatikan sangat cepat sehingga tegangan rata-rata menjadi variatif tanpa DAC fisik atau hardware tambahan.\n• Potensiometer adalah input analog yang mudah dipakai sehingga rangkaian interaktif dan mudah diatur manual.\n• map() penting karena ADC 10-bit (0-1023) dan PWM 8-bit (0-255) memiliki skala berbeda; map() mengonversinya secara proporsional.\n• Tidak semua pin digital mendukung PWM; pahami pin yang didukung tiap board agar program berjalan benar.\n• Serial monitor mempercepat debugging karena nilai input dan output bisa dibandingkan langsung.\n• Dibanding on/off biasa, PWM membuat gradasi kecerahan LED lebih halus, berguna untuk pencahayaan dekoratif, indikator, atau display.\n• PWM adalah fondasi sebelum mengendalikan motor, servo, atau perangkat analog lain.'**
  String get materiL3L3PwmVideoSummary5Text;

  /// No description provided for @materiL4L4DebouncingContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Bouncing: getaran mekanis tombol terbaca sebagai beberapa tekanan sekaligus.\n• Akibatnya counter bisa melonjak walau tombol ditekan sekali.\n• Solusi tanpa delay(): gunakan variabel boolean btnState sebagai penanda tombol siap ditekan.'**
  String get materiL4L4DebouncingContent0Text;

  /// No description provided for @materiL4L4DebouncingContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Logika btnState:\n1. Tombol ditekan dan btnState == true: tambah counter, lalu set btnState = false.\n2. Tombol masih ditahan atau bergetar: btnState false, counter tidak bertambah.\n3. Tombol dilepas: set btnState = true agar siap untuk tekanan berikutnya.'**
  String get materiL4L4DebouncingContent1Text;

  /// No description provided for @materiL4L4DebouncingContent2Text.
  ///
  /// In id, this message translates to:
  /// **'Tips kode rapi:\n• Gunakan switch-case atau if-else if untuk memilih LED sesuai nilai counter.\n• Buat fungsi kustom runLed(byte a, byte b, byte c) agar digitalWrite tidak diulang-ulang.'**
  String get materiL4L4DebouncingContent2Text;

  /// No description provided for @materiL4L4DebouncingDescription.
  ///
  /// In id, this message translates to:
  /// **'Mengatasi getaran mekanis tombol (bouncing) dengan logika state tanpa delay().'**
  String get materiL4L4DebouncingDescription;

  /// No description provided for @materiL4L4DebouncingVideoSummary0Heading.
  ///
  /// In id, this message translates to:
  /// **'Masalah Bouncing (Getaran Fisik Tombol)'**
  String get materiL4L4DebouncingVideoSummary0Heading;

  /// No description provided for @materiL4L4DebouncingVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Pada program counter sederhana (misalnya ledState++), angka counter sering melonjak hanya karena satu kali tekanan cepat pada tombol. Penyebabnya, mikrokontroler membaca getaran mekanis kecil pada tombol fisik sebagai tekanan berkali-kali dalam hitungan mikrodetik.'**
  String get materiL4L4DebouncingVideoSummary1Text;

  /// No description provided for @materiL4L4DebouncingVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Solusi Debouncing via Software (Logika State)'**
  String get materiL4L4DebouncingVideoSummary2Heading;

  /// No description provided for @materiL4L4DebouncingVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'Masalah ini tidak diselesaikan dengan delay(), tetapi dengan variabel kontrol boolean tambahan bernama btnState.\n• Mendeteksi tekanan: saat tombol ditekan, program memeriksa apakah btnState == true. Jika ya, counter (ledState) ditambah 1, lalu btnState langsung diubah menjadi false.\n• Mencegah looping: karena btnState sudah false, tombol yang ditahan atau getaran sisa (bouncing) tidak menambah counter lagi.\n• Reset state: saat tombol dilepas, bagian else mengembalikan btnState menjadi true sehingga tombol siap untuk tekanan berikutnya.'**
  String get materiL4L4DebouncingVideoSummary3Text;

  /// No description provided for @materiL4L4DebouncingVideoSummary4Heading.
  ///
  /// In id, this message translates to:
  /// **'Metode Eksekusi Output'**
  String get materiL4L4DebouncingVideoSummary4Heading;

  /// No description provided for @materiL4L4DebouncingVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'Setelah nilai counter stabil (0 sampai 3), ada dua metode untuk menyalakan LED:\n• If - Else If: cara logis standar dengan pemeriksaan kondisi bertingkat.\n• Switch - Case: hasilnya sama persis, tetapi struktur kodenya lebih rapi dan efisien dibaca.'**
  String get materiL4L4DebouncingVideoSummary5Text;

  /// No description provided for @materiL4L4DebouncingVideoSummary6Heading.
  ///
  /// In id, this message translates to:
  /// **'Penyederhanaan Kode (Custom Void)'**
  String get materiL4L4DebouncingVideoSummary6Heading;

  /// No description provided for @materiL4L4DebouncingVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'Agar perintah digitalWrite tidak ditulis berulang di setiap kondisi, dibuat fungsi kustom void runLed(byte a, byte b, byte c). Untuk mengatur lampu, program cukup memanggil satu baris fungsi ini beserta parameternya, sehingga kode akhir jauh lebih ringkas.'**
  String get materiL4L4DebouncingVideoSummary7Text;

  /// No description provided for @materiL4L4DebouncingVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'Logika debouncing berbasis state ini efisien karena tidak memblokir mikrokontroler seperti delay().'**
  String get materiL4L4DebouncingVideoSummary9Text;

  /// No description provided for @materiL4L4InterruptContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Interrupt: menghentikan sebentar program utama untuk menjalankan fungsi khusus (ISR) saat ada kejadian di pin.\n• Pin interrupt eksternal Arduino Uno (ATmega328): pin 2 dan 3.\n• Variabel yang diubah di ISR wajib volatile.\n• Jangan pakai delay() atau millis() di dalam ISR; buat ISR sesingkat mungkin.'**
  String get materiL4L4InterruptContent0Text;

  /// No description provided for @materiL4L4InterruptContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Mode interrupt:\n• LOW: dipicu saat pin bernilai LOW.\n• CHANGE: dipicu saat sinyal berubah (naik atau turun).\n• RISING: dipicu saat sinyal naik dari LOW ke HIGH.\n• FALLING: dipicu saat sinyal turun dari HIGH ke LOW.'**
  String get materiL4L4InterruptContent1Text;

  /// No description provided for @materiL4L4InterruptContent2Text.
  ///
  /// In id, this message translates to:
  /// **'Interrupt vs if biasa:\n• Interrupt: input langsung ditangani meski program utama sedang sibuk.\n• If biasa: input baru terbaca saat program sampai ke baris tersebut, sehingga bisa terlewat saat proses berat berjalan.'**
  String get materiL4L4InterruptContent2Text;

  /// No description provided for @materiL4L4InterruptDescription.
  ///
  /// In id, this message translates to:
  /// **'Menangani input eksternal secara langsung dengan interrupt, ISR, variabel volatile, dan mode RISING, FALLING, CHANGE, LOW.'**
  String get materiL4L4InterruptDescription;

  /// No description provided for @materiL4L4InterruptVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini membahas cara kerja dan implementasi interrupt pada Arduino dengan mikrokontroler ATmega328 seperti Arduino Uno. Interrupt memungkinkan Arduino menjalankan fungsi tertentu segera saat sinyal pada pin berubah, tanpa menunggu proses utama selesai. Topiknya meliputi definisi interrupt, pemilihan pin pemicu, mode interrupt (rising, falling, change, low), dan penulisan Interrupt Service Routine (ISR).'**
  String get materiL4L4InterruptVideoSummary1Text;

  /// No description provided for @materiL4L4InterruptVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'Kode contoh memakai LCD untuk menampilkan counter yang bertambah saat interrupt terjadi. Proses utama disimulasikan dengan loading yang lama. Counter tetap bertambah tanpa menunggu loading selesai, sedangkan logika if biasa tidak dapat menangani input secara real-time saat program lain berjalan berat.'**
  String get materiL4L4InterruptVideoSummary3Text;

  /// No description provided for @materiL4L4InterruptVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• Konsep dan fungsi dasar interrupt pada Arduino.\n• Pin 2 dan 3 sebagai pin interrupt eksternal pada ATmega328.\n• ISR yang memodifikasi variabel volatile.\n• Perbandingan interrupt dan logika if biasa saat proses berat berjalan.\n• delay() dan millis() tidak efektif di dalam ISR.'**
  String get materiL4L4InterruptVideoSummary5Text;

  /// No description provided for @materiL4L4InterruptVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'• Interrupt mengeksekusi fungsi secara asinkron saat sinyal pin berubah, sangat penting untuk input real-time seperti tombol atau sensor.\n• Arduino Uno dan board ATmega328 lain memakai pin 2 dan 3 untuk interrupt eksternal; sesuaikan pin jika memakai board lain.\n• Variabel yang diubah ISR harus dideklarasikan volatile agar compiler tidak mengoptimasinya dan nilainya selalu terbaru.\n• ISR sebaiknya sesingkat mungkin dan tidak memakai delay() atau millis() karena dapat mengganggu kestabilan program.\n• Mode LOW, CHANGE, RISING, dan FALLING mengatur kapan ISR dipanggil sesuai karakter input.\n• Interrupt mengubah pola pemrograman dari sinkron ke asinkron: program merespons input tanpa menunggu proses lain selesai.'**
  String get materiL4L4InterruptVideoSummary7Text;

  /// No description provided for @materiL4L4InterruptVideoSummary9Text.
  ///
  /// In id, this message translates to:
  /// **'Interrupt membuat sistem merespons input eksternal dengan cepat, terutama saat proses utama berlangsung lama dan tidak boleh terganggu. Mekanisme ini penting pada sistem embedded dan sensor yang butuh pembacaan data real-time.'**
  String get materiL4L4InterruptVideoSummary9Text;

  /// No description provided for @materiL4L4JenisMotorContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• Servo: motor yang sudutnya dapat ditentukan, dikendalikan sinyal PWM.\n• Rentang gerak servo pada video: 0° sampai 180°.\n• Kabel servo: merah = VCC 5V, coklat = ground, oranye/kuning = sinyal PWM.\n• Delay kecil (contoh 0,05 detik) membuat gerakan servo halus.'**
  String get materiL4L4JenisMotorContent0Text;

  /// No description provided for @materiL4L4JenisMotorContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Cara menggerakkan servo secara bertahap:\n1. Sambungkan servo: merah ke 5V, coklat ke ground, oranye/kuning ke pin PWM.\n2. Naikkan sudut sedikit demi sedikit dari 0° ke 180° dengan loop.\n3. Beri delay pendek di setiap langkah.\n4. Turunkan sudut kembali dari 180° ke 0° untuk gerakan bolak-balik (sweep).'**
  String get materiL4L4JenisMotorContent1Text;

  /// No description provided for @materiL4L4JenisMotorContent2Text.
  ///
  /// In id, this message translates to:
  /// **'Pengembangan: Python dengan library pyfirmata dapat mengontrol Arduino, dan Tkinter dapat dipakai untuk membuat slider sudut serta tombol sweep.'**
  String get materiL4L4JenisMotorContent2Text;

  /// No description provided for @materiL4L4JenisMotorDescription.
  ///
  /// In id, this message translates to:
  /// **'Cara kerja servo yang dikendalikan sinyal PWM, standar kabel servo, dan pemrograman Arduino lewat Python (pyfirmata).'**
  String get materiL4L4JenisMotorDescription;

  /// No description provided for @materiL4L4JenisMotorVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini membahas cara mengendalikan motor servo dengan Python yang terhubung ke board Arduino. Dimulai dari konsep dasar servo yang dikendalikan sinyal PWM, lalu contoh kode Python yang menggerakkan servo dari sudut 0° sampai 180° dengan variasi kecepatan dan sudut. Video juga membahas sambungan kabel servo (VCC, ground, PWM), library pyfirmata untuk komunikasi dengan Arduino, dan antarmuka grafis sederhana dengan Tkinter untuk kontrol servo secara interaktif.'**
  String get materiL4L4JenisMotorVideoSummary1Text;

  /// No description provided for @materiL4L4JenisMotorVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'• Servo dikendalikan sinyal PWM dari Arduino.\n• Kabel servo: merah (VCC 5V), coklat (ground), oranye atau kuning (sinyal PWM).\n• Contoh perangkat: Arduino Uno dan servo MG90S atau MG995.\n• Python memakai library pyfirmata dan port serial untuk berkomunikasi dengan Arduino.\n• Loop dengan penambahan sudut menggerakkan servo secara bertahap.\n• Delay mengatur kecepatan gerak servo.\n• GUI Tkinter menyediakan slider sudut dan tombol sweep otomatis.'**
  String get materiL4L4JenisMotorVideoSummary3Text;

  /// No description provided for @materiL4L4JenisMotorVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• Servo bergantung pada PWM: sudut servo mengikuti durasi pulsa. Semakin panjang pulsa ON, sudut bertambah hingga maksimum 180°.\n• Python-Arduino membuka peluang pemrograman tingkat tinggi dan antarmuka kontrol yang lebih interaktif dibanding hanya memakai Arduino IDE.\n• pyfirmata memudahkan komunikasi dengan Arduino lewat serial, sedangkan Tkinter memberi GUI sederhana tanpa toolkit berat.\n• Delay singkat (misalnya 0,05 detik) membuat gerak servo halus dan mudah diikuti, serta tidak membebani mikrokontroler dan servo.\n• Memahami fungsi warna kabel servo mencegah korsleting dan kerusakan komponen.\n• Loop menaikkan dan menurunkan sudut adalah dasar untuk aplikasi seperti robotika, kamera otomatis, dan sistem kendali posisi.'**
  String get materiL4L4JenisMotorVideoSummary5Text;

  /// No description provided for @materiL4L4PosttestDescription.
  ///
  /// In id, this message translates to:
  /// **'Uji pemahamanmu setelah belajar.'**
  String get materiL4L4PosttestDescription;

  /// No description provided for @materiL4L4PosttestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Sudut posisi motor servo dikendalikan menggunakan sinyal...'**
  String get materiL4L4PosttestQQ1Question;

  /// No description provided for @materiL4L4PosttestQQ2Option0.
  ///
  /// In id, this message translates to:
  /// **'Jumlah milidetik sejak board menyala'**
  String get materiL4L4PosttestQQ2Option0;

  /// No description provided for @materiL4L4PosttestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Fungsi millis() mengembalikan...'**
  String get materiL4L4PosttestQQ2Question;

  /// No description provided for @materiL4L4PosttestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'Program tidak terblokir dan bisa menjalankan tugas lain'**
  String get materiL4L4PosttestQQ3Option0;

  /// No description provided for @materiL4L4PosttestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Keunggulan menggunakan millis() dibanding delay() adalah...'**
  String get materiL4L4PosttestQQ3Question;

  /// No description provided for @materiL4L4PosttestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Mekanisme yang menghentikan sementara program utama untuk langsung merespons sinyal penting disebut...'**
  String get materiL4L4PosttestQQ4Question;

  /// No description provided for @materiL4L4PosttestQQ5Option1.
  ///
  /// In id, this message translates to:
  /// **'Menggunakan logika variabel state (seperti btnState)'**
  String get materiL4L4PosttestQQ5Option1;

  /// No description provided for @materiL4L4PosttestQQ5Question.
  ///
  /// In id, this message translates to:
  /// **'Cara mengatasi bouncing tombol tanpa memblokir program adalah...'**
  String get materiL4L4PosttestQQ5Question;

  /// No description provided for @materiL4L4PretestDescription.
  ///
  /// In id, this message translates to:
  /// **'Ukur pengetahuan awalmu tentang motor, timer, dan interrupt.'**
  String get materiL4L4PretestDescription;

  /// No description provided for @materiL4L4PretestQQ1Option1.
  ///
  /// In id, this message translates to:
  /// **'Menggerakkan ke sudut tertentu dalam rentang terbatas'**
  String get materiL4L4PretestQQ1Option1;

  /// No description provided for @materiL4L4PretestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Kabel warna merah pada motor servo standar umumnya dihubungkan ke...'**
  String get materiL4L4PretestQQ2Question;

  /// No description provided for @materiL4L4PretestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'Berhenti menunggu dan memblokir perintah lain'**
  String get materiL4L4PretestQQ3Option0;

  /// No description provided for @materiL4L4PretestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Saat delay() berjalan, mikrokontroler...'**
  String get materiL4L4PretestQQ3Question;

  /// No description provided for @materiL4L4PretestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Masalah getaran mekanis pada tombol yang terbaca berkali-kali disebut...'**
  String get materiL4L4PretestQQ4Question;

  /// No description provided for @materiL4L4TimerTanpaHentiContent0Text.
  ///
  /// In id, this message translates to:
  /// **'Poin penting:\n• delay() menghentikan program, millis() tidak.\n• millis() = jumlah milidetik sejak Arduino menyala.\n• Simpan waktu terakhir aksi di variabel (previousTime) bertipe unsigned long.\n• Jika millis() - previousTime >= interval, jalankan aksi lalu perbarui previousTime.\n• Gunakan variabel boolean untuk membalik status LED.'**
  String get materiL4L4TimerTanpaHentiContent0Text;

  /// No description provided for @materiL4L4TimerTanpaHentiContent1Text.
  ///
  /// In id, this message translates to:
  /// **'Contoh pada video:\n• LED 1 berubah status setiap 10 detik.\n• LED 2 berubah status setiap 6 detik.\n• Keduanya berjalan bersamaan tanpa saling menunggu.'**
  String get materiL4L4TimerTanpaHentiContent1Text;

  /// No description provided for @materiL4L4TimerTanpaHentiDescription.
  ///
  /// In id, this message translates to:
  /// **'Membuat program berbasis event dengan millis() agar tugas berjalan tanpa terhenti oleh delay().'**
  String get materiL4L4TimerTanpaHentiDescription;

  /// No description provided for @materiL4L4TimerTanpaHentiVideoSummary1Text.
  ///
  /// In id, this message translates to:
  /// **'Video ini menjelaskan cara memakai millis() untuk pemrograman berbasis event tanpa delay(). Fungsi millis() menghasilkan waktu dalam milidetik sejak Arduino dinyalakan dan terus berjalan kecuali board di-reset. Nilainya dipakai untuk mengatur interval secara non-blocking sehingga perangkat bisa mengerjakan tugas lain, berbeda dengan delay() yang membuat program berhenti sementara.'**
  String get materiL4L4TimerTanpaHentiVideoSummary1Text;

  /// No description provided for @materiL4L4TimerTanpaHentiVideoSummary2Heading.
  ///
  /// In id, this message translates to:
  /// **'Contoh Implementasi'**
  String get materiL4L4TimerTanpaHentiVideoSummary2Heading;

  /// No description provided for @materiL4L4TimerTanpaHentiVideoSummary3Text.
  ///
  /// In id, this message translates to:
  /// **'Dua lampu LED dikendalikan dengan interval berbeda: lampu pertama berubah setiap 10 detik dan lampu kedua setiap 6 detik. Status dan waktu ditampilkan di LCD 20x4 dengan library LiquidCrystal. Aksi hanya dijalankan saat selisih antara millis() sekarang dan waktu sebelumnya mencapai interval. Tipe data unsigned long menampung nilai waktu, variabel boolean menyimpan status lampu, dan if membandingkan waktu.'**
  String get materiL4L4TimerTanpaHentiVideoSummary3Text;

  /// No description provided for @materiL4L4TimerTanpaHentiVideoSummary5Text.
  ///
  /// In id, this message translates to:
  /// **'• millis() menghitung waktu berjalan dalam milidetik sejak Arduino menyala.\n• Pemrograman event-based membandingkan waktu sekarang dengan waktu sebelumnya (non-blocking).\n• Dua LED dengan interval 10 detik dan 6 detik sebagai contoh.\n• LCD 20x4 menampilkan status dan waktu.\n• unsigned long untuk waktu dan boolean untuk status lampu.\n• Kode modular dengan fungsi untuk membalik status lampu dan memperbarui waktu sebelumnya.'**
  String get materiL4L4TimerTanpaHentiVideoSummary5Text;

  /// No description provided for @materiL4L4TimerTanpaHentiVideoSummary7Text.
  ///
  /// In id, this message translates to:
  /// **'• millis() mengatasi masalah delay() yang bersifat blocking, sehingga program bisa multitasking dan responsif untuk aplikasi IoT, kontrol real-time, dan robotika.\n• unsigned long dipakai untuk waktu karena nilai millis() bisa mencapai sekitar 4,2 miliar ms (sekitar 50 hari) sebelum kembali ke nol.\n• Pendekatan event-based: aksi dipicu oleh waktu atau kejadian lain, konsep yang juga dipakai di banyak bahasa pemrograman modern.\n• Toggle status boolean: membalik status lampu (true/false) setiap interval tercapai adalah cara sederhana mengendalikan output.\n• LCD memberi umpan balik visual untuk memverifikasi program tanpa alat tambahan.\n• Variabel waktu sebelumnya (previousTime) menjaga interval tetap konsisten dan tidak bergantung pada nilai mutlak millis().'**
  String get materiL4L4TimerTanpaHentiVideoSummary7Text;

  /// No description provided for @materiL5L5M1Content0Text.
  ///
  /// In id, this message translates to:
  /// **'Cara kerja sistem:\n• DHT11 membaca suhu.\n• Suhu mencapai batas atas → kipas ON lewat relay.\n• Suhu turun melewati batas bawah → kipas OFF.\n• OLED menampilkan suhu dan status kipas.\n\nPenggunaan dua batas (histeresis) mencegah relay menyala-mati terus-menerus di sekitar satu nilai suhu.'**
  String get materiL5L5M1Content0Text;

  /// No description provided for @materiL5L5M1Content1Text.
  ///
  /// In id, this message translates to:
  /// **'Alat dan bahan:\n• Arduino Uno\n• DHT11\n• OLED I2C 128×64\n• Modul relay 5 V\n• Kipas DC kecil dengan catu terpisah\n• Breadboard dan kabel jumper'**
  String get materiL5L5M1Content1Text;

  /// No description provided for @materiL5L5M1Description.
  ///
  /// In id, this message translates to:
  /// **'Kipas pendingin otomatis berbasis suhu.'**
  String get materiL5L5M1Description;

  /// No description provided for @materiL5L5M2Content0Text.
  ///
  /// In id, this message translates to:
  /// **'Sisi kontrol (Arduino, 5 V):\n• DHT11: VCC → 5V, DATA → D2, GND → GND\n• OLED: VCC → 5V, GND → GND, SDA → A4, SCL → A5\n• Modul relay: VCC → 5V, GND → GND, IN → D7 (active LOW)'**
  String get materiL5L5M2Content0Text;

  /// No description provided for @materiL5L5M2Content1Text.
  ///
  /// In id, this message translates to:
  /// **'Sisi beban (catu kipas terpisah):\n• Catu kipas (+) → terminal COM relay\n• Terminal NO relay → kipas (+)\n• Kipas (−) → catu kipas (−), langsung tanpa relay\n\nRelay memisahkan kedua sisi: sisi beban tidak terhubung ke Arduino sama sekali. Gunakan terminal NO (normally open) agar kipas mati saat relay tidak aktif atau Arduino kehilangan daya.'**
  String get materiL5L5M2Content1Text;

  /// No description provided for @materiL5L5M2Description.
  ///
  /// In id, this message translates to:
  /// **'Sambungan sisi kontrol dan sisi beban.'**
  String get materiL5L5M2Description;

  /// No description provided for @materiL5L5M3Content1Text.
  ///
  /// In id, this message translates to:
  /// **'Logika utama:\n• t ≥ 30 °C → kipasNyala = true\n• t ≤ 28 °C → kipasNyala = false\n• Di antara 28–30 °C status tidak berubah (histeresis)\n• Jika pembacaan gagal (isnan), status kipas dipertahankan dan OLED menampilkan Error'**
  String get materiL5L5M3Content1Text;

  /// No description provided for @materiL5L5M3Description.
  ///
  /// In id, this message translates to:
  /// **'Sketch lengkap dengan histeresis dan tampilan OLED.'**
  String get materiL5L5M3Description;

  /// No description provided for @materiL5L5M4Content0Text.
  ///
  /// In id, this message translates to:
  /// **'Skenario pengujian:\n1. Suhu < 28 °C → kipas OFF, OLED menampilkan suhu\n2. Sensor dihangatkan ≥ 30 °C → kipas ON\n3. Suhu turun ke 28–30 °C → kipas tetap ON (histeresis)\n4. Suhu ≤ 28 °C → kipas OFF\n5. Kabel DATA DHT11 dicabut → OLED menampilkan Error, status kipas tidak berubah'**
  String get materiL5L5M4Content0Text;

  /// No description provided for @materiL5L5M4Content1Text.
  ///
  /// In id, this message translates to:
  /// **'Analisis ketelitian sensor (bandingkan dengan termometer pembanding di beberapa titik suhu):\n• Galat mutlak = |DHT11 − pembanding|\n• Galat (%) = galat mutlak / pembanding × 100%\n• Hitung rata-ratanya, bandingkan dengan akurasi pada datasheet.\n• Catat juga waktu kipas menyala setelah suhu mencapai 30 °C untuk menilai kecepatan respons.'**
  String get materiL5L5M4Content1Text;

  /// No description provided for @materiL5L5M4Content2Text.
  ///
  /// In id, this message translates to:
  /// **'Ide pengembangan:\n• Kendali kecepatan kipas dengan PWM dan driver motor\n• Buzzer sebagai alarm suhu berlebih\n• Log suhu ke kartu SD lewat SPI'**
  String get materiL5L5M4Content2Text;

  /// No description provided for @materiL5L5M4Description.
  ///
  /// In id, this message translates to:
  /// **'Skenario uji, analisis galat, dan ide pengembangan.'**
  String get materiL5L5M4Description;

  /// No description provided for @materiL5L5PosttestDescription.
  ///
  /// In id, this message translates to:
  /// **'Uji pemahamanmu setelah menyelesaikan proyek akhir.'**
  String get materiL5L5PosttestDescription;

  /// No description provided for @materiL5L5PosttestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'Mencegah relay menyala-mati terus-menerus'**
  String get materiL5L5PosttestQQ1Option0;

  /// No description provided for @materiL5L5PosttestQQ1Question.
  ///
  /// In id, this message translates to:
  /// **'Tujuan penggunaan dua batas suhu (histeresis) adalah...'**
  String get materiL5L5PosttestQQ1Question;

  /// No description provided for @materiL5L5PosttestQQ2Question.
  ///
  /// In id, this message translates to:
  /// **'Pada proyek ini, kipas menyala ketika suhu...'**
  String get materiL5L5PosttestQQ2Question;

  /// No description provided for @materiL5L5PosttestQQ3Option0.
  ///
  /// In id, this message translates to:
  /// **'Kipas mati saat relay tidak aktif atau Arduino kehilangan daya'**
  String get materiL5L5PosttestQQ3Option0;

  /// No description provided for @materiL5L5PosttestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'Mengapa dipilih terminal NO (normally open) pada relay?'**
  String get materiL5L5PosttestQQ3Question;

  /// No description provided for @materiL5L5PosttestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Jika isnan(t) bernilai true, artinya...'**
  String get materiL5L5PosttestQQ4Question;

  /// No description provided for @materiL5L5PosttestQQ5Question.
  ///
  /// In id, this message translates to:
  /// **'Rumus galat (%) pada analisis sensor adalah...'**
  String get materiL5L5PosttestQQ5Question;

  /// No description provided for @materiL5L5PretestDescription.
  ///
  /// In id, this message translates to:
  /// **'Ukur pengetahuan awalmu sebelum membuat proyek akhir.'**
  String get materiL5L5PretestDescription;

  /// No description provided for @materiL5L5PretestQQ1Option0.
  ///
  /// In id, this message translates to:
  /// **'Saklar yang dikendalikan sinyal kecil'**
  String get materiL5L5PretestQQ1Option0;

  /// No description provided for @materiL5L5PretestQQ3Question.
  ///
  /// In id, this message translates to:
  /// **'OLED I2C pada Arduino Uno dihubungkan ke pin...'**
  String get materiL5L5PretestQQ3Question;

  /// No description provided for @materiL5L5PretestQQ4Question.
  ///
  /// In id, this message translates to:
  /// **'Alamat I2C OLED SSD1306 yang umum adalah...'**
  String get materiL5L5PretestQQ4Question;

  /// No description provided for @kuisQuestionCounter.
  ///
  /// In id, this message translates to:
  /// **'Pertanyaan {current} dari {total}'**
  String kuisQuestionCounter(Object current, Object total);

  /// No description provided for @btnPrevious.
  ///
  /// In id, this message translates to:
  /// **'Sebelumnya'**
  String get btnPrevious;

  /// No description provided for @folderSubtitle.
  ///
  /// In id, this message translates to:
  /// **'{count} materi • {subtitle}'**
  String folderSubtitle(Object count, Object subtitle);
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
