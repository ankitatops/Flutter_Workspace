import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schedule = [
      {"day": "Monday", "subject": "Mathematics"},
      {"day": "Tuesday", "subject": "Science"},
      {"day": "Wednesday", "subject": "English"},
      {"day": "Thursday", "subject": "History"},
      {"day": "Friday", "subject": "Physics Lab"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Schedule")),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final item = schedule[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.schedule),
              title: Text("${item['day']}"),
              subtitle: Text("${item['subject']}"),
            ),
          );
        },
      ),
    );
  }
}
