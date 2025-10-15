import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(home: Gridviewex(),debugShowCheckedModeBanner: false,));
}

class Gridviewex extends StatefulWidget {
  const Gridviewex({super.key});

  @override
  State<Gridviewex> createState() => _GridviewexState();
}

class _GridviewexState extends State<Gridviewex> {
  List tech = [
    "Flutter",
    "Java",
    "Php",
    "Android",
    "python",
    "c#",
    "asp.net",
    "c++",
  ];
  List techimg = [
    "https://img.icons8.com/color/512/flutter.png",
    "https://cdn3d.iconscout.com/3d/free/preview/free-java-3d-icon-png-download-7578017.png?f=webp&h=700",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUXbDN6MjKqhEQLKobn2Ffg4goxiTe6xptfw&s",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Android_robot.svg/1745px-Android_robot.svg.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX9KYoFpX9v-HF45IjK17OC4jhT19I55y0Fw&s",
    "https://img.icons8.com/color/512/c-sharp-logo-2.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0UgUXEP10vllUWq1_Bzhjnu_udl3tYMtnVg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3hbRO0rvcpye0A0FReULeQmbADXsitOIYMA&s",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: tech.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Center(
              child: Column(
                children: [
                  Image.network(techimg[index], width: 250, height: 150),
                  Text(tech[index]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
