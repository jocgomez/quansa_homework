import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/pages/home/home_view_model.dart';

import 'services/test_local_storage_service.dart';
import 'services/test_storage_service.dart';

void main() async {
  final HomeViewModel viewModel = HomeViewModel(
    TestStorageService(),
    TestLocalStorageService(),
  );
  group('HomeViewModel', () {
    test('onInit, Read localStorage empty', () async {
      viewModel.onInit();
      expect(viewModel.status.todoItems, []);
    });

    testWidgets('create Todo Without Photo', (WidgetTester tester) async {
      /// Get the context
      await tester.pumpWidget(MaterialApp(home: Material(child: Container())));
      final BuildContext context = tester.element(find.byType(Container));

      final TodoItem mockItem = TodoItem(
        title: 'test',
        description: 'description test',
        photoUrl:
            'https://firebasestorage.googleapis.com/v0/b/quansa-homework.appspot.com/o/todosImages%2FOvMZBs9.jpeg?alt=media&token=08e91e36-77da-455c-bd1e-de1d6a8fb1ab',
      );

      await viewModel.createTodo(
        context,
        mockItem,
        File(''),
      );

      expect(viewModel.status.todoItems.contains(mockItem), true);
    });

    /* test('Read localStorage Todo', () async {
      TestLocalStorageService testLocalStorageService =
          await TestLocalStorageService.getInstance();

      final HomeViewModel viewModel = HomeViewModel(
        TestStorageService(),
        testLocalStorageService,
      );

      viewModel.onInit();
      expect(viewModel.status.todoItems, []);
    }); */
  });
}
