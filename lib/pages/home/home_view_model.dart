import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quansa_homework/data/services/local_storage_service.dart';
import 'package:quansa_homework/data/services/storage_service.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/pages/home/home_effect.dart';
import 'package:quansa_homework/pages/home/home_status.dart';
import 'package:quansa_homework/resources/routes_manager.dart';
import 'package:quansa_homework/view_model.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  final StorageService _storageService;
  final LocalStorageService _localStorage;

  HomeViewModel(this._storageService, this._localStorage) {
    status = HomeStatus(todoItems: []);
  }

  Future<void> onInit() async {
    /// Se cargan las tareas desde LocalStorage y si hay las almacena
    final String? todoItemsString = _localStorage.getString('todos');

    if (todoItemsString != null) {
      final List<dynamic> todoItemsMap = json.decode(todoItemsString);

      final List<TodoItem> todoItems =
          todoItemsMap.map((dynamic item) => TodoItem.fromJson(item)).toList();

      status = status.copyWith(todoItems: todoItems);
    }
  }

  void clearTodos() {
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
      debugPrint('Error al tomar la foto: $e');
    }
    return null;
  }

  Future<void> createTodo(
    BuildContext context,
    TodoItem todoItem,
    File? photo,
  ) async {
    String? photoUrl;

    /// Subimos la imágen capturada a la nube
    if (photo != null) {
      addEffect(ShowDialogLoading());
      photoUrl = await _storageService.uploadFile(photo, todoItem.id);
      addEffect(CloseDialog());
      todoItem = todoItem.copyWith(photoUrl: photoUrl);
    }

    final List<TodoItem> todoItems = List.of(status.todoItems);
    todoItems.add(todoItem);

    /// Guardamos la tarea en localstorage como un string
    bool? saved = await _localStorage.setString(
      'todos',
      json.encode(todoItems.toList()),
    );

    if (saved) {
      status = status.copyWith(todoItems: todoItems);
    }
  }

  Future<void> removeTodo(String id) async {
    /// Se elimina de la nube la imagen asociada a la tarea
    await _storageService.removeFile(
      status.todoItems.firstWhere((todo) => todo.id == id).photoUrl,
    );

    /// Se elimina del localstorage la tarea
    final List<TodoItem> todoItems =
        status.todoItems.where((item) => item.id != id).toList();

    bool? savedLocal = await _localStorage.setString(
      'todos',
      json.encode(todoItems.toList()),
    );

    /// Se actualiza el estado de la app
    if (savedLocal) {
      status = status.copyWith(
        todoItems: status.todoItems.where((item) => item.id != id).toList(),
      );
    }
  }

  void goToDetail(BuildContext context, TodoItem todoItem) {
    Navigator.pushNamed(
      context,
      Routes.todoDetailRoute,
      arguments: todoItem,
    );
  }
}
