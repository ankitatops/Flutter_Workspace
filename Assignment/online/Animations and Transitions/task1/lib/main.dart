import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FadeImage(),
    );
  }
}

class FadeImage extends StatelessWidget {
  const FadeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fade In Image")),
      body: Center(
        child: FadeInImage(
          image: NetworkImage('https://thumbs.dreamstime.com/b/programmer-developer-flat-style-illustration-white-background-isolated-character-ai-generated-335094652.jpg'),
          placeholder: NetworkImage(
            'https://assets.designtemplate.io/Website-Developer-Girl-Character-Illustration-700.webp',
          ),
          fadeInDuration: const Duration(milliseconds: 700),
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
