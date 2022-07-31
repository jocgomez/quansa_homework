import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quansa_homework/data/services/local_storage_service.dart';
import 'package:quansa_homework/data/services/storage_service.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/pages/home/home_effect.dart';
import 'package:quansa_homework/pages/home/home_status.dart';
import 'package:quansa_homework/view_model.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  final StorageService _storageService;
  final LocalStorageService _localStorage;

  HomeViewModel(this._storageService, this._localStorage) {
    status = HomeStatus(todoItems: []);
  }

  Future<void> onInit() async {
    /// Get the todos from local storage then are converted to List<TodoItem>
    final String? todoItemsString =
        _localStorage.getPreferences()?.getString('todos');

    if (todoItemsString != null) {
      final List<dynamic> todoItemsMap = json.decode(todoItemsString);

      final List<TodoItem> todoItems =
          todoItemsMap.map((dynamic item) => TodoItem.fromJson(item)).toList();

      status = status.copyWith(todoItems: todoItems);
    }
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

    /// Upload file to cloud storage
    if (photo != null) {
      addEffect(ShowDialogLoading());
      photoUrl = await _storageService.uploadFile(photo, todoItem.id);
      addEffect(CloseDialog());
      todoItem = todoItem.copyWith(photoUrl: photoUrl);
    }

    final List<TodoItem> todoItems = [
      ...status.todoItems,
      todoItem,
    ];

    /// save todo in local storage, the list is now an string
    bool? saved = await _localStorage.getPreferences()?.setString(
          'todos',
          json.encode(todoItems.toList()),
        );

    if (saved ?? false) {
      status = status.copyWith(todoItems: todoItems);
    }
  }

  Future<void> removeTodo(String id) async {
    /// Remove file from cloud storage
    await _storageService.removeFile(
      status.todoItems.firstWhere((todo) => todo.id == id).photoUrl,
    );

    /// Remove todoItem from local Storage
    final List<TodoItem> todoItems =
        status.todoItems.where((item) => item.id != id).toList();

    bool? savedLocal = await _localStorage.getPreferences()?.setString(
          'todos',
          json.encode(todoItems.toList()),
        );

    /// Update local state
    if (savedLocal ?? false) {
      status = status.copyWith(
        todoItems: status.todoItems.where((item) => item.id != id).toList(),
      );
    }
  }
}
