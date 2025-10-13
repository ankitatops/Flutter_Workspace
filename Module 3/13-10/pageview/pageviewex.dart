import 'package:flutter/material.dart';
import 'package:pageviewex/pageviewbuild.dart';
import 'package:pageviewex/pageviewcustom.dart';
import 'package:pageviewex/pageviewtest1.dart';

import 'customized.dart';

class Pageviewex extends StatefulWidget {
  const Pageviewex({super.key});

  @override
  State<Pageviewex> createState() => _PageviewexState();
}

class _PageviewexState extends State<Pageviewex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView - Flutter'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageViewTest1()),
                    );
                  },
                  child: Text(
                    'PageView Example',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.amber[800],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageViewBuild()),
                    );
                  },
                  child: Text(
                    'PageView.builder Example',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange[900],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageViewCustom()),
                    );
                  },
                  child: Text(
                    'PageView.custom Example',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.purple,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomizedPageView(),
                      ),
                    );
                  },
                  child: Text(
                    ' Customized PageView',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
