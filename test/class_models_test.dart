import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/models/class_post.dart';
import 'package:voltar/models/comment.dart';
import 'package:voltar/models/submission.dart';

void main() {
  group('ClassPost', () {
    test('fromMap creates correct object', () {
      final map = {
        'classId': 'class123',
        'authorId': 'author456',
        'type': 'assignment',
        'title': 'Test Tugas',
        'content': 'Deskripsi tugas',
        'deadline': null,
        'isCommentEnabled': true,
        'createdAt': Timestamp.fromDate(DateTime(2026, 1, 15, 10, 30)),
      };
      final post = ClassPost.fromMap('post123', map);

      expect(post.id, 'post123');
      expect(post.classId, 'class123');
      expect(post.authorId, 'author456');
      expect(post.type, 'assignment');
      expect(post.title, 'Test Tugas');
      expect(post.content, 'Deskripsi tugas');
      expect(post.isAssignment, isTrue);
      expect(post.isAnnouncement, isFalse);
    });

    test('isOverdue returns false for null deadline', () {
      final post = ClassPost(
        id: '1',
        classId: 'c1',
        authorId: 'a1',
        type: 'assignment',
        deadline: null,
        content: 'test',
        isCommentEnabled: true,
        createdAt: Timestamp.now(),
      );
      expect(post.isOverdue, isFalse);
    });

    test('isOverdue returns true when past deadline end of day', () {
      final past = DateTime.now().subtract(const Duration(days: 2));
      final post = ClassPost(
        id: '1',
        classId: 'c1',
        authorId: 'a1',
        type: 'assignment',
        deadline: Timestamp.fromDate(past),
        content: 'test',
        isCommentEnabled: true,
        createdAt: Timestamp.now(),
      );
      expect(post.isOverdue, isTrue);
    });

    test('formattedDeadline formats correctly', () {
      final dt = DateTime(2026, 11, 18, 23, 59);
      final post = ClassPost(
        id: '1',
        classId: 'c1',
        authorId: 'a1',
        type: 'assignment',
        deadline: Timestamp.fromDate(dt),
        content: 'test',
        isCommentEnabled: true,
        createdAt: Timestamp.now(),
      );
      expect(post.formattedDeadline, contains('2026'));
      expect(post.formattedDeadline, contains('18'));
      expect(post.formattedDeadline, contains('Nov'));
    });
  });

  group('Comment', () {
    test('fromMap creates correct object', () {
      final map = {
        'postId': 'post123',
        'authorId': 'author456',
        'content': 'Komentar test',
        'createdAt': Timestamp.fromDate(DateTime(2026, 1, 15, 14, 30)),
      };
      final comment = Comment.fromMap('comment123', map);

      expect(comment.id, 'comment123');
      expect(comment.postId, 'post123');
      expect(comment.authorId, 'author456');
      expect(comment.content, 'Komentar test');
    });

    test('formattedCreatedAt formats correctly', () {
      final dt = DateTime(2026, 11, 18, 14, 30);
      final comment = Comment(
        id: 'c1',
        postId: 'p1',
        authorId: 'a1',
        content: 'test',
        createdAt: Timestamp.fromDate(dt),
      );
      expect(comment.formattedCreatedAt, contains('2026'));
      expect(comment.formattedCreatedAt, contains('18'));
      expect(comment.formattedCreatedAt, contains('Nov'));
    });
  });

  group('Submission', () {
    test('createId generates deterministic ID', () {
      expect(Submission.createId('post123', 'student456'), 'post123_student456');
    });

    test('fromMap creates correct object', () {
      final map = {
        'postId': 'post123',
        'classId': 'class456',
        'studentId': 'student789',
        'completedAt': Timestamp.fromDate(DateTime(2026, 1, 15, 16, 45)),
      };
      final sub = Submission.fromMap('post123_student789', map);

      expect(sub.id, 'post123_student789');
      expect(sub.postId, 'post123');
      expect(sub.classId, 'class456');
      expect(sub.studentId, 'student789');
    });

    test('formattedCreatedAt formats correctly', () {
      final dt = DateTime(2026, 11, 18, 16, 45);
      final sub = Submission(
        id: 'p1_s1',
        postId: 'p1',
        classId: 'c1',
        studentId: 's1',
        completedAt: Timestamp.fromDate(dt),
      );
      expect(sub.formattedCreatedAt, contains('2026'));
      expect(sub.formattedCreatedAt, contains('18'));
      expect(sub.formattedCreatedAt, contains('Nov'));
    });
  });
}