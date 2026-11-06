import 'package:flutter/foundation.dart';

/// Tipe learning step: pretest, materi, atau posttest.
enum LearningStepType { pretest, materi, posttest }

/// Pertanyaan untuk pretest dan posttest.
@immutable
class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>).cast<String>(),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'options': options,
    'correctAnswerIndex': correctAnswerIndex,
  };
}

/// Blok konten atomik di dalam step materi (teks narasi, potongan kode, atau gambar).
@immutable
class ContentBlock {
  const ContentBlock({
    required this.type,
    required this.data,
  });

  final ContentBlockType type;
  final String data;

  factory ContentBlock.fromJson(Map<String, dynamic> json) {
    return ContentBlock(
      type: ContentBlockType.values.byName(json['type'] as String),
      data: json['data'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'data': data,
  };
}

/// Tipe blok konten: teks narasi, potongan kode, atau gambar ilustrasi.
enum ContentBlockType { text, code, image }

/// Satu langkah belajar: bisa berupa pretest, materi, atau posttest.
@immutable
class LearningStep {
  const LearningStep({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.estimatedTime,
    this.content,
    this.questions,
  });

  final String id;
  final LearningStepType type;
  final String title;
  final String description;
  final String? estimatedTime;
  final List<ContentBlock>? content;
  final List<QuizQuestion>? questions;

  factory LearningStep.fromJson(Map<String, dynamic> json) {
    final type = LearningStepType.values.byName(json['type'] as String);
    return LearningStep(
      id: json['id'] as String,
      type: type,
      title: json['title'] as String,
      description: json['description'] as String,
      estimatedTime: json['estimatedTime'] as String?,
      content: type == LearningStepType.materi
          ? (json['content'] as List<dynamic>?)
              ?.map((e) => ContentBlock.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      questions: (type == LearningStepType.pretest ||
              type == LearningStepType.posttest)
          ? (json['questions'] as List<dynamic>?)
              ?.map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'title': title,
    'description': description,
    'estimatedTime': estimatedTime,
    'content': content?.map((e) => e.toJson()).toList(),
    'questions': questions?.map((e) => e.toJson()).toList(),
  };
}
