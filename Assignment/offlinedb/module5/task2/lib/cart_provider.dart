import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final Map<String, int> _items = {};

  Map<String, int> get items => _items;

  void addItem(String product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
    notifyListeners();
  }

  void removeItem(String product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! - 1;
      if (_items[product]! <= 0) {
        _items.remove(product);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get itemCount => _items.values.fold(0, (sum, qty) => sum + qty);
}
