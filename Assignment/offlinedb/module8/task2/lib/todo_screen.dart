import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'task_model.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();
  final Box<Task> taskBox = Hive.box<Task>('tasksBox');

  void _addTask(String title) {
    final task = Task(title: title);
    taskBox.add(task);
  }

  void _updateTask(Task task, String newTitle) {
    task.title = newTitle;
    task.save();
  }

  void _toggleTask(Task task) {
    task.isDone = !task.isDone;
    task.save();
  }

  void _deleteTask(Task task) {
    task.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive To-Do List'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Input field
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
                      _addTask(_controller.text);
                      _controller.clear();
                      setState(() {});
                    }
                  },
                  child: Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          // Task list
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: taskBox.listenable(),
              builder: (context, Box<Task> box, _) {
                if (box.values.isEmpty) {
                  return Center(child: Text('No tasks yet!'));
                }

                return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (ctx, index) {
                    Task task = box.getAt(index)!;
                    return Card(
                      margin:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Checkbox(
                          value: task.isDone,
                          activeColor: Colors.teal,
                          onChanged: (_) {
                            _toggleTask(task);
                          },
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.orange),
                              onPressed: () {
                                _controller.text = task.title;
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Edit Task'),
                                    content: TextField(
                                      controller: _controller,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _updateTask(
                                              task, _controller.text);
                                          _controller.clear();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(task),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
