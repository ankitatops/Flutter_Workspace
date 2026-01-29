import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String id;
  String title;
  String author;
  String category;
  String description;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    this.isFavorite = false,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'author': author,
    'category': category,
    'description': description,
    'isFavorite': isFavorite,
  };
}
