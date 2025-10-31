import 'package:flutter/material.dart';


class SimpleProgressBar extends StatefulWidget {
  const SimpleProgressBar({super.key});

  @override
  State<SimpleProgressBar> createState() => _SimpleProgressBarState();
}

class _SimpleProgressBarState extends State<SimpleProgressBar> {
  double progress = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Progress Bar")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 3 * progress,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${progress.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            Slider(
              value: progress,
              min: 0,
              max: 100,
              divisions: 100,
              label: "${progress.toStringAsFixed(0)}%",
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  progress = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
