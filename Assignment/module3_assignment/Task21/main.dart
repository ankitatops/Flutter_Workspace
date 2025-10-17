import 'package:flutter/material.dart';
import 'package:task21/secondscreen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Two Screen App',
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Second Screen'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
        ),
      ),
    );
  }
}

