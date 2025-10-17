import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Drawer Demo',
    home: HomeWithDrawer(),
    debugShowCheckedModeBanner: false,));
}

class HomeWithDrawer extends StatefulWidget {
  @override
  _HomeWithDrawerState createState() => _HomeWithDrawerState();
}

class _HomeWithDrawerState extends State<HomeWithDrawer> {

  int _selectedIndex = 0;

  final List<String> _titles = ['Home', 'Profile', 'Settings'];

  final List<Widget> _screens = [
    Center(child: Text('Welcome to Home Screen!', style: TextStyle(fontSize: 24))),
    Center(child: Text('This is your Profile.', style: TextStyle(fontSize: 24))),
    Center(child: Text('Settings go here.', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Navigation Drawer',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () => _onItemTap(0),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTap(1),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTap(2),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}
