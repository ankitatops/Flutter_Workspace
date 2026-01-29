import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';

class AddEditBookScreen extends StatefulWidget {
  final bool isEdit;
  final QueryDocumentSnapshot? doc;

  AddEditBookScreen({super.key, required this.isEdit, this.doc});

  @override
  State<AddEditBookScreen> createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final titleCtrl = TextEditingController();
  final authorCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  String category = "General";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.doc != null) {
      final data = widget.doc!.data() as Map<String, dynamic>;
      titleCtrl.text = data['title'] ?? "";
      authorCtrl.text = data['author'] ?? "";
      descCtrl.text = data['description'] ?? "";
      category = data['category'] ?? "General";
    }
  }

  Future<void> saveBook() async {
    if (titleCtrl.text.trim().isEmpty || authorCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Title and Author are required")),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please login first")));
      return;
    }

    setState(() => isLoading = true);

    final dataRef = widget.isEdit
        ? widget.doc!.reference
        : FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('books')
              .doc();

    final data = {
      'title': titleCtrl.text.trim(),
      'author': authorCtrl.text.trim(),
      'description': descCtrl.text.trim(),
      'category': category,
      'isFavorite': widget.isEdit
          ? (widget.doc!['isFavorite'] ?? false)
          : false,
      'createdAt': widget.isEdit
          ? widget.doc!['createdAt']
          : FieldValue.serverTimestamp(),
    };

    try {
      await dataRef.set(data);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Book saved successfully")));
      Navigator.pop(context);
    } catch (e) {
      print("Firestore error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to save book")));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BookMateApp.backgroundColor,
      appBar: AppBar(
        backgroundColor: BookMateApp.primaryColor,
        title: Text(widget.isEdit ? "Edit Book" : "Add Book"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: InputDecoration(
                      labelText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: authorCtrl,
                    decoration: InputDecoration(
                      labelText: "Author",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: category,
                    items: ["General", "Programming", "Science", "Fiction"]
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (val) => setState(() => category = val!),
                    decoration: InputDecoration(
                      labelText: "Category",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: descCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Description",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: saveBook,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        widget.isEdit ? "Update Book" : "Add Book",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
