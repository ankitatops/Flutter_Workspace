import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'task_model.dart';
import 'todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(Task());

  await Hive.openBox<Task>('tasksBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive To-Do App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: TodoScreen(),
    );
  }
}
