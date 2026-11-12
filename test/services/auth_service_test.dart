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
  });

  @override
  final String uid;

  @override
  final String? email;

  @override
  String? displayName;

  bool deleted = false;

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
  late final FakeCollectionReference usersCollection =
      FakeCollectionReference(usersStore);

  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) {
    if (collectionPath == 'users') {
      return usersCollection;
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
    test('notifies on construction and stream events, cancels on dispose', () async {
      final StreamController<int> streamCtrl =
          StreamController<int>.broadcast();
      int notifyCount = 0;
      final GoRouterRefreshStream refreshStream =
          GoRouterRefreshStream(streamCtrl.stream);
      refreshStream.addListener(() => notifyCount++);

      expect(notifyCount, 0);

      streamCtrl.add(1);
      await pumpEventQueue();
      expect(notifyCount, 1);

      refreshStream.dispose();
      streamCtrl.add(2);
      await pumpEventQueue();
      expect(notifyCount, 1);
    });
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

    test('login with existing user creates default firestore doc if missing', () async {
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
      final Map<String, dynamic>? saved = fakeFirestore.usersStore['uid_exist'];
      expect(saved, isNotNull);
      expect(saved!['name'], 'Budi Santoso');
      expect(saved['email'], 'budi@smk.sch.id');
      expect(saved['role'], 'siswa');
      expect(saved['coins'], 0);
      expect(saved['completedSteps'], isEmpty);
    });

    test('login throws mapped AuthException on FirebaseAuthException', () async {
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
    });

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
      expect(doc['coins'], 0);
      expect(doc['completedSteps'], isEmpty);
    });

    test('register retries 1x on firestore error and succeeds if retry works', () async {
      final DocumentReference<Map<String, dynamic>> docRef =
          fakeFirestore.collection('users').doc('new_uid_99');
      (docRef as FakeDocumentReference).failSetTimes = 1;

      final UserCredential cred = await service.register(
        'Budi',
        'budi@smk.sch.id',
        'rahasia123',
        'guru',
      );

      expect(cred.user!.uid, 'new_uid_99');
      expect(docRef.setCallCount, 2);
      expect(fakeFirestore.usersStore['new_uid_99']?['role'], 'guru');
    });

    test('register rolls back user when firestore fails after retry', () async {
      final DocumentReference<Map<String, dynamic>> docRef =
          fakeFirestore.collection('users').doc('new_uid_99');
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
      fakeAuth.mockUser = FakeUser(uid: 'uid_stream_test', email: 'test@test.com');
      fakeFirestore.usersStore['uid_stream_test'] = <String, dynamic>{
        'name': 'Rama Pratama',
        'email': 'test@test.com',
        'role': 'siswa',
        'coins': 10,
      };

      final Stream<Map<String, dynamic>?> stream =
          service.userProfileStream('uid_stream_test');
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
        'coins': 5,
      };

      await service.updateProfile(name: 'New Name');

      expect(fakeAuth.mockUser?.displayName, 'New Name');
      final Map<String, dynamic>? stored = fakeFirestore.usersStore['uid_update_test'];
      expect(stored?['name'], 'New Name');
      expect(stored?['email'], 'test@test.com');
      expect(stored?['role'], 'siswa');
      expect(stored?['coins'], 5);
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
}

