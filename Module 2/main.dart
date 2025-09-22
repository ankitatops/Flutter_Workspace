import 'package:flutter/material.dart';



void main() {
  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
  //runApp(MyApp());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.network(
                "https://www.shutterstock.com/image-photo/world-best-exotic-fruit-platter-260nw-2490229919.jpg",
                width: 200,
                height: 200,
              ),
              Text("Likes : "),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Image.network(
                "https://www.shutterstock.com/image-photo/world-best-exotic-fruit-platter-260nw-2490229919.jpg",
                width: 200,
                height: 200,
              ),
              Text("Likes : "),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Image.network(
                "https://www.shutterstock.com/image-photo/world-best-exotic-fruit-platter-260nw-2490229919.jpg",
                width: 200,
                height: 200,
              ),
              Text("Likes : "),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Image.network(
                "https://www.shutterstock.com/image-photo/world-best-exotic-fruit-platter-260nw-2490229919.jpg",
                width: 200,
                height: 200,
              ),
              Text("Likes : "),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Image.network(
                "https://www.shutterstock.com/image-photo/world-best-exotic-fruit-platter-260nw-2490229919.jpg",
                width: 200,
                height: 200,
              ),
              Text("Likes : "),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("clicked");
                },
                child: Text("Submit"),
              ),
              SizedBox(height: 20),


              Container
                (
                child: Padding
                  (
                  padding: EdgeInsets.all(16.00),
                  child: Text("Tops Technologies",style: TextStyle(fontSize: 20.00),),

                ),

              ),
              Container
                (
                color: Colors.blue.shade50,
                padding: EdgeInsets.all(16.0),
                child: Row
                  (
                  children:
                  [
                    CircleAvatar
                      (
                      radius: 80,
                      backgroundImage: NetworkImage("https://www.shutterstock.com/image-photo/world-best-exotic-fruit-platter-260nw-2490229919.jpg"), // Add your image
                    ),
                    SizedBox(height: 16,width: 16,),
                    Column
                      (
                      children:
                      [
                        Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Flutter Developer', style: TextStyle(color: Colors.grey)),

                      ],
                    )

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}