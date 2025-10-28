import 'package:flutter/material.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title:  Text("Settings Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://cdn-icons-png.flaticon.com/512/3524/3524659.png",
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "⚙️ Settings Screen",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
          ],
        ),
      ),
    );
  }
}
