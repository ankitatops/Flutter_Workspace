import 'package:flutter/material.dart';
import 'package:task37/counter_display.dart';
import 'counter_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider Counter App")),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CounterDisplay(),
            SizedBox(height: 20),
            CounterButtons(),
          ],
        ),
      ),
    );
  }
}
