import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? existingTask;
  const AddTaskScreen({super.key, this.existingTask});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final dateCtrl = TextEditingController();

  final db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();

    if (widget.existingTask != null) {
      final t = widget.existingTask!;
      titleCtrl.text = t.title;
      descCtrl.text = t.description;
      dateCtrl.text = t.dueDate.toString().split(" ").first;
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.existingTask?.dueDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );

    if (pickedDate != null) {
      dateCtrl.text = pickedDate.toString().split(" ").first;
    }
  }

  Future<void> _saveTask() async {
    if (titleCtrl.text.isEmpty || dateCtrl.text.isEmpty) {
      _showMessage('Title and Due Date cannot be empty');
      return;
    }

    DateTime? date;
    try {
      date = DateTime.parse(dateCtrl.text);
    } catch (e) {
      _showMessage('Invalid date format (use YYYY-MM-DD)');
      return;
    }

    final newTask = Task(
      id: widget.existingTask?.id,
      title: titleCtrl.text,
      description: descCtrl.text,
      dueDate: date,
      status: widget.existingTask?.status ?? TaskStatus.pending,
    );

    if (widget.existingTask == null) {
      await db.insertTask(newTask);
    } else {
      await db.updateTask(newTask);
    }

    Navigator.pop(context, true);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingTask != null;

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text(isEdit ? "Edit Task" : "Add New Task"),
        elevation: 2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Icon(
              isEdit ? Icons.edit_note : Icons.playlist_add,
              size: 80,
              color: Colors.teal.shade700,
            ),
            const SizedBox(height: 12),
            Text(
              isEdit ? "Update your task" : "Create a new task",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                labelText: "Task Title",
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: descCtrl,
              decoration: InputDecoration(
                labelText: "Description (optional)",
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: dateCtrl,
              readOnly: true,
              onTap: _pickDate,
              decoration: InputDecoration(
                labelText: "Due Date",
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: _pickDate,
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveTask,
                icon: const Icon(Icons.save),
                label: Text(
                  isEdit ? "Update Task" : "Save Task",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
