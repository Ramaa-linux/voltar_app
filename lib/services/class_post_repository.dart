import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/class_post.dart';
import 'auth_service.dart';

/// Repository untuk operasi CRUD pengumuman dan tugas kelas.
/// 
/// Strategi query:
/// - Hanya gunakan satu filter `where('classId')` untuk menghindari composite index
/// - Sorting dan filtering by `type` dilakukan di sisi client (Dart)
class ClassPostRepository {
  final FirebaseFirestore _firestore;
  final AuthService _authService;

  ClassPostRepository({
    FirebaseFirestore? firestore,
    AuthService? authService,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _authService = authService ?? AuthService();

  /// Stream semua posts untuk suatu kelas (announcement + assignment).
  /// Data sudah diurutkan descending berdasarkan `createdAt`.
  Stream<List<ClassPost>> streamPosts(String classId) {
    return _firestore
        .collection('posts')
        .where('classId', isEqualTo: classId)
        .snapshots()
        .map((snapshot) {
      final posts = snapshot.docs.map((doc) {
        return ClassPost.fromMap(doc.id, doc.data());
      }).toList();

      // Sort descending by createdAt (client-side, no composite index needed)
      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return posts;
    });
  }

  /// Fetch posts sekali (Future) untuk kelas - cocok untuk FutureBuilder + RefreshIndicator.
  /// Mengambil nama author via [fetchUsersByIds] agar tidak perlu stream.
  Future<List<ClassPost>> fetchPosts(String classId) async {
    final snapshot = await _firestore
        .collection('posts')
        .where('classId', isEqualTo: classId)
        .get();

    final posts = snapshot.docs.map((doc) {
      return ClassPost.fromMap(doc.id, doc.data());
    }).toList();

    // Sort descending by createdAt
    posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Resolve author names
    await _resolveAuthorNames(posts);

    return posts;
  }

  /// Ambil nama author untuk daftar posts secara batch
  Future<void> _resolveAuthorNames(List<ClassPost> posts) async {
    final authorIds = posts.map((p) => p.authorId).where((id) => id.isNotEmpty).toSet();
    if (authorIds.isEmpty) return;

    final usersMap = await _authService.fetchUsersByIds(authorIds);
    for (final post in posts) {
      final userData = usersMap[post.authorId];
      if (userData != null) {
        // Store author name in a dynamic way - we'll use a map for display
        // Since ClassPost is immutable, we handle this at UI level
      }
    }
  }

  /// Buat pengumuman baru (type: 'announcement')
  Future<void> createAnnouncement({
    required String classId,
    required String authorId,
    required String content,
    String? title,
  }) async {
    final trimmedContent = content.trim();
    if (trimmedContent.isEmpty) {
      throw ArgumentError('Konten pengumuman tidak boleh kosong');
    }

    final now = FieldValue.serverTimestamp();
    await _firestore.collection('posts').add({
      'classId': classId,
      'authorId': authorId,
      'type': 'announcement',
      'title': title?.trim(),
      'content': trimmedContent,
      'deadline': null,
      'isCommentEnabled': true,
      'createdAt': now,
      'updatedAt': now,
    });
  }

  /// Buat tugas baru (type: 'assignment')
  /// [deadline] disimpan sebagai akhir hari (23:59:59) lokal
  Future<void> createAssignment({
    required String classId,
    required String authorId,
    required String title,
    required String content,
    required DateTime deadline,
  }) async {
    final trimmedTitle = title.trim();
    final trimmedContent = content.trim();

    if (trimmedTitle.isEmpty) {
      throw ArgumentError('Judul tugas tidak boleh kosong');
    }
    if (trimmedContent.isEmpty) {
      throw ArgumentError('Deskripsi tugas tidak boleh kosong');
    }

    // Set waktu deadline ke 23:59:59 agar tidak langsung overdue di hari itu
    final endOfDay = DateTime(
      deadline.year,
      deadline.month,
      deadline.day,
      23, 59, 59,
    );

    final now = FieldValue.serverTimestamp();
    await _firestore.collection('posts').add({
      'classId': classId,
      'authorId': authorId,
      'type': 'assignment',
      'title': trimmedTitle,
      'content': trimmedContent,
      'deadline': Timestamp.fromDate(endOfDay),
      'isCommentEnabled': false, // Assignments default: comments disabled
      'createdAt': now,
      'updatedAt': now,
    });
  }

  /// Update post yang sudah ada. Hanya field yang diberikan (non-null) yang diubah.
  /// [authorId], [authorName], [createdAt], [type], [classId] diabaikan (tidak bisa diubah).
  /// Selalu menambah/memperbarui [updatedAt] dengan serverTimestamp.
  Future<void> updatePost({
    required String postId,
    required String classId,
    String? title,
    String? content,
    Timestamp? deadline,
    bool? isCommentEnabled,
  }) async {
    final Map<String, dynamic> updates = {
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (title != null) updates['title'] = title.trim().isEmpty ? null : title.trim();
    if (content != null) {
      if (content.trim().isEmpty) {
        throw ArgumentError('Konten tidak boleh kosong');
      }
      updates['content'] = content.trim();
    }
    if (deadline != null) updates['deadline'] = deadline;
    if (isCommentEnabled != null) updates['isCommentEnabled'] = isCommentEnabled;

    // Hanya update jika ada field selain updatedAt
    if (updates.length > 1) {
      await _firestore.collection('posts').doc(postId).update(updates);
    }
  }

  /// Hapus post dan membersihkan data terkait (best effort via WriteBatch).
  /// Hapus semua dokumen di subcollection `posts/{postId}/comments` dan semua
  /// dokumen `submissions` dengan `postId` yang cocok.
  /// Maksimal 500 operasi per batch; dipotong jika lebih.
  Future<void> deletePostWithCleanup(String postId) async {
    final batch = _firestore.batch();

    // Hapus komentar di subcollection
    final commentsSnap = await _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
    int count = 0;
    for (final doc in commentsSnap.docs) {
      batch.delete(doc.reference);
      count++;
      if (count >= 500) {
        await batch.commit();
        batch.delete(_firestore.collection('posts').doc(postId));
        count = 0;
      }
    }

    // Hapus submissions dengan postId yang cocok
    final subsSnap = await _firestore
        .collection('submissions')
        .where('postId', isEqualTo: postId)
        .get();
    for (final doc in subsSnap.docs) {
      batch.delete(doc.reference);
      count++;
      if (count >= 500) {
        await batch.commit();
        batch.delete(_firestore.collection('posts').doc(postId));
        count = 0;
      }
    }

    // Hapus dokumen post utama
    batch.delete(_firestore.collection('posts').doc(postId));
    await batch.commit();
  }

  /// Hapus post utama saja (tanpa cleanup data terkait).
  /// Digunakan sebagai fallback jika cleanup gagal atau rules tidak mengizinkan.
  Future<void> deletePost(String postId) async {
    // Hapus post utama (comments di subcollection akan yatim, tapi aman untuk skala kelas)
    await _firestore.collection('posts').doc(postId).delete();
  }

  /// Toggle aktif/nonaktif komentar untuk suatu post (khusus guru)
  Future<void> toggleComments({
    required String postId,
    required bool enabled,
  }) async {
    await _firestore.collection('posts').doc(postId).update({
      'isCommentEnabled': enabled,
    });
  }

}