import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;
  bool isPasswordVisible = false;

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void signup() async {
    final email = emailCtrl.text.trim();
    final password = passCtrl.text.trim();

    if (email.isEmpty) {
      showError("Please enter email");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      showError("Please enter valid email");
      return;
    }

    if (password.isEmpty) {
      showError("Please enter password");
      return;
    }

    if (password.length < 6) {
      showError("Password must be at least 6 characters");
      return;
    }

    setState(() => loading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Signup failed";

      if (e.code == "email-already-in-use") {
        message = "Email already registered";
      } else if (e.code == "weak-password") {
        message = "Password is too weak";
      }

      showError(message);
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: EdgeInsets.all(24),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  size: 80,
                  color: BookMateApp.primaryColor,
                ),
                SizedBox(height: 12),
                Text(
                  "Create Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: passCtrl,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: loading ? null : signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BookMateApp.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: loading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Sign Up", style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
