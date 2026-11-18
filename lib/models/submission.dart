import 'package:cloud_firestore/cloud_firestore.dart';

/// Model untuk status penyelesaian tugas oleh siswa.
/// 
/// Document ID menggunakan format deterministik: "{postId}_{studentId}"
/// untuk menghindari duplikasi dan memudahkan upsert.
class Submission {
  final String id; // format: "{postId}_{studentId}"
  final String postId;
  final String classId;
  final String studentId;
  final Timestamp completedAt;

  Submission({
    required this.id,
    required this.postId,
    required this.classId,
    required this.studentId,
    required this.completedAt,
  });

  /// Buat ID deterministik dari postId dan studentId
  static String createId(String postId, String studentId) => '${postId}_$studentId';

  factory Submission.fromMap(String id, Map<String, dynamic> map) {
    return Submission(
      id: id,
      postId: map['postId'] as String? ?? '',
      classId: map['classId'] as String? ?? '',
      studentId: map['studentId'] as String? ?? '',
      completedAt: map['completedAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'classId': classId,
      'studentId': studentId,
      'completedAt': completedAt,
    };
  }

  /// Dapatkan waktu selesai sebagai DateTime
  DateTime get completedDateTime => completedAt.toDate();

  /// Format completedAt untuk tampilan Indonesia (mis. "Senin, 20 Nov 2026, 14:30")
  String get formattedCreatedAt {
    final dt = completedAt.toDate();
    const days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    final dayName = days[dt.weekday % 7];
    return '$dayName, ${dt.day} ${months[dt.month - 1]} ${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return 'Submission(id: $id, postId: $postId, studentId: $studentId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Submission && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}