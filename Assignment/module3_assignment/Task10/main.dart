import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: ShoppingCartApp(), debugShowCheckedModeBanner: false),
  );
}

class ShoppingCartApp extends StatefulWidget {
  @override
  _ShoppingCartAppState createState() => _ShoppingCartAppState();
}

class _ShoppingCartAppState extends State<ShoppingCartApp> {
  final List<String> items = [
    "Apple",
    "Banana",
    "Orange",
    "Grapes",
    "Mango",
    "Pineapple",
    "Strawberry",
    "Watermelon",
  ];

  List<String> cartItems = [];

  void _addToCart(String item) {
    setState(() {
      cartItems.add(item);
    });
  }

  void _removeFromCart(String item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: cartItems.isEmpty
              ? Center(child: Text("Your cart is empty."))
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    String item = cartItems[index];
                    return ListTile(
                      leading: Icon(Icons.shopping_bag),
                      title: Text(item),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeFromCart(item),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: _showCart),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${cartItems.length}',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          String currentItem = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(currentItem),
              trailing: ElevatedButton(
                onPressed: () => _addToCart(currentItem),
                child: Text('Add to Cart'),
              ),
            ),
          );
        },
      ),
    );
  }
}
