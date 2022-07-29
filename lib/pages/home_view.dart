import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quansa_homework/pages/home_view_model.dart';
import 'package:quansa_homework/widgets/appbar_widget.dart';
import 'package:quansa_homework/widgets/todo_item_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
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
  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: const AppbarWidget(),
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
          return TodoItemWidget(
            todoItem: viewModel.status.todoItems[index],
            onDelete: () {},
          );
        },
      ),
    );
  }
}
