import 'package:flutter/material.dart';



class ProgressBar extends StatefulWidget {
  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  var progress = 0;

  @override
  initState() {
    super.initState();
    increaseProgress();
  }

  increaseProgress() async {
    while (progress < 100) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        progress++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Easy Progress Bar")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Progress: ${progress.toStringAsFixed(0)}%",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}