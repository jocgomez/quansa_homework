import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quansa_homework/data/get_it_locator.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/extension/dialog_extension.dart';
import 'package:quansa_homework/extension/dialogs/delete_todo_dialog.dart';
import 'package:quansa_homework/extension/dialogs/loading_dialog.dart';
import 'package:quansa_homework/extension/dialogs/todo_dialog.dart';
import 'package:quansa_homework/pages/home/home_effect.dart';
import 'package:quansa_homework/pages/home/home_view_model.dart';
import 'package:quansa_homework/widgets/appbar_widget.dart';
import 'package:quansa_homework/widgets/todo_item_widget.dart';
import 'package:quansa_homework/data/services/storage_service.dart';
import 'package:quansa_homework/data/services/local_storage_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(
        locator<StorageService>(),
        locator<LocalStorageService>(),
      ),
      child: const HomeViewBody(),
    );
  }
}

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late StreamSubscription<HomeEffect> _effectSubscription;
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  @override
  void initState() {
    HomeViewModel viewModel = context.read<HomeViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.onInit();
    });

    /// Se escuchan los efectos añadidos desde el viewmodel, aqui se muestran
    /// los dialogs
    _effectSubscription = viewModel.effects.listen(
      (HomeEffect event) async {
        if (event is ShowDialogCreateTodo) {
          DialogExtension().build(
            context,
            TodoDialog(
              titleCtrl: titleCtrl,
              descriptionCtrl: descriptionCtrl,
              onTakePicture: viewModel.takePicture,
              onCreateTodo: viewModel.createTodo,
              validateEmptyForm: viewModel.validateEmptyForm,
            ),
          );
        } else if (event is ShowDialogDeleteTodo) {
          DialogExtension().build(
            context,
            DeleteTodoDialog(
              todoId: event.todoId,
              onDeleteTodo: viewModel.removeTodo,
            ),
          );
        } else if (event is ShowDialogLoading) {
          DialogExtension().build(
            context,
            LoadingDialog(),
          );
        } else if (event is CloseDialog) {
          DialogExtension().dispose(context);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _effectSubscription.cancel();
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppbarWidget(onPressed: viewModel.showDialogCreateTodo),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 15),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: viewModel.status.todoItems.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 15);
        },
        itemBuilder: (BuildContext context, int index) {
          TodoItem todo = viewModel.status.todoItems[index];
          return TodoItemWidget(
            todoItem: todo,
            onDelete: () => viewModel.showDialogDeleteTodo(todo.id),
          );
        },
      ),
    );
  }
}
