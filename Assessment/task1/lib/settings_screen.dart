import 'package:flutter/material.dart';
import 'main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    isDarkMode = themeNotifier.value == ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Enable or disable dark mode"),
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
                themeNotifier.value =
                isDarkMode ? ThemeMode.dark : ThemeMode.light;
              });
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "EduTrack Unique",
                applicationVersion: "1.0.0",
                applicationIcon: const Icon(Icons.school,
                    size: 50, color: Colors.deepPurple),
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "EduTrack is a cross-platform educational app "
                          "designed to help students access lessons, announcements, "
                          "and schedules in a clean and interactive way.",
                    ),
                  ),
                ],
              );
            },
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back),
            label: const Text("Go Back"),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
