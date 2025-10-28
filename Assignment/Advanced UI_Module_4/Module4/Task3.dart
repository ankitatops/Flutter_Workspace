import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const BottomNavigationBar1(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
    ),
  );
}

class BottomNavigationBar1 extends StatefulWidget {
  const BottomNavigationBar1({super.key});

  @override
  State<BottomNavigationBar1> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar1> {
  int _selectedIndex = 0;

  final List<String> images = [
    'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTExL3YxMTgxLXR1LWVsZW1lbnQtMjUwLXAtbTN3cXR3dTEucG5n.png',
    'https://static.vecteezy.com/system/resources/previews/067/657/836/non_2x/simple-woman-avatar-icon-for-account-or-profile-use-free-vector.jpg',
    'https://cdn-icons-png.flaticon.com/256/4724/4724531.png',
  ];

  final List<String> titles = [
    'Home Screen',
    'Profile Screen',
    'Settings Screen',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ],
                image: DecorationImage(
                  image: NetworkImage(images[_selectedIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              titles[_selectedIndex],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
