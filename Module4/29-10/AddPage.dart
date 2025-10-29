import 'package:flutter/material.dart';
import 'db.dart';
import 'main.dart';

class Addpage extends StatefulWidget {
  const Addpage({super.key});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  MyDb db1 = MyDb();

  @override
  void initState() {
    db1.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Data")),
      body: Padding(
        padding: EdgeInsets.all(16.00),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(hintText: "Enter Name"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(hintText: "Enter Email"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter email";
                    }
                    // basic email pattern
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Enter Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String n = name.text.toString();
                      String e = email.text.toString();
                      String p = pass.text.toString();

                      db1.db.rawInsert(
                        "insert into students (name,email,password) values (?,?,?)",
                        [n, e, p],
                      );
                      print("Inserted");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    }
                  },
                  child: Text("Insert"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
