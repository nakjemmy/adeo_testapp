// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      id: json['id'] as int,
      courseId: json['course_id'] as int,
      topicID: json['topicID'] as String,
      name: json['name'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      notes: json['notes'] as String,
      category: json['category'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      confirmed: json['confirmed'] as int,
      public: json['public'] as int,
      n: json['n'] as int?,
      p: json['p'] as int?,
      editors: json['editors'] as String?,
      editorId: json['editor_Id'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'topicID': instance.topicID,
      'name': instance.name,
      'author': instance.author,
      'description': instance.description,
      'notes': instance.notes,
      'category': instance.category,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'confirmed': instance.confirmed,
      'public': instance.public,
      'n': instance.n,
      'p': instance.p,
      'editors': instance.editors,
      'editor_Id': instance.editorId,
      'deleted_at': instance.deletedAt,
    };
