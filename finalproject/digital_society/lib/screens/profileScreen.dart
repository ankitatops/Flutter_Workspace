import 'package:flutter/material.dart';
import '../signup/chengePassword.dart';
import '../signup/login_screen.dart';
import 'edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => userLoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Edit Profile"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.lock),
                title: const Text("Change Password"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const chengePassword()),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout",
                    style: TextStyle(color: Colors.red)),
                onTap: () => logout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}