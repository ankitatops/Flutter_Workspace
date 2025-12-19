import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_list.dart';

class ShopPage extends StatelessWidget {
   ShopPage({super.key});

  final List<CartItem> products = [
    CartItem("laptop", 50000),
    CartItem("iphone", 100000),
    CartItem("samsung", 30000),
    CartItem("tablet", 20000),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Total: \$${cart.totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("\$${item.price}"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      cart.addItem(item);
                    },
                    child: const Text("Add"),
                  ),
                );
              },
            ),
          ),

          const Divider(),

          // Cart List
          const Expanded(
            child: CartList(),
          ),
        ],
      ),
    );
  }
}
