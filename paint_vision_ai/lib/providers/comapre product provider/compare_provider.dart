import 'package:flutter/material.dart';

class CompareProvider extends ChangeNotifier {
  // ================= PRODUCTS LIST =================
  final List<Map<String, dynamic>> _compareProducts = [
    {
      "name": "Asian Paints Royale",
      "image": "assets/images/fryola.png",
      "price": "Rs. 3,250",
      "finish": "Premium",
      "washability": "High",
      "coverage": "120-140 sq.ft/L",
      "rating": "4.6",
    },
    {
      "name": "Berger Easy Clean",
      "image": "assets/images/fryola.png",
      "price": "Rs. 2,950",
      "finish": "Luxury",
      "washability": "Very High",
      "coverage": "110-130 sq.ft/L",
      "rating": "4.4",
    },
  ];

  // ================= GETTERS =================
  List<Map<String, dynamic>> get compareProducts => _compareProducts;

  int get productCount => _compareProducts.length;

  // ================= REMOVE PRODUCT =================
  void removeProduct(int index) {
    _compareProducts.removeAt(index);
    notifyListeners();
  }

  // ================= ADD PRODUCT =================
  void addProduct(Map<String, dynamic> product) {
    // max 3 products compare kar sakte hain
    if (_compareProducts.length >= 3) return;

    // duplicate check karo
    final exists = _compareProducts.any((p) => p["name"] == product["name"]);
    if (exists) return;

    _compareProducts.add(product);
    notifyListeners();
  }

  // ================= CLEAR ALL =================
  void clearAll() {
    _compareProducts.clear();
    notifyListeners();
  }

  // ================= GET VALUES BY KEY =================
  // kisi bhi field ki values list return karo
  List<String> getValuesByKey(String key) {
    return _compareProducts.map((p) => p[key] as String).toList();
  }
}
