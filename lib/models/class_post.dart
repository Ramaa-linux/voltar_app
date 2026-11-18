import 'package:cloud_firestore/cloud_firestore.dart';

/// Model untuk pengumuman/tugas di forum kelas.
/// 
/// - [type] bisa 'announcement' atau 'assignment'
/// - [title] wajib untuk assignment, opsional untuk announcement
/// - [deadline] hanya untuk assignment, disimpan sebagai 23:59:59 lokal
class ClassPost {
  final String id;
  final String classId;
  final String authorId;
  final String type; // 'announcement' | 'assignment'
  final String? title;
  final String content;
  final Timestamp? deadline;
  final bool isCommentEnabled;
  final Timestamp createdAt;

  ClassPost({
    required this.id,
    required this.classId,
    required this.authorId,
    required this.type,
    this.title,
    required this.content,
    this.deadline,
    required this.isCommentEnabled,
    required this.createdAt,
  });

  factory ClassPost.fromMap(String id, Map<String, dynamic> map) {
    return ClassPost(
      id: id,
      classId: map['classId'] as String? ?? '',
      authorId: map['authorId'] as String? ?? '',
      type: map['type'] as String? ?? 'announcement',
      title: map['title'] as String?,
      content: map['content'] as String? ?? '',
      deadline: map['deadline'] as Timestamp?,
      isCommentEnabled: map['isCommentEnabled'] as bool? ?? true,
      createdAt: map['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'authorId': authorId,
      'type': type,
      'title': title,
      'content': content,
      'deadline': deadline,
      'isCommentEnabled': isCommentEnabled,
      'createdAt': createdAt,
    };
  }

  /// Cek apakah post ini adalah tugas (assignment)
  bool get isAssignment => type == 'assignment';

  /// Cek apakah post ini adalah pengumuman (announcement)
  bool get isAnnouncement => type == 'announcement';

  /// Cek apakah deadline sudah lewat (overdue)
  /// Deadline disimpan sebagai 23:59:59, jadi tidak overdue di hari deadline
  bool get isOverdue {
    if (deadline == null) return false;
    final now = DateTime.now();
    final deadlineDate = deadline!.toDate();
    // Reset waktu ke 23:59:59 untuk perbandingan yang adil
    final deadlineEndOfDay = DateTime(
      deadlineDate.year,
      deadlineDate.month,
      deadlineDate.day,
      23, 59, 59,
    );
    return now.isAfter(deadlineEndOfDay);
  }

  /// Dapatkan deadline sebagai DateTime (untuk UI)
  DateTime? get deadlineDateTime => deadline?.toDate();

  /// Format deadline untuk tampilan Indonesia (mis. "Jumat, 21 Nov 2026, 23:59")
  String get formattedDeadline {
    if (deadline == null) return '-';
    final dt = deadline!.toDate();
    const days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    final dayName = days[dt.weekday % 7];
    return '$dayName, ${dt.day} ${months[dt.month - 1]} ${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  /// Format createdAt untuk tampilan Indonesia
  String get formattedCreatedAt {
    final dt = createdAt.toDate();
    const days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    final dayName = days[dt.weekday % 7];
    return '$dayName, ${dt.day} ${months[dt.month - 1]} ${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return 'ClassPost(id: $id, type: $type, title: $title, deadline: $deadline, isOverdue: $isOverdue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClassPost && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}