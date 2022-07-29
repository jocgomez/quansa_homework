// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      title: json['title'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String,
      isDone: json['isDone'] as bool? ?? false,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'isDone': instance.isDone,
    };
