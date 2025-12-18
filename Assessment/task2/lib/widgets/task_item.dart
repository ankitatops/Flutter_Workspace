import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = task.status == TaskStatus.completed
        ? Colors.green.shade300
        : Colors.orange.shade300;

    return Card(
      color: statusColor,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == TaskStatus.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("Due: ${task.dueDate.toString().split(" ").first}"),

        leading: IconButton(
          icon: Icon(
            task.status == TaskStatus.completed
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
          ),
          onPressed: onToggle,
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
