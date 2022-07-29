import 'package:flutter/material.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/resources/asset_manager.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem todoItem;
  final VoidCallback onDelete;

  const TodoItemWidget({
    Key? key,
    required this.todoItem,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ListTile(
      leading: SizedBox(
        width: size.width / 5,
        child: FadeInImage.assetNetwork(
          fit: BoxFit.fitHeight,
          placeholder: AssetManager.loading,
          image: todoItem.photoUrl,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            todoItem.isDone ? 'Realizada' : 'Pendiente',
            style: TextStyle(
              fontSize: 12,
              color: todoItem.isDone ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            todoItem.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Text(
        todoItem.description,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        splashRadius: 20,
        onPressed: onDelete,
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
