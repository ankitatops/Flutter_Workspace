import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scale = 1.0;

  void _pulseButton() {
    setState(() => _scale = 1.3);
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _scale = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pulsing Button App')),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: _scale),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: ElevatedButton(
            onPressed: _pulseButton,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Click Me', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
