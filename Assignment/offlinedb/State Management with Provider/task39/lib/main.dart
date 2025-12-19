import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeNotifier = ThemeNotifier();
  await themeNotifier.loadThemePreference();

  runApp(
    ChangeNotifierProvider(
      create: (context) => themeNotifier,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'Theme Switcher',
      theme: themeNotifier.currentTheme,
      home: HomeScreen(),debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Switcher'),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text('Dark Mode'),
          value: themeNotifier.isDarkMode,
          onChanged: (value) {
            themeNotifier.toggleTheme();
          },
        ),
      ),
    );
  }
}
