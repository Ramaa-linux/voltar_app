import 'package:flutter/foundation.dart';

/// Tipe learning step: pretest, materi, posttest, atau folder.
enum LearningStepType { pretest, materi, posttest, folder }

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

/// Blok konten atomik di dalam step materi.
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

/// Tipe blok konten: teks narasi, potongan kode, gambar ilustrasi, atau heading.
enum ContentBlockType { text, code, image, heading }

/// Satu langkah belajar: bisa berupa pretest, materi, posttest, atau folder.
@immutable
class LearningStep {
  const LearningStep({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.estimatedTime,
    this.heroImageUrl,
    this.videoUrl,
    this.content,
    this.videoSummary,
    this.questions,
    this.subMateri,
    // Localization keys (populated by [MateriRepository]; null = use raw JSON value)
    this.localizedTitleKey,
    this.localizedDescriptionKey,
    this.localizedEstimatedTimeKey,
    this.localizedContentKeys,      // parallel index to [content]
    this.localizedVideoSummaryKeys, // parallel index to [videoSummary]
    this.localizedQuestionKeys,   // question index -> ARB key
    this.localizedOptionKeys, // question index -> [option ARB keys]
  });

  final String id;
  final LearningStepType type;
  final String title;
  final String description;
  final String? estimatedTime;
  final String? heroImageUrl;
  final String? videoUrl;
  final List<ContentBlock>? content;
  final List<ContentBlock>? videoSummary;
  final List<QuizQuestion>? questions;
  final List<LearningStep>? subMateri;
  final String? localizedTitleKey;
  final String? localizedDescriptionKey;
  final String? localizedEstimatedTimeKey;
  final List<String>? localizedContentKeys;
  final List<String>? localizedVideoSummaryKeys;
  final Map<int, String>? localizedQuestionKeys;
  final Map<int, List<String>>? localizedOptionKeys;

  /// Salin dengan field yang diganti.
  LearningStep copyWith({
    String? id,
    LearningStepType? type,
    String? title,
    String? description,
    String? estimatedTime,
    String? heroImageUrl,
    String? videoUrl,
    List<ContentBlock>? content,
    List<ContentBlock>? videoSummary,
    List<QuizQuestion>? questions,
    List<LearningStep>? subMateri,
    String? localizedTitleKey,
    String? localizedDescriptionKey,
    String? localizedEstimatedTimeKey,
    List<String>? localizedContentKeys,
    List<String>? localizedVideoSummaryKeys,
    Map<int, String>? localizedQuestionKeys,
    Map<int, List<String>>? localizedOptionKeys,
  }) {
    return LearningStep(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      heroImageUrl: heroImageUrl ?? this.heroImageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      content: content ?? this.content,
      videoSummary: videoSummary ?? this.videoSummary,
      questions: questions ?? this.questions,
      subMateri: subMateri ?? this.subMateri,
      localizedTitleKey: localizedTitleKey ?? this.localizedTitleKey,
      localizedDescriptionKey:
          localizedDescriptionKey ?? this.localizedDescriptionKey,
      localizedEstimatedTimeKey:
          localizedEstimatedTimeKey ?? this.localizedEstimatedTimeKey,
      localizedContentKeys: localizedContentKeys ?? this.localizedContentKeys,
      localizedVideoSummaryKeys:
          localizedVideoSummaryKeys ?? this.localizedVideoSummaryKeys,
      localizedQuestionKeys:
          localizedQuestionKeys ?? this.localizedQuestionKeys,
      localizedOptionKeys: localizedOptionKeys ?? this.localizedOptionKeys,
    );
  }

  factory LearningStep.fromJson(Map<String, dynamic> json) {
    final type = LearningStepType.values.byName(json['type'] as String);
    return LearningStep(
      id: json['id'] as String,
      type: type,
      title: json['title'] as String,
      description: json['description'] as String,
      estimatedTime: json['estimatedTime'] as String?,
      heroImageUrl: json['heroImageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      content: type == LearningStepType.materi
          ? (json['content'] as List<dynamic>?)
              ?.map((e) => ContentBlock.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      videoSummary: type == LearningStepType.materi
          ? (json['videoSummary'] as List<dynamic>?)
              ?.map((e) => ContentBlock.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      questions: (type == LearningStepType.pretest ||
              type == LearningStepType.posttest)
          ? (json['questions'] as List<dynamic>?)
              ?.map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      subMateri: type == LearningStepType.folder
          ? (json['subMateri'] as List<dynamic>?)
              ?.map((e) => LearningStep.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      localizedTitleKey: json['localizedTitleKey'] as String?,
      localizedDescriptionKey:
          json['localizedDescriptionKey'] as String?,
      localizedEstimatedTimeKey:
          json['localizedEstimatedTimeKey'] as String?,
      localizedContentKeys: (json['localizedContentKeys'] as List<dynamic>?)
          ?.cast<String>()
          .toList(),
      localizedVideoSummaryKeys: (json['localizedVideoSummaryKeys']
              as List<dynamic>?)
          ?.cast<String>()
          .toList(),
      localizedQuestionKeys: (json['localizedQuestionKeys']
              as Map<String, dynamic>?)
          ?.map((k, v) => MapEntry(int.parse(k), v as String)),
      localizedOptionKeys: (json['localizedOptionKeys']
              as Map<String, dynamic>?)
          ?.map((k, v) => MapEntry(int.parse(k), (v as List<dynamic>).cast<String>())),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'title': title,
    'description': description,
    'estimatedTime': estimatedTime,
    'heroImageUrl': heroImageUrl,
    'videoUrl': videoUrl,
    'content': content?.map((e) => e.toJson()).toList(),
    'videoSummary': videoSummary?.map((e) => e.toJson()).toList(),
    'questions': questions?.map((e) => e.toJson()).toList(),
    'subMateri': subMateri?.map((e) => e.toJson()).toList(),
    if (localizedTitleKey != null) 'localizedTitleKey': localizedTitleKey,
    if (localizedDescriptionKey != null)
      'localizedDescriptionKey': localizedDescriptionKey,
    if (localizedEstimatedTimeKey != null)
      'localizedEstimatedTimeKey': localizedEstimatedTimeKey,
    if (localizedContentKeys != null)
      'localizedContentKeys': localizedContentKeys,
    if (localizedVideoSummaryKeys != null)
      'localizedVideoSummaryKeys': localizedVideoSummaryKeys,
    if (localizedQuestionKeys != null)
      'localizedQuestionKeys': localizedQuestionKeys,
    if (localizedOptionKeys != null) 'localizedOptionKeys': localizedOptionKeys,
  };
}
