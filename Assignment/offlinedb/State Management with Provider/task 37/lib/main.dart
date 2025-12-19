import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task37/home_screen.dart';

class CounterProvider extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    counter--;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
