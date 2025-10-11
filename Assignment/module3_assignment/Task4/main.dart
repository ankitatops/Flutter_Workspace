import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FormEx(), debugShowCheckedModeBanner: false));
}

class FormEx extends StatefulWidget {
  const FormEx({super.key});

  @override
  State<FormEx> createState() => _FormExState();
}

class _FormExState extends State<FormEx> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _isshow = true;
  var _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Form")),
      body: Form(
        key: _formkey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Enter email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.00),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.00),
                    ),
                      suffixIcon: IconButton(
                          icon: Icon(
                            _isshow ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isshow = !_isshow;
                            });
                          }
                      )
                  ),
                  obscureText: _isshow,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Logged in Succesfully")),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SecondScreen()),
                    // );
                    //   String a = email.text.toString();
                    //   String b = pass.text.toString();
                    //
                    //   if(_formkey.currentState!.validate())
                    //   {
                    //     if(a=="98793859" && b=="1234")
                    //     {
                    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged in Succesfully")));
                    //       //Navigator.push(context,MaterialPageRoute(builder: (context) => SecondScreen()));
                    //     }
                    //     else
                    //     {
                    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
                    //
                    //     }
                    //
                    //  }
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
