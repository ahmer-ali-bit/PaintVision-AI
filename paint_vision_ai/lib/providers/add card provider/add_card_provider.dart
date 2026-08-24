import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardProvider extends ChangeNotifier {
  // 🎯 Controllers
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // 📌 Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 🔄 Save Card Toggle
  bool _saveCard = true;
  bool get saveCard => _saveCard;

  void toggleSaveCard(bool value) {
    _saveCard = value;
    notifyListeners();
  }

  // 💳 Card Type Detection
  String _cardType = '';
  String get cardType => _cardType;

  void detectCardType(String number) {
    // Remove spaces
    final cleanNumber = number.replaceAll(' ', '');

    if (cleanNumber.isEmpty) {
      _cardType = '';
    } else if (cleanNumber.startsWith('4')) {
      _cardType = 'VISA';
    } else if (cleanNumber.startsWith(RegExp(r'^5[1-5]'))) {
      _cardType = 'MASTERCARD';
    } else if (cleanNumber.startsWith(RegExp(r'^3[47]'))) {
      _cardType = 'AMEX';
    } else if (cleanNumber.startsWith('6')) {
      _cardType = 'DISCOVER';
    } else {
      _cardType = '';
    }
    notifyListeners();
  }

  // ✅ Validators
  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter card number';
    }
    final cleanNumber = value.replaceAll(' ', '');
    if (cleanNumber.length < 16) {
      return 'Enter valid 16-digit card number';
    }
    return null;
  }

  String? validateCardHolder(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter card holder name';
    }
    return null;
  }

  String? validateExpiry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (!RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(value)) {
      return 'Invalid';
    }
    return null;
  }

  String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (value.length < 3) {
      return 'Invalid';
    }
    return null;
  }

  // 💾 Save Card
  void saveCardData(BuildContext context) {
    if (formKey.currentState!.validate()) {
      debugPrint('Card Number: ${cardNumberController.text}');
      debugPrint('Card Holder: ${cardHolderController.text}');
      debugPrint('Expiry: ${expiryController.text}');
      debugPrint('CVV: ${cvvController.text}');
      debugPrint('Save Card: $_saveCard');
      debugPrint('Card Type: $_cardType');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Card saved successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      clearForm();
      Navigator.pop(context);
    }
  }

  // 🧹 Clear Form
  void clearForm() {
    cardNumberController.clear();
    cardHolderController.clear();
    expiryController.clear();
    cvvController.clear();
    _saveCard = true;
    _cardType = '';
    notifyListeners();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }
}

// 🎯 Custom Input Formatter for Card Number (1234 5678 9012 3456)
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        buffer.write(' ');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// 🎯 Custom Input Formatter for Expiry Date (MM/YY)
class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && i + 1 != text.length) {
        buffer.write('/');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
