import 'package:adeo_testapp/diagnostic_test/models/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'questions_response.g.dart';

@JsonSerializable()
class QuestionsResponse {
  QuestionsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionsResponseFromJson(json);

  bool status;
  String code;
  String message;
  List<Question> data;

  Map<String, dynamic> toJson() => _$QuestionsResponseToJson(this);
}
