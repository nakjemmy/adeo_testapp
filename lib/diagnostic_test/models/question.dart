import 'package:adeo_testapp/diagnostic_test/models/answer.dart';
import 'package:adeo_testapp/diagnostic_test/models/topic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  Question({
    required this.id,
    required this.courseId,
    required this.topicId,
    required this.qid,
    required this.text,
    required this.instructions,
    required this.resource,
    required this.solution,
    required this.options,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    required this.qtype,
    required this.confirmed,
    required this.public,
    required this.flagged,
    required this.deleted,
    required this.editors,
    this.editorId,
    this.deletedAt,
    this.topic,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  int id;
  @JsonKey(name: 'course_id')
  int courseId;
  @JsonKey(name: 'topic_id')
  int topicId;
  String qid;
  String text;
  String instructions;
  String resource;
  String? solution;
  String options;
  int position;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  String qtype;
  int confirmed;
  int public;
  int flagged;
  int deleted;
  String editors;
  @JsonKey(name: 'editor_id')
  String? editorId;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;
  Topic? topic;
  List<Answer> answers;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
