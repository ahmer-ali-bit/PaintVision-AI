import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  // ================= ADDRESSES LIST =================
  final List<Map<String, dynamic>> _addresses = [
    {
      "title": "Home",
      "address": "123, Model Town, Lahore, Punjab, Pakistan",
      "phone": "+92 300 1234567",
      "isDefault": true,
    },
    {
      "title": "Office",
      "address": "456, Gulberg, Lahore, Punjab, Pakistan",
      "phone": "+92 300 1234567",
      "isDefault": false,
    },
    {
      "title": "Parents Home",
      "address": "789, DHA Phase 5, Lahore, Punjab, Pakistan",
      "phone": "+92 300 1234567",
      "isDefault": false,
    },
  ];

  // ================= GETTERS =================
  List<Map<String, dynamic>> get addresses => _addresses;

  int get totalAddresses => _addresses.length;

  // ================= ADD ADDRESS =================
  void addAddress({
    required String title,
    required String address,
    required String phone,
    required bool isDefault,
  }) {
    // agar new address default hai to pehle sab false karo
    if (isDefault) {
      _setAllNonDefault();
    }

    _addresses.add({
      "title": title,
      "address": address,
      "phone": phone,
      "isDefault": isDefault,
    });

    notifyListeners();
  }

  // ================= EDIT ADDRESS =================
  void editAddress({
    required int index,
    required String title,
    required String address,
    required String phone,
    required bool isDefault,
  }) {
    // agar edited address default hai to pehle sab false karo
    if (isDefault) {
      _setAllNonDefault();
    }

    _addresses[index] = {
      "title": title,
      "address": address,
      "phone": phone,
      "isDefault": isDefault,
    };

    notifyListeners();
  }

  // ================= DELETE ADDRESS =================
  void deleteAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }

  // ================= PRIVATE: SET ALL NON-DEFAULT =================
  // ye method sirf is class ke andar use hogi
  void _setAllNonDefault() {
    for (var addr in _addresses) {
      addr["isDefault"] = false;
    }
  }
}
