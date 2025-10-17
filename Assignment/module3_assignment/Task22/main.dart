import 'package:flutter/material.dart';
import 'DetailsScreen.dart';
import 'Settings Screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Three Screen App',
      initialRoute: homeRoute,
      debugShowCheckedModeBanner: false,

      routes: {
        homeRoute: (context) => HomeScreen(),
        detailsRoute: (context) => DetailsScreen(),
        settingsRoute: (context) => SettingsScreen(),
      },
    ),
  );
}


const String homeRoute = '/';
const String detailsRoute = '/details';
const String settingsRoute = '/settings';

class HomeScreen extends StatelessWidget {
  final String messageToSend = "Hello from Home Screen!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Go to Details"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  detailsRoute,
                  arguments: messageToSend,
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Go to Settings"),
              onPressed: () {
                Navigator.pushNamed(context, settingsRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}



