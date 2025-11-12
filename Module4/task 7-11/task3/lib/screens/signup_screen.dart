import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
   // _checkLoginStatus();
  }

  // Auto redirect if already logged in
  // Future<void> _checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   if (isLoggedIn) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const DashboardScreen()),
  //     );
  //   }
  // }

  // Signup Function
  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> registeredEmails = prefs.getStringList('emails') ?? [];

    if (registeredEmails.contains(emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This email is already registered!")),
      );
      return;
    }

    registeredEmails.add(emailController.text.trim());


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Signup Successful! Please Login.")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (val) =>
                val!.isEmpty ? "Please enter email" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (val) =>
                val!.isEmpty ? "Please enter password" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: const Text("Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
