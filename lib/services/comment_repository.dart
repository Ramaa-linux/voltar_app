import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  /// Sorting dilakukan di sisi client agar tidak membutuhkan composite index.
  Stream<List<Comment>> streamComments(String postId) {
    return _commentsRef(postId)
        .snapshots()
        .map((snapshot) {
      final comments = snapshot.docs.map((doc) {
        return Comment.fromMap(doc.id, doc.data());
      }).toList();
      comments.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return comments;
    });
  }

  /// Ambil komentar sekali (Future) untuk post - cocok untuk lazy load + FutureBuilder.
  Future<List<Comment>> fetchCommentsOnce(String postId) async {
    debugPrint('fetchCommentsOnce called - postId: $postId');
    debugPrint('FirebaseAuth.instance.currentUser?.uid: ${FirebaseAuth.instance.currentUser?.uid}');

    final snapshot = await _commentsRef(postId).get();

    final comments = snapshot.docs.map((doc) {
      return Comment.fromMap(doc.id, doc.data());
    }).toList();
    comments.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return comments;
  }

  /// Tambah komentar baru.
  Future<void> addComment({
    required String postId,
    required String authorId,
    required String content,
    String? authorName,
  }) async {
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Komentar tidak boleh kosong');
    }

    await _commentsRef(postId).add({
      'postId': postId,
      'authorId': authorId,
      if (authorName != null) 'authorName': authorName,
      'content': trimmed,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Hapus komentar (khusus pemilik atau guru)
  Future<void> deleteComment(String postId, String commentId) async {
    await _commentsRef(postId).doc(commentId).delete();
  }
}