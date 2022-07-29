import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  final String title, description, photoUrl;
  final bool isDone;

  Todo({
    required this.title,
    required this.description,
    required this.photoUrl,
    this.isDone = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
