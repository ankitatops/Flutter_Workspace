import 'dart:io';

// Product class
class Product
{
  String name;
  double price;

  Product(this.name, this.price);
}

// Cart class
class Cart
{
  List<Product> products = [];

  void addProduct(Product product)
  {
    products.add(product);
  }

  double calculateTotal()
  {
    double total = 0;
    for (var p in products)
    {
      total += p.price;
    }
    print("\nTotal Price: \$${total.toStringAsFixed(2)}");
    return total;
  }
}

// Order class
class Order
{
  Cart cart;

  Order(this.cart);

  void checkout()
  {
    print("\n--- Order Summary ---");
    if (cart.products.isEmpty)
    {
      print("Your cart is empty.");
    } else
    {
      for (var p in cart.products)
      {
        print("- ${p.name} - \$${p.price.toStringAsFixed(2)}");
      }
      cart.calculateTotal();
    }
    print("✅ Thank you for shopping!");
  }
}

void main() {
  Cart myCart = Cart();

  int choice = 0;

  while (choice != 5) {
    print("\n--- Shopping Cart Menu ---");
    print("1. Add Apple (\$100)");
    print("2. Add Banana (\$50)");
    print("3. Add Pen (\$50)");
    print("4. Add Book (\$75)");
    print("5. Checkout");

    stdout.write("Enter your choice: ");
    choice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    switch (choice) {
      case 1:
        myCart.addProduct(Product("Apple", 100));
        print("Apple added to cart.");
        break;
      case 2:
        myCart.addProduct(Product("Banana", 50));
        print("Banana added to cart.");
        break;
      case 3:
        myCart.addProduct(Product("Pen", 50));
        print("Pen added to cart.");
        break;
      case 4:
        myCart.addProduct(Product("Book", 75));
        print("Book added to cart.");
        break;
      case 5:
        Order myOrder = Order(myCart);
        myOrder.checkout();
        break;
      default:
        print("Invalid choice.");
    }
  }
}