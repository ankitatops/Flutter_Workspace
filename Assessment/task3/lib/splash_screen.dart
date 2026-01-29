import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
     with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  DashboardScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [BookMateApp.primaryColor, BookMateApp.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu_book, size: 100, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  "BookMate",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Your personal library",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
