import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Counter App'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Current Value',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '$counter',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: 'decrement',
                      backgroundColor: Colors.redAccent,
                      onPressed: decrement,
                      child: Icon(Icons.remove),
                    ),
                    SizedBox(width: 30),
                    FloatingActionButton(
                      heroTag: 'increment',
                      backgroundColor: Colors.green,
                      onPressed: increment,
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
