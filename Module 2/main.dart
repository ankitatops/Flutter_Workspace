import 'package:flutter/material.dart';

  void main()
  {
    runApp(MaterialApp(home:MyApp(),debugShowCheckedModeBanner: false,));
  }
  class MyApp extends StatelessWidget
  {
  @override
  Widget build(BuildContext context)
  {
  return Scaffold
  (
  appBar: AppBar(title: Text("My First App"),backgroundColor: Colors.grey,),
  body: Center
  (
  child: Column
  (
  children:
  [
  SizedBox(height: 50,),

    Text("c",style: TextStyle(fontSize: 20.00,color: Colors.blueGrey),),
    SizedBox(height: 15,),
    Text("c++",style: TextStyle(fontSize: 20.00,color: Colors.grey),),
    SizedBox(height: 15,),
    Text("Java",style: TextStyle(fontSize: 20.00,color: Colors.blueGrey),),
    SizedBox(height: 15,),
    Text("c#",style: TextStyle(fontSize: 20.00,color: Colors.grey),),
    SizedBox(height: 15,), 
    Text("ASP.NET",style: TextStyle(fontSize: 20.00,color: Colors.blueGrey),),
    SizedBox(height: 15,), 
    Text("Wordpress",style: TextStyle(fontSize: 20.00,color: Colors.grey),),
    SizedBox(height: 15,),
    Text("Android",style: TextStyle(fontSize: 20.00,color: Colors.blueGrey),),
    SizedBox(height: 15,),
    Text("Networking",style: TextStyle(fontSize: 20.00,color: Colors.grey),),
  ],
  )

  ),


  );
  }

  }
  
