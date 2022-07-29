import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/pages/home_effect.dart';
import 'package:quansa_homework/pages/home_status.dart';
import 'package:quansa_homework/view_model.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  HomeViewModel() {
    status = HomeStatus(
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

  void onClickAddTodo() {
    addEffect(ShowDialogCreateTodo());
  }

  void createTodo() {
    print('test create todo');
  }
}
