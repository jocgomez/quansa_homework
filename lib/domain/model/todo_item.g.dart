// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      title: json['title'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String,
      isDone: json['isDone'] as bool? ?? false,
    )..id = json['id'] as String;

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'isDone': instance.isDone,
    };
