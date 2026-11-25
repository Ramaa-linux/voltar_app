// ignore_for_file: subtype_of_sealed_class, must_be_immutable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/auth/auth_validators.dart';
import 'package:voltar/router/app_router.dart';
import 'package:voltar/services/auth_service.dart';

// --- Fakes untuk FirebaseAuth & Firestore ---

class FakeUser extends Fake implements User {
  FakeUser({
    required this.uid,
    this.email = 'test@example.com',
    this.displayName,
    this.emailVerified = false,
  });

  @override
  final String uid;

  @override
  final String? email;

  @override
  String? displayName;

  @override
  bool emailVerified;

  bool deleted = false;

  @override
  Future<void> reload() async {}

  @override
  Future<String> getIdToken([bool forceRefresh = false]) async => 'mock_token';

  @override
  Future<void> sendEmailVerification([
    ActionCodeSettings? actionCodeSettings,
  ]) async {}

  @override
  Future<void> updateDisplayName(String? value) async {
    displayName = value;
  }

  @override
  Future<void> delete() async {
    deleted = true;
  }
}

class FakeUserCredential extends Fake implements UserCredential {
  FakeUserCredential(this._user);

  final User _user;

  @override
  User get user => _user;
}

class FakeDocumentSnapshot extends Fake
    implements DocumentSnapshot<Map<String, dynamic>> {
  FakeDocumentSnapshot(this._exists, [this._data]);

  final bool _exists;
  final Map<String, dynamic>? _data;

  @override
  bool get exists => _exists;

  @override
  Map<String, dynamic>? data() => _data;
}

class FakeCollectionReference extends Fake
    implements CollectionReference<Map<String, dynamic>> {
  FakeCollectionReference(this._store);

  final Map<String, Map<String, dynamic>> _store;
  final Map<String, FakeDocumentReference> docRefs =
      <String, FakeDocumentReference>{};

  @override
  DocumentReference<Map<String, dynamic>> doc([String? path]) {
    final String docId = path ?? 'generated_id';
    return docRefs.putIfAbsent(
      docId,
      () => FakeDocumentReference(docId, _store),
    );
  }
}

class FakeFirestore extends Fake implements FirebaseFirestore {
  final Map<String, Map<String, dynamic>> usersStore =
      <String, Map<String, dynamic>>{};
  final Map<String, Map<String, dynamic>> adminCodesStore =
      <String, Map<String, dynamic>>{};
  late final FakeCollectionReference usersCollection = FakeCollectionReference(
    usersStore,
  );
  late final FakeCollectionReference adminCodesCollection =
      FakeCollectionReference(adminCodesStore);

  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) {
    if (collectionPath == 'users') {
      return usersCollection;
    }
    if (collectionPath == 'admin_codes') {
      return adminCodesCollection;
    }
    throw UnimplementedError();
  }
}

class FakeFirebaseAuth extends Fake implements FirebaseAuth {
  FakeUser? mockUser;
  bool signedOut = false;
  final StreamController<User?> _controller =
      StreamController<User?>.broadcast();

  String? failSignInWithCode;
  String? failCreateWithCode;

  @override
  User? get currentUser => mockUser;

  @override
  Stream<User?> authStateChanges() => _controller.stream;

  void emitUser(User? user) {
    mockUser = user as FakeUser?;
    _controller.add(user);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (failSignInWithCode != null) {
      throw FirebaseAuthException(code: failSignInWithCode!);
    }
    final FakeUser user = mockUser ?? FakeUser(uid: 'user_123', email: email);
    mockUser = user;
    _controller.add(user);
    return FakeUserCredential(user);
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (failCreateWithCode != null) {
      throw FirebaseAuthException(code: failCreateWithCode!);
    }
    final FakeUser user = FakeUser(uid: 'new_uid_99', email: email);
    mockUser = user;
    _controller.add(user);
    return FakeUserCredential(user);
  }

  @override
  Future<void> signOut() async {
    signedOut = true;
    mockUser = null;
    _controller.add(null);
  }
}

class FakeDocumentReference extends Fake
    implements DocumentReference<Map<String, dynamic>> {
  FakeDocumentReference(this.id, this._store);

  @override
  final String id;
  final Map<String, Map<String, dynamic>> _store;

  int setCallCount = 0;
  int failSetTimes = 0;

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> get([
    GetOptions? options,
  ]) async {
    final Map<String, dynamic>? data = _store[id];
    return FakeDocumentSnapshot(data != null, data);
  }

  @override
  Future<void> set(Map<String, dynamic> data, [SetOptions? options]) async {
    setCallCount++;
    if (failSetTimes > 0) {
      failSetTimes--;
      throw FirebaseException(
        plugin: 'cloud_firestore',
        code: 'unavailable',
        message: 'Simulated firestore failure',
      );
    }
    if (options?.merge == true && _store.containsKey(id)) {
      _store[id] = <String, dynamic>{..._store[id]!, ...data};
    } else {
      _store[id] = Map<String, dynamic>.from(data);
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots({
    bool includeMetadataChanges = false,
    ListenSource source = ListenSource.defaultSource,
  }) {
    final Map<String, dynamic>? data = _store[id];
    return Stream<DocumentSnapshot<Map<String, dynamic>>>.value(
      FakeDocumentSnapshot(data != null, data),
    );
  }
}

void main() {
  group('AuthValidators', () {
    test('validateName accepts only valid length', () {
      expect(AuthValidators.validateName(null), isNotNull);
      expect(AuthValidators.validateName(''), isNotNull);
      expect(AuthValidators.validateName('   '), isNotNull);
      expect(AuthValidators.validateName('A'), isNotNull);
      expect(AuthValidators.validateName('Al'), isNull);
      expect(AuthValidators.validateName('Budi Santoso'), isNull);
    });

    test('validateEmail validates format strictly', () {
      expect(AuthValidators.validateEmail(null), isNotNull);
      expect(AuthValidators.validateEmail(''), isNotNull);
      expect(AuthValidators.validateEmail('notanemail'), isNotNull);
      expect(AuthValidators.validateEmail('user@'), isNotNull);
      expect(AuthValidators.validateEmail('user@domain'), isNotNull);
      expect(AuthValidators.validateEmail('budi@smk.sch.id'), isNull);
      expect(AuthValidators.validateEmail('user.name@example.com'), isNull);
    });

    test('validatePassword requires at least 6 characters', () {
      expect(AuthValidators.validatePassword(null), isNotNull);
      expect(AuthValidators.validatePassword(''), isNotNull);
      expect(AuthValidators.validatePassword('12345'), isNotNull);
      expect(AuthValidators.validatePassword('123456'), isNull);
    });

    test('validateConfirmPassword checks match against original', () {
      expect(
        AuthValidators.validateConfirmPassword(null, 'rahasia123'),
        isNotNull,
      );
      expect(
        AuthValidators.validateConfirmPassword('', 'rahasia123'),
        isNotNull,
      );
      expect(
        AuthValidators.validateConfirmPassword('salah', 'rahasia123'),
        isNotNull,
      );
      expect(
        AuthValidators.validateConfirmPassword('rahasia123', 'rahasia123'),
        isNull,
      );
    });

    test('evaluatePasswordStrength assigns correct level and progress', () {
      expect(
        AuthValidators.evaluatePasswordStrength(''),
        PasswordStrength.none,
      );
      expect(
        AuthValidators.evaluatePasswordStrength('123'),
        PasswordStrength.weak,
      );
      expect(
        AuthValidators.evaluatePasswordStrength('abcdef'),
        PasswordStrength.weak,
      );
      expect(
        AuthValidators.evaluatePasswordStrength('abc123'),
        PasswordStrength.medium,
      );
      expect(
        AuthValidators.evaluatePasswordStrength('Abc12345!'),
        PasswordStrength.strong,
      );

      expect(PasswordStrength.weak.label, 'Lemah');
      expect(PasswordStrength.medium.label, 'Sedang');
      expect(PasswordStrength.strong.label, 'Kuat');
      expect(PasswordStrength.strong.progress, 1.0);
    });
  });

  group('authRedirect pure function', () {
    test('unauthenticated user redirected to /login from protected routes', () {
      expect(authRedirect(isLoggedIn: false, matchedLocation: '/'), '/login');
      expect(
        authRedirect(isLoggedIn: false, matchedLocation: '/materi'),
        '/login',
      );
      expect(
        authRedirect(isLoggedIn: false, matchedLocation: '/simulasi'),
        '/login',
      );
      expect(
        authRedirect(isLoggedIn: false, matchedLocation: '/profil'),
        '/login',
      );
    });

    test('unauthenticated user allowed on /login and /register', () {
      expect(
        authRedirect(isLoggedIn: false, matchedLocation: '/login'),
        isNull,
      );
      expect(
        authRedirect(isLoggedIn: false, matchedLocation: '/register'),
        isNull,
      );
    });

    test('authenticated user redirected to / from auth routes', () {
      expect(authRedirect(isLoggedIn: true, matchedLocation: '/login'), '/');
      expect(authRedirect(isLoggedIn: true, matchedLocation: '/register'), '/');
    });

    test('authenticated user allowed on protected routes', () {
      expect(authRedirect(isLoggedIn: true, matchedLocation: '/'), isNull);
      expect(
        authRedirect(isLoggedIn: true, matchedLocation: '/materi'),
        isNull,
      );
      expect(
        authRedirect(isLoggedIn: true, matchedLocation: '/simulasi/editor'),
        isNull,
      );
    });
  });

  group('GoRouterRefreshStream', () {
    test(
      'notifies on construction and stream events, cancels on dispose',
      () async {
        final StreamController<int> streamCtrl =
            StreamController<int>.broadcast();
        int notifyCount = 0;
        final GoRouterRefreshStream refreshStream = GoRouterRefreshStream(
          streamCtrl.stream,
        );
        refreshStream.addListener(() => notifyCount++);

        expect(notifyCount, 0);

        streamCtrl.add(1);
        await pumpEventQueue();
        expect(notifyCount, 1);

        refreshStream.dispose();
        streamCtrl.add(2);
        await pumpEventQueue();
        expect(notifyCount, 1);
      },
    );
  });

  group('AuthService', () {
    late FakeFirebaseAuth fakeAuth;
    late FakeFirestore fakeFirestore;
    late AuthService service;

    setUp(() {
      fakeAuth = FakeFirebaseAuth();
      fakeFirestore = FakeFirestore();
      service = AuthService(auth: fakeAuth, firestore: fakeFirestore);
    });

    test('mapErrorCode returns accurate Indonesian messages', () {
      expect(
        AuthService.mapErrorCode('invalid-email').message,
        'Format email tidak valid.',
      );
      expect(
        AuthService.mapErrorCode('wrong-password').message,
        'Email atau password salah.',
      );
      expect(
        AuthService.mapErrorCode('user-not-found').message,
        'Email atau password salah.',
      );
      expect(
        AuthService.mapErrorCode('email-already-in-use').message,
        'Email sudah terdaftar. Silakan masuk.',
      );
      expect(
        AuthService.mapErrorCode('weak-password').message,
        'Password terlalu lemah (minimal 6 karakter).',
      );
      expect(
        AuthService.mapErrorCode('user-disabled').message,
        'Akun ini telah dinonaktifkan.',
      );
      expect(
        AuthService.mapErrorCode('too-many-requests').message,
        contains('Terlalu banyak'),
      );
      expect(
        AuthService.mapErrorCode('network-request-failed').message,
        contains('koneksi internet'),
      );
      expect(
        AuthService.mapErrorCode('unknown_other').message,
        contains('Terjadi kesalahan autentikasi'),
      );
    });

    test(
      'login with existing user creates default firestore doc if missing',
      () async {
        fakeAuth.mockUser = FakeUser(
          uid: 'uid_exist',
          email: 'budi@smk.sch.id',
          displayName: 'Budi Santoso',
        );

        final UserCredential cred = await service.login(
          '  BUDI@SMK.SCH.ID  ',
          'password123',
        );

        expect(cred.user!.uid, 'uid_exist');
        final Map<String, dynamic>? saved =
            fakeFirestore.usersStore['uid_exist'];
        expect(saved, isNotNull);
        expect(saved!['name'], 'Budi Santoso');
        expect(saved['email'], 'budi@smk.sch.id');
        expect(saved['role'], 'siswa');
        expect(saved.containsKey('coins'), isFalse);
        expect(saved['completedSteps'], isEmpty);
      },
    );

    test(
      'login throws mapped AuthException on FirebaseAuthException',
      () async {
        fakeAuth.failSignInWithCode = 'wrong-password';

        expect(
          () => service.login('user@test.com', 'badpass'),
          throwsA(
            isA<AuthException>().having(
              (AuthException e) => e.message,
              'message',
              'Email atau password salah.',
            ),
          ),
        );
      },
    );

    test('register creates user and saves profile to firestore', () async {
      final UserCredential cred = await service.register(
        '  Budi Santoso  ',
        '  BUDI@SMK.SCH.ID  ',
        'rahasia123',
        'Siswa',
      );

      expect(cred.user!.uid, 'new_uid_99');
      expect(cred.user!.displayName, 'Budi Santoso');

      final Map<String, dynamic>? doc = fakeFirestore.usersStore['new_uid_99'];
      expect(doc, isNotNull);
      expect(doc!['name'], 'Budi Santoso');
      expect(doc['email'], 'budi@smk.sch.id');
      expect(doc['role'], 'siswa');
      expect(doc.containsKey('coins'), isFalse);
      expect(doc['completedSteps'], isEmpty);
    });

    test(
      'register retries 1x on firestore error and succeeds if retry works',
      () async {
        final DocumentReference<Map<String, dynamic>> docRef = fakeFirestore
            .collection('users')
            .doc('new_uid_99');
        (docRef as FakeDocumentReference).failSetTimes = 1;

        fakeFirestore.adminCodesStore['GURU-123'] = <String, dynamic>{
          'isValid': true,
        };

        final UserCredential cred = await service.register(
          'Budi',
          'budi@smk.sch.id',
          'rahasia123',
          'guru',
          teacherCode: 'GURU-123',
        );

        expect(cred.user!.uid, 'new_uid_99');
        expect(docRef.setCallCount, 2);
        expect(fakeFirestore.usersStore['new_uid_99']?['role'], 'guru');
        expect(
          fakeFirestore.usersStore['new_uid_99']?['teacherCode'],
          'GURU-123',
        );
      },
    );

    test('register rolls back user when firestore fails after retry', () async {
      final DocumentReference<Map<String, dynamic>> docRef = fakeFirestore
          .collection('users')
          .doc('new_uid_99');
      (docRef as FakeDocumentReference).failSetTimes = 2;

      try {
        await service.register(
          'Budi',
          'budi@smk.sch.id',
          'rahasia123',
          'siswa',
        );
        fail('Should throw');
      } on AuthException catch (e) {
        expect(e.code, 'firestore-write-failed');
      }

      expect(fakeAuth.mockUser?.deleted, isTrue);
    });

    test('logout calls signOut successfully', () async {
      fakeAuth.mockUser = FakeUser(uid: 'uid_123');
      await service.logout();
      expect(fakeAuth.signedOut, isTrue);
      expect(fakeAuth.currentUser, isNull);
    });

    test('userProfileStream emits user document data', () async {
      fakeAuth.mockUser = FakeUser(
        uid: 'uid_stream_test',
        email: 'test@test.com',
      );
      fakeFirestore.usersStore['uid_stream_test'] = <String, dynamic>{
        'name': 'Rama Pratama',
        'email': 'test@test.com',
        'role': 'siswa',
      };

      final Stream<Map<String, dynamic>?> stream = service.userProfileStream(
        'uid_stream_test',
      );
      await expectLater(
        stream,
        emitsInOrder(<dynamic>[
          <String, dynamic>{
            'name': 'Rama Pratama',
            'email': 'test@test.com',
            'role': 'siswa',
            'coins': 10,
          },
          emitsDone,
        ]),
      );
    });

    test('updateProfile updates name in FirebaseAuth and Firestore', () async {
      fakeAuth.mockUser = FakeUser(
        uid: 'uid_update_test',
        email: 'test@test.com',
        displayName: 'Old Name',
      );
      fakeFirestore.usersStore['uid_update_test'] = <String, dynamic>{
        'name': 'Old Name',
        'email': 'test@test.com',
        'role': 'siswa',
      };

      await service.updateProfile(name: 'New Name');

      expect(fakeAuth.mockUser?.displayName, 'New Name');
      final Map<String, dynamic>? stored =
          fakeFirestore.usersStore['uid_update_test'];
      expect(stored?['name'], 'New Name');
      expect(stored?['email'], 'test@test.com');
      expect(stored?['role'], 'siswa');
    });

    test('updateProfile throws when name is empty', () async {
      fakeAuth.mockUser = FakeUser(uid: 'uid_empty_test');

      expect(
        () => service.updateProfile(name: '   '),
        throwsA(
          isA<AuthException>().having(
            (AuthException e) => e.message,
            'message',
            'Nama lengkap tidak boleh kosong.',
          ),
        ),
      );
    });

    test('updateProfile throws when not logged in', () async {
      fakeAuth.mockUser = null;

      expect(
        () => service.updateProfile(name: 'Some Name'),
        throwsA(
          isA<AuthException>().having(
            (AuthException e) => e.message,
            'message',
            'Tidak ada akun yang sedang masuk.',
          ),
        ),
      );
    });
  });

  group('Fase 25A Unit Tests (11.2)', () {
    late FakeFirebaseAuth fakeAuth;
    late FakeFirestore fakeFirestore;
    late AuthService service;

    setUp(() {
      fakeAuth = FakeFirebaseAuth();
      fakeFirestore = FakeFirestore();
      service = AuthService(auth: fakeAuth, firestore: fakeFirestore);
    });

    test('normalizeTeacherCode handles various inputs', () {
      expect(normalizeTeacherCode('  guru-1234  '), 'GURU-1234');
      expect(normalizeTeacherCode('  guru_eduvolt  '), 'GURU_EDUVOLT');
      expect(normalizeTeacherCode('abc1'), 'ABC1');
      expect(normalizeTeacherCode('A1-B2-C3-D4'), 'A1-B2-C3-D4');
      expect(normalizeTeacherCode(null), isNull);
      expect(normalizeTeacherCode(''), isNull);
      expect(normalizeTeacherCode('   '), isNull);
      expect(normalizeTeacherCode('abc'), isNull); // too short (< 4)
      expect(normalizeTeacherCode('A' * 65), isNull); // too long (> 64)
      expect(normalizeTeacherCode('guru/1234'), isNull); // invalid slash
      expect(normalizeTeacherCode('guru@1234'), isNull); // invalid symbol
      expect(normalizeTeacherCode('gürü1234'), isNull); // Unicode umlaut
    });

    test('friendlyAuthError maps all table 5.2 codes accurately', () {
      expect(
        friendlyAuthError(FirebaseAuthException(code: 'email-already-in-use')),
        'Email ini sudah terdaftar. Coba masuk atau gunakan email lain.',
      );
      expect(
        friendlyAuthError(FirebaseAuthException(code: 'invalid-email')),
        'Format email tidak valid.',
      );
      expect(
        friendlyAuthError(FirebaseAuthException(code: 'weak-password')),
        'Kata sandi terlalu lemah. Gunakan minimal 8 karakter.',
      );
      expect(
        friendlyAuthError(
          FirebaseAuthException(code: 'network-request-failed'),
        ),
        'Tidak ada koneksi internet. Periksa jaringanmu lalu coba lagi.',
      );
      expect(
        friendlyAuthError(FirebaseAuthException(code: 'too-many-requests')),
        'Terlalu banyak percobaan. Tunggu beberapa menit lalu coba lagi.',
      );
      expect(
        friendlyAuthError(FirebaseAuthException(code: 'operation-not-allowed')),
        'Pendaftaran email sedang dinonaktifkan. Hubungi admin.',
      );
      expect(
        friendlyAuthError(FirebaseAuthException(code: 'user-token-expired')),
        'Sesi kamu berakhir. Silakan masuk kembali.',
      );
      expect(
        friendlyAuthError(
          FirebaseException(plugin: 'firestore', code: 'unavailable'),
        ),
        'Server sedang sibuk atau koneksi terputus. Coba lagi sebentar.',
      );
      expect(
        friendlyAuthError(
          FirebaseException(plugin: 'firestore', code: 'permission-denied'),
        ),
        'Kamu tidak punya izin untuk tindakan ini.',
      );
      expect(
        friendlyAuthError(const AuthException('Pesan khusus')),
        'Pesan khusus',
      );
      expect(
        friendlyAuthError(Exception('error asing')),
        'Terjadi kesalahan. Silakan coba lagi.',
      );
    });

    test('register with invalid teacher code rejects before user creation (Fase 25C)', () async {
      fakeAuth.mockUser = null;
      fakeFirestore.adminCodesStore['VALID-CODE'] = <String, dynamic>{
        'isValid': true,
      };

      // 1. Kode tidak ditemukan
      try {
        await service.register(
          'Guru Budi',
          'budi@guru.sch.id',
          'rahasia123',
          'guru',
          teacherCode: 'SALAH-CODE',
        );
        fail('Should throw');
      } on AuthException catch (e) {
        expect(e.message, 'Kode Verifikasi Guru tidak ditemukan.');
        expect(e.code, 'teacher-code-not-found');
      }

      // Akun tidak dibuat (pre-validation)
      expect(fakeAuth.mockUser, isNull);
      expect(fakeFirestore.usersStore.containsKey('new_uid_99'), isFalse);

      // 2. Kode ada tapi isValid = false
      fakeFirestore.adminCodesStore['INVALID-FLAG'] = <String, dynamic>{
        'isValid': false,
      };

      try {
        await service.register(
          'Guru Budi',
          'budi@guru.sch.id',
          'rahasia123',
          'guru',
          teacherCode: 'INVALID-FLAG',
        );
        fail('Should throw');
      } on AuthException catch (e) {
        expect(e.message, 'Kode Verifikasi Guru tidak valid (isValid = false).');
        expect(e.code, 'teacher-code-invalid');
      }

      expect(fakeAuth.mockUser, isNull);
    });

    test(
      'register with valid teacher code (including GURU_EDUVOLT) saves teacherCode in document',
      () async {
        fakeAuth.mockUser = null;
        fakeFirestore.adminCodesStore['GURU_EDUVOLT'] = <String, dynamic>{
          'isValid': true,
        };

        final UserCredential cred = await service.register(
          'Guru Budi',
          'budi@guru.sch.id',
          'rahasia123',
          'guru',
          teacherCode: 'guru_eduvolt',
        );

        expect(cred.user!.uid, 'new_uid_99');
        final Map<String, dynamic>? doc =
            fakeFirestore.usersStore['new_uid_99'];
        expect(doc, isNotNull);
        expect(doc!['role'], 'guru');
        expect(doc['teacherCode'], 'GURU_EDUVOLT');
        expect(service.snapshot.status, AuthStatus.unverified);
        expect(service.snapshot.role, UserRole.guru);
      },
    );

    test('register as siswa does NOT save teacherCode', () async {
      fakeAuth.mockUser = null;

      final UserCredential cred = await service.register(
        'Siswa Ani',
        'ani@siswa.sch.id',
        'rahasia123',
        'siswa',
      );

      expect(cred.user!.uid, 'new_uid_99');
      final Map<String, dynamic>? doc = fakeFirestore.usersStore['new_uid_99'];
      expect(doc, isNotNull);
      expect(doc!['role'], 'siswa');
      expect(doc.containsKey('teacherCode'), isFalse);
      expect(service.snapshot.status, AuthStatus.unverified);
      expect(service.snapshot.role, UserRole.siswa);
    });

    test('reloadAndCheckVerified updates snapshot to ready when emailVerified becomes true', () async {
      final FakeUser user = FakeUser(uid: 'uid_verify', emailVerified: false);
      fakeAuth.mockUser = user;
      fakeFirestore.usersStore['uid_verify'] = <String, dynamic>{
        'role': 'guru',
        'name': 'Pak Guru',
      };

      await service.reloadAndCheckVerified();
      expect(service.snapshot.status, AuthStatus.unverified);

      // Now simulate user verified email
      user.emailVerified = true;
      final bool result = await service.reloadAndCheckVerified();
      expect(result, isTrue);
      expect(service.snapshot.status, AuthStatus.ready);
      expect(service.snapshot.role, UserRole.guru);
    });

    test(
      'reloadAndCheckVerified defaults legacy account without role to siswa',
      () async {
        final FakeUser user = FakeUser(uid: 'uid_legacy', emailVerified: true);
        fakeAuth.mockUser = user;
        fakeFirestore.usersStore['uid_legacy'] = <String, dynamic>{
          'name': 'Akun Lama',
          // role field omitted
        };

        await service.reloadAndCheckVerified();
        expect(service.snapshot.status, AuthStatus.ready);
        expect(service.snapshot.role, UserRole.siswa);
        // Ensure it did NOT write role back to Firestore (D10)
        expect(
          fakeFirestore.usersStore['uid_legacy']!.containsKey('role'),
          isFalse,
        );
      },
    );

    test(
      'reloadAndCheckVerified sets roleError when user doc is missing',
      () async {
        final FakeUser user = FakeUser(uid: 'uid_ghost', emailVerified: true);
        fakeAuth.mockUser = user;
        // no firestore document

        await service.reloadAndCheckVerified();
        expect(service.snapshot.status, AuthStatus.roleError);
        expect(
          service.snapshot.errorMessage,
          contains('Profil akun tidak ditemukan'),
        );
      },
    );
  });
}
