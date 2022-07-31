import 'package:json_annotation/json_annotation.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class TodoItem {
  late String id;
  final String title, description, photoUrl;
  final bool isDone;

  TodoItem({
    required this.title,
    required this.description,
    required this.photoUrl,
    this.isDone = false,
  }) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);

  TodoItem copyWith({
    String? title,
    String? description,
    String? photoUrl,
    bool? isDone,
  }) {
    return TodoItem(
      title: title ?? this.title,
      description: description ?? this.description,
      photoUrl: photoUrl ?? this.photoUrl,
      isDone: isDone ?? this.isDone,
    );
  }
}
