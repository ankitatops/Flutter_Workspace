import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: NameListScreen(), debugShowCheckedModeBanner: false),
  );
}

class NameListScreen extends StatelessWidget {
  final List<String> names = [
    'John',
    'meera',
    'Liam',
    'krishna',
    'Sophia',
    'Mason',
    'panda',
    'Ethan',
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Names'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person, color: Colors.teal),
            title: Text(
              names[index],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              print("${names[index]} tapped");
            },
          );
        },
      ),
    );
  }
}
