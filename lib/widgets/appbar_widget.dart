import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppbarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Lista de tareas'),
      actions: [
        IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.add),
          onPressed: () {
            // TODO: Create dialog to create todo item.
          },
        ),
      ],
    );
  }
}
