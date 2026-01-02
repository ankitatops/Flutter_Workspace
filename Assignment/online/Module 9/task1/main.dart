import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Implicit Animation Button',
      home: const AnimatedButtonExample(),
    );
  }
}

class AnimatedButtonExample extends StatefulWidget {
  const AnimatedButtonExample({super.key});

  @override
  State<AnimatedButtonExample> createState() => _AnimatedButtonExampleState();
}

class _AnimatedButtonExampleState extends State<AnimatedButtonExample> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animation Button'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isPressed = !_isPressed;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isPressed ? 220 : 150,
            height: _isPressed ? 65 : 50,
            decoration: BoxDecoration(
              color: _isPressed ? Colors.green : Colors.blue,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Press Me',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
