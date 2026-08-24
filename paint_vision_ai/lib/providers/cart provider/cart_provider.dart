import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [
    {
      "name": "Asian Paints Royale",
      "price": 3250,
      "image": "assets/images/fryola.png",
      "quantity": 1,
    },
    {
      "name": "Berger Easy Clean",
      "price": 2950,
      "image": "assets/images/fryola.png",
      "quantity": 1,
    },
    {
      "name": "Dulux Velvet Touch",
      "price": 3200,
      "image": "assets/images/fryola.png",
      "quantity": 1,
    },
  ];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  int get subtotal {
    int total = 0;
    for (var item in _cartItems) {
      total += (item['price'] as int) * (item['quantity'] as int);
    }
    return total;
  }

  void increment(int index) {
    _cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decrement(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
      notifyListeners();
    }
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  int _parsePrice(dynamic price) {
    if (price is int) return price;

    if (price is String) {
      final cleanedPrice = price
          .replaceAll('Rs.', '')
          .replaceAll(',', '')
          .trim();
      return int.tryParse(cleanedPrice) ?? 0;
    }

    return 0;
  }

  void addItem(Map<String, dynamic> product) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item['name'] == product['name'],
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity']++;
    } else {
      _cartItems.add({
        "name": product["name"],
        "price": _parsePrice(product["price"]),
        "image": product["image"],
        "quantity": 1,
      });
    }

    notifyListeners();
  }

  void addMultipleItems(List<Map<String, dynamic>> products) {
    for (var product in products) {
      final existingIndex = _cartItems.indexWhere(
        (item) => item['name'] == product['name'],
      );

      if (existingIndex != -1) {
        _cartItems[existingIndex]['quantity']++;
      } else {
        _cartItems.add({
          "name": product["name"],
          "price": _parsePrice(product["price"]),
          "image": product["image"],
          "quantity": 1,
        });
      }
    }

    notifyListeners();
  }
}
