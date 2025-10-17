import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: asset(), debugShowCheckedModeBanner: false));
}

class asset extends StatelessWidget {
  const asset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Asset Image")),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/panda.jpg',
              width: 100,
              height: 150,
              fit: BoxFit.cover,

            ),
            Image.asset(
              'assets/panda.jpg',
              width: 150,
              height: 150,
              fit: BoxFit.cover,

            ),
            Image.asset(
              'assets/panda.jpg',
              width: 200,
              height: 150,
              fit: BoxFit.cover,

            )

          ],
        ),
      ),
    );
  }
}