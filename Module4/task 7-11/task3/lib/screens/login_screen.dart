import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  late SharedPreferences sharedPreferences;
  var newuser;
  @override
  void initState() {
   // super.initState();
    checkvalue();
  }
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
  checkvalue()async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    newuser = sharedPreferences.getBool("tops")??true;

    if(newuser==false)
    {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DashboardScreen()));

    }
  }
  //  Login Function
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;


    String email = emailController.text.trim();
    String password = passController.text.trim();

    List<String> registeredEmails = sharedPreferences.getStringList('emails') ?? [];

    if (!registeredEmails.contains(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No account found for this email.")),
      );
      return;
    }

    String? savedPass = sharedPreferences.getString(email);

    if (savedPass == password) {

      sharedPreferences.setBool("tops", false);
      sharedPreferences.setString("myemail",email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
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
                onPressed: _login,
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  );
                },
                child: const Text("No account? Signup here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
