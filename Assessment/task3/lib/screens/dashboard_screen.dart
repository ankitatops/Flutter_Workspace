import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_edit_book_screen.dart';
import 'book_details.dart';
import 'favorites_screen.dart';
import 'login_screen.dart';
import '../main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Books"),
          backgroundColor: BookMateApp.primaryColor,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: BookMateApp.secondaryColor,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Favorites"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search by title",
                      prefixIcon: Icon(
                        Icons.search,
                        color: BookMateApp.accentColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchText = val.toLowerCase();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('books')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: CircularProgressIndicator());
                      final docs = snapshot.data!.docs.where((doc) {
                        final title = (doc['title'] ?? "")
                            .toString()
                            .toLowerCase();
                        return title.contains(searchText);
                      }).toList();
                      if (docs.isEmpty)
                        return Center(child: Text("No books found"));

                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final book = docs[index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            child: ListTile(
                              leading: Icon(
                                Icons.book,
                                size: 40,
                                color: BookMateApp.primaryColor,
                              ),
                              title: Text(
                                book['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(book['author']),
                              trailing: IconButton(
                                icon: Icon(
                                  book['isFavorite']
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  book.reference.update({
                                    'isFavorite': !book['isFavorite'],
                                  });
                                },
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
                  ),
                ),
              ],
            ),
            FavoritesScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: BookMateApp.primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddEditBookScreen(isEdit: false),
              ),
            );
          },
        ),
      ),
    );
  }
}
