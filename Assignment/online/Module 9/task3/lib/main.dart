import 'dart:async';
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
      home: LoadingExample(),
    );
  }
}

class LoadingExample extends StatefulWidget {
  @override
  State<LoadingExample> createState() => _LoadingExampleState();
}

class _LoadingExampleState extends State<LoadingExample> {
  bool isLoading = true;
  String data = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate API call

    setState(() {
      isLoading = false;
      data = "✅ Data Loaded Successfully!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loading Animation")),
      body: Center(
        child: isLoading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading data..."),
          ],
        )
            : Text(
          data,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
