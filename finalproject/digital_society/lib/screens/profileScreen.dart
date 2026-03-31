import 'package:flutter/material.dart';
import '../signup/chengePassword.dart';
import '../signup/login_screen.dart';
import 'edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feedback.dart';

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
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Edit Profile"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen()),
                  );
                },
              ),
            ),

            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text("Change Password"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => chengePassword()),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.feedback),
                title: Text("Send Feedback"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => feedback()),
                  );
                },
              ),
            ),

            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Logout",
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