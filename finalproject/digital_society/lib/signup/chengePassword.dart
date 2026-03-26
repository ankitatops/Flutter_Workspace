import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class chengePassword extends StatefulWidget {
  const chengePassword({super.key});

  @override
  State<chengePassword> createState() => _chengePasswordState();
}

class _chengePasswordState extends State<chengePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  int userId = 0;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  /// 🔹 Get User ID from SharedPreferences
  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bgimage.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🔹 Overlay
          Container(color: Colors.black.withOpacity(0.4)),

          /// 🔹 Content
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// 🔹 Title
                  Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.blue.shade100,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// 🔹 Glass Card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter:
                        ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.3)),
                          ),

                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [

                                /// 🔹 Old Password
                                buildPasswordField(
                                  controller: oldPassword,
                                  hint: "Old Password",
                                  obscure: _obscureOld,
                                  toggle: () {
                                    setState(() {
                                      _obscureOld = !_obscureOld;
                                    });
                                  },
                                ),

                                const SizedBox(height: 15),

                                /// 🔹 New Password
                                buildPasswordField(
                                  controller: newPassword,
                                  hint: "New Password",
                                  obscure: _obscureNew,
                                  toggle: () {
                                    setState(() {
                                      _obscureNew = !_obscureNew;
                                    });
                                  },
                                ),

                                const SizedBox(height: 15),

                                /// 🔹 Confirm Password
                                buildPasswordField(
                                  controller: confirmPassword,
                                  hint: "Confirm Password",
                                  obscure: _obscureConfirm,
                                  toggle: () {
                                    setState(() {
                                      _obscureConfirm =
                                      !_obscureConfirm;
                                    });
                                  },
                                  isConfirm: true,
                                ),

                                const SizedBox(height: 20),

                                /// 🔹 Button
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.indigo,
                                        Colors.deepPurple,
                                      ],
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(30),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!
                                          .validate()) {
                                        changePassword();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            30),
                                      ),
                                    ),
                                    child: const Text(
                                      "Update Password",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Password Field Widget
  Widget buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
    bool isConfirm = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter $hint";
        }
        if (hint == "New Password" && value.length < 6) {
          return "Min 6 characters";
        }
        if (isConfirm && value != newPassword.text) {
          return "Passwords do not match";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.lock, color: Colors.blue),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: toggle,
        ),
        filled: true,
        fillColor: Colors.blue.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// 🔹 API Call
  void changePassword() async {
    var response = await http.post(
      Uri.parse(
          "https://prakrutitech.xyz/ankita/change_password.php"),
      body: {
        "user_id": userId.toString(),
        "old_password": oldPassword.text,
        "new_password": newPassword.text,
      },
    );

    var data = json.decode(response.body);

    if (data["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"]),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"]),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}