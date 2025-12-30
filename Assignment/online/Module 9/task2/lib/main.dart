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
      title: 'Hero Animation Demo',
      home: const FirstScreen(),
    );
  }
}

/// First Screen

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondScreen(),
              ),
            );
          },
          child: Hero(
            tag: 'hero-image',
            child: Image.network(
              'https://thumbs.dreamstime.com/b/cartoon-girl-exploring-her-computer-emphasizing-joys-learning-technology-cartoon-girl-computer-adventure-354455907.jpg',
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}

/// Second Screen

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Hero(
          tag: 'hero-image',
          child: Image.network(
            'https://img.freepik.com/premium-vector/cute-girl-working-computer-cartoon-vector-icon-illustration-people-technology-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-1444.jpg',
            width: 300,
          ),
        ),
      ),
    );
  }
}
