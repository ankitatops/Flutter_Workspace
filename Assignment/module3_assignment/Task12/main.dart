import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: ToggleBackgroundApp(), debugShowCheckedModeBanner: false),
  );
}

class ToggleBackgroundApp extends StatefulWidget {
  @override
  _ToggleBackgroundAppState createState() => _ToggleBackgroundAppState();
}

class _ToggleBackgroundAppState extends State<ToggleBackgroundApp> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isSwitched ? Colors.blueGrey : Colors.white,
      appBar: AppBar(
        title: Text('Toggle Background'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dark Mode',
              style: TextStyle(
                fontSize: 20,
                color: _isSwitched ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(width: 12),
            Switch(
              value: _isSwitched,
              activeColor: Colors.teal,
              onChanged: (value) {
                setState(() {
                  _isSwitched = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
