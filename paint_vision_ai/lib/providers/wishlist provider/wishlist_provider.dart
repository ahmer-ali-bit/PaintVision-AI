import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _paints = [
    {
      "name": "Asian Paints Royale",
      "type": "Premium Emulsion",
      "price": "Rs. 3,250",
      "image": "assets/images/fryola.png",
      "isFavorite": true,
    },
    {
      "name": "Berger Easy Clean",
      "type": "Luxary Emulsion",
      "price": "Rs. 2,950",
      "image": "assets/images/fryola.png",
      "isFavorite": true,
    },
    {
      "name": "Dulux Velvot Touch",
      "type": "Premium Emulsion",
      "price": "Rs. 3,200",
      "image": "assets/images/fryola.png",
      "isFavorite": true,
    },
    {
      "name": "Nippon Momento",
      "type": "Premium Emulsion",
      "price": "Rs. 4,100",
      "image": "assets/images/fryola.png",
      "isFavorite": true,
    },
  ];

  List<Map<String, dynamic>> get paints => _paints;

  int get itemCount => _paints.length;

  void toggleFavorite(int index) {
    _paints[index]["isFavorite"] = !_paints[index]["isFavorite"];

    // agar unfavorite ho jaye to wishlist se remove kar do
    if (_paints[index]["isFavorite"] == false) {
      _paints.removeAt(index);
    }

    notifyListeners();
  }

  void clearWishlist() {
    _paints.clear();
    notifyListeners();
  }
}
