import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BookMateApp());
}

class BookMateApp extends StatelessWidget {
  const BookMateApp({super.key});

  static const Color primaryColor = Color(0xFFFF6F61);
  static const Color secondaryColor = Color(0xFFFFD662);
  static const Color accentColor = Color(0xFF4A4E69);
  static const Color backgroundColor = Color(0xFFFFF7EE);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BookMate",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
