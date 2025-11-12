import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_product_screen.dart';
import 'view_product_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late SharedPreferences sharedPreferences;
  String myuser = "";

  @override
  void initState() {
    checkdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(onPressed:

          ()
          {
            sharedPreferences.setBool("tops", true);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
            }

              , icon: const Icon(Icons.logout))
        ],
      ),
      body: const ViewProductScreen(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
          setState(() {});
        },
      ),
    );
  }

  checkdata()async
  {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(()
    {

      myuser = sharedPreferences.getString("myemail")!;

    });

  }
}

