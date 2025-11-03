import 'package:flutter/material.dart';
import 'lesson_card.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> lessons = [
      {
        "title": "Mathematics",
        "image": "https://cdn-icons-png.flaticon.com/512/2906/2906547.png",
        "desc": "Learn numbers, equations, and problem solving.",
        "color": Colors.deepPurpleAccent
      },
      {
        "title": "Science",
        "image": "https://cdn-icons-png.flaticon.com/512/2821/2821637.png",
        "desc": "Explore physics, chemistry, and biology.",
        "color": Colors.teal
      },
      {
        "title": "English",
        "image": "https://cdn-icons-png.flaticon.com/512/167/167707.png",
        "desc": "Improve reading, writing, and speaking skills.",
        "color": Colors.orangeAccent
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Your Lessons")),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return LessonCard(
            title: lesson["title"] as String,
            description: lesson["desc"] as String,
            imageUrl: lesson["image"] as String,
            color: lesson["color"] as Color,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Opening ${lesson['title']}")),
              );
            },
          );
        },
      ),
    );
  }
}
