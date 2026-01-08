import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login.dart';
import '../onboardingscreen/onboardingscreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/anim.json"),
      ),
    );
  }

  void checkConnection() async {
    var status = await Connectivity().checkConnectivity();

    if (status.contains(ConnectivityResult.wifi) ||
        status.contains(ConnectivityResult.mobile)) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = prefs.getBool('onboarding_seen') ?? false;

      Timer(const Duration(seconds: 3), () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
            seen ? const LoginScreen() : const OnboardingScreen(),
          ),
        );
      });

    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Internet Found")),
      );
    }
  }
}
