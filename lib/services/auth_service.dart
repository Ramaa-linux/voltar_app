import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Exception autentikasi berpesan Bahasa Indonesia untuk ditampilkan ke UI.
class AuthException implements Exception {
  const AuthException(this.message, {this.code = 'unknown'});

  final String message;
  final String code;

  @override
  String toString() => message;
}

/// Status autentikasi pengguna untuk redirect sinkron di GoRouter.
enum AuthStatus { unauthenticated, unverified, resolvingRole, roleError, ready }

/// Peran pengguna dalam aplikasi.
enum UserRole { siswa, guru }

/// Snapshot status autentikasi yang disimpan di memori untuk redirect sinkron.
class AuthSnapshot {
  const AuthSnapshot({required this.status, this.role, this.errorMessage});

  final AuthStatus status;
  final UserRole? role;
  final String? errorMessage;

  /// User sudah terverifikasi dan role sudah diketahui.
  bool get isReady => status == AuthStatus.ready;

  /// User belum verifikasi email.
  bool get isUnverified => status == AuthStatus.unverified;

  /// User belum login.
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;

  /// Sedang memuat role (asinkron).
  bool get isResolvingRole => status == AuthStatus.resolvingRole;

  /// Terjadi error saat memuat role.
  bool get hasRoleError => status == AuthStatus.roleError;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSnapshot &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          role == other.role &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(status, role, errorMessage);

  @override
  String toString() =>
      'AuthSnapshot(status: $status, role: $role, error: $errorMessage)';
}

/// Mengubah input mentah menjadi ID dokumen yang aman, atau null bila bentuknya tidak sah (Fase 25A/25C).
String? normalizeTeacherCode(String? raw) {
  if (raw == null) return null;
  final String code = raw.trim().toUpperCase();
  // ponytail: allow alphanumeric, hyphen (-), and underscore (_) for codes like GURU_EDUVOLT.
  final bool ok = RegExp(r'^[A-Z0-9_-]{4,64}$').hasMatch(code);
  return ok ? code : null;
}

/// Pesan error ramah berbahasa Indonesia untuk ditampilkan ke user (Fase 25A Bagian 5.2).
String friendlyAuthError(Object e) {
  if (e is AuthException) {
    return e.message;
  }
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email ini sudah terdaftar. Coba masuk atau gunakan email lain.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'weak-password':
        return 'Kata sandi terlalu lemah. Gunakan minimal 8 karakter.';
      case 'network-request-failed':
        return 'Tidak ada koneksi internet. Periksa jaringanmu lalu coba lagi.';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Tunggu beberapa menit lalu coba lagi.';
      case 'operation-not-allowed':
        return 'Pendaftaran email sedang dinonaktifkan. Hubungi admin.';
      case 'user-token-expired':
      case 'user-not-found':
      case 'requires-recent-login':
        return 'Sesi kamu berakhir. Silakan masuk kembali.';
      case 'wrong-password':
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Email atau password salah.';
      default:
        return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
  if (e is FirebaseException) {
    switch (e.code) {
      case 'unavailable':
      case 'deadline-exceeded':
        return 'Server sedang sibuk atau koneksi terputus. Coba lagi sebentar.';
      case 'permission-denied':
        return 'Kamu tidak punya izin untuk tindakan ini.';
      default:
        return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
  return 'Terjadi kesalahan. Silakan coba lagi.';
}

/// Provider tunggal [AuthService] untuk dependency injection Riverpod.
final Provider<AuthService> authServiceProvider = Provider<AuthService>((
  Ref ref,
) {
  return AuthService();
});

/// Provider stream data profil pengguna aktif dari Firestore `users/{uid}`.
final StreamProvider<Map<String, dynamic>?> userProfileProvider =
    StreamProvider<Map<String, dynamic>?>((Ref ref) {
      final AuthService authService = ref.watch(authServiceProvider);
      final User? user = authService.currentUser;
      if (user == null) {
        return Stream<Map<String, dynamic>?>.value(null);
      }
      return authService.userProfileStream(user.uid);
    });

/// Layanan autentikasi Firebase Auth + profil pengguna di Firestore `users/{uid}`.
class AuthService extends ChangeNotifier {
  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _authOverride = auth,
       _firestoreOverride = firestore,
       _storageOverride = storage,
       _snapshot = const AuthSnapshot(status: AuthStatus.unauthenticated);

  final FirebaseAuth? _authOverride;
  final FirebaseFirestore? _firestoreOverride;
  final FirebaseStorage? _storageOverride;

  FirebaseAuth get _auth => _authOverride ?? FirebaseAuth.instance;
  FirebaseFirestore get _firestore =>
      _firestoreOverride ?? FirebaseFirestore.instance;
  FirebaseStorage get _storage => _storageOverride ?? FirebaseStorage.instance;

  AuthSnapshot _snapshot;

  AuthSnapshot get snapshot => _snapshot;

  void _updateSnapshot(AuthSnapshot newSnapshot) {
    if (_snapshot != newSnapshot) {
      _snapshot = newSnapshot;
      notifyListeners();
    }
  }

  Stream<User?> get authStateChanges {
    if (_authOverride != null) {
      return _authOverride.authStateChanges();
    }
    if (Firebase.apps.isEmpty) {
      return const Stream<User?>.empty();
    }
    return FirebaseAuth.instance.authStateChanges();
  }

  /// Stream perubahan user (termasuk emailVerified) untuk refreshListenable.
  Stream<User?> get userChanges {
    if (_authOverride != null) {
      return _authOverride.userChanges();
    }
    if (Firebase.apps.isEmpty) {
      return const Stream<User?>.empty();
    }
    return FirebaseAuth.instance.userChanges();
  }

  User? get currentUser {
    if (_authOverride != null) {
      return _authOverride.currentUser;
    }
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseAuth.instance.currentUser;
  }

  /// Inisialisasi status auth dari user saat ini (dipanggil saat app start).
  Future<void> initializeAuthState() async {
    final User? user = currentUser;
    if (user == null) {
      _updateSnapshot(const AuthSnapshot(status: AuthStatus.unauthenticated));
      return;
    }
    await reloadAndCheckVerified();
  }

  Future<UserCredential> login(String email, String password) async {
    final String cleanEmail = email.trim().toLowerCase();
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: cleanEmail,
        password: password,
      );

      final User? user = credential.user;
      if (user != null) {
        final DocumentReference<Map<String, dynamic>> docRef = _firestore
            .collection('users')
            .doc(user.uid);
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await docRef
            .get();
        if (!snapshot.exists) {
          final String fallbackName =
              (user.displayName != null && user.displayName!.trim().isNotEmpty)
              ? user.displayName!.trim()
              : cleanEmail.split('@').first;
          await docRef.set(<String, dynamic>{
            'name': fallbackName,
            'email': cleanEmail,
            'role': 'siswa',
            'coins': 0,
            'completedSteps': <String>[],
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        }
        await reloadAndCheckVerified();
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    } on AuthException {
      rethrow;
    } catch (_) {
      throw const AuthException(
        'Terjadi kesalahan saat masuk. Silakan coba lagi.',
      );
    }
  }

  /// Memvalidasi kode verifikasi guru dari koleksi `admin_codes/{code}`.
  /// Mengembalikan `true` jika kode valid dan `isValid == true`.
  Future<bool> verifyTeacherCode(String rawCode) async {
    final String code = rawCode.trim().toUpperCase();
    if (code.isEmpty || code.contains('/')) {
      return false;
    }
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('admin_codes')
          .doc(code)
          .get();
      if (!doc.exists) {
        return false;
      }
      final Map<String, dynamic>? data = doc.data();
      if (data == null) {
        return false;
      }
      final bool isValid = data['isValid'] == true;
      return isValid;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw const AuthException(
          'Gagal memeriksa kode (Akses Ditolak). Pastikan Firestore Rules sudah benar.',
          code: 'permission-denied',
        );
      }
      if (e.code == 'unavailable' || e.code == 'deadline-exceeded') {
        throw AuthException(friendlyAuthError(e), code: e.code);
      }
      rethrow;
    }
  }

  /// Mendaftarkan user baru dengan alur (Fase 25C):
  /// 1. Jika role == guru: validasi kode di Firestore `admin_codes/{code}` TERLEBIH DAHULU
  /// 2. createUserWithEmailAndPassword (hanya jika kode guru valid atau role == siswa)
  /// 3. Tulis dokumen users/{uid} (merge=true untuk kompatibilitas akun lama)
  /// 4. sendEmailVerification()
  /// 5. Update snapshot ke unverified
  Future<UserCredential> register(
    String name,
    String email,
    String password,
    String role, {
    String? teacherCode,
  }) async {
    final String cleanName = name.trim();
    final String cleanEmail = email.trim().toLowerCase();
    final String cleanRole = role.trim().toLowerCase();

    if (cleanRole != 'siswa' && cleanRole != 'guru') {
      throw const AuthException('Role tidak valid.', code: 'invalid-role');
    }

    // 1. Validasi kode guru TERLEBIH DAHULU sebelum membuat akun Firebase Auth
    String? verifiedTeacherCode;
    if (cleanRole == 'guru') {
      if (teacherCode == null || teacherCode.trim().isEmpty) {
        throw const AuthException(
          'Kode Verifikasi wajib diisi.',
          code: 'teacher-code-empty',
        );
      }

      final String cleanCode = teacherCode.trim().toUpperCase();
      if (cleanCode.contains('/')) {
        throw const AuthException(
          'Kode Verifikasi Guru tidak ditemukan.',
          code: 'teacher-code-not-found',
        );
      }

      try {
        final DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
            .collection('admin_codes')
            .doc(cleanCode)
            .get();

        if (!doc.exists) {
          throw const AuthException(
            'Kode Verifikasi Guru tidak ditemukan.',
            code: 'teacher-code-not-found',
          );
        }

        final Map<String, dynamic>? data = doc.data();
        if (data == null || data['isValid'] != true) {
          throw const AuthException(
            'Kode Verifikasi Guru tidak valid (isValid = false).',
            code: 'teacher-code-invalid',
          );
        }
        verifiedTeacherCode = cleanCode;
      } on FirebaseException catch (e) {
        if (e.code == 'permission-denied') {
          throw const AuthException(
            'Gagal memeriksa kode (Akses Ditolak). Pastikan Firestore Rules sudah benar.',
            code: 'permission-denied',
          );
        }
        if (e.code == 'unavailable' || e.code == 'deadline-exceeded') {
          throw AuthException(friendlyAuthError(e), code: e.code);
        }
        rethrow;
      }
    }

    // 2. Buat akun Firebase Auth hanya setelah kode guru tervalidasi (atau jika siswa)
    UserCredential? credential;
    try {
      credential = await _auth.createUserWithEmailAndPassword(
        email: cleanEmail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    } catch (_) {
      throw const AuthException(
        'Terjadi kesalahan saat mendaftar. Silakan coba lagi.',
      );
    }

    final User? user = credential.user;
    if (user == null) {
      throw const AuthException(
        'Gagal membuat akun pengguna. Silakan coba lagi.',
      );
    }

    try {
      await user.updateDisplayName(cleanName);
    } catch (_) {}

    // 3. Siapkan dan simpan data user ke Firestore
    final Map<String, dynamic> userData = <String, dynamic>{
      'uid': user.uid,
      'name': cleanName,
      'email': cleanEmail,
      'role': cleanRole,
      'coins': 0,
      'completedSteps': <String>[],
      'createdAt': FieldValue.serverTimestamp(),
    };

    if (cleanRole == 'guru' && verifiedTeacherCode != null) {
      userData['teacherCode'] = verifiedTeacherCode;
    }

    final DocumentReference<Map<String, dynamic>> docRef = _firestore
        .collection('users')
        .doc(user.uid);

    try {
      await docRef.set(userData, SetOptions(merge: true));
    } catch (_) {
      try {
        await docRef.set(userData, SetOptions(merge: true));
      } catch (_) {
        await _rollbackUser(user);
        throw const AuthException(
          'Gagal menyimpan profil pengguna. Silakan periksa koneksi dan daftar ulang.',
          code: 'firestore-write-failed',
        );
      }
    }

    // Kirim email verifikasi
    try {
      await sendVerificationEmail();
    } catch (_) {
      // Jika gagal kirim email, akun tetap dibuat. User bisa minta kirim ulang di halaman pending.
    }

    // Update snapshot ke unverified
    _updateSnapshot(
      AuthSnapshot(
        status: AuthStatus.unverified,
        role: cleanRole == 'guru' ? UserRole.guru : UserRole.siswa,
      ),
    );

    return credential;
  }

  /// Rollback user: hapus dari Firebase Auth.
  Future<void> _rollbackUser(User user) async {
    try {
      await user.delete();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Rollback user.delete() failed: $e');
      }
      try {
        await _auth.signOut();
      } catch (_) {}
      throw const AuthException(
        'Pendaftaran gagal. Jika kamu tidak bisa mendaftar ulang dengan email yang sama, hubungi admin.',
        code: 'registration-rollback-failed',
      );
    }
  }

  /// Kirim email verifikasi ke user saat ini.
  Future<void> sendVerificationEmail() async {
    final User? user = currentUser;
    if (user == null) {
      throw const AuthException(
        'Tidak ada pengguna yang sedang masuk.',
        code: 'no-current-user',
      );
    }
    try {
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  bool _reloadInFlight = false;

  /// Reload user dari server dan cek status emailVerified.
  /// Update snapshot sesuai hasil.
  Future<bool> reloadAndCheckVerified() async {
    if (_reloadInFlight) {
      return false;
    }
    _reloadInFlight = true;
    try {
      final User? user = currentUser;
      if (user == null) {
        _updateSnapshot(const AuthSnapshot(status: AuthStatus.unauthenticated));
        return false;
      }

      try {
        await user.reload();
      } on FirebaseAuthException catch (e) {
        _updateSnapshot(
          AuthSnapshot(
            status: AuthStatus.roleError,
            errorMessage: friendlyAuthError(e),
          ),
        );
        return false;
      } on FirebaseException catch (e) {
        _updateSnapshot(
          AuthSnapshot(
            status: AuthStatus.roleError,
            errorMessage: friendlyAuthError(e),
          ),
        );
        return false;
      }

      // Periksa emailVerified setelah reload dari currentUser terbaru
      final User? reloadedUser = currentUser;
      if (reloadedUser == null) {
        _updateSnapshot(const AuthSnapshot(status: AuthStatus.unauthenticated));
        return false;
      }

      if (!reloadedUser.emailVerified) {
        _updateSnapshot(
          AuthSnapshot(status: AuthStatus.unverified, role: _cachedRole),
        );
        return false;
      }

      // Email terverifikasi: perbarui ID Token untuk claim email_verified
      try {
        await reloadedUser.getIdToken(true);
      } catch (_) {}

      final bool loaded = await _loadRoleAndUpdateSnapshot(reloadedUser);
      notifyAuthStateChanged();
      return loaded;
    } finally {
      _reloadInFlight = false;
    }
  }

  UserRole? _cachedRole;

  /// Muat role dari Firestore dan update snapshot.
  Future<bool> _loadRoleAndUpdateSnapshot(User user) async {
    _updateSnapshot(const AuthSnapshot(status: AuthStatus.resolvingRole));

    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        _updateSnapshot(
          const AuthSnapshot(
            status: AuthStatus.roleError,
            errorMessage: 'Profil akun tidak ditemukan. Hubungi admin sekolah.',
          ),
        );
        return false;
      }

      final Map<String, dynamic>? data = doc.data();
      // Kompatibilitas akun lama (D10): jika dokumen ada tapi tanpa field role, default ke siswa
      final String roleStr =
          (data?['role'] as String?)?.toLowerCase().trim() ?? 'siswa';
      final UserRole role = roleStr == 'guru' ? UserRole.guru : UserRole.siswa;
      _cachedRole = role;

      _updateSnapshot(AuthSnapshot(status: AuthStatus.ready, role: role));

      return true;
    } on FirebaseException catch (e) {
      _updateSnapshot(
        AuthSnapshot(
          status: AuthStatus.roleError,
          errorMessage: friendlyAuthError(e),
        ),
      );
      return false;
    } catch (_) {
      _updateSnapshot(
        const AuthSnapshot(
          status: AuthStatus.roleError,
          errorMessage: 'Gagal memuat peran pengguna. Silakan coba lagi.',
        ),
      );
      return false;
    }
  }

  /// Logout dan reset snapshot.
  Future<void> logout() async {
    _cachedRole = null;
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    } catch (_) {
      throw const AuthException('Gagal keluar dari akun. Silakan coba lagi.');
    } finally {
      _updateSnapshot(const AuthSnapshot(status: AuthStatus.unauthenticated));
    }
  }

  /// Dipanggil halaman pending setelah deteksi verifikasi (mis. app resume).
  /// Memicu notifyListeners untuk refreshListenable GoRouter.
  void notifyAuthStateChanged() {
    notifyListeners();
  }

  /// Stream dokumen pengguna di Firestore `users/{uid}`.
  Stream<Map<String, dynamic>?> userProfileStream(String uid) {
    if (_firestoreOverride != null) {
      return _firestoreOverride
          .collection('users')
          .doc(uid)
          .snapshots()
          .map((snapshot) => snapshot.data());
    }
    if (Firebase.apps.isEmpty) {
      return Stream<Map<String, dynamic>?>.value(null);
    }
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }

  /// Memperbarui nama pengguna di FirebaseAuth dan dokumen Firestore `users/{uid}`.
  Future<void> updateProfile({required String name}) async {
    final String cleanName = name.trim();
    if (cleanName.isEmpty) {
      throw const AuthException('Nama lengkap tidak boleh kosong.');
    }

    final User? user = currentUser;
    if (user == null) {
      throw const AuthException('Tidak ada akun yang sedang masuk.');
    }

    try {
      await user.updateDisplayName(cleanName);
    } catch (_) {}

    final DocumentReference<Map<String, dynamic>> docRef = _firestore
        .collection('users')
        .doc(user.uid);

    try {
      await docRef.set(<String, dynamic>{
        'name': cleanName,
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    } catch (_) {
      throw const AuthException('Gagal memperbarui profil. Silakan coba lagi.');
    }
  }

  /// Memperbarui URL foto profil di FirebaseAuth dan dokumen Firestore `users/{uid}`.
  Future<void> updatePhotoUrl(String photoUrl) async {
    final String cleanUrl = photoUrl.trim();
    final User? user = currentUser;
    if (user == null) {
      throw const AuthException('Tidak ada akun yang sedang masuk.');
    }

    try {
      await user.updatePhotoURL(cleanUrl);
    } catch (_) {}

    final DocumentReference<Map<String, dynamic>> docRef = _firestore
        .collection('users')
        .doc(user.uid);

    try {
      await docRef.set(<String, dynamic>{
        'photoUrl': cleanUrl,
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    } catch (_) {
      throw const AuthException(
        'Gagal memperbarui foto profil. Silakan coba lagi.',
      );
    }
  }

  /// Mengunggah foto profil ke Firebase Storage (`profile_pictures/{uid}.jpg`),
  /// lalu menyimpan download URL ke FirebaseAuth dan Firestore.
  Future<String> uploadProfilePicture(
    Uint8List imageBytes, {
    String contentType = 'image/jpeg',
  }) async {
    final User? user = currentUser;
    if (user == null) {
      throw const AuthException('Tidak ada akun yang sedang masuk.');
    }

    try {
      final Reference storageRef = _storage.ref(
        'profile_pictures/${user.uid}.jpg',
      );
      final UploadTask uploadTask = storageRef.putData(
        imageBytes,
        SettableMetadata(contentType: contentType),
      );

      await uploadTask;

      final String downloadUrl = await storageRef.getDownloadURL();

      try {
        await user.updatePhotoURL(downloadUrl);
      } catch (_) {}

      final DocumentReference<Map<String, dynamic>> docRef = _firestore
          .collection('users')
          .doc(user.uid);
      await docRef.set(<String, dynamic>{
        'photoUrl': downloadUrl,
      }, SetOptions(merge: true));

      return downloadUrl;
    } on FirebaseException catch (e) {
      throw _mapStorageException(e);
    } catch (_) {
      throw const AuthException(
        'Gagal mengunggah foto profil. Silakan coba lagi.',
      );
    }
  }

  /// Membuat kelas baru untuk guru.
  /// Menyimpan dokumen di koleksi `classes` dengan:
  /// - name: nama kelas
  /// - teacherId: UID guru
  /// - classCode: kode unik 6 karakter alfanumerik
  /// - createdAt: timestamp server
  /// Return `classCode` yang digenerate.
  Future<String> createClass(String className) async {
    final User? user = currentUser;
    if (user == null) {
      throw const AuthException('Tidak ada akun yang sedang masuk.');
    }

    final String cleanName = className.trim();
    if (cleanName.isEmpty) {
      throw const AuthException('Nama kelas tidak boleh kosong.');
    }

    // Generate unique class code (6 chars alphanumeric)
    String classCode = '';
    bool isUnique = false;
    int attempts = 0;
    const maxAttempts = 10;

    while (!isUnique && attempts < maxAttempts) {
      classCode = _generateClassCode();
      try {
        final QuerySnapshot snapshot = await _firestore
            .collection('classes')
            .where('classCode', isEqualTo: classCode)
            .limit(1)
            .get();

        if (snapshot.docs.isEmpty) {
          isUnique = true;
        } else {
          attempts++;
        }
      } on FirebaseException catch (e) {
        throw _mapFirebaseException(e);
      }
    }

    if (!isUnique) {
      // Fallback: use 8-char code
      classCode = _generateClassCode(length: 8);
    }

    final DocumentReference<Map<String, dynamic>> classRef = _firestore
        .collection('classes')
        .doc();

    try {
      await classRef.set(<String, dynamic>{
        'name': cleanName,
        'teacherId': user.uid,
        'classCode': classCode,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    }

    return classCode;
  }

  /// Siswa bergabung ke kelas menggunakan kode kelas.
  /// Query `classes` where `classCode == classCode`.
  /// Jika ketemu: update `users/{studentId}` set `classId = doc.id`.
  /// Jika tidak: throw `AuthException('Kode kelas tidak ditemukan')`.
  Future<void> joinClass(String classCode) async {
    final User? user = currentUser;
    if (user == null) {
      throw const AuthException('Tidak ada akun yang sedang masuk.');
    }

    final String cleanCode = classCode.trim().toUpperCase();
    if (cleanCode.isEmpty) {
      throw const AuthException('Kode kelas tidak boleh kosong.');
    }

    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('classes')
          .where('classCode', isEqualTo: cleanCode)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw const AuthException('Kode kelas tidak ditemukan.');
      }

      final String classId = snapshot.docs.first.id;

      // Update user document with classId
      final DocumentReference<Map<String, dynamic>> userRef = _firestore
          .collection('users')
          .doc(user.uid);

      await userRef.set(<String, dynamic>{
        'classId': classId,
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  /// Generate unique class code.
  String _generateClassCode({int length = 6}) {
    const String chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // Exclude O, 0, I, 1
    final List<String> code = List.generate(
      length,
      (_) => chars[DateTime.now().microsecondsSinceEpoch % chars.length],
    );
    // Add randomness
    for (int i = 0; i < length; i++) {
      code[i] = chars[(DateTime.now().millisecondsSinceEpoch + i * 7) % chars.length];
    }
    return code.join();
  }

  /// Ambil data profil beberapa user sekaligus berdasarkan daftar UID.
  /// Menggunakan batching `whereIn` per 10 UID untuk efisiensi dan kompatibilitas Firestore.
  Future<Map<String, Map<String, dynamic>>> fetchUsersByIds(
    Iterable<String> uids,
  ) async {
    final uniqueIds = uids.where((id) => id.trim().isNotEmpty).toSet().toList();
    if (uniqueIds.isEmpty) return <String, Map<String, dynamic>>{};

    final Map<String, Map<String, dynamic>> result =
        <String, Map<String, dynamic>>{};

    for (var i = 0; i < uniqueIds.length; i += 10) {
      final chunk = uniqueIds.sublist(
        i,
        i + 10 > uniqueIds.length ? uniqueIds.length : i + 10,
      );
      try {
        final snapshot = await _firestore
            .collection('users')
            .where(FieldPath.documentId, whereIn: chunk)
            .get();
        for (final doc in snapshot.docs) {
          result[doc.id] = doc.data();
        }
      } catch (_) {
        // Fallback: ambil satu per satu jika whereIn gagal
        for (final id in chunk) {
          try {
            final doc = await _firestore.collection('users').doc(id).get();
            if (doc.exists && doc.data() != null) {
              result[id] = doc.data()!;
            }
          } catch (_) {}
        }
      }
    }

    return result;
  }

  static AuthException mapErrorCode(String code) {
    switch (code) {
      case 'invalid-email':
        return AuthException('Format email tidak valid.', code: code);
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return AuthException('Email atau password salah.', code: code);
      case 'email-already-in-use':
        return AuthException(
          'Email sudah terdaftar. Silakan masuk.',
          code: code,
        );
      case 'weak-password':
        return AuthException(
          'Password terlalu lemah (minimal 6 karakter).',
          code: code,
        );
      case 'user-disabled':
        return AuthException('Akun ini telah dinonaktifkan.', code: code);
      case 'too-many-requests':
        return AuthException(
          'Terlalu banyak percobaan gagal. Coba lagi beberapa saat.',
          code: code,
        );
      case 'network-request-failed':
      case 'unavailable':
        return AuthException(
          'Tidak ada koneksi internet. Periksa jaringan Anda.',
          code: code,
        );
      default:
        return AuthException(
          'Terjadi kesalahan autentikasi. Silakan coba lagi.',
          code: code,
        );
    }
  }

  static AuthException _mapFirebaseAuthException(FirebaseAuthException e) =>
      mapErrorCode(e.code);

  static AuthException _mapFirebaseException(FirebaseException e) =>
      mapErrorCode(e.code);

  static AuthException _mapStorageException(FirebaseException e) {
    final String normalizedCode = e.code.replaceFirst('storage/', '');
    switch (normalizedCode) {
      case 'unauthorized':
      case 'permission-denied':
      case 'unauthenticated':
        return AuthException(
          'Akses ditolak. Pastikan Firebase Storage sudah diaktifkan dan Rules diset ke test mode.',
          code: e.code,
        );
      case 'object-not-found':
      case 'bucket-not-found':
      case 'project-not-found':
        return AuthException(
          'Penyimpanan belum siap. Pastikan Firebase Storage sudah diaktifkan dan Rules diset ke test mode.',
          code: e.code,
        );
      case 'quota-exceeded':
        return AuthException(
          'Kuota penyimpanan Firebase Storage telah penuh.',
          code: e.code,
        );
      case 'canceled':
        return AuthException('Proses unggah foto dibatalkan.', code: e.code);
      case 'retry-limit-exceeded':
      case 'network-request-failed':
      case 'unavailable':
        return AuthException(
          'Koneksi terputus saat mengunggah foto. Periksa jaringan Anda.',
          code: e.code,
        );
      default:
        return AuthException(
          'Gagal mengunggah foto (${e.code}). Pastikan Firebase Storage sudah diaktifkan dan Rules diset ke test mode.',
          code: e.code,
        );
    }
  }
}
