// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      id: json['id'] as int,
      questionId: json['question_id'] as int,
      text: json['text'] as String,
      value: json['value'] as int,
      solution: json['solution'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      answerOrder: json['answer_order'] as int?,
      responses: json['responses'] as int,
      flagged: json['flagged'] as int,
      editors: json['editors'] as String?,
      editorId: json['editor_id'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'text': instance.text,
      'value': instance.value,
      'solution': instance.solution,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'answer_order': instance.answerOrder,
      'responses': instance.responses,
      'flagged': instance.flagged,
      'editors': instance.editors,
      'editor_id': instance.editorId,
      'deleted_at': instance.deletedAt,
    };
