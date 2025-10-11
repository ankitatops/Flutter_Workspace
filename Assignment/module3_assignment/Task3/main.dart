import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: MyTextStyleApp(), debugShowCheckedModeBanner: false),
  );
}

class MyTextStyleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextStyle Example'),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, Flutter!',
              style: TextStyle(
                fontSize: 32,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                backgroundColor: Colors.yellow[100],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Styling text is fun!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepOrange,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.yellow[100],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Let’s learn Flutter step by step!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.w600,
                //decoration: TextDecoration.underline,
                decorationColor: Colors.greenAccent,
                decorationThickness: 2,
                backgroundColor: Colors.yellow[100],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Flutter makes UI development easy !',
              style: TextStyle(
                fontSize: 22,
                color: Colors.purple,
                fontWeight: FontWeight.w700,
                wordSpacing: 5,
                backgroundColor: Colors.yellow[100],
                shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(2, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Beautiful apps, faster!',
              style: TextStyle(
                fontSize: 26,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                letterSpacing: 3,
                backgroundColor: Colors.yellow[100],
              ),
            ),
            SizedBox(height: 30),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'Beautiful Gradient Text 💜',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
