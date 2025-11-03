import 'package:flutter/material.dart';
import 'package:task1/profile_screen.dart';
import 'package:task1/register_screen.dart';
import 'package:task1/schedule_screen.dart';
import 'package:task1/settings_screen.dart';
import 'announcements_screen.dart';
import 'home_screen.dart';
import 'lessons_screen.dart';
import 'login_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/register': (context) => const RegisterScreen(),
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(),
  '/lessons': (context) => const LessonsScreen(),
  '/announcements': (context) => const AnnouncementsScreen(),
  '/schedule': (context) => const ScheduleScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/settings': (context) => const SettingsScreen(),
};
