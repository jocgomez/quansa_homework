import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/pages/home_effect.dart';
import 'package:quansa_homework/pages/home_status.dart';
import 'package:quansa_homework/services/firebase_storage_service.dart';
import 'package:quansa_homework/view_model.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  final StorageService _storageService;

  HomeViewModel(this._storageService) {
    status = HomeStatus(
      isImageUploading: false,
      todoItems: [
        TodoItem(
          title: 'Todo 1',
          description: 'Todo 1 description',
          photoUrl:
              'https://thumbs.dreamstime.com/b/todo-pegajoso-11106198.jpg',
        ),
        TodoItem(
          title: 'Todo 2',
          description: 'Todo 2 description',
          photoUrl: 'https://i.imgur.com/OvMZBs9.jpeg',
          isDone: true,
        ),
        TodoItem(
          title: 'Todo 3',
          description: 'Todo 3 description',
          photoUrl: 'https://todogroup.org/img/og.png',
        ),
        TodoItem(
          title: 'Todo 4',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          photoUrl:
              'https://thumbs.dreamstime.com/b/todo-pegajoso-11106198.jpg',
          isDone: true,
        ),
        TodoItem(
          title: 'Todo 5',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          photoUrl:
              'https://thumbs.dreamstime.com/b/todo-pegajoso-11106198.jpg',
        )
      ],
    );
  }

  /// Validación para textfields vacios
  String? validateEmptyForm(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo es obligatorio';
    }
    return null;
  }

  /// Efectos para poder abrir el dialog desde el view
  void showDialogCreateTodo() {
    addEffect(ShowDialogCreateTodo());
  }

  void showDialogDeleteTodo(String todoId) {
    addEffect(ShowDialogDeleteTodo(todoId));
  }

  /// Se hace uso de la libreria ImagePicker para tomar una foto con la cámara
  Future<XFile?> takePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      return image;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> createTodo(TodoItem todoItem, File? photo) async {
    status = status.copyWith(isImageUploading: true);
    if (photo != null) {
      await _storageService.uploadFile(photo, todoItem.id);
    }

    status = status.copyWith(
      todoItems: [
        ...status.todoItems,
        todoItem,
      ],
    );
  }

  void removeTodo(String id) {
    status = status.copyWith(
      todoItems: status.todoItems.where((item) => item.id != id).toList(),
    );
  }
}
