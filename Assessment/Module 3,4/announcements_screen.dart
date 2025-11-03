import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = [
      "Exam schedule released.",
      "New lesson on Flutter added.",
      "Parent-teacher meeting on Friday.",
      "Submit assignments by Sunday."
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Announcements")),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.announcement),
              title: Text(announcements[index]),
            ),
          );
        },
      ),
    );
  }
}
