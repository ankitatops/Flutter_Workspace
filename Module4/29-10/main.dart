import 'package:flutter/material.dart';

import 'AddPage.dart';
import 'db.dart';

void main() {
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyDb db1 = MyDb();
  List<Map> slist = [];

  @override
  void initState() {
    db1.open();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite CRUD"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Addpage()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: slist.map((stuone) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(stuone["name"]),
                subtitle: Text(stuone["email"]),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      slist = await db1.db.rawQuery('SELECT * FROM students');
      setState(() {});
    });
  }
}
