import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Product Listing',
      home: ProductListingScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product({required this.name, required this.imageUrl, required this.price});
}

class ProductListingScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Smartphone",
      imageUrl:
          "https://hips.hearstapps.com/hmg-prod/images/2-67cef69cd806e.jpg?crop=0.498xw:1.00xh;0.226xw,0&resize=640:*",
      price: 699.99,
    ),
    Product(
      name: "Headphones",
      imageUrl:
          "https://media.tatacroma.com/Croma%20Assets/Communication/Headphones%20and%20Earphones/Images/239033_0_aq6dfy.png",
      price: 199.99,
    ),
    Product(
      name: "Shoes",
      imageUrl:
          "https://m.media-amazon.com/images/I/5113UxbMY9L._UY1000_.jpg",
      price: 89.99,
    ),
    Product(
      name: "Watch",
      imageUrl:
          "https://m.media-amazon.com/images/I/81gfzrOzSJL._UF1000,1000_QL80_.jpg",
      price: 149.99,
    ),
    Product(
      name: "Backpack",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0UsQBZiPj3Z0C_LLgQ-q2_5TthDTGS8oWMg&s",
      price: 79.99,
    ),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Listing')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: 160,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(
                          product.imageUrl,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
