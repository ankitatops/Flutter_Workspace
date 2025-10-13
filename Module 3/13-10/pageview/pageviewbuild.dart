import 'package:flutter/material.dart';

class PageViewBuild extends StatefulWidget {
  const PageViewBuild({super.key});

  @override
  State<PageViewBuild> createState() => _PageViewBuildState();
}

class _PageViewBuildState extends State<PageViewBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pageview Builder")),
      body: PageView.builder(
        //itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            color: index % 2 == 0 ? Colors.green : Colors.blue[700],
          );
        },
      ),
    );
  }
}
