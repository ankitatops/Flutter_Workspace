import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';

class ShopScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': 1200},
    {'name': 'Smartphone', 'price': 800},
    {'name': 'Headphones', 'price': 150},
    {'name': 'Keyboard', 'price': 100},
    {'name': 'Mouse', 'price': 50},
    {'name': 'Monitor', 'price': 300},
    {'name': 'Smartwatch', 'price': 200},
    {'name': 'External Hard Drive', 'price': 120},
    {'name': 'USB Flash Drive', 'price': 20},
    {'name': 'Webcam', 'price': 80},
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tech Shop',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart, color: Colors.white),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.itemCount.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, index) {
            final product = products[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.shade100,
                  child: Text(
                    product['name'][0],
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  product['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                subtitle: Text(
                  "\$${product['price']}",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    cart.addItem(product['name']);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
