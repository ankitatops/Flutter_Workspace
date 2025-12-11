
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:socialmedialogin/paymentex.dart';

void main()
{
  runApp(MaterialApp(home:MyApp()));
}

class MyApp extends StatefulWidget
{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar(title: Text("Login With Gmail"),actions:
      [
        IconButton(onPressed: ()async
        {
          await  _googleSignIn.signOut();
        }, icon: Icon(Icons.logout))
      ],),
      body: Center
        (
        child: Column
          (
          children:
          [
            ElevatedButton(onPressed: ()
            {

              _handlesignin(context);

            }, child: Text("Login With Gmail"))

          ],
        ),
      ),
    );
  }

  void _handlesignin(BuildContext context)async
  {
    GoogleSignInAccount? googleaccount = await _googleSignIn.signIn();
    try
    {
      if (googleaccount != null)
      {
        final GoogleSignInAuthentication googleAuth = await googleaccount.authentication;
        final accessToken = googleAuth.accessToken;
        final idToken = googleAuth.idToken;
        if(accessToken!=null)
        {
          print("Name is :" + googleaccount.displayName.toString());
          print("Email is :" + googleaccount.email.toString());
          print("photo is :" + googleaccount.photoUrl.toString());
        }
      }
    }
    catch(e)
    {
      print(e);
    }
  }
}
