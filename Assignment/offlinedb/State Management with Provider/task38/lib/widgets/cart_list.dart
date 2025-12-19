import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final item = cart.items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text("\$${item.price}"),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () {
                  cart.removeItem(item);
                },
              ),
            );
          },
        );
      },
    );
  }
}
