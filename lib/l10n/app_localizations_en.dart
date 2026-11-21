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
}
