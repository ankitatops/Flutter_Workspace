import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(home: task1(), debugShowCheckedModeBanner: false));
}

class task1 extends StatefulWidget
{
  const task1({super.key});

  @override
  State<task1> createState() => _FormExState();
}

class _FormExState extends State<task1>
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Hello World")),
      body: Form(

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text( "Hello, Flutter!",style: TextStyle(fontSize: 20.00,color: Colors.grey),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}