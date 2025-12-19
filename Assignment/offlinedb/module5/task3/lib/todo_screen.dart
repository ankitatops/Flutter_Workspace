import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_notifier.dart';

class TodoScreen extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    final taskNotifier = ref.read(taskListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Input field and Add button
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      taskNotifier.addTask(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          // Task list
          Expanded(
            child: tasks.isEmpty
                ? Center(
              child: Text(
                'No tasks yet!',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
                : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return Card(
                  elevation: 3,
                  margin:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      activeColor: Colors.teal,
                      onChanged: (_) =>
                          taskNotifier.toggleTask(task.id),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: task.isDone
                            ? Colors.grey
                            : Colors.black87,
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          taskNotifier.removeTask(task.id),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
