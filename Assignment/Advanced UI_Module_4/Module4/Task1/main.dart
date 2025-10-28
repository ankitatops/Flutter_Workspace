import 'package:flutter/material.dart';
import 'package:task3/product%20screen.dart';
import 'details.dart';
import 'home screen.dart';

void main() {
  runApp(MaterialApp(
      title: 'Multi-Screen App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/products': (context) => ProductListScreen(),
        '/details': (context) => ProductDetailsScreen()}));
}
