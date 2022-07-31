import 'package:flutter/material.dart';
import 'package:quansa_homework/domain/model/todo_item.dart';
import 'package:quansa_homework/pages/home/home_view.dart';
import 'package:quansa_homework/pages/todo_detail/todo_detail_view.dart';

class Routes {
  static const String homeRoute = '/';
  static const String todoDetailRoute = '/todoDetail';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.todoDetailRoute:
        return MaterialPageRoute(
          builder: (_) => TodoDetailView(
            todoItem: routeSettings.arguments! as TodoItem,
          ),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Ruta no encontrada'),
        ),
        body: const Center(
          child: Text('No fue posible encontrar la ruta espeficiada'),
        ),
      ),
    );
  }
}
