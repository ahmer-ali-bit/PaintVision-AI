import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  // ================= PAYMENT METHODS LIST =================
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      "type": "visa",
      "name": "Visa",
      "number": "**** 4242",
      "expiry": "12/26",
      "image": "assets/images/visa.png",
      "isDefault": true,
    },
    {
      "type": "mastercard",
      "name": "Mastercard",
      "number": "**** 8888",
      "expiry": "10/25",
      "image": "assets/images/mastercard.png",
      "isDefault": false,
    },
    {
      "type": "jazzcash",
      "name": "JazzCash",
      "number": "03xx-xxxxxxx",
      "expiry": "",
      "image": "assets/images/jazzcash.png",
      "isDefault": false,
    },
    {
      "type": "easypaisa",
      "name": "EasyPaisa",
      "number": "03xx-xxxxxxx",
      "expiry": "",
      "image": "assets/images/easypaisa.png",
      "isDefault": false,
    },
  ];

  // ================= GETTERS =================
  List<Map<String, dynamic>> get paymentMethods => _paymentMethods;

  int get totalMethods => _paymentMethods.length;

  // ================= SET DEFAULT =================
  void setDefault(int index) {
    // pehle sab false karo
    for (var method in _paymentMethods) {
      method["isDefault"] = false;
    }
    // phir selected ko true karo
    _paymentMethods[index]["isDefault"] = true;
    notifyListeners();
  }

  // ================= DELETE METHOD =================
  void deleteMethod(int index) {
    _paymentMethods.removeAt(index);
    notifyListeners();
  }

  // ================= ADD NEW CARD =================
  void addCard({
    required String name,
    required String number,
    required String expiry,
  }) {
    _paymentMethods.add({
      "type": "card",
      "name": name,
      "number": "**** $number",
      "expiry": expiry,
      "image": "assets/images/cardpayment.png",
      "isDefault": false,
    });
    notifyListeners();
  }
}
