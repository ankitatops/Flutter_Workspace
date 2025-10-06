import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpre/dashboard.dart';

void main() {
  runApp(MaterialApp(home: loginscreen(),debugShowCheckedModeBanner: false));
}

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscrenState();
}

class _loginscrenState extends State<loginscreen>
{
  late SharedPreferences Sharespreferences;
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  var newuser;

  @override
  void initState()
  {
    checkvalue();

  }

  Widget build(BuildContext context) {
    return Scaffold
      (
        appBar: AppBar(title: Text("login screen"),),
        body: Center(
          child: Column(
            children: [
              TextField(controller: uname,
                decoration: InputDecoration(hintText: "Enter Username"),),
              SizedBox(height: 10,),
              TextField(
                controller: pass,
                decoration: InputDecoration(hintText: "Enter Password"),
                obscureText: true,),
              SizedBox(height: 10,),
              ElevatedButton( onPressed: ()
              {
                String u = uname.text.toString();
                String p = pass.text.toString();

                Sharespreferences.setBool("Tops", false);
                Sharespreferences.setString("uname", u);
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => dashboard()));
              }, child: Text("login"),)
            ],
          ),
        )
    );
  }

  void checkvalue()async
  {
    Sharespreferences = await SharedPreferences.getInstance();
    newuser = Sharespreferences.getBool("tops")??true;

    if(newuser==false)
    {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => dashboard()));

    }
  }
}


