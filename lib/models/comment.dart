import 'package:cloud_firestore/cloud_firestore.dart';

/// Model untuk komentar pada pengumuman/tugas.
class Comment {
  final String id;
  final String postId;
  final String authorId;
  final String content;
  final Timestamp createdAt;

  Comment({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromMap(String id, Map<String, dynamic> map) {
    return Comment(
      id: id,
      postId: map['postId'] as String? ?? '',
      authorId: map['authorId'] as String? ?? '',
      content: map['content'] as String? ?? '',
      createdAt: map['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'authorId': authorId,
      'content': content,
      'createdAt': createdAt,
    };
  }

  /// Dapatkan waktu dibuat sebagai DateTime
  DateTime get createdDateTime => createdAt.toDate();

  /// Format createdAt untuk tampilan Indonesia (mis. "Senin, 20 Nov 2026, 14:30")
  String get formattedCreatedAt {
    final dt = createdAt.toDate();
    const days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    final dayName = days[dt.weekday % 7];
    return '$dayName, ${dt.day} ${months[dt.month - 1]} ${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return 'Comment(id: $id, postId: $postId, authorId: $authorId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Comment && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}