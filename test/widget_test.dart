import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/pages/home/home_view_model.dart';

import 'services/test_local_storage_service.dart';
import 'services/test_storage_service.dart';

void main() async {
  ///TODO: Evaluar el uso de la libreria ImagePicker para tomar una foto con la cámara
  ///TODO: Evaluar subida y eliminada de files en FirebaseStorage

  /// Se establece la tarea de ejemplo
  final TodoItem mockItem = TodoItem(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    title: 'test',
    description: 'description test',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/quansa-homework.appspot.com/o/todosImages%2FOvMZBs9.jpeg?alt=media&token=08e91e36-77da-455c-bd1e-de1d6a8fb1ab',
  );

  group('HomeViewModel', () {
    /// Se crea una tarea y se evalua si está en el estado y en LocalStorage
    testWidgets('Created todo should be in state and localStorage',
        (WidgetTester tester) async {
      final HomeViewModel viewModel = HomeViewModel(
        TestStorageService(),
        TestLocalStorageService(),
      );

      /// Se obtiene el contexto a partir del WidgetTester, se obtiene porque el createTodo() despliega un dialog
      await tester.pumpWidget(MaterialApp(home: Material(child: Container())));
      final BuildContext context = tester.element(find.byType(Container));

      await viewModel.createTodo(
        context,
        mockItem,
        File(''),
      );

      /// Se valida que la tarea este en el estado
      int index = viewModel.status.todoItems
          .indexWhere((TodoItem item) => item.id == mockItem.id);
      expect(viewModel.status.todoItems.isNotEmpty && index != -1, true);

      /// Se valida que la tarea se guarde en LocalStorage
      viewModel.clearTodos();
      expect(viewModel.status.todoItems.isEmpty, true);
      viewModel.onInit();
      index = viewModel.status.todoItems
          .indexWhere((TodoItem item) => item.id == mockItem.id);
      expect(index != -1, true);
    });

    testWidgets('Deleted todo should not be in state neither localStorage',
        (WidgetTester tester) async {
      final HomeViewModel viewModel = HomeViewModel(
        TestStorageService(),
        TestLocalStorageService(),
      );

      /// Se obtiene el contexto a partir del WidgetTester, se obtiene porque el createTodo() despliega un dialog
      await tester.pumpWidget(MaterialApp(home: Material(child: Container())));
      final BuildContext context = tester.element(find.byType(Container));
      int indexTodo;

      await viewModel.createTodo(
        context,
        mockItem,
        File(''),
      );

      /// Se elimina la tarea de localstorage y cloudStorage
      await viewModel.removeTodo(mockItem.id);

      /// Se valida que la tarea no se encuentre en el estado
      indexTodo = viewModel.status.todoItems
          .indexWhere((TodoItem item) => item.id == mockItem.id);
      expect(indexTodo == -1, true);

      /// Se valida que la tarea se no se encuentre en LocalStorage
      viewModel.clearTodos();
      expect(viewModel.status.todoItems.isEmpty, true);
      viewModel.onInit();
      indexTodo = viewModel.status.todoItems
          .indexWhere((TodoItem item) => item.id == mockItem.id);
      expect(indexTodo == -1, true);
    });
  });
}
