import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic {
  Topic({
    required this.id,
    required this.courseId,
    required this.topicID,
    required this.name,
    required this.author,
    required this.description,
    required this.notes,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.confirmed,
    required this.public,
    required this.n,
    required this.p,
    this.editors,
    this.editorId,
    this.deletedAt,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  int id;
  @JsonKey(name: 'course_id')
  int courseId;
  String topicID;
  String name;
  String author;
  String description;
  String notes;
  String category;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  int confirmed;
  int public;
  int? n;
  int? p;
  String? editors;
  @JsonKey(name: 'editor_Id')
  String? editorId;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
