import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Row Layout'),
        backgroundColor: Colors.cyan,
      ),
      body: const ResponsiveRow(),
    );
  }
}

class ResponsiveRow extends StatelessWidget {
  const ResponsiveRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.redAccent,
          child: const Center(
            child: Text('Fixed', style: TextStyle(color: Colors.white)),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 100,
            color: Colors.green,
            child: const Center(
              child: Text('Expanded 2x', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 100,
            color: Colors.blue,
            child: const Center(
              child: Text('Expanded 1x', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
