import 'package:flutter/material.dart';
import 'preferences_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Preferences App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: PreferencesScreen(),debugShowCheckedModeBanner: false,
    );
  }
}
