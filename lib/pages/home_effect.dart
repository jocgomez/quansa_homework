import 'package:quansa_homework/view_model.dart';

abstract class HomeEffect extends Effect {}

class ShowDialogCreateTodo extends HomeEffect {
  ShowDialogCreateTodo();
}

class ShowDialogDeleteTodo extends HomeEffect {
  final String todoId;
  ShowDialogDeleteTodo(this.todoId);
}
