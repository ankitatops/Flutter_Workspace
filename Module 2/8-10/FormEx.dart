import 'package:flutter/material.dart';
import 'package:task/second.dart';

class FormEx extends StatefulWidget {
  const FormEx({super.key});

  @override
  State<FormEx> createState() => _FormExState();
}

enum Gender { male, female }

class _FormExState extends State<FormEx> {
  Gender _gender = Gender.female;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  bool cricket = false;
  bool reading = false;
  bool music = false;

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
                controller: fname,
                decoration: InputDecoration(
                  hintText: "Enter firstname ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.00),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter  firstname";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lname,
                decoration: InputDecoration(
                  hintText: "Enter lastname",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.00),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter lastname";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
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
              Column(
                children: [
                  const Text(
                    "Select Gender:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [

                      Expanded(
                        child: RadioListTile<Gender>(
                          title: const Text('Male'),
                          value: Gender.male,
                          groupValue: _gender,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<Gender>(
                          title: const Text('Female'),
                          value: Gender.female,
                          groupValue: _gender,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(


                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Hobbies:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text("Cricket"),
                    value: cricket,
                    onChanged: (value) {
                      setState(() {
                        cricket = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Reading"),
                    value: reading,
                    onChanged: (value) {
                      setState(() {
                        reading = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Music"),
                    value: music,
                    onChanged: (value) {
                      setState(() {
                        music = value!;
                      });
                    },
                  ),
                ],
              )
              const SizedBox(height: 20),

          // Submit Button
          ElevatedButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                // Gather hobbies
                List<String> hobbies = [];
                if (cricket) hobbies.add("Cricket");
                if (reading) hobbies.add("Reading");
                if (music) hobbies.add("Music");

                // Navigate to Second page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SecondPage(
                          firstName: fname.text,
                          lastName: lname.text,
                          email: email.text,
                          gender: _gender.name,
                          hobbies: hobbies,
                        ),
                  ),
                );
              }
            },
            child: const Text("Submit"),
          ),

        ),
      ),
    ),)
    ,
    );
  }
}



