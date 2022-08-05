// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as int,
      courseId: json['course_id'] as int,
      topicId: json['topic_id'] as int,
      qid: json['qid'] as String,
      text: json['text'] as String,
      instructions: json['instructions'] as String,
      resource: json['resource'] as String,
      solution: json['solution'] as String?,
      options: json['options'] as String,
      position: json['position'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      qtype: json['qtype'] as String,
      confirmed: json['confirmed'] as int,
      public: json['public'] as int,
      flagged: json['flagged'] as int,
      deleted: json['deleted'] as int,
      editors: json['editors'] as String,
      editorId: json['editor_id'] as String?,
      deletedAt: json['deleted_at'] as String?,
      topic: json['topic'] == null
          ? null
          : Topic.fromJson(json['topic'] as Map<String, dynamic>),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'topic_id': instance.topicId,
      'qid': instance.qid,
      'text': instance.text,
      'instructions': instance.instructions,
      'resource': instance.resource,
      'solution': instance.solution,
      'options': instance.options,
      'position': instance.position,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'qtype': instance.qtype,
      'confirmed': instance.confirmed,
      'public': instance.public,
      'flagged': instance.flagged,
      'deleted': instance.deleted,
      'editors': instance.editors,
      'editor_id': instance.editorId,
      'deleted_at': instance.deletedAt,
      'topic': instance.topic?.toJson(),
      'answers': instance.answers.map((e) => e.toJson()).toList(),
    };
