import 'package:flutter/material.dart';
import 'package:task4/screen1.dart';
import 'package:task4/screen2.dart';
import 'package:task4/screen3.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Navigation Drawer',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Tops Technologies'),
              accountEmail: const Text('tops@gmail.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                ),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img.freepik.com/free-vector/abstract-purple-fluid-background_23-2148972248.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _drawerItem(
              context,
              Icons.home,
              "Home",
              const ScreenOne(),
              Colors.pink,
            ),
            _drawerItem(
              context,
              Icons.person,
              "Profile",
              const ScreenTwo(),
              Colors.teal,
            ),
            _drawerItem(
              context,
              Icons.settings,
              "Settings",
              const ScreenThree(),
              Colors.cyan,
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Drawer App!",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
