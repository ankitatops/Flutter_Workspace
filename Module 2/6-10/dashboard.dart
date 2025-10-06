import 'package:flutter/material.dart';
import 'package:sharedpre/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late SharedPreferences sharedPreferences;
  String myuser = "";

  @override
  void initState() {
    checkdata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome: $myuser"),
        actions: [
          IconButton(
            onPressed: () {
              sharedPreferences.setBool("tops", true);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginscreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  void checkdata() async
  {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      myuser = sharedPreferences.getString("uname")!;
    });
  }
}
