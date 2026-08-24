import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/address%20provider/address_provider.dart';
import 'package:provider/provider.dart';

class AddAddressProvider extends ChangeNotifier {
  // 🎯 Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  // 📌 Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 🏙️ City Dropdown
  String? _selectedCity;
  String? get selectedCity => _selectedCity;

  final List<String> cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Rawalpindi',
    'Faisalabad',
    'Multan',
    'Peshawar',
    'Quetta',
  ];

  void setCity(String? city) {
    _selectedCity = city;
    notifyListeners();
  }

  // 🔄 Default Address Toggle
  bool _isDefault = false;
  bool get isDefault => _isDefault;

  void toggleDefault(bool value) {
    _isDefault = value;
    notifyListeners();
  }

  // ✅ Validators
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter full name';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }
    if (value.length < 10) {
      return 'Enter valid phone number';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter address';
    }
    return null;
  }

  String? validatePostalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter postal code';
    }
    return null;
  }

  // 💾 Save Address (👇 Updated - AddressProvider ko call karta hai)
  void saveAddress(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (_selectedCity == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select a city')));
        return;
      }

      // 🎯 AddressProvider ka instance lo
      final addressProvider = context.read<AddressProvider>();

      // 🎯 Full address string banao
      final fullAddress =
          '${addressLine1Controller.text}, ${addressLine2Controller.text.isNotEmpty ? "${addressLine2Controller.text}, " : ""}$_selectedCity - ${postalCodeController.text}';

      // 🎯 AddressProvider mein add karo
      addressProvider.addAddress(
        title: fullNameController.text, // Ya "Home", "Office" etc.
        address: fullAddress,
        phone: phoneController.text,
        isDefault: _isDefault,
      );

      // ✅ Success Message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // 🧹 Clear + Back
      clearForm();
      Navigator.pop(context);
    }
  }

  // 🧹 Clear Form
  void clearForm() {
    fullNameController.clear();
    phoneController.clear();
    addressLine1Controller.clear();
    addressLine2Controller.clear();
    postalCodeController.clear();
    _selectedCity = null;
    _isDefault = false;
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    postalCodeController.dispose();
    super.dispose();
  }
}
