import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  bool isOnline = false;

  void toggleStatus() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 80;

    final String imageUrl = isOnline
        ? "https://cdn-icons-png.flaticon.com/512/1458/1458533.png"
        : "https://static.thenounproject.com/png/2330410-200.png";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Online / Offline",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isOnline ? Colors.green : Colors.red,
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              isOnline ? "Online" : "Offline",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isOnline ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: toggleStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: isOnline ? Colors.red : Colors.green,
              ),
              child: Text(
                isOnline ? "Go Offline" : "Go Online",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
