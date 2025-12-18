import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ widgets/task_item.dart';
import '../database/database_helper.dart';
import '../models/task_model.dart';
import 'add_edit_task_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DatabaseHelper.instance;
  List<Task> tasks = [];
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadTheme();
  }

  Future<void> _loadTasks() async {
    tasks = await db.getTasks();
    setState(() {});
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('isDark') ?? false;
    setState(() {});
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', value);
  }

  Future<void> _deleteTask(int id) async {
    await db.deleteTask(id);
    _loadTasks();
  }

  Future<void> _toggleStatus(Task task) async {
    task.status = task.status == TaskStatus.pending
        ? TaskStatus.completed
        : TaskStatus.pending;
    await db.updateTask(task);
    _loadTasks();
  }

  Future<void> _editTask(Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(existingTask: task),
      ),
    );
    if (result == true) _loadTasks();
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          isDark: isDark,
          onThemeChange: (value) {
            setState(() => isDark = value);
            _saveTheme(value);
          },
        ),
      ),
    );
  }

  void _filterTasks(String value) {
    if (value == 'All') {
      _loadTasks();
    } else {
      setState(() {
        tasks = tasks.where((t) =>
        value == 'Pending'
            ? t.status == TaskStatus.pending
            : t.status == TaskStatus.completed).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark
          ? ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.purpleAccent,
        ),
      )
          : ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.tealAccent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("TaskMate"),
          centerTitle: true,
          elevation: 2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          actions: [
            IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
            IconButton(icon: const Icon(Icons.settings), onPressed: _goToSettings),
            PopupMenuButton<String>(
              onSelected: _filterTasks,
              itemBuilder: (_) => const [
                PopupMenuItem(value: "All", child: Text("All Tasks")),
                PopupMenuItem(value: "Pending", child: Text("Pending")),
                PopupMenuItem(value: "Completed", child: Text("Completed")),
              ],
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.grey.shade900, Colors.black]
                  : [Colors.teal.shade50, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: tasks.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu_book_outlined,
                      size: 80, color: Colors.grey.shade600),
                  const SizedBox(height: 16),
                  Text(
                    "No tasks yet!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tap the + button to add your first task.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: tasks.length,
            itemBuilder: (_, i) {
              final t = tasks[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TaskTile(
                    task: t,
                    onDelete: () => _deleteTask(t.id!),
                    onToggle: () => _toggleStatus(t),
                    onEdit: () => _editTask(t),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTaskScreen()),
            );
            if (result == true) _loadTasks();
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
