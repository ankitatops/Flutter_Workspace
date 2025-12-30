import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpandCollapseExample(),
    );
  }
}

class ExpandCollapseExample extends StatefulWidget {
  const ExpandCollapseExample({super.key});

  @override
  State<ExpandCollapseExample> createState() => _ExpandCollapseExampleState();
}

class _ExpandCollapseExampleState extends State<ExpandCollapseExample> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expand & Collapse"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(isExpanded ? "Collapse" : "Expand"),
            ),

            const SizedBox(height: 20),

            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: isExpanded ? 150 : 0,
              width: 300,
              color: Colors.blue,
              alignment: Alignment.center,
              child: isExpanded
                  ? const Text(
                "Hello Friends",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
