import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/extension/dialog_builder.dart';
import 'package:quansa_homework/resources/asset_manager.dart';

class TodoDialog extends DialogBuilder {
  final TextEditingController titleCtrl;
  final TextEditingController descriptionCtrl;
  final Future<XFile?> Function() onTakePicture;
  final Future<void> Function(TodoItem, File?) onCreateTodo;
  final String? Function(String?) validateEmptyForm;

  TodoDialog({
    required this.titleCtrl,
    required this.descriptionCtrl,
    required this.onTakePicture,
    required this.onCreateTodo,
    required this.validateEmptyForm,
  });

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  XFile? photo;
  bool isDone = false;

  @override
  Widget buildAlertDialog(BuildContext context) {
    /// StatefulBuilder para poder tener un estado dentro del dialog
    /// y asi actualizar la imagen tomada y el switch de isDone
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Crear Tarea'),
        content: SingleChildScrollView(
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (photo != null)
                  Image.file(
                    File(photo!.path),
                    height: 150,
                    width: 150,
                  ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    photo = null;
                    onTakePicture().then((value) {
                      setState(() {
                        photo = value;
                      });
                    });
                  },
                  child: const Text('Tomar foto'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Titulo',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 50,
                  validator: validateEmptyForm,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 5,
                  maxLength: 200,
                  validator: validateEmptyForm,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('¿Está realizada?'),
                    Switch(
                      value: isDone,
                      onChanged: (value) {
                        setState(() {
                          isDone = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
              titleCtrl.clear();
              descriptionCtrl.clear();
            },
          ),
          TextButton(
            child: const Text('Crear'),
            onPressed: () {
              if (keyForm.currentState?.validate() ?? false) {
                Navigator.of(context).pop();
                onCreateTodo(
                  TodoItem(
                    title: titleCtrl.text,
                    description: descriptionCtrl.text,
                    photoUrl: photo?.path ?? AssetManager.todoDefault,
                    isDone: isDone,
                  ),
                  photo != null ? File(photo!.path) : null,
                );
                titleCtrl.clear();
                descriptionCtrl.clear();
              }
            },
          ),
        ],
      );
    });
  }
}
