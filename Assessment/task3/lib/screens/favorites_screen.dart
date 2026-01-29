import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'book_details.dart';
import '../main.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('books')
          .where('isFavorite', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        if (docs.isEmpty) {
          return Center(
            child: Text(
              "No favorites yet",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final book = docs[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Icon(Icons.book, color: BookMateApp.primaryColor),
                title: Text(
                  book['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(book['author']),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: null,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailScreen(doc: book),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
