import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task_model.dart';

final taskListProvider =
StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List decoded = jsonDecode(tasksString);
      state = decoded.map((e) => Task.fromMap(e)).toList();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
    jsonEncode(state.map((task) => task.toMap()).toList());
    await prefs.setString('tasks', encoded);
  }

  void addTask(String title) {
    final task = Task(id: DateTime.now().toString(), title: title);
    state = [...state, task];
    saveTasks();
  }

  void toggleTask(String id) {
    state = state
        .map((task) => task.id == id
        ? Task(id: task.id, title: task.title, isDone: !task.isDone)
        : task)
        .toList();
    saveTasks();
  }

  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
    saveTasks();
  }
}
