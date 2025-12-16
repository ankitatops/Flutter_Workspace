import 'package:blocprovider/pages/StreamDataTab.dart';
import 'package:blocprovider/pages/triggerLogicTab.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          child: TabBarView(children: [StramDataTab(), TriggerLogicTab()]),
        ),
        bottomNavigationBar: Container(
          child: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Stream \nJust Data.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),

              Tab(
                child: Text(
                  'Trigger \nLogic/Function.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            indicatorColor: Colors.orange,
          ),
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
