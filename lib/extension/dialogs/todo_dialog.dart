import 'package:flutter/material.dart';
import 'package:quansa_homework/extension/dialog_builder.dart';
import 'package:quansa_homework/pages/home_view_model.dart';

class TodoDialog extends DialogBuilder {
  final HomeViewModel viewModel;
  TodoDialog(this.viewModel);

  @override
  Widget buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear Tarea'),
      content: const TextField(
        decoration: InputDecoration(
          labelText: 'Titulo',
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Crear'),
          onPressed: () {
            Navigator.of(context).pop();
            viewModel.createTodo();
          },
        ),
      ],
    );
  }
}
