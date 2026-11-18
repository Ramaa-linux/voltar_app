import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/comment.dart';

/// Repository untuk operasi CRUD komentar.
/// 
/// Comments disimpan sebagai subcollection di `posts/{postId}/comments`
/// untuk memungkinkan query sederhana: `where('postId')` tanpa composite index.
class CommentRepository {
  final FirebaseFirestore _firestore;

  CommentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _commentsRef(String postId) {
    return _firestore.collection('posts').doc(postId).collection('comments');
  }

  /// Stream komentar untuk suatu post.
  /// Diurutkan ascending berdasarkan `createdAt` (komentar lama di atas).
  Stream<List<Comment>> streamComments(String postId) {
    return _commentsRef(postId)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Comment.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  /// Ambil komentar sekali (Future) untuk post - cocok untuk lazy load + FutureBuilder.
  Future<List<Comment>> fetchCommentsOnce(String postId) async {
    final snapshot = await _commentsRef(postId)
        .orderBy('createdAt', descending: false)
        .get();

    return snapshot.docs.map((doc) {
      return Comment.fromMap(doc.id, doc.data());
    }).toList();
  }

  /// Tambah komentar baru.
  Future<void> addComment({
    required String postId,
    required String authorId,
    required String content,
  }) async {
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Komentar tidak boleh kosong');
    }

    await _commentsRef(postId).add({
      'postId': postId,
      'authorId': authorId,
      'content': trimmed,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Hapus komentar (khusus pemilik atau guru)
  Future<void> deleteComment(String postId, String commentId) async {
    await _commentsRef(postId).doc(commentId).delete();
  }
}