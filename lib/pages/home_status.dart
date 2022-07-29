import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/view_model.dart';

class HomeStatus extends ViewStatus {
  final bool isImageUploading;
  final List<TodoItem> todoItems;

  HomeStatus({
    required this.isImageUploading,
    required this.todoItems,
  });

  HomeStatus copyWith({
    bool? isImageUploading,
    List<TodoItem>? todoItems,
  }) {
    return HomeStatus(
      isImageUploading: isImageUploading ?? this.isImageUploading,
      todoItems: todoItems ?? this.todoItems,
    );
  }
}
