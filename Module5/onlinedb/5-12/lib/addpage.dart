import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class AddPage extends StatefulWidget
{
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage>
{
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  late String myname,myemail,mypass;
  CollectionReference addUser = FirebaseFirestore.instance.collection('Students');
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar(title: Text("Add Data"),),
      body: Center
        (
        child: Column
          (
          children:
          [
            TextFormField(controller:name,decoration: InputDecoration(hintText: "Enter Name"),),
            SizedBox(height: 10,),
            TextFormField(controller:email,decoration: InputDecoration(hintText: "Enter Email")),
            SizedBox(height: 10,),
            TextFormField(controller:pass,decoration: InputDecoration(hintText: "Enter Password")),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()
            {
              myname = name.text.toString();
              myemail = email.text.toString();
              mypass = pass.text.toString();

              registeruser();

            }, child: Text("Add"))
          ],
        ),
      ),
    );
  }

  Future<void> registeruser()async
  {
    try
    {
      await addUser.add({'Name': myname, 'Email': myemail, 'Password': mypass});
      if (!mounted) return; // <-- Check if widget is still mounted

      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
    catch(e)
    {
      print(e);
    }

  }
}