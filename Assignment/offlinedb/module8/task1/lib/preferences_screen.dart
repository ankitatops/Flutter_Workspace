import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isDarkMode = false;
  String _savedUsername = '';
  bool _savedDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load saved preferences
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedUsername = prefs.getString('username') ?? '';
      _savedDarkMode = prefs.getBool('darkMode') ?? false;
      _nameController.text = _savedUsername;
      _isDarkMode = _savedDarkMode;
    });
  }

  // Save preferences
  void _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _nameController.text);
    await prefs.setBool('darkMode', _isDarkMode);

    setState(() {
      _savedUsername = _nameController.text;
      _savedDarkMode = _isDarkMode;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Preferences saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Preferences'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Username input
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Dark mode toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _isDarkMode,
                  onChanged: (val) {
                    setState(() {
                      _isDarkMode = val;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            // Save button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
              onPressed: _savePreferences,
              child: Text('Save Preferences', style: TextStyle(fontSize: 16)),
            ),

            SizedBox(height: 40),

            // Display saved preferences
            Text(
              'Saved Preferences:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text('Username: $_savedUsername'),
            Text('Dark Mode: ${_savedDarkMode ? "Enabled" : "Disabled"}'),
          ],
        ),
      ),
    );
  }
}
