import 'package:flutter/material.dart';
import 'db_helper.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List<Map<String, dynamic>> notesList = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    notesList = await DBHelper.instance.getNotes();
    setState(() {});
  }

  void showNoteDialog({Map<String, dynamic>? note}) {
    if (note != null) {
      titleController.text = note['title'];
      contentController.text = note['content'] ?? '';
    } else {
      titleController.clear();
      contentController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(note == null ? "Add Note" : "Edit Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: "Content"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (note == null) {
                await DBHelper.instance.insertNote({
                  "title": titleController.text,
                  "content": contentController.text,
                });
              } else {
                await DBHelper.instance.updateNote({
                  "id": note['id'],
                  "title": titleController.text,
                  "content": contentController.text,
                });
              }
              Navigator.pop(context);
              loadNotes();
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  Future<void> deleteNote(int id) async {
    await DBHelper.instance.deleteNote(id);
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes App")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNoteDialog(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (context, index) {
          final note = notesList[index];
          return Card(
            child: ListTile(
              title: Text(note['title']),
              subtitle: Text(note['content'] ?? ""),
              onTap: () => showNoteDialog(note: note),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteNote(note['id']),
              ),
            ),
          );
        },
      ),
    );
  }
}

