import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  Answer({
    required this.id,
    required this.questionId,
    required this.text,
    required this.value,
    required this.solution,
    required this.createdAt,
    required this.updatedAt,
    required this.answerOrder,
    required this.responses,
    required this.flagged,
    this.editors,
    this.editorId,
    this.deletedAt,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  int id;
  @JsonKey(name: 'question_id')
  int questionId;
  String text;
  int value;
  String solution;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'answer_order')
  int? answerOrder;
  int responses;
  int flagged;
  String? editors;
  @JsonKey(name: 'editor_id')
  String? editorId;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  bool get isRightAnswer => value == 1;
}
