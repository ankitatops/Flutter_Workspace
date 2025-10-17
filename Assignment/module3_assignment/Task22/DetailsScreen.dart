import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Details Screen")),
    body: Center(
      child: Text("Details go here", style: TextStyle(fontSize: 20)),
    ),
  );
}
}