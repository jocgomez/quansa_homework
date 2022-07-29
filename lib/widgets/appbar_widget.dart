import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback onPressed;
  const AppbarWidget({Key? key, required this.onPressed}) : super(key: key);

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
          onPressed: onPressed,
        ),
      ],
    );
  }
}
