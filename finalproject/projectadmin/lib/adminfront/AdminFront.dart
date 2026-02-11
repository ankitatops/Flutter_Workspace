import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../admincategory/Home/home.dart';
import '../admincategory/upload/adminupload.dart';
import '../adminlogin/adminlogin.dart';

class Adminfront extends StatefulWidget
{
  @override
  State<Adminfront> createState() => _AdminfrontState();
}

class _AdminfrontState extends State<Adminfront>
{

  String mynum = "";
  late SharedPreferences sharedPreferences;
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>
  [
    Home(),
    Upload(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }
  @override
  void initState()
  {
    // TODO: implement initState
    //super.initState();
    checkdata();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar(
        title: Text("Welcome",style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        backgroundColor: kBrown,
        actions:
        [
          IconButton(onPressed: ()
          {
            sharedPreferences.setBool("ewishesadmin", true);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminLoginScreen()));

          }, icon: Icon(Icons.logout,color: Colors.white,))
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
              label: "Upload"
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

  void checkdata()async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(()
    {
      mynum = sharedPreferences.getString("uname")!;
    });

  }
}