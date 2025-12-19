import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // Optional: total quantity
    int totalItems = cart.items.values.fold(0, (sum, qty) => sum + qty);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () => cart.clearCart(),
          ),
        ],
      ),
      body: cart.items.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty!',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: cart.items.entries.map((entry) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        entry.key,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      subtitle: Text(
                        'Quantity: ${entry.value}',
                        style: TextStyle(color: Colors.black54),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => cart.removeItem(entry.key),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Total items bar at bottom
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            color: Colors.teal.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Items:',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$totalItems',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Checkout', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Checkout not implemented!')),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
