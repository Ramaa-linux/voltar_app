import 'package:cloud_firestore/cloud_firestore.dart';

/// Model untuk komentar pada pengumuman/tugas.
class Comment {
  final String id;
  final String postId;
  final String authorId;
  final String? authorName;
  final String content;
  final Timestamp createdAt;

  Comment({
    required this.id,
    required this.postId,
    required this.authorId,
    this.authorName,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromMap(String id, Map<String, dynamic> map) {
    return Comment(
      id: id,
      postId: map['postId'] as String? ?? '',
      authorId: map['authorId'] as String? ?? '',
      authorName: map['authorName'] as String?,
      content: map['content'] as String? ?? '',
      createdAt: map['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'authorId': authorId,
      if (authorName != null) 'authorName': authorName,
      'content': content,
      'createdAt': createdAt,
    };
  }

  /// Dapatkan waktu dibuat sebagai DateTime
  DateTime get createdDateTime => createdAt.toDate();

  /// Format createdAt untuk tampilan Indonesia
  String get formattedCreatedAt {
    final dt = createdAt.toDate();
    final day = _dayName(dt.weekday);
    final month = _monthName(dt.month);
    return '$day, ${dt.day} $month ${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _dayName(int d) => d == 1 ? 'Senin' : d == 2 ? 'Selasa' : d == 3 ? 'Rabu' : d == 4 ? 'Kamis' : d == 5 ? 'Jumat' : d == 6 ? 'Sabtu' : 'Minggu';

  String _monthName(int m) => m == 1 ? 'Jan' : m == 2 ? 'Feb' : m == 3 ? 'Mar' : m == 4 ? 'Apr' : m == 5 ? 'Mei' : m == 6 ? 'Jun' : m == 7 ? 'Jul' : m == 8 ? 'Agu' : m == 9 ? 'Sep' : m == 10 ? 'Okt' : m == 11 ? 'Nov' : 'Des';

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