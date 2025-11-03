import 'package:flutter/material.dart';
import 'avatar_badge.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text("EduTrack Home")),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(email ?? "Student"),
              accountEmail: Text(email ?? "student@edutrack.com"),
              currentAccountPicture: const AvatarBadge(
                imageUrl: "https://cdn-icons-png.freepik.com/512/2940/2940652.png",
                isOnline: true,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Lessons"),
              onTap: () => Navigator.pushNamed(context, '/lessons'),
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text("Announcements"),
              onTap: () => Navigator.pushNamed(context, '/announcements'),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text("Schedule"),
              onTap: () => Navigator.pushNamed(context, '/schedule'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Welcome, ${email ?? 'Student'} 👋",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
