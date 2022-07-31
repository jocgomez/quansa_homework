import 'package:flutter/material.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';

class TodoDetailView extends StatelessWidget {
  final TodoItem todoItem;
  const TodoDetailView({Key? key, required this.todoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
      ),
      body: const Center(
        child: Text('Todo Detail'),
      ),
    );
  }
}
