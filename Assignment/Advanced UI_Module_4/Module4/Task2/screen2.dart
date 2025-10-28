import 'package:flutter/material.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:  Text("Profile Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              "👤 Profile Screen",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
