import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("profile screen"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Center(
              child: Row(
                children:
                [
                  CircleAvatar
                    (

                    radius: 80,
                    backgroundImage: NetworkImage(
                        "https://www.shutterstock.com/image-photo/world-best-exotic-fruit-platter-260nw-2490229919.jpg"), // Add your image
                  ),
                  SizedBox(height: 16, width: 16,),
                  Column
                    (
                    children:
                    [
                      Text('Ankita Gondaliya', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Flutter Developer',
                          style: TextStyle(color: Colors.grey)),


                    ],



                  ),
                  Column(
                    children: [
                  Text("Likes : "),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
              ]
                  )




                ],
              ),
            )


        )
    );
  }
}
