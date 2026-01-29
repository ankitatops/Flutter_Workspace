import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_edit_book_screen.dart';
import '../main.dart';

class BookDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const BookDetailScreen({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    final data = doc.data() as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: BookMateApp.backgroundColor,
      appBar: AppBar(
        backgroundColor: BookMateApp.primaryColor,
        title: Text(data['title']),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditBookScreen(isEdit: true, doc: doc),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final ok = await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text("Delete Book"),
                  content: Text("Are you sure you want to delete this book?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BookMateApp.primaryColor,
                      ),
                      child: Text("Delete"),
                    ),
                  ],
                ),
              );

              if (ok == true) {
                await doc.reference.delete();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title: ${data['title']}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: BookMateApp.accentColor,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Author: ${data['author']}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 12),
                Text(
                  "Category: ${data['category']}",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 12),
                Text(
                  "Description:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(data['description'] ?? "No description"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
