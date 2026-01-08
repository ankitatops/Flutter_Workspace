import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/user/login/login.dart';
import 'package:project1/user/signup/widgets/custom_clippers/brown_top_clipper.dart';
import 'package:project1/user/signup/widgets/custom_clippers/gold_top_clipper.dart';
import 'package:project1/user/signup/widgets/custom_clippers/lightgold_top_clipper.dart';
import 'package:project1/user/signup/widgets/header.dart';
import '../constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final TextEditingController mobileno = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kLightGold,
      body: Stack(
        children: [
          ClipPath(
            clipper: const GoldTopClipper(),
            child: Container(color: kGold),
          ),
          ClipPath(
            clipper: const BrownTopClipper(),
            child: Container(color: kBrown),
          ),
          ClipPath(
            clipper: const LightGoldTopClipper(),
            child: Container(color: kLightGold),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingL),
              child: Column(
                children: [
                  Header(),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kPaddingL),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: space * 6),

                          TextFormField(
                            controller: username,
                            decoration:
                            inputDecoration("Username", Icons.person),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username required";
                              }
                              if (value.length < 3) {
                                return "Minimum 3 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: space),

                          TextFormField(
                            controller: password,
                            obscureText: _isObscure,
                            decoration: inputDecoration(
                              "Password",
                              Icons.lock,
                              suffix: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password required";
                              }
                              if (value.length < 6) {
                                return "Minimum 6 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: space),

                          TextFormField(
                            controller: mobileno,
                            keyboardType: TextInputType.phone,
                            decoration:
                            inputDecoration("Mobile Number", Icons.phone),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Mobile number required";
                              }
                              if (value.length != 10) {
                                return "Enter 10 digit number";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: space),

                          TextFormField(
                            controller: confirmpassword,
                            obscureText: _isObscure,
                            decoration: inputDecoration(
                                "Confirm Password", Icons.lock),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm password required";
                              }
                              if (value != password.text) {
                                return "Password not matching";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: space + 5),

                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: kDarkBrown,
                                padding: const EdgeInsets.all(kPaddingS + 5),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  registeruser();
                                }
                              },
                              child: Text(
                                "Register to continue",
                                style: TextStyle(
                                    color: kGold,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> registeruser() async {
    var url = "https://prakrutitech.xyz/FlutterProject/signup.php";

    await http.post(Uri.parse(url), body: {
      "username": username.text,
      "password": password.text,
      "mobileno": mobileno.text,
      "identifier": "User"
    });

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }


  InputDecoration inputDecoration(String hint, IconData icon,
      {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      errorStyle: const TextStyle(color: Colors.red, fontSize: 13),
      border: const OutlineInputBorder(),
    );
  }
}
