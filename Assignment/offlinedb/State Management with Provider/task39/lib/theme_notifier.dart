import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemePreference(_isDarkMode);
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> _saveThemePreference(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDark);
  }
}
