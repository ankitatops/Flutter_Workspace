import 'package:flutter/material.dart';
import 'package:floatbutton/splashscreen.dart';
void main() {
  runApp(MaterialApp(home: FloatEx(), debugShowCheckedModeBanner: false));
}

class FloatEx extends StatefulWidget {
  const FloatEx({super.key});

  @override
  State<FloatEx> createState() => _FloatExState();
}

class _FloatExState extends State<FloatEx> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Floating Action Button")),
      body: Center(
        child: ListView(
          children: [
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
            SizedBox(height: 25),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Splashscreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

