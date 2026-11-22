// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'EduVolt';

  @override
  String homeGreeting(Object name) {
    return 'Hello, $name!';
  }

  @override
  String get btnStart => 'Start';

  @override
  String get btnContinue => 'Continue';

  @override
  String get btnSave => 'Save';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get menuProfile => 'Profile';

  @override
  String get menuLanguage => 'Language';

  @override
  String get langIndonesian => 'Indonesian';

  @override
  String get langEnglish => 'English';

  @override
  String get loginTitle => 'Login';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get classTitle => 'Class';

  @override
  String get taskTitle => 'Tasks';

  @override
  String get commentTitle => 'Comments';

  @override
  String get navHome => 'Home';

  @override
  String get navMateri => 'Materi';

  @override
  String get navSimulasi => 'Simulation';

  @override
  String get navKelas => 'Class';

  @override
  String get navProfil => 'Profile';

  @override
  String get guruNavDashboard => 'Dashboard';

  @override
  String get guruNavKelas => 'Classes';

  @override
  String get guruNavTugas => 'Tasks';

  @override
  String get guruNavProfil => 'Profile';

  @override
  String get guruKelasDetailTitle => 'Class Detail';

  @override
  String get guruKelasEdit => 'Edit Class';

  @override
  String get guruKelasComingSoon => 'Coming soon in next update';

  @override
  String get guruTugasTitle => 'Task List';

  @override
  String guruTugasCount(Object count) {
    return '$count tasks';
  }

  @override
  String get guruTugasCreate => 'Create Task';

  @override
  String get guruTugasFilterAll => 'All';

  @override
  String get guruTugasFilterActive => 'Active';

  @override
  String get guruTugasFilterCompleted => 'Completed';

  @override
  String get guruTugasStatusActive => 'Active';

  @override
  String get guruTugasStatusCompleted => 'Completed';

  @override
  String guruTugasDeadline(Object date) {
    return 'Deadline: $date';
  }

  @override
  String guruTugasDetailSnack(Object title) {
    return 'Detail \"$title\" - Coming soon';
  }

  @override
  String get settingsEditProfil => 'Edit Profile';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsAbout => 'About App';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirm => 'Logout Confirmation';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get confirmYes => 'Yes';

  @override
  String get confirmNo => 'No';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'name@school.edu';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get nameLabel => 'Full Name';

  @override
  String get nameHint => 'Enter your full name';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Re-enter password';

  @override
  String get teacherCodeLabel => 'Teacher Code (Optional)';

  @override
  String get teacherCodeHint => 'Enter teacher invitation code';

  @override
  String get roleStudent => 'Student';

  @override
  String get roleTeacher => 'Teacher';

  @override
  String get registerRoleLabel => 'Register As';

  @override
  String get btnLogin => 'Login';

  @override
  String get btnRegister => 'Register';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get registerLink => 'Register';

  @override
  String get hasAccount => 'Already have an account? ';

  @override
  String get loginLink => 'Login';

  @override
  String get welcomeTitle => 'Welcome';

  @override
  String get welcomeSubtitle =>
      'Learning electronics made fun and interactive!';

  @override
  String get continueLearning => 'Continue Learning';

  @override
  String get quickShortcuts => 'Quick Shortcuts';

  @override
  String get miniGames => 'Mini-Games';

  @override
  String get joinClassTitle => 'Join Class';

  @override
  String get joinClassDesc => 'Enter the class code from your teacher';

  @override
  String get classCodeLabel => 'Class Code';

  @override
  String get classCodeHint => 'Example: ABC123';

  @override
  String get btnJoinClass => 'Join';

  @override
  String get myClass => 'My Class';

  @override
  String classCode(Object code) {
    return 'Code: $code';
  }

  @override
  String studentCount(Object count) {
    return '$count students';
  }

  @override
  String teacherLabel(Object name) {
    return 'Teacher: $name';
  }

  @override
  String get levelUnlocked => 'Unlocked';

  @override
  String get levelLocked => 'Locked';

  @override
  String get completePrevLevel => 'Complete the previous level first';

  @override
  String get selectLevel => 'Select Level';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageDialogTitle => 'Choose Language / Pilih Bahasa';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get saving => 'Saving...';

  @override
  String get processing => 'Processing...';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get avatarChange => 'Change Photo';

  @override
  String get photoUploading => 'Uploading photo...';

  @override
  String get errorRequired => 'Please fill in this field';

  @override
  String get errorEmail => 'Invalid email format';

  @override
  String get errorPasswordMin => 'Password must be at least 6 characters';

  @override
  String get errorPasswordMatch => 'Passwords do not match';

  @override
  String get errorName => 'Name must be at least 2 characters';

  @override
  String get errorTeacherCode => 'Invalid teacher code';

  @override
  String get authErrorNetwork => 'Network connection issue. Try again.';

  @override
  String get authErrorWrongPassword => 'Wrong email or password';

  @override
  String get authErrorUserNotFound => 'Account not found';

  @override
  String get authErrorEmailInUse => 'Email already registered';

  @override
  String get authErrorWeakPassword => 'Password too weak';

  @override
  String get authErrorInvalidEmail => 'Invalid email format';

  @override
  String get verificationPendingTitle => 'Email Verification';

  @override
  String verificationPendingDesc(Object email) {
    return 'We\'ve sent a verification email to $email. Please check your inbox.';
  }

  @override
  String get verificationResend => 'Resend';

  @override
  String get verificationCheck => 'Check Verification';

  @override
  String get profileName => 'Name';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileRole => 'Role';

  @override
  String get profileClass => 'Class';

  @override
  String get profileStudentId => 'Student ID';

  @override
  String get profileTeacherId => 'Teacher ID';

  @override
  String get statsClasses => 'Classes';

  @override
  String get statsStudents => 'Students';

  @override
  String get statsTasks => 'Tasks';

  @override
  String get menuEditProfil => 'Edit Profile';

  @override
  String get menuNotifications => 'Notifications';

  @override
  String get menuAbout => 'About App';

  @override
  String get menuLogout => 'Logout';

  @override
  String get appName => 'EduVolt';

  @override
  String version(Object version) {
    return 'Version $version';
  }

  @override
  String get copyright => '© 2024 EduVolt. All rights reserved.';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get close => 'Close';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get noData => 'No data';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get sort => 'Sort';

  @override
  String get refresh => 'Refresh';

  @override
  String get titleProfile => 'Profile';

  @override
  String get titleSettings => 'Settings';

  @override
  String get btnYesLogout => 'Yes, Logout';

  @override
  String errLogoutFailed(Object error) {
    return 'Logout failed: $error';
  }

  @override
  String get msgNoNotifications => 'No new notifications.';

  @override
  String get btnClose => 'Close';

  @override
  String aboutDesc(Object version) {
    return 'EduVolt v$version - Electronics Learning Platform for SMK.';
  }

  @override
  String get aboutMadeBy => 'Made by: EduVolt Team';

  @override
  String appVersion(Object version) {
    return 'EduVolt v$version';
  }

  @override
  String get loginSubtitle => 'Learning electronics is fun ⚡';

  @override
  String get tidakAdaSoal => 'No questions available';

  @override
  String get gagalMemuatLevel => 'Failed to load level';

  @override
  String get selesaikanLevelSebelumnya => 'Complete the previous level first';

  @override
  String get kirimJawaban => 'Submit Answer';

  @override
  String get kembaliKeLevel => 'Back to Level';

  @override
  String get memuatKuis => 'Loading quiz...';

  @override
  String get gagalMemuatKuis => 'Failed to load quiz';

  @override
  String get tidakAdaData => 'No data';

  @override
  String get kodeKelas => 'Class Code';

  @override
  String get gabungKelas => 'Join Class';

  @override
  String get kelasSaya => 'My Class';

  @override
  String get cari => 'Search';

  @override
  String get urutkan => 'Sort';

  @override
  String get muatUlang => 'Refresh';

  @override
  String get cobaLagi => 'Try Again';

  @override
  String get memuat => 'Loading...';

  @override
  String get kelasTidakDitemukan => 'Class not found';

  @override
  String get hubungiGuruKodeKelas =>
      'Contact your teacher for the correct class code';

  @override
  String get belumAdaPostingan => 'No Posts Yet';

  @override
  String get tungguPengumumanGuru => 'Wait for announcements from teacher';

  @override
  String get belumAdaTugas => 'No assignments yet';

  @override
  String get belumAdaKelas => 'No classes yet';

  @override
  String get gagalMemuat => 'Failed to Load';

  @override
  String get selesaiTugas => 'Assignment Completed';

  @override
  String get tugasTerlambat => 'Overdue';

  @override
  String get belumDikerjakan => 'Not started';

  @override
  String get hapusPostingan => 'Delete Post';

  @override
  String get hapusTugas => 'Delete Assignment?';

  @override
  String get tindakanTidakDapatDibatalkan => 'This action cannot be undone';

  @override
  String get postinganDihapus => 'Post deleted';

  @override
  String get tugasDihapus => 'Assignment deleted';

  @override
  String get belumLogin => 'Not Logged In';

  @override
  String get silakanLoginGuru =>
      'Please log in as a teacher to manage classes.';

  @override
  String get daftarKelas => 'Class List';

  @override
  String get kelolaKelasYangAndaAmpu => 'Manage your classes';

  @override
  String get buatKelasBaru => 'Create New Class';

  @override
  String get buatTugasBaru => 'Create new assignment for your students';

  @override
  String get namaKelas => 'Class Name';

  @override
  String get deskripsiKelas => 'Class Description';

  @override
  String get kodeUndangan => 'Invitation Code';

  @override
  String get tanggalBatas => 'Due Date';

  @override
  String get mataPelajaran => 'Subject';

  @override
  String get pilihMataPelajaran => 'Select Subject';

  @override
  String get totalSiswa => 'Total Students';

  @override
  String get totalKelas => 'Total Classes';

  @override
  String get totalTugas => 'Total Assignments';

  @override
  String get aktivitasTerkini => 'Recent Activity';

  @override
  String get guru => 'Teacher';

  @override
  String get siswa => 'Student';

  @override
  String get kode => 'Code';

  @override
  String get buatPengumumanAtauTugasPertama =>
      'Create your first announcement or assignment';

  @override
  String get belumPunyaKelas => 'Don\'t have a class?';

  @override
  String get masukkanKodeKelas => 'Enter class code from your teacher to join.';

  @override
  String get joinClassSuccess => 'Successfully joined class!';

  @override
  String get lihatDetail => 'View Detail';

  @override
  String get tugasDanAbsen => 'Assignments & Attendance';

  @override
  String get pengguna => 'User';

  @override
  String semuaTab(Object count) {
    return 'All ($count)';
  }

  @override
  String get belumAdaTugasSelesai => 'No Completed Assignments';

  @override
  String get tugasSelesaiWillAppear =>
      'Completed assignments will appear here.';

  @override
  String get semuaTugasSelesai => 'All Assignments Completed! 🎉';

  @override
  String get tidakAdaTugasTertunda => 'No pending assignments.';

  @override
  String get postUpdated => 'Post updated';

  @override
  String deadlineLabel(Object deadline) {
    return 'Deadline: $deadline';
  }

  @override
  String get lewat => 'Overdue';

  @override
  String get pengumuman => 'Announcement';

  @override
  String hapusApa(Object item) {
    return 'Delete $item?';
  }

  @override
  String get assignmentUpdated => 'Assignment updated';

  @override
  String siswaTab(Object count) {
    return 'Students ($count)';
  }

  @override
  String kodeLabel(Object code) {
    return 'Code: $code';
  }

  @override
  String get gagalMemuatSiswa => 'Failed to load student list.';

  @override
  String get tanpaNama => 'No Name';

  @override
  String get tungguTugasDariGuru => 'Wait for assignments from teacher';

  @override
  String get buatPengumuman => 'Create Announcement';

  @override
  String get bagikanInfo =>
      'Share important information with all students in class.';

  @override
  String get judulOpsional => 'Title (Optional)';

  @override
  String get contohJudul => 'Example: Lab Schedule Next Week';

  @override
  String get isiPengumuman => 'Announcement Content';

  @override
  String get tulisPengumuman => 'Write announcement here...';

  @override
  String get memposting => 'Posting...';

  @override
  String get postingPengumuman => 'Post Announcement';

  @override
  String get isiPengumumanTidakBolehKosong =>
      'Announcement content cannot be empty';

  @override
  String get pilihDeadline => 'Select Deadline';

  @override
  String deadlineWithTime(Object date, Object time) {
    return 'Deadline: $date $time';
  }

  @override
  String get membuat => 'Creating...';

  @override
  String get buatTugas => 'Create Assignment';

  @override
  String get judulTugasWajibDiisi => 'Assignment title is required';

  @override
  String get deskripsiTugasWajibDiisi => 'Assignment description is required';

  @override
  String get deadlineWajibDipilih => 'Deadline must be selected';

  @override
  String get tugasBerhasilDibuat => 'Assignment successfully created';

  @override
  String get gagalMemuatMateri => 'Failed to load material';

  @override
  String get kembali => 'Back';

  @override
  String get kuis => 'Quiz';

  @override
  String get selanjutnya => 'Next';

  @override
  String get selamat => 'Congratulations!';

  @override
  String get perluBelajarLagi => 'Need to study more';

  @override
  String skorKamu(Object score) {
    return 'Your Score: $score';
  }

  @override
  String benarDari(Object correct, Object total) {
    return '$correct of $total correct';
  }

  @override
  String get levelPrefix => 'Level';

  @override
  String get kembaliKePilihLevel => 'Back to Select Level';

  @override
  String get badgePretest => 'PRE-TEST';

  @override
  String get badgeMateri => 'MATERIAL';

  @override
  String get badgePosttest => 'POST-TEST';

  @override
  String get badgeFolder => 'FOLDER';

  @override
  String get chipSelesai => 'Completed';

  @override
  String get chipMulai => 'Start';

  @override
  String pertanyaan(Object count) {
    return '$count questions';
  }

  @override
  String get videoTidakTersedia => 'Video not available';

  @override
  String get ringkasanVideo => 'Video Summary';

  @override
  String simulasiSegeraHadir(Object title) {
    return 'Practice simulation for $title coming soon.';
  }

  @override
  String get tandaiSelesai => 'Mark Complete';

  @override
  String get tandaiSelesaiDialog => 'Mark Complete?';

  @override
  String konfirmasiTandaiSelesai(Object title) {
    return 'Are you sure you want to mark \"$title\" as complete?';
  }

  @override
  String ditandaiSelesai(Object title) {
    return '$title marked complete!';
  }

  @override
  String get sudahSelesai => 'Already Complete';

  @override
  String gambarPlaceholder(Object url) {
    return 'Image: $url\\n\\n(Tap to view fullscreen in Phase 3+)';
  }

  @override
  String get homeContinueLearning => 'Continue Learning';

  @override
  String get homeQuickShortcuts => 'Quick Shortcuts';

  @override
  String get homeMiniGames => 'Mini-Games';

  @override
  String get homeStudyReady => 'Ready to study electronics today?';

  @override
  String get homeProgressLabel => 'PROGRESS BELAJAR';

  @override
  String get homeCourseTitle => 'Basic Electronics';

  @override
  String get homeStreakLabel => 'Streak';

  @override
  String homeStreakDays(Object days) {
    return '$days days';
  }

  @override
  String get homeCoinsLabel => 'Coins';

  @override
  String get homeModuleLabel => 'Module';

  @override
  String homeModuleText(Object count) {
    return '$count Module completed';
  }

  @override
  String get homeJoinClass => 'Join Class';

  @override
  String get homeJoinClassDesc => 'Enter class code from your teacher';

  @override
  String get homeJoinSuccess => 'Successfully joined class!';

  @override
  String get homeClassCodeLabel => 'Class Code';

  @override
  String get homeClassCodeHint => 'Example: ABC123';

  @override
  String get homeGabung => 'Join';

  @override
  String get homeClassNotFound => 'Class not found';

  @override
  String get homeContactTeacher =>
      'Contact your teacher for the correct class code';

  @override
  String get homeNoClassName => 'No Name';

  @override
  String get homeKode => 'Code:';

  @override
  String get homeLevelCompleted => 'Completed';

  @override
  String homeLevelCurrent(Object level) {
    return 'Level $level';
  }

  @override
  String get homeExploreMateri => 'Explore Materials';

  @override
  String get homeStartLearning => 'Start Learning';

  @override
  String get homeContinue => 'Continue';

  @override
  String get homeGuessComponent => 'Guess Component';

  @override
  String get homeGuessDesc => 'Guess component & read resistor color bands!';

  @override
  String get homeCircuitRush => 'Circuit Rush';

  @override
  String get homeCircuitRushDesc => 'Guide electrons past resistor obstacles!';

  @override
  String get homeCableConnect => 'Connect Cable';

  @override
  String get homeCableConnectDesc =>
      'Arrange closed cable paths through components!';

  @override
  String get homePlay => 'Play';

  @override
  String get guruWelcome => 'Welcome,';

  @override
  String get guruActivities => 'Recent Activities';

  @override
  String get guruStatsClasses => 'Classes';

  @override
  String get guruStatsStudents => 'Students';

  @override
  String get guruStatsActiveAssignments => 'Active Assignments';

  @override
  String get guruCreateClass => '+ Create Class';

  @override
  String get guruNotLoggedIn => 'Not Logged In';

  @override
  String get guruLoginPrompt => 'Please log in as a teacher to manage classes.';

  @override
  String get guruNoClasses => 'No Classes';

  @override
  String get guruCreateClassPrompt =>
      'Tap \"+ Create Class\" to create a new class.';

  @override
  String get guruCreateClassTitle => 'Create New Class';

  @override
  String get guruClassNameLabel => 'Class Name';

  @override
  String get guruClassNameHint => 'Example: 10 IPA 1';

  @override
  String get guruClassNameRequired => 'Class name cannot be empty';

  @override
  String get guruCancel => 'Cancel';

  @override
  String get guruCreate => 'Create';

  @override
  String get guruLoginFirst => 'Please log in first';

  @override
  String guruClassCreated(Object code, Object name) {
    return 'Class \"$name\" created successfully (Code: $code)';
  }

  @override
  String guruClassCreateFailed(Object error) {
    return 'Failed to create class: $error';
  }

  @override
  String get homeCalcResistor => 'Resistor Calculator';

  @override
  String get homeCalcResistorDesc => 'Read color bands';

  @override
  String get homeCalcOhm => 'Ohm Calculator';

  @override
  String get homeCalcOhmDesc => 'Calculate V, I, R';

  @override
  String get defaultName => 'Budi Santoso';

  @override
  String get defaultEmail => 'budi.santoso@sekolah.sch.id';

  @override
  String get fotoProfilDiperbarui => 'Profile photo updated';

  @override
  String get gagalUnggahFoto =>
      'Failed to select or upload profile photo. Please try again.';

  @override
  String get profilDiperbarui => 'Profile updated';

  @override
  String get gagalSimpanProfil => 'Failed to save profile. Please try again.';

  @override
  String get editProfil => 'Edit Profile';

  @override
  String get tambahFoto => 'Add photo';

  @override
  String get pilihFotoGaleri => 'Choose from gallery';

  @override
  String get ledSimTitle => 'Running LED Simulation';

  @override
  String get ledSimDesc =>
      'Observe how microcontroller digital pins turn on a series of LEDs alternately.';

  @override
  String ledStatusActive(Object pin) {
    return 'Active: Pin D$pin HIGH';
  }

  @override
  String get ledStatusStandby => 'Status: Standby (All Pins LOW)';

  @override
  String get ledBtnStop => 'Stop Animation';

  @override
  String get ledBtnStart => 'Start Animation';

  @override
  String get ledConceptTitle => 'How It Works';

  @override
  String get ledConceptText =>
      '1. Microcontroller sends HIGH (5V) signal to one pin.\\n2. LED turns on because current flows through resistor to GND.\\n3. Loop routine turns off LED (LOW) then switches to next pin.';

  @override
  String get pbSimTitle => 'Push Button Simulation';

  @override
  String get pbSimDesc =>
      'Press and hold the tactile switch below to send current to the LED.';

  @override
  String get pbCircuitClosed => 'CLOSED CIRCUIT: CURRENT FLOWING';

  @override
  String get pbCircuitOpen => 'OPEN CIRCUIT: STANDBY';

  @override
  String get pbBtnPressed => 'Pressed';

  @override
  String get pbBtnHold => 'Press & Hold';

  @override
  String get pbLedOn => 'LED ON';

  @override
  String get pbLedOff => 'LED OFF';

  @override
  String get relaySimTitle => '5V Relay Module Simulation';

  @override
  String get relayOn => 'ON';

  @override
  String get relayOff => 'OFF';

  @override
  String get relayDesc =>
      'Active LOW logic: Give LOW (0V) signal on Pin D7 to send current to relay coil.';

  @override
  String get relayDc12v => 'DC 12V';

  @override
  String get relayLoadOn => 'LOAD (ON)';

  @override
  String get relayLoadOff => 'LOAD (OFF)';

  @override
  String get rcTitle => 'Resistor Color Code Calculator';

  @override
  String get rcDesc =>
      'Select number of bands then tap a band to change its color.';

  @override
  String get rcBandCount => 'Number of Bands';

  @override
  String get rcBand4 => '4 Bands';

  @override
  String get rcBand5 => '5 Bands';

  @override
  String get rcBand6 => '6 Bands';

  @override
  String get rcReadingTitle => 'How to Read Bands';

  @override
  String get rcReadingText =>
      '• 4 Bands: Digit 1, Digit 2, Multiplier, Tolerance\\n• 5 Bands: Digit 1, Digit 2, Digit 3, Multiplier, Tolerance\\n• 6 Bands: Digit 1, Digit 2, Digit 3, Multiplier, Tolerance, Tempco\\n\\nExample 220 Ω ±5%: Red (2) - Red (2) - Brown (×10) - Gold (±5%)';

  @override
  String rcBandDigit(Object n) {
    return 'Band $n (Digit)';
  }

  @override
  String rcBandMultiplier(Object n) {
    return 'Band $n (Multiplier)';
  }

  @override
  String rcBandTolerance(Object n) {
    return 'Band $n (Tolerance)';
  }

  @override
  String rcBandTempco(Object n) {
    return 'Band $n (Tempco)';
  }

  @override
  String get ohmSimTitle => 'Closed Circuit & Ohm\'s Law Simulation';

  @override
  String get ohmSimDesc =>
      'Observe electric current flow in a closed circuit from battery (+) terminal, through resistance and load, back to (-) terminal.';

  @override
  String get ohmSwitchOpen => 'OPEN';

  @override
  String get ohmSwitchClosed => 'CLOSED';

  @override
  String ohmVoltage(Object v) {
    return 'Voltage: $v V';
  }

  @override
  String ohmResistance(Object r) {
    return 'Resistance: $r Ω';
  }

  @override
  String ohmCurrent(Object i) {
    return 'Current: $i mA';
  }

  @override
  String ohmCircuitClosed(Object i) {
    return 'CLOSED CIRCUIT: Current Flowing ($i mA)';
  }

  @override
  String get ohmCircuitOpen => 'OPEN CIRCUIT: Current Cut Off (0.0 mA)';

  @override
  String get ohmBtnOpen => 'Open Switch (OFF)';

  @override
  String get ohmBtnClose => 'Close Switch (ON)';

  @override
  String get ohmParamTitle => 'Parameter Settings';

  @override
  String get ohmParamDesc =>
      'Change voltage or resistance values to see their effect on particle speed and lamp brightness.';

  @override
  String get ohmVoltageLabel => 'Voltage (V)';

  @override
  String get ohmResistanceLabel => 'Resistance (R)';

  @override
  String get ohmConceptTitle => 'Closed Circuit & Ohm\'s Law Concept';

  @override
  String get ohmConceptText =>
      '1. Closed Circuit: Current only flows when there is a closed conductor path from the battery (+) terminal to the load and back to the (-) terminal.\\n\\n2. Resistor Resistance (R): Resistor limits the rate of charge particles. The higher the resistance, the slower the current flow.\\n\\n3. Lamp Brightness: Current (I = V / R) determines lamp brightness. Higher current makes the lamp brighter.';

  @override
  String get ohmLampLabel => 'Lamp';

  @override
  String get ohmSwitchLabelOn => 'Switch ON';

  @override
  String get ohmSwitchLabelOff => 'Switch OFF';

  @override
  String get motorSimTitle => 'Motor Simulation';

  @override
  String get motorServo => 'Servo';

  @override
  String get motorDc => 'DC Motor';

  @override
  String get motorStepper => 'Stepper Motor';

  @override
  String get motorStatusRunning => 'Running';

  @override
  String get motorStatusStopped => 'Stopped';

  @override
  String get motorStatusStalled => 'Stalled';

  @override
  String get motorServoTitle => 'SG90 Servo Motor Simulation';

  @override
  String get motorDcTitle => 'DC Motor & PWM Control Simulation';

  @override
  String get motorStepperTitle => 'Stepper 28BYJ-48 + ULN2003 Simulation';

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
    return 'Distance: $d cm';
  }

  @override
  String sensorLight(Object l) {
    return 'Light: $l %';
  }

  @override
  String sensorTemperature(Object t) {
    return 'Temp: $t °C';
  }

  @override
  String sensorHumidity(Object h) {
    return 'Humidity: $h %';
  }

  @override
  String sensorGas(Object g) {
    return 'Gas: $g ppm';
  }

  @override
  String get sensorFanOn => 'FAN ON';

  @override
  String get sensorFanOff => 'FAN OFF';

  @override
  String get sensorAlarmBlink => 'ALARM BLINK';

  @override
  String get sensorStandby => 'STANDBY';

  @override
  String get rcResultTitle => 'Resistance Value';

  @override
  String rcToleranceLabel(Object t) {
    return 'Tolerance: ±$t%';
  }

  @override
  String rcTempcoLabel(Object t) {
    return 'Tempco: $t ppm/K';
  }

  @override
  String get sensorHcsr04Title => 'Ultrasonic Sensor HC-SR04';

  @override
  String get sensorHcsr04Desc =>
      'Sound waves emitted from Transmitter (T), bounce off object, and enter Receiver (R).';

  @override
  String get sensorHcsr04Panel => 'Object Distance (2 cm - 400 cm)';

  @override
  String sensorHcsr04StatusDanger(Object d) {
    return 'Distance: $d cm (Danger!)';
  }

  @override
  String sensorHcsr04StatusSafe(Object d) {
    return 'Distance: $d cm (Safe)';
  }

  @override
  String get sensorHcsr04SubDanger =>
      'Distance < 20 cm -> LED Indicator Green ON';

  @override
  String get sensorHcsr04SubSafe => 'Distance >= 20 cm -> LED OFF';

  @override
  String get sensorHcsr04BadgeOn => 'LED: ON';

  @override
  String get sensorHcsr04BadgeOff => 'LED: OFF';

  @override
  String get sensorLdrTitle => 'Light Sensor LDR';

  @override
  String get sensorLdrDesc =>
      'When light < 30%, LDR resistance increases so the lamp turns on automatically.';

  @override
  String get sensorLdrPanel => 'Light Intensity (0% - 100%)';

  @override
  String get sensorLdrStatusDark => 'Condition: Dark -> Lamp ON';

  @override
  String get sensorLdrStatusBright => 'Condition: Bright -> Lamp OFF';

  @override
  String sensorLdrSub(Object l) {
    return 'Intensity: $l% (Dark threshold < 30%)';
  }

  @override
  String get sensorLdrBadgeOn => 'GLOW: ON';

  @override
  String get sensorLdrBadgeOff => 'GLOW: OFF';

  @override
  String get sensorDht11Title => 'Temperature & Humidity Sensor DHT11';

  @override
  String get sensorDht11Desc =>
      'Measures temperature & air humidity. If temp > 30°C, cooling fan turns on.';

  @override
  String get sensorDht11Panel =>
      'Temperature (20°C - 40°C) & Humidity (0% - 100%)';

  @override
  String sensorDht11Status(Object h, Object t) {
    return 'Temp: $t°C | Humidity: $h%';
  }

  @override
  String get sensorDht11FanOn => 'FAN ON';

  @override
  String get sensorDht11FanOff => 'FAN OFF';

  @override
  String get sensorMq135Title => 'Gas Sensor MQ-135';

  @override
  String get sensorMq135Desc =>
      'Detects gas/smoke concentration in the air. If above threshold, alarm LED blinks.';

  @override
  String get sensorMq135Panel => 'Gas Concentration (0 - 1000 ppm)';

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
  String get sensorTempHeader => 'Temperature';

  @override
  String get sensorHumidityHeader => 'Humidity';

  @override
  String get motorSketchTitle => 'ARDUINO SKETCH LIVE PREVIEW';

  @override
  String get motorInputA0 => 'A0 → Output';

  @override
  String get motorInputD2D3 => 'D2/D3 → Output';

  @override
  String get motorDcForward => 'Maju (CW)';

  @override
  String get motorDcReverse => 'Mundur (CCW)';

  @override
  String get motorDcGas => 'GAS ▲ (Hold)';

  @override
  String get motorDcBrake => 'REM ▼ (Hold)';

  @override
  String get motorDcStop => 'STOP';

  @override
  String get motorDcPresetFwd200 => 'Forward (PWM 200)';

  @override
  String get motorDcPresetRev100 => 'Reverse (PWM 100)';

  @override
  String get motorDcPowerLabel => 'DC Motor Main Switch (Soft-Start)';

  @override
  String get motorDcPowerSubtitle =>
      'When ON, speed ramps up gradually to target PWM';

  @override
  String get motorDcAutoBrakeLabel => 'Auto-Brake (Release GAS = Decelerate)';

  @override
  String get motorDcAutoBrakeSubtitle =>
      'Auto coasting when GAS button is released';

  @override
  String motorDcStalled(Object pwm) {
    return 'Torque insufficient (stall): PWM below $pwm cannot rotate rotor.';
  }

  @override
  String get motorInputDeviceTitle => 'INPUT DEVICE';

  @override
  String get motorInputAnalog => 'Analog input (ADC 0–1023)';

  @override
  String get motorInputDigital => 'Digital input (HIGH/LOW)';

  @override
  String get motorInputPotentiometer => 'Potentiometer';

  @override
  String get motorInputSwitchPushButton => 'Switch / Push Button';

  @override
  String get motorServoPresetTitle => 'PRESET ANGLE & STEP (HOLD TO REPEAT)';

  @override
  String get motorServoSweepLabel => 'Sweep Mode (0° ↔ 180°)';

  @override
  String get motorServoSweepSubtitle =>
      'Moves back and forth automatically like Arduino Sweep example';

  @override
  String get motorServoSweepSpeed => 'Sweep Speed:';

  @override
  String get motorSpeedSlow => 'Slow';

  @override
  String get motorSpeedMedium => 'Medium';

  @override
  String get motorSpeedFast => 'Fast';

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
  String get stepperHalfRev => '½ Rev (180°)';

  @override
  String get stepperFullRev => '1 Rev (360°)';

  @override
  String get stepperResetZero => 'Reset 0°';

  @override
  String stepperAutoRunLabel(Object dir) {
    return 'Auto-Run Stepper ($dir)';
  }

  @override
  String get stepperAutoRunSubtitle => 'Steps continuously at selected speed';

  @override
  String get stepperDirCw => 'CW ↻';

  @override
  String get stepperDirCcw => 'CCW ↺';

  @override
  String get telemetryTitle => 'TELEMETRY & OSCILLOSCOPE';

  @override
  String get telemetryPwmServo => 'PWM 50 Hz (Period 20 ms)';

  @override
  String get telemetryPwmDc => 'PWM ~490 Hz (Pin D5)';

  @override
  String get telemetryStepSequence => '4-Coil Step Sequence (IN1–IN4)';

  @override
  String get telemetryActualAngle => 'Actual Angle';

  @override
  String get telemetryTargetAngle => 'Target Angle';

  @override
  String get telemetryPulseWidth => 'Pulse Width';

  @override
  String get telemetryFrequency => 'Frequency';

  @override
  String get telemetryPwm => 'PWM';

  @override
  String get telemetryDutyCycle => 'Duty Cycle';

  @override
  String get telemetryRpm => 'RPM';

  @override
  String get telemetryDirection => 'Direction';

  @override
  String get telemetryDirectionCw => 'CW (Forward)';

  @override
  String get telemetryDirectionCcw => 'CCW (Reverse)';

  @override
  String get telemetryDirectionStall => 'STALL';

  @override
  String get telemetryDirectionStop => 'STOP';

  @override
  String get telemetryStepCounter => 'Step Counter';

  @override
  String get telemetryStepperAngle => 'Angle';

  @override
  String get telemetryStepperCoils => 'Coils ABCD';

  @override
  String get telemetryStepperSpeed => 'Speed';

  @override
  String get potentiometerTitle => 'Potentiometer Rotary (A0)';

  @override
  String get ohmCalcTitle => 'Ohm\'s Law Calculator';

  @override
  String get ohmCalcVoltageLabel => 'Voltage (V)';

  @override
  String get ohmCalcCurrentLabel => 'Current (I)';

  @override
  String get ohmCalcResistanceLabel => 'Resistance (R)';

  @override
  String get ohmCalcVoltageUnit => 'Volt (V)';

  @override
  String get ohmCalcCurrentUnit => 'Ampere (A)';

  @override
  String get ohmCalcResistanceUnit => 'Ohm (Ω)';

  @override
  String get ohmCalcAutoResult => 'Auto result';

  @override
  String get ohmCalcHintValue => '0';

  @override
  String get ohmCalcErrRZero => 'Resistance (R) cannot be 0';

  @override
  String get ohmCalcErrIZero => 'Current (I) cannot be 0';

  @override
  String get ohmCalcDesc =>
      'Fill 2 values, the third is calculated automatically';

  @override
  String get ohmCalcBasicFormulas => 'Basic Formulas';

  @override
  String get ohmCalcResetButton => 'Reset';

  @override
  String get authErrNameRequired => 'Full name is required';

  @override
  String get authErrNameMin => 'Full name must be at least 2 characters';

  @override
  String get authErrEmailRequired => 'Email is required';

  @override
  String get authErrEmailInvalid => 'Invalid email format';

  @override
  String get authErrPasswordRequired => 'Password is required';

  @override
  String get authErrPasswordMin => 'Password must be at least 6 characters';

  @override
  String get authErrConfirmPasswordRequired => 'Confirm password is required';

  @override
  String get authErrConfirmPasswordMismatch => 'Passwords do not match';

  @override
  String get authErrTeacherCodeRequired =>
      'Teacher verification code is required';

  @override
  String get authErrTeacherCodeNotFound =>
      'Teacher verification code not found.';

  @override
  String get authErrTeacherCodeInvalid =>
      'Teacher verification code is invalid.';

  @override
  String get authErrTeacherCodePermissionDenied =>
      'Failed to check code (Access Denied). Please ensure Firestore Rules are correct.';

  @override
  String get registerNameLabel => 'Full Name';

  @override
  String get registerNameHint => 'Enter your full name';

  @override
  String get registerEmailHint => 'name@school.sch.id';

  @override
  String get registerPasswordHint => 'Minimum 6 characters';

  @override
  String get registerConfirmPasswordLabel => 'Confirm Password';

  @override
  String get registerConfirmPasswordHint => 'Retype your password';

  @override
  String get registerRoleStudent => 'Student';

  @override
  String get registerRoleTeacher => 'Teacher';

  @override
  String get registerTeacherCodeLabel => 'Teacher Verification Code';

  @override
  String get registerTeacherCodeHint => 'Enter verification code';

  @override
  String get registerTeacherCodeDescription =>
      'Verification code is provided by the admin. Do not share the code with students.';

  @override
  String get authErrEmailAlreadyInUse =>
      'This email is already registered. Try signing in or use a different email.';

  @override
  String get authErrWeakPassword =>
      'Password is too weak. Use at least 8 characters.';

  @override
  String get authErrNetworkFailed =>
      'No internet connection. Check your network and try again.';

  @override
  String get authErrTooManyRequests =>
      'Too many attempts. Wait a few minutes and try again.';

  @override
  String get authErrOperationNotAllowed =>
      'Email registration is disabled. Contact admin.';

  @override
  String get authErrSessionExpired =>
      'Your session has expired. Please sign in again.';

  @override
  String get authErrInvalidCredentials => 'Invalid email or password.';

  @override
  String get authErrServerBusy =>
      'Server is busy or connection is lost. Try again shortly.';

  @override
  String get authErrPermissionDenied =>
      'You don\'t have permission for this action.';

  @override
  String get authErrUnknown => 'Something went wrong. Please try again.';

  @override
  String get passwordStrengthWeak => 'Weak';

  @override
  String get passwordStrengthMedium => 'Medium';

  @override
  String get passwordStrengthStrong => 'Strong';

  @override
  String get resistorCalcSheetTitle => 'Quick Tools';

  @override
  String get resistorCalcCloseTooltip => 'Close';

  @override
  String get authLoadingPreparing => 'Preparing your account...';

  @override
  String get authLoadingWaitMessage =>
      'Please wait, loading your account role data.';

  @override
  String get authLoadingFailedTitle => 'Failed to Set Up Account';

  @override
  String get authLoadingFailedMessage =>
      'An issue occurred while loading your account role. Check your internet connection.';

  @override
  String get authLoadingRetrying => 'Retrying...';

  @override
  String get authLoadingRetry => 'Try Again';

  @override
  String get authLoadingLoggingOut => 'Logging out...';

  @override
  String get authLoadingLogout => 'Logout';

  @override
  String get verificationPendingHeader => 'Check Your Email!';

  @override
  String get verificationPendingSpamHint =>
      'Not found? Check Spam or Promotions folder.';

  @override
  String get verificationPendingResending => 'Sending...';

  @override
  String get verificationPendingCheckButton => 'I have verified';

  @override
  String get verificationPendingLoggingOut => 'Logging out...';

  @override
  String get verificationPendingBackToLogin => 'Back to Login';

  @override
  String get verificationPendingErrorDefault =>
      'An issue occurred while loading your account. Check your internet connection.';

  @override
  String get verificationPendingResent => 'Verification email has been resent.';

  @override
  String get verificationPendingNotVerified =>
      'Your email has not been verified yet. Please click the link in the email.';

  @override
  String get verificationPendingDescEmailPrefix =>
      'We have sent a verification link to: ';

  @override
  String get verificationPendingDescEmailSuffix =>
      '. Please open your email and click the link to activate your account.';

  @override
  String get verificationPendingDescGeneric =>
      'We have sent a verification link to your email. Please open your email and click the link to activate your account.';

  @override
  String verificationPendingResendCooldown(Object seconds) {
    return 'Resend (${seconds}s)';
  }

  @override
  String get verificationPendingResendLabel => 'Resend Verification Email';

  @override
  String get verificationPendingResendingEn => 'Sending...';

  @override
  String get gameCableConnectTooltipBack => 'Back';

  @override
  String get gameCableConnectTooltipRedo => 'Redo Path';

  @override
  String get gameCableConnectCircuitClosed => 'Circuit Closed';

  @override
  String get gameCableConnectExit => 'Exit';

  @override
  String get gameCableConnectTimeUp => 'Time\'s Up';

  @override
  String get gameCableConnectTryAgain => 'Try Again';

  @override
  String get gameCableConnectNextLevel => 'Next Level (+10s)';

  @override
  String get gameCableConnectFeedback =>
      'Drag wire from (+) through all components to (-).';

  @override
  String get gameCableConnectChipCurrent => 'Current Flowing!';

  @override
  String get gameCircuitRushTooltipBack => 'Back';

  @override
  String get gameCircuitRushTooltipResume => 'Resume';

  @override
  String get gameCircuitRushTooltipPause => 'Pause';

  @override
  String get gameCircuitRushTitle => 'Circuit Rush';

  @override
  String get gameCircuitRushStart => 'Start Game';

  @override
  String get gameCircuitRushPaused => 'Game Paused';

  @override
  String get gameCircuitRushResumeBtn => 'Resume';

  @override
  String get gameCircuitRushRestartBtn => 'Restart';

  @override
  String get gameCircuitRushExitBtn => 'Exit';

  @override
  String get gameCircuitRushShortCircuit => 'Short Circuit';

  @override
  String get gameCircuitRushGameOverRetry => 'Play Again';

  @override
  String gameGuessLevel(Object level) {
    return 'Level $level';
  }

  @override
  String get gameCircuitRushChipShort => 'Short Circuit!';

  @override
  String get gameCircuitRushReadyDesc =>
      'Tap screen to jump over resistor gaps and collect volt coins!';

  @override
  String get simulasiTitle => 'Simulasi';

  @override
  String get simulasiNewProject => 'Open New Project';

  @override
  String get simulasiExistingProjects => 'Existing Projects';

  @override
  String get simulasiLedBlinkerTitle => 'LED Blinker';

  @override
  String get simulasiLedBlinkerDesc => 'Basic Arduino LED blink simulation';

  @override
  String get simulasiTooltipBack => 'Back';

  @override
  String get simulasiDebugAvrTitle => 'Debug AVR';

  @override
  String get simulasiSimMachine => 'Simulation Machine';

  @override
  String get simulasiModeIsolate => 'Isolate';

  @override
  String get simulasiModeTimer => 'Timer';

  @override
  String get simulasiStopped => 'Stopped';

  @override
  String get simulasiBtnStart => 'Start';

  @override
  String get simulasiBtnStop => 'Stop';

  @override
  String get simulasiBlinkCircuit => 'Blink Circuit';

  @override
  String get simulasiLedOn => 'On';

  @override
  String get simulasiLedOff => 'Off';

  @override
  String get simulasiEditorDefaultName => 'Simulator Velxio';

  @override
  String get simulasiBtnReload => 'Reload';

  @override
  String get simulasiConnDisconnected => 'Connection Lost';

  @override
  String get simulasiBtnRetry => 'Try Again';

  @override
  String get simulasiSubtitle =>
      'Design and test virtual circuits directly in the browser.';

  @override
  String get simulasiTrafficLightTitle => '4-Way Traffic Light';

  @override
  String get simulasiTrafficLightDesc => '4-way traffic light simulation';

  @override
  String get simulasiCanvas2dTitle => 'Canvas 2D';

  @override
  String get kelasJoinSuccess => 'Successfully joined class!';

  @override
  String get kelasNoClassYet => 'Don\'t have a class yet?';

  @override
  String get kelasTabForum => 'Forum';

  @override
  String get kelasTabTugas => 'Assignments';

  @override
  String get kelasTabOrang => 'People';

  @override
  String get postDetailTaskMarkedComplete => 'Task marked complete';

  @override
  String get postDetailSubmissionCancelled => 'Submission cancelled';

  @override
  String postDetailDeleteTitle(Object type) {
    return 'Delete $type?';
  }

  @override
  String get postDetailDeleteConfirm => 'This action cannot be undone.';

  @override
  String get postDetailCancel => 'Cancel';

  @override
  String get postDetailDelete => 'Delete';

  @override
  String get postDetailDeleted => 'Deleted successfully';

  @override
  String get postDetailEditComingSoon => 'Edit post coming soon';

  @override
  String get postDetailUser => 'User';

  @override
  String get postDetailEdited => 'edited';

  @override
  String get postDetailNoDeadline => 'No deadline';

  @override
  String postDetailDeadline(Object date) {
    return 'Deadline: $date';
  }

  @override
  String get postDetailOverdue => 'Past deadline';

  @override
  String postDetailComments(Object count) {
    return 'Comments ($count)';
  }

  @override
  String get postDetailNoComments => 'No comments yet. Be the first!';

  @override
  String get postDetailCommentsDisabled => 'Comments disabled by teacher.';

  @override
  String get postDetailCommentHint => 'Write a comment...';

  @override
  String get postDetailSend => 'Send';

  @override
  String get postDetailViewCompleted => 'View completed students';

  @override
  String get postDetailCompleted => '✓ Completed';

  @override
  String get postDetailCancelSubmission => 'Cancel';

  @override
  String get postDetailSubmittedLate => 'Submitted after deadline';

  @override
  String get postDetailSubmitLate => 'Submit (Late)';

  @override
  String get postDetailMarkComplete => 'Mark Complete';

  @override
  String get postDetailUploadFile => 'Upload File';

  @override
  String get postDetailUploadComingSoon => 'Upload feature coming soon';

  @override
  String get postDetailDetailTask => 'Task Details';

  @override
  String get postDetailDetailAnnouncement => 'Announcement Details';

  @override
  String get postDetailEditMenu => 'Edit';

  @override
  String get postDetailDeleteMenu => 'Delete';

  @override
  String get postDetailFailedLoadComments => 'Failed to load comments';

  @override
  String get postDetailFailedLoad => 'Failed to load';

  @override
  String get postDetailRetry => 'Try Again';

  @override
  String get postDetailNotFound => 'Post Not Found';

  @override
  String get postDetailNotFoundMsg => 'Post not found or already deleted.';

  @override
  String get postDetailBack => 'Back';

  @override
  String get postDetailStudentsCompleted => 'Completed Students';

  @override
  String get postDetailNoStudentsCompleted =>
      'No students have completed this task yet.';

  @override
  String postDetailCompletedAt(Object date) {
    return 'Completed: $date';
  }

  @override
  String get postDetailClose => 'Close';

  @override
  String get postDetailYou => 'You';

  @override
  String get postDetailDeleteComment => 'Delete Comment?';

  @override
  String postDetailFailedSendComment(Object error) {
    return 'Failed to send comment: $error';
  }

  @override
  String postDetailFailedUpdateStatus(Object error) {
    return 'Failed to update status: $error';
  }

  @override
  String postDetailFailedDelete(Object error) {
    return 'Failed to delete: $error';
  }

  @override
  String get createPostAnnouncementPosted => 'Announcement posted successfully';

  @override
  String get createPostCreateAssignment => 'Create New Assignment';

  @override
  String get createPostAssignmentDescription => 'Assignment Description';

  @override
  String get editPostEditAssignment => 'Edit Assignment';

  @override
  String get editPostEditAnnouncement => 'Edit Announcement';

  @override
  String get editPostTitle => 'Title';

  @override
  String get editPostAssignmentTitle => 'Assignment Title';

  @override
  String get editPostTitleOptional => 'Title (Optional)';

  @override
  String get editPostDeadline => 'Deadline';

  @override
  String get editPostSelectDeadline => 'Select Deadline';

  @override
  String get editPostAllowComments => 'Allow Comments';

  @override
  String get editPostCancel => 'Cancel';

  @override
  String get editPostSaving => 'Saving...';

  @override
  String get editPostSave => 'Save';

  @override
  String get editPostContentEmpty => 'Content cannot be empty';

  @override
  String get editPostUpdated => 'Successfully updated';

  @override
  String guruKelasCardSiswa(Object count) {
    return '$count siswa';
  }

  @override
  String get profilStatClasses => 'Classes';

  @override
  String get profilStatStudents => 'Students';

  @override
  String get profilStatAssignments => 'Assignments';

  @override
  String get profilMenuEditProfil => 'Edit Profile';

  @override
  String get profilMenuEditProfilSub => 'Edit name, photo, and account info';

  @override
  String get profilMenuNotifikasi => 'Notifications';

  @override
  String get profilMenuNotifikasiSub => 'Manage notification preferences';

  @override
  String get profilMenuBantuan => 'Help & Support';

  @override
  String get profilMenuBantuanSub => 'FAQ, guides, and contact us';

  @override
  String get profilMenuKeamanan => 'Security';

  @override
  String get profilMenuKeamananSub => 'Change password and account security';

  @override
  String get profilMenuBahasa => 'Language';

  @override
  String get profilMenuBahasaSub => 'Change app language';

  @override
  String get profilComingSoon => 'Feature coming soon';

  @override
  String get profilLogout => 'Logout';

  @override
  String get profilLogoutConfirmTitle => 'Confirm Logout';

  @override
  String get profilLogoutConfirmMsg => 'Are you sure you want to log out?';

  @override
  String get profilCancel => 'Cancel';

  @override
  String get profilLogoutYes => 'Yes, Logout';

  @override
  String get profilLogoutFailed => 'Failed to log out. Please try again.';

  @override
  String get profilLoadFailed => 'Failed to load profile';

  @override
  String get profilLoadFailedMsg => 'Check your internet connection';

  @override
  String get profilFallbackName => 'Teacher';

  @override
  String get profilFallbackRoleLabel => 'Teacher';

  @override
  String get profilNIPUnavailable => 'NIP not available';

  @override
  String get profilLanguageDialogTitle => 'Choose Language';

  @override
  String homeProgressCaption(Object completed, Object total) {
    return '$completed of $total materials completed';
  }

  @override
  String homeCoinsCount(Object coins) {
    return '$coins Coins';
  }

  @override
  String homeProgressSemantics(Object completed, Object percent, Object total) {
    return 'Learning progress $percent%, $completed of $total materials completed';
  }

  @override
  String get homeAllCompleted => 'All materials completed 🎉';

  @override
  String homeSubtitleDone(Object level) {
    return 'Level $level • All modules completed';
  }

  @override
  String homeSubtitleStart(Object level) {
    return 'Level $level • Start Learning';
  }

  @override
  String homeSubtitleProgress(Object completed, Object level, Object total) {
    return 'Level $level • $completed of $total materials';
  }

  @override
  String homeSubtitleNext(Object level) {
    return 'Level $level • Next material';
  }

  @override
  String materiGagalMemuatLevel(Object error) {
    return 'Failed to load level: $error';
  }

  @override
  String homeLevelLocked(Object level) {
    return 'Level $level, locked';
  }

  @override
  String materiLevelHeader(Object level) {
    return 'LEVEL $level';
  }

  @override
  String get materiChipBelajar => 'Studying';

  @override
  String get materiChipLocked => 'Locked';

  @override
  String get materiGambarTidakDitemukan => 'Image not found';

  @override
  String get materiTabBacaan => 'Reading';

  @override
  String get materiTabVideo => 'Video';

  @override
  String get materiTabPraktik => 'Practice';

  @override
  String levelCaption(Object totalMateri, Object totalMinutes) {
    return '$totalMateri materials • $totalMinutes min';
  }

  @override
  String get levelCaptionEmpty => 'No materials yet';

  @override
  String estimatedTimeShort(Object value) {
    return '$value min';
  }

  @override
  String estimatedTimeMedium(Object value) {
    return '$value min';
  }

  @override
  String estimatedTimeLong(Object value) {
    return '$value min';
  }

  @override
  String get dayMinggu => 'Sunday';

  @override
  String get daySenin => 'Monday';

  @override
  String get daySelasa => 'Tuesday';

  @override
  String get dayRabu => 'Wednesday';

  @override
  String get dayKamis => 'Thursday';

  @override
  String get dayJumat => 'Friday';

  @override
  String get daySabtu => 'Saturday';

  @override
  String get monthJan => 'January';

  @override
  String get monthFeb => 'February';

  @override
  String get monthMar => 'March';

  @override
  String get monthApr => 'April';

  @override
  String get monthMei => 'May';

  @override
  String get monthJun => 'June';

  @override
  String get monthJul => 'July';

  @override
  String get monthAgu => 'August';

  @override
  String get monthSep => 'September';

  @override
  String get monthOkt => 'October';

  @override
  String get monthNov => 'November';

  @override
  String get monthDes => 'December';

  @override
  String get materiKomponenL1KomBreadboardEstimatedTime => '5 minutes';

  @override
  String get materiKomponenL1KomBreadboardTitle => 'Breadboard';

  @override
  String get materiKomponenL1KomHukumOhmEstimatedTime => '5 minutes';

  @override
  String get materiKomponenL1KomHukumOhmTitle => 'Ohm\'s Law';

  @override
  String get materiKomponenL1KomKapasitorEstimatedTime => '5 minutes';

  @override
  String get materiKomponenL1KomKapasitorTitle => 'Kapasitor';

  @override
  String get materiKomponenL1KomLedEstimatedTime => '5 minutes';

  @override
  String get materiKomponenL1KomLedTitle => 'LED (Light Emitting Diode)';

  @override
  String get materiKomponenL1KomResistorEstimatedTime => '5 minutes';

  @override
  String get materiKomponenL1KomTactileSwitchEstimatedTime => '5 minutes';

  @override
  String get materiL1L1KomBreadboardEstimatedTime => '5 minutes';

  @override
  String get materiL1L1KomBreadboardTitle => 'Breadboard';

  @override
  String get materiL1L1KomHukumOhmEstimatedTime => '5 minutes';

  @override
  String get materiL1L1KomHukumOhmTitle => 'Ohm\'s Law';

  @override
  String get materiL1L1KomHukumOhmVideoSummary5Heading => 'Bab 3: example Soal';

  @override
  String get materiL1L1KomKapasitorEstimatedTime => '5 minutes';

  @override
  String get materiL1L1KomKapasitorTitle => 'Kapasitor';

  @override
  String get materiL1L1KomLedEstimatedTime => '5 minutes';

  @override
  String get materiL1L1KomLedTitle => 'LED (Light Emitting Diode)';

  @override
  String get materiL1L1KomLedVideoSummary0Heading => 'Bab 1: Pengenalan LED';

  @override
  String get materiL1L1KomLedVideoSummary5Heading => 'Bab 3: Type-Type LED';

  @override
  String get materiL1L1KomResistorEstimatedTime => '5 minutes';

  @override
  String get materiL1L1KomResistorTitle => 'Resistor (way calculating value)';

  @override
  String get materiL1L1KomTactileSwitchEstimatedTime => '5 minutes';

  @override
  String get materiL1L1KomTactileSwitchTitle => 'Tactile Switch (Push Button)';

  @override
  String get materiL1L1KomponenFolderTitle => 'Pengenalan Komponen';

  @override
  String get materiL1L1PosttestQQ1Option0 => 'V = I / R';

  @override
  String get materiL1L1PosttestQQ1Option1 => 'V = I × R';

  @override
  String get materiL1L1PosttestQQ1Option2 => 'R = V × I';

  @override
  String get materiL1L1PosttestQQ1Option3 => 'I = V × R';

  @override
  String get materiL1L1PosttestQQ1Question => 'formula hukum Ohm is...';

  @override
  String get materiL1L1PosttestQQ2Option0 => '10 Ω';

  @override
  String get materiL1L1PosttestQQ2Option1 => '150 Ω';

  @override
  String get materiL1L1PosttestQQ2Option2 => '220 Ω';

  @override
  String get materiL1L1PosttestQQ2Option3 => '10 kΩ';

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
  String get materiL1L1PretestQQ3Option0 => 'Katoda (−)';

  @override
  String get materiL1L1PretestQQ3Option1 => 'Anoda (+)';

  @override
  String get materiL1L1PretestQQ3Option2 => 'Ground';

  @override
  String get materiL1L1PretestQQ3Option3 => 'Lead tengah';

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
  String get materiL2L2ArrayPointerEstimatedTime => '8 minutes';

  @override
  String get materiL2L2ArrayPointerTitle => 'Array & Pointer';

  @override
  String get materiL2L2ArrayPointerVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL2L2ArrayPointerVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL2L2ArrayPointerVideoSummary4Heading => 'Wawasan Kunci';

  @override
  String get materiL2L2InputOutputEstimatedTime => '10 minutes';

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
  String get materiL2L2OperatorPercabanganEstimatedTime => '10 minutes';

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
  String get materiL2L2PretestQQ1Option2 => 'each tombol ditekan';

  @override
  String get materiL2L2PretestQQ1Option3 => 'not pernah';

  @override
  String get materiL2L2PretestQQ2Option0 => 'int';

  @override
  String get materiL2L2PretestQQ2Option1 => 'bool';

  @override
  String get materiL2L2PretestQQ2Option2 => 'float';

  @override
  String get materiL2L2PretestQQ2Option3 => 'char';

  @override
  String get materiL2L2PretestQQ3Option0 => 'HIGH and LOW';

  @override
  String get materiL2L2PretestQQ3Option1 => 'ON and 0';

  @override
  String get materiL2L2PretestQQ3Option2 => '1 and 2';

  @override
  String get materiL2L2PretestQQ3Option3 => 'VCC and AC';

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
  String get materiL2L2RelayEstimatedTime => '8 minutes';

  @override
  String get materiL2L2RelayTitle => 'Relay';

  @override
  String get materiL2L2RelayVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL2L2RelayVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL2L2RelayVideoSummary4Heading => 'Wawasan Kunci';

  @override
  String get materiL2L2StrukturSketchEstimatedTime => '8 minutes';

  @override
  String get materiL2L2StrukturSketchVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL2L2StrukturSketchVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL2L2StrukturSketchVideoSummary4Heading => 'Wawasan Kunci';

  @override
  String get materiL2L2StrukturSketchVideoSummary6Heading => 'Penutup';

  @override
  String get materiL3L3AdcEstimatedTime => '10 minutes';

  @override
  String get materiL3L3AdcTitle => 'ADC (Analog to Digital Converter)';

  @override
  String get materiL3L3AdcVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL3L3AdcVideoSummary2Heading => 'Sorotan Utama';

  @override
  String get materiL3L3AdcVideoSummary4Heading => 'Wawasan Penting';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorEstimatedTime => '8 minutes';

  @override
  String get materiL3L3PosttestQQ1Option0 => 'V = (nilai ADC / 255) × 5 V';

  @override
  String get materiL3L3PosttestQQ1Option1 => 'V = (nilai ADC / 1023) × 5 V';

  @override
  String get materiL3L3PosttestQQ1Option2 => 'V = nilai ADC × 5 V';

  @override
  String get materiL3L3PosttestQQ1Option3 => 'V = 1023 / value ADC';

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
  String get materiL3L3PretestQQ1Option0 => 'D0–D13';

  @override
  String get materiL3L3PretestQQ1Option1 => 'A0–A5';

  @override
  String get materiL3L3PretestQQ1Option2 => 'RX/TX';

  @override
  String get materiL3L3PretestQQ1Option3 => 'RESET';

  @override
  String get materiL3L3PretestQQ2Option0 => '0–100';

  @override
  String get materiL3L3PretestQQ2Option1 => '0–255';

  @override
  String get materiL3L3PretestQQ2Option2 => '0–1023';

  @override
  String get materiL3L3PretestQQ2Option3 => '0–5';

  @override
  String get materiL3L3PretestQQ3Option0 => '0–100';

  @override
  String get materiL3L3PretestQQ3Option1 => '0–255';

  @override
  String get materiL3L3PretestQQ3Option2 => '0–1023';

  @override
  String get materiL3L3PretestQQ3Option3 => '0–5';

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
  String get materiL3L3PwmEstimatedTime => '10 minutes';

  @override
  String get materiL3L3PwmTitle => 'PWM (Pulse Width Modulation)';

  @override
  String get materiL3L3PwmVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL3L3PwmVideoSummary2Heading => 'Poin-poin Penting';

  @override
  String get materiL3L3PwmVideoSummary4Heading => 'Insight Kunci';

  @override
  String get materiL4L4DebouncingEstimatedTime => '8 minutes';

  @override
  String get materiL4L4DebouncingTitle => 'Debouncing';

  @override
  String get materiL4L4DebouncingVideoSummary8Heading => 'Kesimpulan';

  @override
  String get materiL4L4InterruptEstimatedTime => '10 minutes';

  @override
  String get materiL4L4InterruptTitle => 'Interrupt';

  @override
  String get materiL4L4InterruptVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL4L4InterruptVideoSummary2Heading => 'example Implementasi';

  @override
  String get materiL4L4InterruptVideoSummary4Heading => 'Sorotan';

  @override
  String get materiL4L4InterruptVideoSummary6Heading => 'Wawasan Kunci';

  @override
  String get materiL4L4InterruptVideoSummary8Heading => 'Kesimpulan';

  @override
  String get materiL4L4JenisMotorEstimatedTime => '10 minutes';

  @override
  String get materiL4L4JenisMotorTitle => 'Type Motor: Servo';

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
  String get materiL4L4PosttestQQ2Option1 => 'Jam and tanggal sebenarnya';

  @override
  String get materiL4L4PosttestQQ2Option2 => 'value ADC terakhir';

  @override
  String get materiL4L4PosttestQQ2Option3 => 'Duty cycle PWM';

  @override
  String get materiL4L4PosttestQQ3Option1 => 'Konsumsi memori menjadi nol';

  @override
  String get materiL4L4PosttestQQ3Option2 => 'not membutuhkan fungsi loop()';

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
  String get materiL4L4PretestQQ1Question => 'Servo used for...';

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
  String get materiL4L4TimerTanpaHentiEstimatedTime => '10 minutes';

  @override
  String get materiL4L4TimerTanpaHentiTitle => 'Timer Tanpa Henti (millis)';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary0Heading => 'Ringkasan';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary4Heading => 'Sorotan Utama';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary6Heading => 'Wawasan Kunci';

  @override
  String get materiL5L5M1EstimatedTime => '8 minutes';

  @override
  String get materiL5L5M1Title => 'Deskripsi Proyek & Histeresis';

  @override
  String get materiL5L5M2EstimatedTime => '10 minutes';

  @override
  String get materiL5L5M2Title => 'Rangkaian Lengkap';

  @override
  String get materiL5L5M3EstimatedTime => '15 minutes';

  @override
  String get materiL5L5M3Title => 'Kode Program Kipas Otomatis';

  @override
  String get materiL5L5M4EstimatedTime => '10 minutes';

  @override
  String get materiL5L5M4Title => 'Pengujian & Pengembangan';

  @override
  String get materiL5L5PosttestQQ1Option1 => 'Mempercepat pembacaan sensor';

  @override
  String get materiL5L5PosttestQQ1Option2 => 'Menghemat memori';

  @override
  String get materiL5L5PosttestQQ1Option3 => 'Mengganti sensor';

  @override
  String get materiL5L5PosttestQQ2Option0 => '≤ 28 °C';

  @override
  String get materiL5L5PosttestQQ2Option1 => '≥ 30 °C';

  @override
  String get materiL5L5PosttestQQ2Option2 => 'Tepat 29 °C';

  @override
  String get materiL5L5PosttestQQ2Option3 => 'not terbaca';

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
  String get materiL5L5PosttestQQ5Option0 => 'Galat mutlak / pembanding × 100%';

  @override
  String get materiL5L5PosttestQQ5Option1 => 'Pembanding / galat mutlak';

  @override
  String get materiL5L5PosttestQQ5Option2 => 'DHT11 × 100%';

  @override
  String get materiL5L5PosttestQQ5Option3 => 'Galat mutlak − pembanding';

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
  String get materiL5L5PretestQQ2Option0 => 'Suhu and kelembaban';

  @override
  String get materiL5L5PretestQQ2Option1 => 'Jarak';

  @override
  String get materiL5L5PretestQQ2Option2 => 'Kadar gas';

  @override
  String get materiL5L5PretestQQ2Option3 => 'light';

  @override
  String get materiL5L5PretestQQ2Question => 'Sensor DHT11 mengukur...';

  @override
  String get materiL5L5PretestQQ3Option0 => 'A4 (SDA) and A5 (SCL)';

  @override
  String get materiL5L5PretestQQ3Option1 => 'D0 and D1';

  @override
  String get materiL5L5PretestQQ3Option2 => 'D2 and D3';

  @override
  String get materiL5L5PretestQQ3Option3 => 'A0 and A1';

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
      'Breadboard is alat prototipe for merangkai rangkaian elektronik tanpa menyolder. Memahami pola koneksinya penting agar rangkaian not salah sambung.';

  @override
  String get materiKomponenL1KomBreadboardContent1Text =>
      'Key points:\n- Jalur biru and merah menandai baris that terhubung.\n- Celah tengah memisahkan two sisi, cocok for memasang IC.\n- Adjacent pins are not necessarily connected, check the pattern.\n- Use multimeter continuity mode to test connection.\n- Available in 400 and 830 pin types.';

  @override
  String get materiKomponenL1KomBreadboardDescription =>
      'Breadboard is papan for merangkai komponen elektronik tanpa solder, with pola koneksi pin that already ditentukan.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary0Heading =>
      'Bab 1: Struktur Breadboard';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary1Text =>
      'Breadboard terdiri from deretan pin that connected internally with a certain pattern. Blue and red tracks show mutually connected rows.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary2Text =>
      'Terdapat two breadboard types with different pin counts, around 400 pin and 830 pin, but working principle is the same.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary3Heading =>
      'Bab 2: Pola Koneksi and Celah Tengah';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary4Text =>
      'Pin that adjacent not yet tentu terhubung because there is celah pembatas at bagian tengah. Jalur koneksi umumnya horizontal at sisi pinggir and vertikal at bagian tengah.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary5Text =>
      'Celah tengah dimanfaatkan for memasang IC agar pin kiri and kanan IC not saling terhubung.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary6Heading =>
      'Bab 3: Pengujian and Penggunaan';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary7Text =>
      'Multimeter (avometer) with fungsi continuity test can used for memeriksa apakah pin-pin breadboard saling terhubung.';

  @override
  String get materiKomponenL1KomBreadboardVideoSummary8Text =>
      'Breadboard used for make prototipe rangkaian tanpa menyolder, sehingga memudahkan perubahan and pengujian.';

  @override
  String get materiKomponenL1KomHukumOhmContent0Text =>
      'Ohm\'s Law menghubungkan arus, tegangan, and hambatan in rangkaian listrik. formula dasarnya: I = V / R.';

  @override
  String get materiKomponenL1KomHukumOhmContent1Text =>
      'Key points:\n- Current is directly proportional to voltage.\n- Current is inversely proportional to resistance.\n- Units: I (ampere), V (volt), R (ohm).\n- Can be used to calculate one value if the other two are known.';

  @override
  String get materiKomponenL1KomHukumOhmDescription =>
      'Ohm\'s Law menjelaskan hubungan antara arus, tegangan, and hambatan in rangkaian listrik, with formula I = V / R.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary0Heading =>
      'Bab 1: Pengertian Ohm\'s Law';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary1Text =>
      'Ohm\'s Law is prinsip dasar elektronika that menjelaskan hubungan antara arus listrik (I), tegangan (V), and hambatan (R) in suatu rangkaian.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary2Text =>
      'Arus that mengalir through konduktor berbanding lurus with tegangan that diberikan and berbanding terbalik with hambatannya.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary3Heading =>
      'Bab 2: formula Ohm\'s Law';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary4Text =>
      'Rumusnya is I = V / R, with I in ampere, V in volt, and R in ohm.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary5Heading =>
      'Bab 3: example Soal';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary6Text =>
      'First example is calculating arus that mengalir through sebuah lamp with hambatan and tegangan tertentu.';

  @override
  String get materiKomponenL1KomHukumOhmVideoSummary7Text =>
      'Second example is calculating tegangan that needed for produce arus tertentu on hambatan tertentu.';

  @override
  String get materiKomponenL1KomKapasitorContent0Text =>
      'Kapasitor stores and releases electrical energy. Its functions include maintaining voltage stability, filtering signals, and frequency tuning.';

  @override
  String get materiKomponenL1KomKapasitorContent1Text =>
      'Key points:\n- Struktur: two metal plates with dielectric material between them.\n- Ceramic type for small capacitance and high frequency.\n- Polyester type for audio.\n- Elco and solid capacitor polarized, install according to lead positif and negatif.\n- Variable capacitor for radio frequency tuning.\n- Value range from pF to F.';

  @override
  String get materiKomponenL1KomKapasitorDescription =>
      'Kapasitor is komponen that stores and releases electrical energy with cepat, with type determined by its dielectric material.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary0Heading =>
      'Bab 1: Pengertian Kapasitor';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary10Text =>
      'Pemasangan kapasitor polarized with terbalik can menyebabkan kerusakan, bahkan ledakan.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary1Text =>
      'Kapasitor is komponen elektronik that mampu menyimpan and melepas energi listrik secara cepat. Komponen ini terdiri from two metal plates that dipisahkan oleh material dielektrik that not menghantarkan listrik.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary2Text =>
      'material dielektrik menentukan Type kapasitor, misalnya keramik, kertas, or poliester.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary3Heading =>
      'Bab 2: Type-Type Kapasitor';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary4Text =>
      'Kapasitor keramik common ditemui, berkapasitansi small, and sering dipakai for frekuensi tinggi. Kapasitor poliester banyak dipakai on aplikasi audio.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary5Text =>
      'Kapasitor elektrolitik (Elco) and solid capacitor memiliki kapasitansi besar and polarized, sehingga harus dipasang with benar. Solid capacitor lebih tahan panas and awet, banyak dipakai at motherboard komputer.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary6Text =>
      'Variable capacitor can diatur nilainya secara mekanis and sering dipakai for penyetelan frekuensi on radio.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary7Text =>
      'Superkapasitor memiliki kapasitansi hingga ratusan farad and berpotensi menggantikan baterai on beberapa aplikasi.';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary8Heading =>
      'Bab 3: Rentang Kapasitansi and Keselamatan';

  @override
  String get materiKomponenL1KomKapasitorVideoSummary9Text =>
      'Kapasitansi kapasitor bervariasi from beberapa pikofarad (pF) hingga ratusan farad (F).';

  @override
  String get materiKomponenL1KomLedContent0Text =>
      'LED (Light Emitting Diode) is diode that emit light. Berbeda with lamp incandescent, LED produce light through recombination electron and charge carrier at in semiconductor, sehingga lebih efficient and lebih durable.';

  @override
  String get materiKomponenL1KomLedContent1Text =>
      'Key points:\n- Color LED determined by material semiconductor.\n- Forward voltage (Vf) berbeda for each Color.\n- Beam angle and intensity light can selected according to need.\n- Lead LED has polarity, and Lead long usually is anoda.';

  @override
  String get materiKomponenL1KomLedContent2Text =>
      'Type LED: through-hole (common, 5 mm), SMD (small and thin), high power (needs heatsink), COB (banyak chip in satu modul), RGB (multi-Color), and alfanumerik (display angka and huruf).';

  @override
  String get materiKomponenL1KomLedDescription =>
      'LED is diode that emit light saat dialiri listrik, with Color and tegangan kerja that determined by material semikonduktornya.';

  @override
  String get materiKomponenL1KomLedVideoSummary0Heading =>
      'Bab 1: Pengenalan LED';

  @override
  String get materiKomponenL1KomLedVideoSummary1Text =>
      'LED not lamp ordinary like lamp incandescent, melainkan Type diode that emit light when supplied with electricity. LED terbuat from material semiconductor tipe P and tipe N, and light dihasilkan saat electron and charge carrier bertemu.';

  @override
  String get materiKomponenL1KomLedVideoSummary2Heading =>
      'Bab 2: Color, Tegangan, and Karakteristik';

  @override
  String get materiKomponenL1KomLedVideoSummary3Text =>
      'Color light LED determined by material pembuatnya, that juga menentukan panjang gelombang and tegangan kerja. Contohnya, LED biru biasanya membutuhkan Forward voltage lebih tinggi dibanding LED merah.';

  @override
  String get materiKomponenL1KomLedVideoSummary4Text =>
      'Karakteristik lain that perlu diperhatikan is Beam angle light (around 10° sampai 120°) and intensity light that diukur in millicandela.';

  @override
  String get materiKomponenL1KomLedVideoSummary5Heading =>
      'Bab 3: Type-Type LED';

  @override
  String get materiKomponenL1KomLedVideoSummary6Text =>
      'LED through-hole is tipe that common with size usually 5 mm, easy to install, and polaritasnya mudah dikenali from panjang Lead.';

  @override
  String get materiKomponenL1KomLedVideoSummary7Text =>
      'LED SMD berukuran sangat small and thin, cocok for pemasangan massal on ruang terbatas. LED high power sangat terang but produce panas sehingga requires heatsink.';

  @override
  String get materiKomponenL1KomLedVideoSummary8Text =>
      'LED COB menggabungkan banyak chip in satu modul small. LED RGB terdiri from three Color dasar merah, hijau, and biru that can dikontrol secara independen for produce berbagai Color.';

  @override
  String get materiKomponenL1KomLedVideoSummary9Text =>
      'LED alfanumerik used sebagai tampilan angka and huruf on berbagai alat elektronik.';

  @override
  String get materiKomponenL1KomResistorContent0Text =>
      'value resistor dibaca from kode Color gelang. for resistor at bawah 1 ohm, gelang pengali bernilai pecahan, sehingga value akhirnya bisa berupa desimal.';

  @override
  String get materiKomponenL1KomResistorContent2Text =>
      'Key points:\n- two gelang first is digit signifikan.\n- Gelang third is pengali.\n- Gelang emas menandakan toleransi 5%.\n- Metode that sama berlaku from 1 kiloohm hingga 1 gigaohm.';

  @override
  String get materiKomponenL1KomResistorDescription =>
      'way calculating value resistor with kode Color, termasuk resistor at bawah 1 ohm menggunakan metode second.';

  @override
  String get materiKomponenL1KomResistorTitle =>
      'Resistor (way calculating value)';

  @override
  String get materiKomponenL1KomResistorVideoSummary0Heading =>
      'Bab 1: Metode second for Resistor';

  @override
  String get materiKomponenL1KomResistorVideoSummary1Text =>
      'Video ini membahas way second calculating value resistor, khususnya resistor with value at bawah 1 ohm, menggunakan tabel khusus.';

  @override
  String get materiKomponenL1KomResistorVideoSummary2Text =>
      'Metode ini menyediakan two way perhitungan, yaitu way konvensional and way menggunakan bilangan berpangkat. Hasil keduanya sama.';

  @override
  String get materiKomponenL1KomResistorVideoSummary3Heading =>
      'Bab 2: example Perhitungan';

  @override
  String get materiKomponenL1KomResistorVideoSummary4Text =>
      'Contohnya is resistor with gelang hijau, hitam, silver, and emas. Color hijau bernilai 5, hitam bernilai 0, and silver sebagai pengali bernilai 0,01.';

  @override
  String get materiKomponenL1KomResistorVideoSummary5Text =>
      'Perhitungannya is 50 x 0,01 = 0,5 ohm, with toleransi 5% that ditandai gelang emas.';

  @override
  String get materiKomponenL1KomResistorVideoSummary6Heading =>
      'Bab 3: Cakupan Metode';

  @override
  String get materiKomponenL1KomResistorVideoSummary7Text =>
      'Metode ini juga berlaku for semua resistor with rentang value from 1 kiloohm sampai 1 gigaohm.';

  @override
  String get materiKomponenL1KomTactileSwitchContent0Text =>
      'Tactile switch is push button small that memberikan sinyal on saat ditekan and off saat dilepas. Cocok for input tombol on rangkaian elektronik small.';

  @override
  String get materiKomponenL1KomTactileSwitchContent1Text =>
      'Key points:\n- Sifatnya momentary (tekan for on, lepas for off).\n- Tegangan kerja DC around 4,5 sampai 12 V.\n- Arus maksimum around 100 mA.\n- not disarankan for rangkaian AC.\n- common dipakai on remote control and perangkat elektronik small.';

  @override
  String get materiKomponenL1KomTactileSwitchDescription =>
      'Tactile switch is saklar tekan small that aktif saat ditekan and off saat dilepas, common dipakai on rangkaian DC tegangan rendah.';

  @override
  String get materiKomponenL1KomTactileSwitchTitle =>
      'Tactile Switch (Push Button)';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary0Heading =>
      'Bab 1: Pengenalan Saklar Mini Tactile';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary1Text =>
      'Saklar mini or tactile switch, juga dikenal sebagai micro switch, berukuran sangat small and berfungsi sebagai saklar tekan (push button).';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary2Text =>
      'Saklar ini bekerja secara momentary: on saat ditekan and off saat dilepas.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary3Heading =>
      'Bab 2: Pin and Prinsip Kerja';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary4Text =>
      'Saklar ini umumnya memiliki four pin, but prinsip kerjanya sederhana with two kutub. two pin biasanya berpasangan secara paralel sehingga stabil secara mekanis and listrik.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary5Text =>
      'Terdapat variasi bentuk batang, from panjang, pendek, hingga pipih, sesuai need desain.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary6Heading =>
      'Bab 3: Batasan and Aplikasi';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary7Text =>
      'Saklar used on rangkaian DC with tegangan around 4,5 sampai 12 volt and arus maksimum around 100 mA.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary8Text =>
      'Saklar ini jarang used on rangkaian AC because alasan keselamatan and peruntukannya for sirkuit DC small.';

  @override
  String get materiKomponenL1KomTactileSwitchVideoSummary9Text =>
      'Saklar ditemukan on remote control, TV lama, and set-top box. Pemasangannya dilakukan on PCB, or breadboard for eksperimen.';

  @override
  String get materiL1L1KomBreadboardContent0Text =>
      'Breadboard is alat prototipe for merangkai rangkaian elektronik tanpa menyolder. Memahami pola koneksinya penting agar rangkaian not salah sambung.';

  @override
  String get materiL1L1KomBreadboardContent1Text =>
      'Key points:\n- Jalur biru and merah menandai baris that terhubung.\n- Celah tengah memisahkan two sisi, cocok for memasang IC.\n- Adjacent pins are not necessarily connected, check the pattern.\n- Use multimeter continuity mode to test connection.\n- Available in 400 and 830 pin types.';

  @override
  String get materiL1L1KomBreadboardDescription =>
      'Breadboard is papan for merangkai komponen elektronik tanpa solder, with pola koneksi pin that already ditentukan.';

  @override
  String get materiL1L1KomBreadboardVideoSummary0Heading =>
      'Bab 1: Struktur Breadboard';

  @override
  String get materiL1L1KomBreadboardVideoSummary1Text =>
      'Breadboard terdiri from deretan pin that connected internally with a certain pattern. Blue and red tracks show mutually connected rows.';

  @override
  String get materiL1L1KomBreadboardVideoSummary2Text =>
      'Terdapat two breadboard types with different pin counts, around 400 pin and 830 pin, but working principle is the same.';

  @override
  String get materiL1L1KomBreadboardVideoSummary3Heading =>
      'Bab 2: Pola Koneksi and Celah Tengah';

  @override
  String get materiL1L1KomBreadboardVideoSummary4Text =>
      'Pin that adjacent not yet tentu terhubung because there is celah pembatas at bagian tengah. Jalur koneksi umumnya horizontal at sisi pinggir and vertikal at bagian tengah.';

  @override
  String get materiL1L1KomBreadboardVideoSummary5Text =>
      'Celah tengah dimanfaatkan for memasang IC agar pin kiri and kanan IC not saling terhubung.';

  @override
  String get materiL1L1KomBreadboardVideoSummary6Heading =>
      'Bab 3: Pengujian and Penggunaan';

  @override
  String get materiL1L1KomBreadboardVideoSummary7Text =>
      'Multimeter (avometer) with fungsi continuity test can used for memeriksa apakah pin-pin breadboard saling terhubung.';

  @override
  String get materiL1L1KomBreadboardVideoSummary8Text =>
      'Breadboard used for make prototipe rangkaian tanpa menyolder, sehingga memudahkan perubahan and pengujian.';

  @override
  String get materiL1L1KomHukumOhmContent0Text =>
      'Ohm\'s Law menghubungkan arus, tegangan, and hambatan in rangkaian listrik. formula dasarnya: I = V / R.';

  @override
  String get materiL1L1KomHukumOhmContent1Text =>
      'Key points:\n- Current is directly proportional to voltage.\n- Current is inversely proportional to resistance.\n- Units: I (ampere), V (volt), R (ohm).\n- Can be used to calculate one value if the other two are known.';

  @override
  String get materiL1L1KomHukumOhmDescription =>
      'Ohm\'s Law menjelaskan hubungan antara arus, tegangan, and hambatan in rangkaian listrik, with formula I = V / R.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary0Heading =>
      'Bab 1: Pengertian Ohm\'s Law';

  @override
  String get materiL1L1KomHukumOhmVideoSummary1Text =>
      'Ohm\'s Law is prinsip dasar elektronika that menjelaskan hubungan antara arus listrik (I), tegangan (V), and hambatan (R) in suatu rangkaian.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary2Text =>
      'Arus that mengalir through konduktor berbanding lurus with tegangan that diberikan and berbanding terbalik with hambatannya.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary3Heading =>
      'Bab 2: formula Ohm\'s Law';

  @override
  String get materiL1L1KomHukumOhmVideoSummary4Text =>
      'Rumusnya is I = V / R, with I in ampere, V in volt, and R in ohm.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary6Text =>
      'First example is calculating arus that mengalir through sebuah lamp with hambatan and tegangan tertentu.';

  @override
  String get materiL1L1KomHukumOhmVideoSummary7Text =>
      'Second example is calculating tegangan that needed for produce arus tertentu on hambatan tertentu.';

  @override
  String get materiL1L1KomKapasitorContent0Text =>
      'Kapasitor stores and releases electrical energy. Its functions include maintaining voltage stability, filtering signals, and frequency tuning.';

  @override
  String get materiL1L1KomKapasitorContent1Text =>
      'Key points:\n- Struktur: two metal plates with dielectric material between them.\n- Ceramic type for small capacitance and high frequency.\n- Polyester type for audio.\n- Elco and solid capacitor polarized, install according to lead positif and negatif.\n- Variable capacitor for radio frequency tuning.\n- Value range from pF to F.';

  @override
  String get materiL1L1KomKapasitorDescription =>
      'Kapasitor is komponen that stores and releases electrical energy with cepat, with type determined by its dielectric material.';

  @override
  String get materiL1L1KomKapasitorVideoSummary0Heading =>
      'Bab 1: Pengertian Kapasitor';

  @override
  String get materiL1L1KomKapasitorVideoSummary10Text =>
      'Pemasangan kapasitor polarized with terbalik can menyebabkan kerusakan, bahkan ledakan.';

  @override
  String get materiL1L1KomKapasitorVideoSummary1Text =>
      'Kapasitor is komponen elektronik that mampu menyimpan and melepas energi listrik secara cepat. Komponen ini terdiri from two metal plates that dipisahkan oleh material dielektrik that not menghantarkan listrik.';

  @override
  String get materiL1L1KomKapasitorVideoSummary2Text =>
      'material dielektrik menentukan Type kapasitor, misalnya keramik, kertas, or poliester.';

  @override
  String get materiL1L1KomKapasitorVideoSummary3Heading =>
      'Bab 2: Type-Type Kapasitor';

  @override
  String get materiL1L1KomKapasitorVideoSummary4Text =>
      'Kapasitor keramik common ditemui, berkapasitansi small, and sering dipakai for frekuensi tinggi. Kapasitor poliester banyak dipakai on aplikasi audio.';

  @override
  String get materiL1L1KomKapasitorVideoSummary5Text =>
      'Kapasitor elektrolitik (Elco) and solid capacitor memiliki kapasitansi besar and polarized, sehingga harus dipasang with benar. Solid capacitor lebih tahan panas and awet, banyak dipakai at motherboard komputer.';

  @override
  String get materiL1L1KomKapasitorVideoSummary6Text =>
      'Variable capacitor can diatur nilainya secara mekanis and sering dipakai for penyetelan frekuensi on radio.';

  @override
  String get materiL1L1KomKapasitorVideoSummary7Text =>
      'Superkapasitor memiliki kapasitansi hingga ratusan farad and berpotensi menggantikan baterai on beberapa aplikasi.';

  @override
  String get materiL1L1KomKapasitorVideoSummary8Heading =>
      'Bab 3: Rentang Kapasitansi and Keselamatan';

  @override
  String get materiL1L1KomKapasitorVideoSummary9Text =>
      'Kapasitansi kapasitor bervariasi from beberapa pikofarad (pF) hingga ratusan farad (F).';

  @override
  String get materiL1L1KomLedContent0Text =>
      'LED (Light Emitting Diode) is diode that emit light. Berbeda with lamp incandescent, LED produce light through recombination electron and charge carrier at in semiconductor, sehingga lebih efficient and lebih durable.';

  @override
  String get materiL1L1KomLedContent1Text =>
      'Key points:\n- Color LED determined by material semiconductor.\n- Forward voltage (Vf) berbeda for each Color.\n- Beam angle and intensity light can selected according to need.\n- Lead LED has polarity, and Lead long usually is anoda.';

  @override
  String get materiL1L1KomLedContent2Text =>
      'Type LED: through-hole (common, 5 mm), SMD (small and thin), high power (needs heatsink), COB (banyak chip in satu modul), RGB (multi-Color), and alfanumerik (display angka and huruf).';

  @override
  String get materiL1L1KomLedDescription =>
      'LED is diode that emit light saat dialiri listrik, with Color and tegangan kerja that determined by material semikonduktornya.';

  @override
  String get materiL1L1KomLedVideoSummary1Text =>
      'LED not lamp ordinary like lamp incandescent, melainkan Type diode that emit light when supplied with electricity. LED terbuat from material semiconductor tipe P and tipe N, and light dihasilkan saat electron and charge carrier bertemu.';

  @override
  String get materiL1L1KomLedVideoSummary2Heading =>
      'Bab 2: Color, Tegangan, and Karakteristik';

  @override
  String get materiL1L1KomLedVideoSummary3Text =>
      'Color light LED determined by material pembuatnya, that juga menentukan panjang gelombang and tegangan kerja. Contohnya, LED biru biasanya membutuhkan Forward voltage lebih tinggi dibanding LED merah.';

  @override
  String get materiL1L1KomLedVideoSummary4Text =>
      'Karakteristik lain that perlu diperhatikan is Beam angle light (around 10° sampai 120°) and intensity light that diukur in millicandela.';

  @override
  String get materiL1L1KomLedVideoSummary6Text =>
      'LED through-hole is tipe that common with size usually 5 mm, easy to install, and polaritasnya mudah dikenali from panjang Lead.';

  @override
  String get materiL1L1KomLedVideoSummary7Text =>
      'LED SMD berukuran sangat small and thin, cocok for pemasangan massal on ruang terbatas. LED high power sangat terang but produce panas sehingga requires heatsink.';

  @override
  String get materiL1L1KomLedVideoSummary8Text =>
      'LED COB menggabungkan banyak chip in satu modul small. LED RGB terdiri from three Color dasar merah, hijau, and biru that can dikontrol secara independen for produce berbagai Color.';

  @override
  String get materiL1L1KomLedVideoSummary9Text =>
      'LED alfanumerik used sebagai tampilan angka and huruf on berbagai alat elektronik.';

  @override
  String get materiL1L1KomResistorContent0Text =>
      'value resistor dibaca from kode Color gelang. for resistor at bawah 1 ohm, gelang pengali bernilai pecahan, sehingga value akhirnya bisa berupa desimal.';

  @override
  String get materiL1L1KomResistorContent2Text =>
      'Key points:\n- two gelang first is digit signifikan.\n- Gelang third is pengali.\n- Gelang emas menandakan toleransi 5%.\n- Metode that sama berlaku from 1 kiloohm hingga 1 gigaohm.';

  @override
  String get materiL1L1KomResistorDescription =>
      'way calculating value resistor with kode Color, termasuk resistor at bawah 1 ohm menggunakan metode second.';

  @override
  String get materiL1L1KomResistorVideoSummary0Heading =>
      'Bab 1: Metode second for Resistor';

  @override
  String get materiL1L1KomResistorVideoSummary1Text =>
      'Video ini membahas way second calculating value resistor, khususnya resistor with value at bawah 1 ohm, menggunakan tabel khusus.';

  @override
  String get materiL1L1KomResistorVideoSummary2Text =>
      'Metode ini menyediakan two way perhitungan, yaitu way konvensional and way menggunakan bilangan berpangkat. Hasil keduanya sama.';

  @override
  String get materiL1L1KomResistorVideoSummary3Heading =>
      'Bab 2: example Perhitungan';

  @override
  String get materiL1L1KomResistorVideoSummary4Text =>
      'Contohnya is resistor with gelang hijau, hitam, silver, and emas. Color hijau bernilai 5, hitam bernilai 0, and silver sebagai pengali bernilai 0,01.';

  @override
  String get materiL1L1KomResistorVideoSummary5Text =>
      'Perhitungannya is 50 x 0,01 = 0,5 ohm, with toleransi 5% that ditandai gelang emas.';

  @override
  String get materiL1L1KomResistorVideoSummary6Heading =>
      'Bab 3: Cakupan Metode';

  @override
  String get materiL1L1KomResistorVideoSummary7Text =>
      'Metode ini juga berlaku for semua resistor with rentang value from 1 kiloohm sampai 1 gigaohm.';

  @override
  String get materiL1L1KomTactileSwitchContent0Text =>
      'Tactile switch is push button small that memberikan sinyal on saat ditekan and off saat dilepas. Cocok for input tombol on rangkaian elektronik small.';

  @override
  String get materiL1L1KomTactileSwitchContent1Text =>
      'Key points:\n- Sifatnya momentary (tekan for on, lepas for off).\n- Tegangan kerja DC around 4,5 sampai 12 V.\n- Arus maksimum around 100 mA.\n- not disarankan for rangkaian AC.\n- common dipakai on remote control and perangkat elektronik small.';

  @override
  String get materiL1L1KomTactileSwitchDescription =>
      'Tactile switch is saklar tekan small that aktif saat ditekan and off saat dilepas, common dipakai on rangkaian DC tegangan rendah.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary0Heading =>
      'Bab 1: Pengenalan Saklar Mini Tactile';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary1Text =>
      'Saklar mini or tactile switch, juga dikenal sebagai micro switch, berukuran sangat small and berfungsi sebagai saklar tekan (push button).';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary2Text =>
      'Saklar ini bekerja secara momentary: on saat ditekan and off saat dilepas.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary3Heading =>
      'Bab 2: Pin and Prinsip Kerja';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary4Text =>
      'Saklar ini umumnya memiliki four pin, but prinsip kerjanya sederhana with two kutub. two pin biasanya berpasangan secara paralel sehingga stabil secara mekanis and listrik.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary5Text =>
      'Terdapat variasi bentuk batang, from panjang, pendek, hingga pipih, sesuai need desain.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary6Heading =>
      'Bab 3: Batasan and Aplikasi';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary7Text =>
      'Saklar used on rangkaian DC with tegangan around 4,5 sampai 12 volt and arus maksimum around 100 mA.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary8Text =>
      'Saklar ini jarang used on rangkaian AC because alasan keselamatan and peruntukannya for sirkuit DC small.';

  @override
  String get materiL1L1KomTactileSwitchVideoSummary9Text =>
      'Saklar ditemukan on remote control, TV lama, and set-top box. Pemasangannya dilakukan on PCB, or breadboard for eksperimen.';

  @override
  String get materiL1L1KomponenFolderDescription =>
      'Pelajari komponen-komponen dasar elektronika beserta fungsi and karakteristiknya.';

  @override
  String get materiL1L1PosttestDescription =>
      'Uji pemahamanmu setelah belajar.';

  @override
  String get materiL1L1PosttestQQ2Question =>
      'Hasil calculate resistor LED is 150 Ω. value standar aman that dipilih on modul is...';

  @override
  String get materiL1L1PosttestQQ3Question =>
      'Arus LED 2 V with resistor 220 Ω on catu 5 V is around...';

  @override
  String get materiL1L1PosttestQQ4Question =>
      'Batas arus that aman per pin Arduino Uno is around...';

  @override
  String get materiL1L1PosttestQQ5Question =>
      'on praktikum LED eksternal, resistor and LED dihubungkan to pin...';

  @override
  String get materiL1L1PretestDescription =>
      'Ukur pengetahuan awalmu tentang dasar elektronika.';

  @override
  String get materiL1L1PretestQQ1Question =>
      'Besaran that mendorong muatan listrik mengalir disebut...';

  @override
  String get materiL1L1PretestQQ2Question => 'Satuan hambatan listrik is...';

  @override
  String get materiL1L1PretestQQ3Question =>
      'on LED, Lead that lebih panjang is...';

  @override
  String get materiL1L1PretestQQ4Question =>
      'Chip mikrokontroler that used Arduino Uno is...';

  @override
  String get materiL2L2ArrayPointerContent0Text =>
      'Key points:\n• Array menyimpan banyak value in satu variabel; array multidimensi like tabel baris and kolom.\n• Indeks array dimulai from 0, jadi tambahkan 1 saat display nomor agar mudah dibaca.\n• Batasi indeks agar not melewati ukuran array.\n• Gunakan fungsi terpisah for mengisi data and mencari value tertentu.';

  @override
  String get materiL2L2ArrayPointerContent1Text =>
      'way mencari value terendah:\n1. Mulai from value awal that besar (example 100).\n2. Bandingkan each elemen array with value tersebut.\n3. if there is elemen that lebih small, ganti value terendah.\n4. Setelah semua elemen diperiksa, value that tersisa is that terendah.';

  @override
  String get materiL2L2ArrayPointerDescription =>
      'Mengelola data berbentuk tabel with array satu dimensi and multidimensi, lengkap with fungsi and pembatasan indeks.';

  @override
  String get materiL2L2ArrayPointerVideoSummary1Text =>
      'Video ini melanjutkan seri belajar Arduino with fokus on array satu dimensi and multidimensi. Array multidimensi dijelaskan sebagai data tabel like at Excel, misalnya value beberapa siswa on beberapa mata pelajaran. Program mengisi value to in array, lalu mencari value matematika terendah, value IPA tertinggi, and value rata-rata tertinggi. Serial monitor dipakai for memantau value and proses perhitungan step demi step.';

  @override
  String get materiL2L2ArrayPointerVideoSummary3Text =>
      '• Array multidimensi for merepresentasikan data tabel like value siswa.\n• Pengisian data value siswa to in array multidimensi.\n• Fungsi khusus for mencari value terendah, tertinggi, and rata-rata tertinggi.\n• Pembatasan indeks array agar not terjadi error saat indeks melebihi batas data.\n• Serial monitor for debugging and memantau perhitungan secara real-time.\n• Variabel, fungsi, and array digabung in satu program that relatif lengkap.';

  @override
  String get materiL2L2ArrayPointerVideoSummary5Text =>
      '• Array multidimensi memudahkan pengelolaan data kompleks, terutama saat satu operasi melibatkan banyak data sekaligus.\n• Fungsi make kode modular: misalnya satu fungsi for mengisi value and satu fungsi for mencari value terendah, sehingga kode lebih rapi and mudah at-debug.\n• Pembatasan indeks krusial: array punya batas indeks tetap, jadi program harus memeriksa indeks agar not melebihi jumlah data and menghindari error runtime.\n• Serial monitor display value and hasil calculate berurutan, sehingga logika program mudah dipahami step demi step.\n• Penomoran ramah pengguna: menambah 1 on indeks make nomor siswa dimulai from 1, not 0.\n• Mencari value minimum or maksimum: tentukan value awal (misalnya 100 for value terendah), bandingkan satu per satu, and perbarui nilainya sampai ditemukan hasil that dicari.';

  @override
  String get materiL2L2InputOutputContent0Text =>
      'Rangkaian:\n• four LED at pin digital 9 sampai 12.\n• Push button at pin analog 4.';

  @override
  String get materiL2L2InputOutputContent1Text =>
      'Key points:\n• Simpan pin LED in array konstan, lalu atur semuanya sebagai output with perulangan for.\n• Pin push button diatur sebagai input and dibaca with digitalRead().\n• each tekanan menambah penghitung x; switch case memilih LED that menyala sesuai value x.\n• Saat x mencapai 4, reset to 0 agar urutan kembali to LED first.\n• Delay 300 ms mencegah pembacaan ganda akibat bouncing.';

  @override
  String get materiL2L2InputOutputDescription =>
      'control four LED secara bergantian with satu push button memakai array, perulangan for, and switch case.';

  @override
  String get materiL2L2InputOutputVideoSummary1Text =>
      'Video ini menjawab pertanyaan: bisakah satu push button control beberapa LED secara bergantian? four LED dipasang at pin digital 9 sampai 12, and push button at pin analog 4. Pin LED disimpan in array konstan and diinisialisasi with perulangan for. each kali tombol ditekan, variabel penghitung x bertambah satu, and value x menentukan LED mana that menyala lewat switch case. Setelah LED keempat, x kembali to 0 sehingga urutan berulang.';

  @override
  String get materiL2L2InputOutputVideoSummary3Text =>
      '• Satu push button can control four LED secara bergantian.\n• Array pin LED make kode rapi and mudah ditambah.\n• Perulangan for and switch case set LED that aktif.\n• Pin tombol harus diatur sebagai input with pinMode() and dibaca with digitalRead().\n• Penghitung x at-reset to 0 saat mencapai 4 agar siklus berulang.\n• Jeda 300 ms mencegah pembacaan ganda akibat bouncing tombol.';

  @override
  String get materiL2L2InputOutputVideoSummary5Text =>
      '• Array konstan for pin LED make program skalabel: menambah LED not perlu banyak mengubah kode.\n• Perulangan for and switch case menghemat kode and menghindari if-else that rumit; value x langsung menentukan LED aktif.\n• Pin Arduino harus diset sebagai input secara eksplisit with pinMode(), lalu status tombol dibaca with digitalRead().\n• Mereset penghitung saat mencapai 4 is example sederhana pengendalian state that berulang (siklik) and sering dipakai at sistem embedded.\n• Delay 300 ms setelah pembacaan tombol meredam bouncing sehingga satu tekanan not terbaca berkali-kali.';

  @override
  String get materiL2L2InputOutputVideoSummary7Text =>
      '1. Inisialisasi array pin LED: LED[0] = 12, LED[1] = 11, LED[2] = 10, LED[3] = 9.\n2. Atur pin push button sebagai input.\n3. Baca status push button with digitalRead().\n4. if tombol ditekan (status == 1), tambahkan x = x + 1.\n5. Gunakan switch case on x: 0 turn on LED 1, 1 turn on LED 2, 2 turn on LED 3, 3 turn on LED 4 (LED lain off), and 4 mereset x menjadi 0.\n6. Beri delay 300 ms sebelum read input lagi.\n7. Ulangi from step 3.';

  @override
  String get materiL2L2OperatorPercabanganContent0Text =>
      'Key points:\n• Fungsi that dipakai: setup(), loop(), digitalWrite(), delay(), and digitalRead().\n• LED harus dipasang with resistor (example 220 ohm) agar arus aman.\n• Push button dibaca with digitalRead(); hasilnya diproses with if-else.\n• example logika: if tombol ditekan, kedipkan LED lebih cepat; if not, kembali to kecepatan normal.\n• Serial monitor membantu memantau status tombol saat debugging.';

  @override
  String get materiL2L2OperatorPercabanganContent1Text =>
      'Alur praktik:\n1. Kedipkan LED bawaan Arduino.\n2. Pindahkan to LED eksternal at breadboard.\n3. Tambahkan LED second agar berkedip bergantian.\n4. Tambahkan push button for mengubah kecepatan kedip.';

  @override
  String get materiL2L2OperatorPercabanganDescription =>
      'Praktik make LED berkedip and mengubah kecepatan kedipnya with push button memakai digitalRead() and if-else.';

  @override
  String get materiL2L2OperatorPercabanganTitle =>
      'Operator & Percabangan (Simulasi LED)';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary1Text =>
      'Tutorial pengantar for pemula that belajar Arduino from nol. Video memakai Arduino Uno R3, breadboard, LED, resistor, and push button. Alurnya: instalasi Arduino IDE, memasang komponen, make program LED berkedip, lalu make mode kecepatan kedip that diubah with push button. Video juga menekankan kesabaran, eksplorasi mandiri, and belajar bersama komunitas.';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary2Heading =>
      'Sorotan Utama';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary3Text =>
      '• Panduan memulai Arduino from nol tanpa asumsi pengetahuan teknis.\n• Komponen that dibahas: Arduino Uno R3, breadboard, LED, resistor, kabel jumper, and push button.\n• Instalasi and penggunaan Arduino IDE for pemrograman dasar LED.\n• Rangkaian LED sederhana that berkedip with interval that bisa diubah.\n• two LED berkedip bergantian on breadboard.\n• Push button dipakai for mengubah kecepatan kedip LED secara interaktif.';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary4Heading =>
      'Wawasan Kunci';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary5Text =>
      '• Arduino sebagai otak rangkaian: program that at-upload set way kerja komponen elektronik. Banyaknya pin I/O memudahkan sambungan to sensor and modul lain.\n• Breadboard: memudahkan merangkai tanpa solder. Jalur positif (garis merah) and negatif (garis biru) serta jalur horizontal perlu dipahami agar not salah menyusun rangkaian.\n• Resistor: menghambat arus agar LED not rusak because kelebihan arus. Resistor 220 ohm menjadi example paling dasar.\n• Arduino IDE and bahasa Arduino (mirip C/C++): setup() for inisialisasi sekali, loop() for perintah berulang, serta digitalWrite() and delay() for set pin and waktu.\n• Push button sebagai input: digitalRead() read status tombol, lalu if-else mengubah kecepatan kedip LED. Serial monitor dipakai for memantau status tombol (debugging).\n• Praktik langsung: unggah program, lalu coba modifikasi like mengubah value delay agar pemahaman lebih in.';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary6Heading =>
      'step-step Penting';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary7Text =>
      '1. Siapkan peralatan and komponen sesuai daftar.\n2. Pahami fungsi breadboard and aturan jalur listriknya (merah positif, biru negatif).\n3. Pasang Arduino IDE versi terbaru and sambungkan Arduino to PC with kabel USB.\n4. Buat program first: LED bawaan Arduino berkedip with delay that bisa diatur.\n5. Pasang LED at breadboard with resistor and sambungkan to pin digital Arduino.\n6. Ubah program agar mengendalikan LED eksternal on pin that sesuai, lalu uji.\n7. Tambahkan LED second for kedip bergantian.\n8. Pasang push button at breadboard and sambungkan to pin digital sebagai input.\n9. Program kecepatan kedip agar berubah saat tombol ditekan memakai digitalRead() and if-else.\n10. Gunakan serial monitor for memantau status tombol.';

  @override
  String get materiL2L2OperatorPercabanganVideoSummary9Text =>
      'with biaya around 100 ribu rupiah, siapa pun bisa mulai belajar Arduino. Pesan pembuat video: jangan cepat menyerah, terus bereksplorasi, and berbagi at komunitas.';

  @override
  String get materiL2L2PosttestDescription =>
      'Uji pemahamanmu setelah belajar.';

  @override
  String get materiL2L2PosttestQQ1Question =>
      'Fungsi loop() on sketch Arduino dijalankan...';

  @override
  String get materiL2L2PosttestQQ3Question =>
      'Terminal relay that terhubung to COM hanya saat relay aktif (ON) is...';

  @override
  String get materiL2L2PosttestQQ4Question =>
      'Perintah for read status tombol on pin digital is...';

  @override
  String get materiL2L2PosttestQQ5Question =>
      'way menulis komentar satu baris on kode Arduino is menggunakan...';

  @override
  String get materiL2L2PretestDescription =>
      'Ukur pengetahuan awalmu tentang pemrograman Arduino.';

  @override
  String get materiL2L2PretestQQ1Question =>
      'Fungsi setup() on sketch Arduino dijalankan...';

  @override
  String get materiL2L2PretestQQ2Question =>
      'Tipe data for bilangan desimal is...';

  @override
  String get materiL2L2PretestQQ3Question => 'two keadaan pin digital is...';

  @override
  String get materiL2L2PretestQQ4Question =>
      'Indeks elemen first sebuah array is...';

  @override
  String get materiL2L2RelayContent0Text =>
      'Pin relay:\n• COM (Common): terminal bersama.\n• NO (Normally Open): terhubung to COM hanya saat relay ON.\n• NC (Normally Close): terhubung to COM saat relay OFF.';

  @override
  String get materiL2L2RelayContent1Text =>
      'Key points:\n• Relay memisahkan sisi kontrol (5V Arduino) from sisi beban.\n• Kendalikan relay with pinMode(pin, OUTPUT) and digitalWrite() HIGH or LOW.\n• Atur siklus ON/OFF with delay, misalnya ON 5 detik lalu OFF 1 detik.\n• Menukar sambungan NO and NC membalik pola hidup-off beban.\n• Kemampuan relay on video: AC hingga 250 volt, arus maksimal 10-15 ampere.';

  @override
  String get materiL2L2RelayDescription =>
      'way kerja relay 5V DC, fungsi pin COM, NO, and NC, serta way memprogramnya with Arduino.';

  @override
  String get materiL2L2RelayVideoSummary1Text =>
      'Video ini menjelaskan relay 5 volt DC with three pin utama: COM (Common), NO (Normally Open), and NC (Normally Close). Relay bekerja sebagai saklar elektromagnetik that menyambung or memutus koneksi antar pin sesuai kondisi ON/OFF. Pembahasan mencakup fungsi tiap pin, pengkabelan relay with Arduino Nano, pemrograman sederhana lewat pin digital with interval waktu tertentu, and demo pengendalian kipas DC 12 volt memakai pin NO and NC. Relay ini juga can dipakai on tegangan AC hingga 250 volt with arus maksimal 10-15 ampere.';

  @override
  String get materiL2L2RelayVideoSummary3Text =>
      '• Fungsi pin COM, NO, and NC on relay 5V DC.\n• Relay dihubungkan to Arduino Nano lewat pin digital and ground.\n• Pemrograman dasar relay not membutuhkan library khusus.\n• Waktu hidup-off relay diatur with delay.\n• Demo kipas DC 12 volt, termasuk perbedaan kerja relay saat memakai NO and NC.\n• Relay can mengendalikan beban AC hingga 250 volt and maksimal 10-15 ampere.';

  @override
  String get materiL2L2RelayVideoSummary5Text =>
      '• NO and NC: NO hanya terhubung with COM saat relay aktif (ON), sedangkan NC terhubung saat relay OFF. with demikian there is two skenario kendali beban tanpa mengubah rangkaian lain.\n• Relay sebagai saklar elektromagnetik: tegangan rendah (5V from Arduino) can mengendalikan beban bertegangan tinggi or arus besar because sisi kontrol and sisi beban terpisah.\n• Tanpa library khusus: cukup atur pin digital sebagai output lalu beri sinyal HIGH or LOW.\n• Pengaturan waktu with delay: misalnya kipas menyala 5 detik, off 1 detik, lalu berulang.\n• Menukar sambungan from NO to NC akan membalik pola hidup-off perangkat tanpa mengubah kode.\n• Relay ini cocok for peralatan rumah tangga like lamp, kipas angin, or mesin with tegangan AC standar.';

  @override
  String get materiL2L2StrukturSketchContent0Text =>
      'Key points:\n• setup(): berjalan sekali saat Arduino menyala, dipakai for inisialisasi.\n• loop(): berjalan berulang selama Arduino menyala.\n• Variabel: tanpa spasi, not diawali angka.\n• Tipe data common: boolean, byte, char, int, unsigned int, long, unsigned long, float, double, String.\n• Komentar: // for satu baris, /* ... */ for blok.';

  @override
  String get materiL2L2StrukturSketchDescription =>
      'Mengenal fungsi setup() and loop(), aturan penulisan variabel, tipe data common, and komentar on program Arduino.';

  @override
  String get materiL2L2StrukturSketchTitle =>
      'Struktur Sketch, Variabel & Tipe Data';

  @override
  String get materiL2L2StrukturSketchVideoSummary1Text =>
      'Video ini membahas dasar pemrograman Arduino: struktur program, penulisan variabel, tipe data that common dipakai, and way menulis komentar. Fungsi setup() berjalan sekali saat program dijalankan, sedangkan loop() berjalan berulang selama alat menyala. Tipe data selected according to need penyimpanan angka, karakter, hingga kalimat. at akhir dijelaskan two bentuk komentar: satu baris with // and blok with /* ... */.';

  @override
  String get materiL2L2StrukturSketchVideoSummary3Text =>
      '• setup() and loop() is fungsi wajib in semua program Arduino.\n• Nama variabel not boleh mengandung spasi and not boleh diawali angka.\n• int, long, and versi unsigned-nya menyimpan bilangan bulat with rentang memori berbeda.\n• char and String menyimpan karakter and kalimat; boolean menyimpan true/false.\n• Komentar menjelaskan kode tanpa memengaruhi eksekusi program.';

  @override
  String get materiL2L2StrukturSketchVideoSummary5Text =>
      '• Setup and loop: setup() bekerja sekali at awal for inisialisasi, sedangkan loop() mengulang perintah terus-menerus sehingga Arduino berjalan tanpa henti.\n• Aturan penamaan variabel: tanpa spasi and not diawali angka agar kode bebas error and mudah dibaca. Underscore or gabungan kata tanpa spasi membantu keterbacaan.\n• Pilihan tipe data: byte for angka small tanpa tanda, int and long for bilangan bulat that lebih besar, float and double for bilangan pecahan. Pilih sesuai need agar memori efficient and data akurat.\n• Boolean: hanya bernilai true or false, cocok for kondisi logika like sensor digital that hanya punya two keadaan.\n• Komentar satu baris (//) cocok for penjelasan singkat, sedangkan komentar blok (/* ... */) cocok for catatan panjang or menonaktifkan banyak baris kode sekaligus.';

  @override
  String get materiL2L2StrukturSketchVideoSummary7Text =>
      'Video ini is pertemuan first from seri belajar Arduino. Memahami struktur dasar, tipe data, and komentar is fondasi sebelum make proyek that lebih kompleks.';

  @override
  String get materiL3L3AdcContent0Text =>
      'Key points:\n• Pin digital: hanya HIGH (1) or LOW (0).\n• Pin analog: read tegangan 0-5 V sebagai angka 0-1023 (ADC 10-bit).\n• Potensiometer produce tegangan that berubah saat knob turned.\n• Arduino Uno punya enam pin analog; Arduino Mega punya more.';

  @override
  String get materiL3L3AdcContent1Text =>
      'formula conversion:\nV = (value ADC / 1023) × 5 V\n\nexample pengondisian LED:\n• ADC < 350: LED merah menyala\n• ADC 351-700: LED kuning menyala\n• ADC > 700: LED hijau menyala';

  @override
  String get materiL3L3AdcDescription =>
      'Memahami input analog Arduino, conversion ADC 0-1023, and read potensiometer for mengendalikan LED indikator.';

  @override
  String get materiL3L3AdcVideoSummary1Text =>
      'Video ini membahas pin analog Arduino Uno with potensiometer sebagai input and LED sebagai indikator. Dimulai from perbedaan pin digital and analog, konsep Analog to Digital Converter (ADC), hingga way read tegangan potensiometer menjadi value digital 0 sampai 1023. value itu dipakai for turn on LED sesuai rentang tegangan. Pin analog penting for sensor that mengeluarkan tegangan kontinu, berbeda with sinyal digital that hanya bernilai 0 and 1.';

  @override
  String get materiL3L3AdcVideoSummary3Text =>
      '• Input digital hanya 0 and 1, sedangkan input analog bernilai kontinu antara 0 sampai 5 Volt.\n• ADC Arduino mengubah sinyal analog menjadi value digital 0 sampai 1023.\n• Potensiometer is sensor analog that tegangan keluarannya bisa diatur manual.\n• formula tegangan: V = (value ADC / 1023) × 5 V.\n• Struktur if-else set LED sesuai rentang value analog.\n• Pilih Type Arduino with jumlah pin analog sesuai need, misalnya Arduino Mega for banyak sensor.';

  @override
  String get materiL3L3AdcVideoSummary5Text =>
      '• ADC itu esensial: ADC 10-bit mengubah tegangan kontinu menjadi angka 0-1023. Tanpa ADC, Arduino hanya paham on or off.\n• Potensiometer cocok for belajar: memutar knob make value ADC at serial monitor naik or turun sehingga hubungan tegangan and value terbaca mudah dipahami.\n• formula conversion: Tegangan input = (value ADC / 1023) × 5 Volt, dipakai for mengubah angka digital menjadi besaran tegangan nyata.\n• Pengkondisian LED: example if-else with value ADC at bawah 350 turn on LED merah, 351-700 kuning, and at atas 700 hijau.\n• Batasan pin: Arduino Uno hanya punya enam pin analog. Arduino Mega punya more for need that lebih kompleks.\n• Hardware and software harus sejalan: pemasangan potensiometer, resistor, and LED that benar dipadukan with program that logis.\n• Banyak sensor fisik (suhu, arus, tegangan, posisi) memberi keluaran analog, sehingga materi ini menjadi dasar for IoT, robotika, and otomasi.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorContent0Text =>
      'Key points:\n• Sensor mengubah kondisi fisik (light, suhu, jarak, suara, magnet) menjadi sinyal listrik that dibaca mikrokontroler.\n• there is sensor analog and digital; sebagian sensor sama fungsinya but berbeda bentuk and ukuran modul.\n• Sensor suhu: termistor NTC and sensor analog; there is juga sensor kelembaban.\n• Sensor garis and laser dipakai for robot and pengindraan jarak.\n• Sensor magnetik mendeteksi magnet or logam; sensor sentuh dipakai sebagai pengganti tombol.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorContent1Text =>
      'example sensor that dibahas: joystick, modul suara, sensor garis, sensor jarak, sensor suhu, sensor sentuh, sensor magnetik, LED RGB, sensor laser, potensiometer, and fotoresistor.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorDescription =>
      'Mengenal berbagai Type sensor for belajar elektronika, from joystick and sensor suhu hingga sensor garis and laser.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorTitle =>
      'Type & Prinsip Kerja Sensor';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary0Heading =>
      'Ringkasan';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary1Text =>
      'Video ini memperkenalkan 37 Type sensor for belajar elektronika and mengembangkan aplikasi mikrokontroler. Pembicara menunjukkan sensor satu per satu sambil menguji fungsinya. Sebagian already dicoba, sebagian masih dievaluasi. Video memberi gambaran fungsi dasar maupun khusus berbagai sensor that cocok for eksperimen pemula and hobiis.';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary2Heading =>
      'Sensor that Ditampilkan';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary3Text =>
      '• Joystick\n• Modul sensor suara (besar and small)\n• Sensor garis (line tracking)\n• Sensor jarak\n• Sensor suhu and kelembaban (termistor NTC and analog)\n• Sensor sentuh (metal touch)\n• Sensor magnetik\n• LED RGB and LED two Color\n• Sensor laser\n• Potensiometer rotary\n• Sensor fotoresistor';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary4Heading =>
      'Wawasan Kunci';

  @override
  String get materiL3L3JenisPrinsipKerjaSensorVideoSummary5Text =>
      '• Paket sensor lengkap mempercepat belajar because bisa langsung dicoba, from input analog hingga digital. Paket 37 sensor ini around Rp190.000.\n• there is sensor with fungsi sama but bentuk and ukuran modul berbeda (misalnya modul suara besar and small), sehingga bisa disesuaikan with ruang proyek.\n• Sensor magnetik mendeteksi magnet or logam; sensor metal touch can dipakai for kontak sentuh tanpa tombol fisik.\n• LED RGB and LED two Color memungkinkan eksperimen pengaturan Color with mikrokontroler.\n• Sensor suhu (termistor NTC maupun analog) and sensor kelembaban penting for monitoring lingkungan and IoT.\n• Sensor garis and sensor laser berguna for robot bergerak otomatis and pengindraan jarak.\n• Sensor banyak dipakai on aplikasi robotik and kontrol otomatis.';

  @override
  String get materiL3L3PosttestDescription =>
      'Uji pemahamanmu setelah belajar.';

  @override
  String get materiL3L3PosttestQQ1Question =>
      'formula conversion value ADC menjadi tegangan (with referensi 5 V) is...';

  @override
  String get materiL3L3PosttestQQ2Question =>
      'if analogRead produce around 512, tegangan that dibaca mendekati...';

  @override
  String get materiL3L3PosttestQQ3Question =>
      'Pin berikut that mendukung keluaran PWM is...';

  @override
  String get materiL3L3PosttestQQ4Question =>
      'Perintah for set kecerahan LED through sinyal PWM is...';

  @override
  String get materiL3L3PosttestQQ5Option0 =>
      'Mengubah kondisi fisik menjadi sinyal listrik';

  @override
  String get materiL3L3PosttestQQ5Option1 =>
      'Menyimpan program secara permanen';

  @override
  String get materiL3L3PosttestQQ5Question =>
      'Fungsi utama sensor in sistem mikrokontroler is...';

  @override
  String get materiL3L3PretestDescription =>
      'Ukur pengetahuan awalmu tentang input analog and sensor.';

  @override
  String get materiL3L3PretestQQ1Question =>
      'Pin input analog on Arduino Uno is...';

  @override
  String get materiL3L3PretestQQ2Question =>
      'Value range hasil conversion ADC 10-bit on Arduino is...';

  @override
  String get materiL3L3PretestQQ3Question =>
      'Value range on analogWrite() for PWM is...';

  @override
  String get materiL3L3PretestQQ4Question =>
      'Fungsi that used for memetakan rentang value 0–1023 to 0–255 is...';

  @override
  String get materiL3L3PwmContent0Text =>
      'Key points:\n• PWM meniru tegangan analog with turn on and turn off sinyal digital secara cepat.\n• analogWrite(pin, value) with value 0-255.\n• Gunakan hanya pin PWM (3, 5, 6, 9, 10, 11 on Arduino Nano).\n• map(value, 0, 1023, 0, 255) menyesuaikan value potensiometer to rentang PWM.';

  @override
  String get materiL3L3PwmContent1Text =>
      'Alur program:\n1. Baca potensiometer with analogRead() (0-1023).\n2. Ubah to 0-255 with map().\n3. Kirim hasilnya to LED with analogWrite().\n4. Tampilkan value input and output at serial monitor.';

  @override
  String get materiL3L3PwmDescription =>
      'set kecerahan LED with PWM, analogWrite(), and potensiometer menggunakan fungsi map().';

  @override
  String get materiL3L3PwmVideoSummary1Text =>
      'Video ini menjelaskan konsep Pulse Width Modulation (PWM) and penerapannya for set kecerahan LED. with PWM, Arduino can produce berbagai value tegangan antara 0 sampai 5 volt lewat pin digital that mendukung PWM, not hanya 0 or 5 volt. on example praktik, value analog potensiometer (0-1023) dikonversi with map() menjadi 0-255, lalu dipakai sebagai parameter analogWrite() for set intensity LED. value input and output dipantau at serial monitor.';

  @override
  String get materiL3L3PwmVideoSummary3Text =>
      '• PWM memungkinkan tegangan variatif (0-5 V) on pin digital Arduino.\n• analogWrite() menerima value 0-255 for set output PWM.\n• Potensiometer memberi value analog 0-1023.\n• map() mengubah value analog menjadi rentang PWM 0-255.\n• Arduino Nano mendukung PWM at pin digital 3, 5, 6, 9, 10, and 11.\n• Kecerahan LED berubah real-time sesuai putaran potensiometer.\n• Serial monitor display value input potensiometer and output PWM.';

  @override
  String get materiL3L3PwmVideoSummary5Text =>
      '• PWM efficient for kontrol tegangan: sinyal digital dihidupkan and dimatikan sangat cepat sehingga tegangan rata-rata menjadi variatif tanpa DAC fisik or hardware tambahan.\n• Potensiometer is input analog that mudah dipakai sehingga rangkaian interaktif and mudah diatur manual.\n• map() penting because ADC 10-bit (0-1023) and PWM 8-bit (0-255) memiliki skala berbeda; map() mengonversinya secara proporsional.\n• not semua pin digital mendukung PWM; pahami pin that didukung tiap board agar program berjalan benar.\n• Serial monitor mempercepat debugging because value input and output bisa dibandingkan langsung.\n• Dibanding on/off ordinary, PWM make gradasi kecerahan LED lebih halus, berguna for pencahayaan dekoratif, indikator, or display.\n• PWM is fondasi sebelum mengendalikan motor, servo, or perangkat analog lain.';

  @override
  String get materiL4L4DebouncingContent0Text =>
      'Key points:\n• Bouncing: getaran mekanis tombol terbaca sebagai beberapa tekanan sekaligus.\n• Akibatnya counter bisa melonjak walau tombol ditekan sekali.\n• Solusi tanpa delay(): gunakan variabel boolean btnState sebagai penanda tombol siap ditekan.';

  @override
  String get materiL4L4DebouncingContent1Text =>
      'Logika btnState:\n1. Tombol ditekan and btnState == true: tambah counter, lalu set btnState = false.\n2. Tombol masih ditahan or bergetar: btnState false, counter not bertambah.\n3. Tombol dilepas: set btnState = true agar siap for tekanan berikutnya.';

  @override
  String get materiL4L4DebouncingContent2Text =>
      'Tips kode rapi:\n• Gunakan switch-case or if-else if for memilih LED sesuai value counter.\n• Buat fungsi kustom runLed(byte a, byte b, byte c) agar digitalWrite not diulang-ulang.';

  @override
  String get materiL4L4DebouncingDescription =>
      'Mengatasi getaran mekanis tombol (bouncing) with logika state tanpa delay().';

  @override
  String get materiL4L4DebouncingVideoSummary0Heading =>
      'Masalah Bouncing (Getaran Fisik Tombol)';

  @override
  String get materiL4L4DebouncingVideoSummary1Text =>
      'on program counter sederhana (misalnya ledState++), angka counter sering melonjak hanya because satu kali tekanan cepat on tombol. Penyebabnya, mikrokontroler read getaran mekanis small on tombol fisik sebagai tekanan berkali-kali in hitungan mikrodetik.';

  @override
  String get materiL4L4DebouncingVideoSummary2Heading =>
      'Solusi Debouncing via Software (Logika State)';

  @override
  String get materiL4L4DebouncingVideoSummary3Text =>
      'Masalah ini not diselesaikan with delay(), but with variabel kontrol boolean tambahan bernama btnState.\n• Mendeteksi tekanan: saat tombol ditekan, program memeriksa apakah btnState == true. if ya, counter (ledState) ditambah 1, lalu btnState langsung diubah menjadi false.\n• Mencegah looping: because btnState already false, tombol that ditahan or getaran sisa (bouncing) not menambah counter lagi.\n• Reset state: saat tombol dilepas, bagian else mengembalikan btnState menjadi true sehingga tombol siap for tekanan berikutnya.';

  @override
  String get materiL4L4DebouncingVideoSummary4Heading =>
      'Metode Eksekusi Output';

  @override
  String get materiL4L4DebouncingVideoSummary5Text =>
      'Setelah value counter stabil (0 sampai 3), there is two metode for turn on LED:\n• If - Else If: way logis standar with pemeriksaan kondisi bertingkat.\n• Switch - Case: hasilnya sama persis, but struktur kodenya lebih rapi and efficient dibaca.';

  @override
  String get materiL4L4DebouncingVideoSummary6Heading =>
      'Penyederhanaan Kode (Custom Void)';

  @override
  String get materiL4L4DebouncingVideoSummary7Text =>
      'Agar perintah digitalWrite not ditulis berulang at each kondisi, dibuat fungsi kustom void runLed(byte a, byte b, byte c). for set lamp, program cukup memanggil satu baris fungsi ini beserta parameternya, sehingga kode akhir jauh lebih ringkas.';

  @override
  String get materiL4L4DebouncingVideoSummary9Text =>
      'Logika debouncing berbasis state ini efficient because not memblokir mikrokontroler like delay().';

  @override
  String get materiL4L4InterruptContent0Text =>
      'Key points:\n• Interrupt: menghentikan sebentar program utama for menjalankan fungsi khusus (ISR) saat there is kejadian at pin.\n• Pin interrupt eksternal Arduino Uno (ATmega328): pin 2 and 3.\n• Variabel that diubah at ISR wajib volatile.\n• Jangan pakai delay() or millis() at in ISR; buat ISR sesingkat mungkin.';

  @override
  String get materiL4L4InterruptContent1Text =>
      'Mode interrupt:\n• LOW: dipicu saat pin bernilai LOW.\n• CHANGE: dipicu saat sinyal berubah (naik or turun).\n• RISING: dipicu saat sinyal naik from LOW to HIGH.\n• FALLING: dipicu saat sinyal turun from HIGH to LOW.';

  @override
  String get materiL4L4InterruptContent2Text =>
      'Interrupt vs if ordinary:\n• Interrupt: input langsung ditangani meski program utama sedang sibuk.\n• If ordinary: input baru terbaca saat program sampai to baris tersebut, sehingga bisa terlewat saat proses berat berjalan.';

  @override
  String get materiL4L4InterruptDescription =>
      'Menangani input eksternal secara langsung with interrupt, ISR, variabel volatile, and mode RISING, FALLING, CHANGE, LOW.';

  @override
  String get materiL4L4InterruptVideoSummary1Text =>
      'Video ini membahas way kerja and implementasi interrupt on Arduino with mikrokontroler ATmega328 like Arduino Uno. Interrupt memungkinkan Arduino menjalankan fungsi tertentu segera saat sinyal on pin berubah, tanpa menunggu proses utama selesai. Topiknya meliputi definisi interrupt, pemilihan pin pemicu, mode interrupt (rising, falling, change, low), and penulisan Interrupt Service Routine (ISR).';

  @override
  String get materiL4L4InterruptVideoSummary3Text =>
      'Kode example memakai LCD for display counter that bertambah saat interrupt terjadi. Proses utama disimulasikan with loading that lama. Counter tetap bertambah tanpa menunggu loading selesai, sedangkan logika if ordinary not can menangani input secara real-time saat program lain berjalan berat.';

  @override
  String get materiL4L4InterruptVideoSummary5Text =>
      '• Konsep and fungsi dasar interrupt on Arduino.\n• Pin 2 and 3 sebagai pin interrupt eksternal on ATmega328.\n• ISR that memodifikasi variabel volatile.\n• Perbandingan interrupt and logika if ordinary saat proses berat berjalan.\n• delay() and millis() not efektif at in ISR.';

  @override
  String get materiL4L4InterruptVideoSummary7Text =>
      '• Interrupt mengeksekusi fungsi secara asinkron saat sinyal pin berubah, sangat penting for input real-time like tombol or sensor.\n• Arduino Uno and board ATmega328 lain memakai pin 2 and 3 for interrupt eksternal; sesuaikan pin if memakai board lain.\n• Variabel that diubah ISR harus dideklarasikan volatile agar compiler not mengoptimasinya and nilainya selalu terbaru.\n• ISR sebaiknya sesingkat mungkin and not memakai delay() or millis() because can mengganggu kestabilan program.\n• Mode LOW, CHANGE, RISING, and FALLING set kapan ISR dipanggil sesuai karakter input.\n• Interrupt mengubah pola pemrograman from sinkron to asinkron: program merespons input tanpa menunggu proses lain selesai.';

  @override
  String get materiL4L4InterruptVideoSummary9Text =>
      'Interrupt make sistem merespons input eksternal with cepat, terutama saat proses utama berlangsung lama and not boleh terganggu. Mekanisme ini penting on sistem embedded and sensor that butuh pembacaan data real-time.';

  @override
  String get materiL4L4JenisMotorContent0Text =>
      'Key points:\n• Servo: motor that sudutnya can ditentukan, dikendalikan sinyal PWM.\n• Rentang gerak servo on video: 0° sampai 180°.\n• Kabel servo: merah = VCC 5V, coklat = ground, oranye/kuning = sinyal PWM.\n• Delay small (example 0,05 detik) make gerakan servo halus.';

  @override
  String get materiL4L4JenisMotorContent1Text =>
      'way menggerakkan servo secara bertahap:\n1. Sambungkan servo: merah to 5V, coklat to ground, oranye/kuning to pin PWM.\n2. Naikkan sudut sedikit demi sedikit from 0° to 180° with loop.\n3. Beri delay pendek at each step.\n4. Turunkan sudut kembali from 180° to 0° for gerakan bolak-balik (sweep).';

  @override
  String get materiL4L4JenisMotorContent2Text =>
      'Pengembangan: Python with library pyfirmata can control Arduino, and Tkinter can dipakai for make slider sudut serta tombol sweep.';

  @override
  String get materiL4L4JenisMotorDescription =>
      'way kerja servo that dikendalikan sinyal PWM, standar kabel servo, and pemrograman Arduino lewat Python (pyfirmata).';

  @override
  String get materiL4L4JenisMotorVideoSummary1Text =>
      'Video ini membahas way mengendalikan motor servo with Python that terhubung to board Arduino. Dimulai from konsep dasar servo that dikendalikan sinyal PWM, lalu example kode Python that menggerakkan servo from sudut 0° sampai 180° with variasi kecepatan and sudut. Video juga membahas sambungan kabel servo (VCC, ground, PWM), library pyfirmata for komunikasi with Arduino, and antarmuka grafis sederhana with Tkinter for kontrol servo secara interaktif.';

  @override
  String get materiL4L4JenisMotorVideoSummary3Text =>
      '• Servo dikendalikan sinyal PWM from Arduino.\n• Kabel servo: merah (VCC 5V), coklat (ground), oranye or kuning (sinyal PWM).\n• example perangkat: Arduino Uno and servo MG90S or MG995.\n• Python memakai library pyfirmata and port serial for berkomunikasi with Arduino.\n• Loop with penambahan sudut menggerakkan servo secara bertahap.\n• Delay set kecepatan gerak servo.\n• GUI Tkinter menyediakan slider sudut and tombol sweep otomatis.';

  @override
  String get materiL4L4JenisMotorVideoSummary5Text =>
      '• Servo bergantung on PWM: sudut servo mengikuti durasi pulsa. Semakin panjang pulsa ON, sudut bertambah hingga maksimum 180°.\n• Python-Arduino membuka peluang pemrograman tingkat tinggi and antarmuka kontrol that lebih interaktif dibanding hanya memakai Arduino IDE.\n• pyfirmata memudahkan komunikasi with Arduino lewat serial, sedangkan Tkinter memberi GUI sederhana tanpa toolkit berat.\n• Delay singkat (misalnya 0,05 detik) make gerak servo halus and mudah diikuti, serta not membebani mikrokontroler and servo.\n• Memahami fungsi Color kabel servo mencegah korsleting and kerusakan komponen.\n• Loop menaikkan and menurunkan sudut is dasar for aplikasi like robotika, kamera otomatis, and sistem kendali posisi.';

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
      'Program not terblokir and bisa menjalankan tugas lain';

  @override
  String get materiL4L4PosttestQQ3Question =>
      'Keunggulan menggunakan millis() dibanding delay() is...';

  @override
  String get materiL4L4PosttestQQ4Question =>
      'Mekanisme that menghentikan sementara program utama for langsung merespons sinyal penting disebut...';

  @override
  String get materiL4L4PosttestQQ5Option1 =>
      'Menggunakan logika variabel state (like btnState)';

  @override
  String get materiL4L4PosttestQQ5Question =>
      'way mengatasi bouncing tombol tanpa memblokir program is...';

  @override
  String get materiL4L4PretestDescription =>
      'Ukur pengetahuan awalmu tentang motor, timer, and interrupt.';

  @override
  String get materiL4L4PretestQQ1Option1 =>
      'Menggerakkan to sudut tertentu in rentang terbatas';

  @override
  String get materiL4L4PretestQQ2Question =>
      'Kabel Color merah on motor servo standar umumnya dihubungkan to...';

  @override
  String get materiL4L4PretestQQ3Option0 =>
      'Berhenti menunggu and memblokir perintah lain';

  @override
  String get materiL4L4PretestQQ3Question =>
      'Saat delay() berjalan, mikrokontroler...';

  @override
  String get materiL4L4PretestQQ4Question =>
      'Masalah getaran mekanis on tombol that terbaca berkali-kali disebut...';

  @override
  String get materiL4L4TimerTanpaHentiContent0Text =>
      'Key points:\n• delay() menghentikan program, millis() not.\n• millis() = jumlah milidetik sejak Arduino menyala.\n• Simpan waktu terakhir aksi at variabel (previousTime) bertipe unsigned long.\n• if millis() - previousTime >= interval, jalankan aksi lalu perbarui previousTime.\n• Gunakan variabel boolean for membalik status LED.';

  @override
  String get materiL4L4TimerTanpaHentiContent1Text =>
      'example on video:\n• LED 1 berubah status each 10 detik.\n• LED 2 berubah status each 6 detik.\n• Keduanya berjalan bersamaan tanpa saling menunggu.';

  @override
  String get materiL4L4TimerTanpaHentiDescription =>
      'make program berbasis event with millis() agar tugas berjalan tanpa terhenti oleh delay().';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary1Text =>
      'Video ini menjelaskan way memakai millis() for pemrograman berbasis event tanpa delay(). Fungsi millis() produce waktu in milidetik sejak Arduino dinyalakan and terus berjalan kecuali board at-reset. Nilainya dipakai for set interval secara non-blocking sehingga perangkat bisa mengerjakan tugas lain, berbeda with delay() that make program berhenti sementara.';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary2Heading =>
      'example Implementasi';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary3Text =>
      'two lamp LED dikendalikan with interval berbeda: lamp first berubah each 10 detik and lamp second each 6 detik. Status and waktu ditampilkan at LCD 20x4 with library LiquidCrystal. Aksi hanya dijalankan saat selisih antara millis() sekarang and waktu sebelumnya mencapai interval. Tipe data unsigned long menampung value waktu, variabel boolean menyimpan status lamp, and if membandingkan waktu.';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary5Text =>
      '• millis() calculating waktu berjalan in milidetik sejak Arduino menyala.\n• Pemrograman event-based membandingkan waktu sekarang with waktu sebelumnya (non-blocking).\n• two LED with interval 10 detik and 6 detik sebagai example.\n• LCD 20x4 display status and waktu.\n• unsigned long for waktu and boolean for status lamp.\n• Kode modular with fungsi for membalik status lamp and memperbarui waktu sebelumnya.';

  @override
  String get materiL4L4TimerTanpaHentiVideoSummary7Text =>
      '• millis() mengatasi masalah delay() that bersifat blocking, sehingga program bisa multitasking and responsif for aplikasi IoT, kontrol real-time, and robotika.\n• unsigned long dipakai for waktu because value millis() bisa mencapai around 4,2 miliar ms (around 50 hari) sebelum kembali to nol.\n• Pendekatan event-based: aksi dipicu oleh waktu or kejadian lain, konsep that juga dipakai at banyak bahasa pemrograman modern.\n• Toggle status boolean: membalik status lamp (true/false) each interval tercapai is way sederhana mengendalikan output.\n• LCD memberi umpan balik visual for memverifikasi program tanpa alat tambahan.\n• Variabel waktu sebelumnya (previousTime) menjaga interval tetap konsisten and not bergantung on value mutlak millis().';

  @override
  String get materiL5L5M1Content0Text =>
      'way kerja sistem:\n• DHT11 read suhu.\n• Suhu mencapai batas atas → kipas ON lewat relay.\n• Suhu turun melewati batas bawah → kipas OFF.\n• OLED display suhu and status kipas.\n\nPenggunaan two batas (histeresis) mencegah relay menyala-off terus-menerus at around satu value suhu.';

  @override
  String get materiL5L5M1Content1Text =>
      'Alat and material:\n• Arduino Uno\n• DHT11\n• OLED I2C 128×64\n• Modul relay 5 V\n• Kipas DC small with catu terpisah\n• Breadboard and kabel jumper';

  @override
  String get materiL5L5M1Description =>
      'Kipas pendingin otomatis berbasis suhu.';

  @override
  String get materiL5L5M2Content0Text =>
      'Sisi kontrol (Arduino, 5 V):\n• DHT11: VCC → 5V, DATA → D2, GND → GND\n• OLED: VCC → 5V, GND → GND, SDA → A4, SCL → A5\n• Modul relay: VCC → 5V, GND → GND, IN → D7 (active LOW)';

  @override
  String get materiL5L5M2Content1Text =>
      'Sisi beban (catu kipas terpisah):\n• Catu kipas (+) → terminal COM relay\n• Terminal NO relay → kipas (+)\n• Kipas (−) → catu kipas (−), langsung tanpa relay\n\nRelay memisahkan second sisi: sisi beban not terhubung to Arduino sama sekali. Gunakan terminal NO (normally open) agar kipas off saat relay not aktif or Arduino kehilangan daya.';

  @override
  String get materiL5L5M2Description =>
      'Sambungan sisi kontrol and sisi beban.';

  @override
  String get materiL5L5M3Content1Text =>
      'Logika utama:\n• t ≥ 30 °C → kipasNyala = true\n• t ≤ 28 °C → kipasNyala = false\n• at antara 28–30 °C status not berubah (histeresis)\n• if pembacaan gagal (isnan), status kipas dipertahankan and OLED display Error';

  @override
  String get materiL5L5M3Description =>
      'Sketch lengkap with histeresis and tampilan OLED.';

  @override
  String get materiL5L5M4Content0Text =>
      'Skenario pengujian:\n1. Suhu < 28 °C → kipas OFF, OLED display suhu\n2. Sensor dihangatkan ≥ 30 °C → kipas ON\n3. Suhu turun to 28–30 °C → kipas tetap ON (histeresis)\n4. Suhu ≤ 28 °C → kipas OFF\n5. Kabel DATA DHT11 dicabut → OLED display Error, status kipas not berubah';

  @override
  String get materiL5L5M4Content1Text =>
      'Analisis ketelitian sensor (bandingkan with termometer pembanding at beberapa titik suhu):\n• Galat mutlak = |DHT11 − pembanding|\n• Galat (%) = galat mutlak / pembanding × 100%\n• calculate rata-ratanya, bandingkan with akurasi on datasheet.\n• Catat juga waktu kipas menyala setelah suhu mencapai 30 °C for menilai kecepatan respons.';

  @override
  String get materiL5L5M4Content2Text =>
      'Ide pengembangan:\n• Kendali kecepatan kipas with PWM and driver motor\n• Buzzer sebagai alarm suhu berlebih\n• Log suhu to kartu SD lewat SPI';

  @override
  String get materiL5L5M4Description =>
      'Skenario uji, analisis galat, and ide pengembangan.';

  @override
  String get materiL5L5PosttestDescription =>
      'Uji pemahamanmu setelah menyelesaikan proyek akhir.';

  @override
  String get materiL5L5PosttestQQ1Option0 =>
      'Mencegah relay menyala-off terus-menerus';

  @override
  String get materiL5L5PosttestQQ1Question =>
      'Tujuan penggunaan two batas suhu (histeresis) is...';

  @override
  String get materiL5L5PosttestQQ2Question =>
      'on proyek ini, kipas menyala ketika suhu...';

  @override
  String get materiL5L5PosttestQQ3Option0 =>
      'Kipas off saat relay not aktif or Arduino kehilangan daya';

  @override
  String get materiL5L5PosttestQQ3Question =>
      'Mengapa dipilih terminal NO (normally open) on relay?';

  @override
  String get materiL5L5PosttestQQ4Question =>
      'if isnan(t) bernilai true, artinya...';

  @override
  String get materiL5L5PosttestQQ5Question =>
      'formula galat (%) on analisis sensor is...';

  @override
  String get materiL5L5PretestDescription =>
      'Ukur pengetahuan awalmu sebelum make proyek akhir.';

  @override
  String get materiL5L5PretestQQ1Option0 =>
      'Saklar that dikendalikan sinyal small';

  @override
  String get materiL5L5PretestQQ3Question =>
      'OLED I2C on Arduino Uno dihubungkan to pin...';

  @override
  String get materiL5L5PretestQQ4Question =>
      'Alamat I2C OLED SSD1306 that common is...';

  @override
  String kuisQuestionCounter(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String get btnPrevious => 'Previous';

  @override
  String folderSubtitle(Object count, Object subtitle) {
    return '$count materials • $subtitle';
  }
}
