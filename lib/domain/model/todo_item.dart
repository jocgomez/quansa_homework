import 'package:json_annotation/json_annotation.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class TodoItem {
  final String id = DateTime.now().microsecondsSinceEpoch.toString();
  final String title, description, photoUrl;
  final bool isDone;

  TodoItem({
    required this.title,
    required this.description,
    required this.photoUrl,
    this.isDone = false,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
