import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Exception autentikasi berpesan Bahasa Indonesia untuk ditampilkan ke UI.
class AuthException implements Exception {
  const AuthException(this.message, {this.code = 'unknown'});

  final String message;
  final String code;

  @override
  String toString() => message;
}

/// Provider tunggal [AuthService] untuk dependency injection Riverpod.
final Provider<AuthService> authServiceProvider = Provider<AuthService>((Ref ref) {
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
class AuthService {
  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _authOverride = auth,
       _firestoreOverride = firestore,
       _storageOverride = storage;

  final FirebaseAuth? _authOverride;
  final FirebaseFirestore? _firestoreOverride;
  final FirebaseStorage? _storageOverride;

  FirebaseAuth get _auth => _authOverride ?? FirebaseAuth.instance;
  FirebaseFirestore get _firestore =>
      _firestoreOverride ?? FirebaseFirestore.instance;
  FirebaseStorage get _storage =>
      _storageOverride ?? FirebaseStorage.instance;

  Stream<User?> get authStateChanges {
    if (_authOverride != null) {
      return _authOverride.authStateChanges();
    }
    if (Firebase.apps.isEmpty) {
      return const Stream<User?>.empty();
    }
    return FirebaseAuth.instance.authStateChanges();
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
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await docRef.get();
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
          });
        }
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

  Future<UserCredential> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final String cleanName = name.trim();
    final String cleanEmail = email.trim().toLowerCase();
    final String cleanRole = role.trim().toLowerCase();

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

    final Map<String, dynamic> userData = <String, dynamic>{
      'name': cleanName,
      'email': cleanEmail,
      'role': cleanRole,
      'coins': 0,
      'completedSteps': <String>[],
      'createdAt': FieldValue.serverTimestamp(),
    };

    final DocumentReference<Map<String, dynamic>> docRef = _firestore
        .collection('users')
        .doc(user.uid);

    try {
      await docRef.set(userData);
    } catch (_) {
      try {
        await docRef.set(userData);
      } catch (_) {
        try {
          await user.delete();
        } catch (_) {
          try {
            await _auth.signOut();
          } catch (_) {}
        }
        throw const AuthException(
          'Gagal menyimpan profil pengguna. Silakan periksa koneksi dan daftar ulang.',
          code: 'firestore-write-failed',
        );
      }
    }

    return credential;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    } catch (_) {
      throw const AuthException('Gagal keluar dari akun. Silakan coba lagi.');
    }
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

    final DocumentReference<Map<String, dynamic>> docRef =
        _firestore.collection('users').doc(user.uid);

    try {
      await docRef.set(
        <String, dynamic>{'name': cleanName},
        SetOptions(merge: true),
      );
    } on FirebaseException catch (e) {
      throw _mapFirebaseException(e);
    } catch (_) {
      throw const AuthException(
        'Gagal memperbarui profil. Silakan coba lagi.',
      );
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

    final DocumentReference<Map<String, dynamic>> docRef =
        _firestore.collection('users').doc(user.uid);

    try {
      await docRef.set(
        <String, dynamic>{'photoUrl': cleanUrl},
        SetOptions(merge: true),
      );
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
      final Reference storageRef =
          _storage.ref('profile_pictures/${user.uid}.jpg');
      final UploadTask uploadTask = storageRef.putData(
        imageBytes,
        SettableMetadata(contentType: contentType),
      );

      await uploadTask;

      final String downloadUrl = await storageRef.getDownloadURL();

      try {
        await user.updatePhotoURL(downloadUrl);
      } catch (_) {}

      final DocumentReference<Map<String, dynamic>> docRef =
          _firestore.collection('users').doc(user.uid);
      await docRef.set(
        <String, dynamic>{'photoUrl': downloadUrl},
        SetOptions(merge: true),
      );

      return downloadUrl;
    } on FirebaseException catch (e) {
      throw _mapStorageException(e);
    } catch (_) {
      throw const AuthException(
        'Gagal mengunggah foto profil. Silakan coba lagi.',
      );
    }
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
        return AuthException(
          'Proses unggah foto dibatalkan.',
          code: e.code,
        );
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

