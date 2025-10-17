import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings Screen")),
      body: Center(
        child: Text("Settings go here", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}