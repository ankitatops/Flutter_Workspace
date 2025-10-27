import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stack Overlay Example'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
              Image.network(
              'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
                Container(
                  width: 300,
                  height: 200,
                  color: Colors.black.withOpacity(0.5),
                ),

                Text(
                  'Beautiful Nature',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ),
    );
  }
}
