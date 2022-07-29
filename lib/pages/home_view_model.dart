import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:quansa_homework/data/services/storage_service.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/pages/home_effect.dart';
import 'package:quansa_homework/pages/home_status.dart';
import 'package:quansa_homework/view_model.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  final StorageService _storageService;

  HomeViewModel(this._storageService) {
    status = HomeStatus(todoItems: []);
  }

  Future<void> onInit() async {
    // TODO: Consultar localmente las tareas
    status = status.copyWith(todoItems: []);
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
    String? photoUrl;
    if (photo != null) {
      photoUrl = await _storageService.uploadFile(photo, todoItem.id);
      todoItem = todoItem.copyWith(photoUrl: photoUrl);
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
