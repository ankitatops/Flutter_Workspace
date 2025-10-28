import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title:  Text("Home Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://cdn-icons-png.flaticon.com/512/1946/1946488.png",
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "🏠 Home Screen",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
