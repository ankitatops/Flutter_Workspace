import 'package:flutter/material.dart';
import 'package:project1/user/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/download.dart';
import '../Screens/home.dart';
import '../constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String mynum = "";
  late SharedPreferences sharedPreferences;
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>
  [
    Home(),
    Download(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    checkdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar(
        title: Text("Welcome $mynum", style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        backgroundColor: kBrown,
        actions:
        [
          IconButton(onPressed: () {
            sharedPreferences.setBool("tops", true);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }, icon: Icon(Icons.logout, color: Colors.white,))
        ],
      ),
      body: Center
        (
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: kLightGold,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
            //title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.download),
              label: "Download"
            //title: Text('Download'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kGold,
        backgroundColor: kDarkBrown,
        unselectedItemColor: kTerracotta,
        onTap: _onItemTapped,
      ),
    );
  }

  void checkdata() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      mynum = sharedPreferences.getString("mymob")!;
    });
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
      print(_selectedIndex);
    });
  }
}
