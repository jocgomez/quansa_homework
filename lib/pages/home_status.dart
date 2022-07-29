import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/view_model.dart';

class HomeStatus extends ViewStatus {
  final List<TodoItem> todoItems;

  HomeStatus({
    required this.todoItems,
  });

  HomeStatus copyWith({
    List<TodoItem>? todoItems,
  }) {
    return HomeStatus(
      todoItems: todoItems ?? this.todoItems,
    );
  }
}
