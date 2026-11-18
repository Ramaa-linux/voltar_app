import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/submission.dart';

/// Repository untuk operasi submission/penyelesaian tugas.
/// 
/// Document ID menggunakan format deterministik: "{postId}_{studentId}"
/// Memungkinkan:
/// - Upsert tanpa duplikasi (set dengan merge)
/// - Get langsung by ID tanpa query
/// - Query by classId + studentId (2 equality filters, no composite index)
class SubmissionRepository {
  final FirebaseFirestore _firestore;

  SubmissionRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Referensi ke collection submissions
  CollectionReference<Map<String, dynamic>> get _submissionsRef =>
      _firestore.collection('submissions');

  /// Stream submission untuk satu tugas (post) - khusus guru
  Stream<List<Submission>> streamSubmissionsForPost(String postId) {
    return _submissionsRef
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Submission.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  /// Ambil submissions sekali (Future) untuk post - cocok untuk dialog "Lihat yang sudah selesai".
  Future<List<Submission>> fetchSubmissionsForPostOnce(String postId) async {
    final snapshot = await _submissionsRef
        .where('postId', isEqualTo: postId)
        .get();

    return snapshot.docs.map((doc) {
      return Submission.fromMap(doc.id, doc.data());
    }).toList();
  }

  /// Stream submission siswa untuk satu kelas
  /// Digunakan untuk filter "Belum Selesai" / "Selesai" di tab Tugas siswa
  Stream<List<Submission>> streamMySubmissions({
    required String classId,
    required String studentId,
  }) {
    return _submissionsRef
        .where('classId', isEqualTo: classId)
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Submission.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  /// Tandai tugas selesai/belum selesai (toggle)
  /// Menggunakan deterministic ID untuk upsert
  Future<void> setCompleted({
    required String postId,
    required String classId,
    required String studentId,
    required bool completed,
  }) async {
    final id = Submission.createId(postId, studentId);
    final docRef = _submissionsRef.doc(id);

    if (completed) {
      await docRef.set({
        'postId': postId,
        'classId': classId,
        'studentId': studentId,
        'completedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } else {
      await docRef.delete();
    }
  }

  /// Cek apakah tugas sudah diselesaikan oleh siswa (get by ID deterministik)
  Future<bool> isCompleted({
    required String postId,
    required String studentId,
  }) async {
    final id = Submission.createId(postId, studentId);
    final doc = await _submissionsRef.doc(id).get();
    return doc.exists;
  }

  /// Hapus submission (cleanup jika tugas dihapus guru)
  Future<void> deleteSubmission(String postId, String studentId) async {
    final id = Submission.createId(postId, studentId);
    await _submissionsRef.doc(id).delete();
  }
}