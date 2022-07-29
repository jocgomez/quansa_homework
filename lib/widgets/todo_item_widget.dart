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
    return ListTile(
      leading: FadeInImage.assetNetwork(
        placeholder: AssetManager.loading,
        image: 'https://thumbs.dreamstime.com/b/todo-pegajoso-11106198.jpg',
      ),
      title: Text(
        todoItem.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
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
