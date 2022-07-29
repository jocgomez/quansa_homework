import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quansa_homework/extension/dialog_builder.dart';

class DeleteTodoDialog extends DialogBuilder {
  final String todoId;
  final Function(String) onDeleteTodo;

  DeleteTodoDialog({
    required this.todoId,
    required this.onDeleteTodo,
  });

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  XFile? photo;

  @override
  Widget buildAlertDialog(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Eliminar Tarea'),
        content: const Text(
          '¿Esta seguro que desea eliminar la tarea?',
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Eliminar'),
            onPressed: () {
              Navigator.of(context).pop();
              onDeleteTodo(todoId);
            },
          ),
        ],
      );
    });
  }
}
