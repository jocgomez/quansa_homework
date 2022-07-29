import 'package:flutter/material.dart';
import 'package:quansa_homework/data/get_it_locator.dart';
import 'package:quansa_homework/pages/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Locator.setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomeView(),
    );
  }
}
