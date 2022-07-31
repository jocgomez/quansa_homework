import 'package:flutter/material.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/resources/asset_manager.dart';

class TodoDetailView extends StatelessWidget {
  final TodoItem todoItem;
  const TodoDetailView({
    Key? key,
    required this.todoItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Hero(
                tag: todoItem.id,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.fitHeight,
                    placeholder: AssetManager.loading,
                    image: todoItem.photoUrl,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              todoItem.isDone ? 'Realizada' : 'Pendiente',
              style: TextStyle(
                fontSize: 16,
                color: todoItem.isDone ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              todoItem.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              todoItem.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
