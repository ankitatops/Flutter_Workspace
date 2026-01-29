import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final VoidCallback onTap;

  BookCard({required this.doc, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(Icons.book, size: 50),
        title: Text(doc['title']),
        subtitle: Text("${doc['author']} - ${doc['category']}"),
        trailing: IconButton(
          icon: Icon(
            doc['isFavorite'] ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            doc.reference.update({'isFavorite': !doc['isFavorite']});
          },
        ),
        onTap: onTap,
      ),
    );
  }
}
