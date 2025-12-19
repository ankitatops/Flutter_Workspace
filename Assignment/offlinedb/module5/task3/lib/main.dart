import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_screen.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod To-Do App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: TodoScreen(),debugShowCheckedModeBanner: false,
    );
  }
}
