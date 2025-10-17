import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    title: 'Task Manager',
    home: TaskManagerHome(),
    debugShowCheckedModeBanner: false,));
}

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}


class TaskManagerHome extends StatefulWidget {
  @override
  _TaskManagerHomeState createState() => _TaskManagerHomeState();
}

class _TaskManagerHomeState extends State<TaskManagerHome> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  void _addTask(){
    String title = _taskController.text.trim();
    if (title.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: title));
        _taskController.clear();
      });
    }
  }
  void _toggleTaskCompletion(int index, bool? value) {
    setState(() {
      _tasks[index].isCompleted = value ?? false;
    });
  }
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Task Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter new task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? Center(child: Text('No tasks yet.'))
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return CheckboxListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    value: task.isCompleted,
                    onChanged: (value) =>
                        _toggleTaskCompletion(index, value),
                    secondary: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
