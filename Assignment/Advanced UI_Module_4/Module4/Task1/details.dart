import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Image.network(
            product['image'],
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            product['name'],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Price: \$${product['price']}",
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back"),
          ),
        ],
      ),
    );
  }
}
