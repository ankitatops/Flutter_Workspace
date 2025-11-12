import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'edit_product_screen.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({super.key});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  final dbHelper = DbHelper.instance;
  List<Map<String, dynamic>> products = [];
  String query = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  ///  Load all products from the database
  Future<void> _load() async {
    setState(() => isLoading = true);
    final data = await dbHelper.queryAll();
    print("Fetched products: $data"); // For debugging
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  /// Delete a product by ID
  Future<void> _delete(int id) async {
    await dbHelper.delete(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product deleted successfully!")),
    );
    _load();
  }

  /// Edit product and refresh list on return
  Future<void> _edit(Map<String, dynamic> product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditProductScreen(product: product)),
    );
    if (result == true) {
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter list based on search query
    final filtered = query.isEmpty
        ? products
        : products
        .where((p) => p['company']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("View Products")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _load,
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search by company",
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => query = v),
              ),
            ),

            // Product List
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text("No products found"))
                  : ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final item = filtered[i];
                  Uint8List? img;

                  // Decode Base64 image (if exists)
                  if (item['image'] != null &&
                      item['image'].toString().isNotEmpty) {
                    try {
                      img = base64Decode(item['image']);
                    } catch (e) {
                      print("Image decode error: $e");
                    }
                  }

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 5),
                    child: ListTile(
                      leading: img != null
                          ? CircleAvatar(
                        backgroundImage: MemoryImage(img),
                        radius: 25,
                      )
                          : const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.image_not_supported),
                      ),
                      title: Text(
                        item['company'] ?? 'Unknown',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${item['model']} | ₹${item['finalPrice']} (Disc ${item['discount']}%)",
                        style: const TextStyle(fontSize: 13),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.blueAccent),
                            onPressed: () => _edit(item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () => _delete(item['_id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
