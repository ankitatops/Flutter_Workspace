import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final List<String> hobbies;

  const SecondPage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.hobbies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Info")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("First Name: $firstName"),
            Text("Last Name: $lastName"),
            Text("Email: $email"),
            Text("Gender: $gender"),
            Text("Hobbies: ${hobbies.join(', ')}"),
          ],
        ),
      ),
    );
  }
}
