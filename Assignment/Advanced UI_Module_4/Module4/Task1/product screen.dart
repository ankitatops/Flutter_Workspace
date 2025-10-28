import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Laptop',
      'price': 50000,
      'image':
          'https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/13-laptop-platinum-right-render-fy25:VP4-1260x795?fmt=png-alpha',
    },
    {
      'id': 2,
      'name': 'Smartphone',
      'price': 70000,
      'image':
          'https://images.samsung.com/is/image/samsung/assets/in/explore/brand/latest-samsung-smartphones-launched-in-india/M55-5G-720x540_2.jpg?720_N_JPG',
    },
    {
      'id': 3,
      'name': 'Headphones',
      'price': 700,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmHcEKd3Nqr3Nm3_3hSezsH6Z4wtiriGK6TA&s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                product['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(product['name']),
              subtitle: Text('\$${product['price']}'),
              onTap: () {
                Navigator.pushNamed(context, '/details', arguments: product);
              },
            ),
          );
        },
      ),
    );
  }
}
