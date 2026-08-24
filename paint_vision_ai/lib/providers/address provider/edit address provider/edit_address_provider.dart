import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/address%20provider/address_provider.dart';
import 'package:provider/provider.dart';

class EditAddressProvider extends ChangeNotifier {
  // 🎯 Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  // 📌 Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 🎯 Index to know which address is being edited
  int? _editIndex;

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

  // 🎯 Load Existing Data
  void loadAddressData({
    required int index,
    required String fullName,
    required String phone,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String postalCode,
    required bool isDefault,
  }) {
    _editIndex = index;
    fullNameController.text = fullName;
    phoneController.text = phone;
    addressLine1Controller.text = addressLine1;
    addressLine2Controller.text = addressLine2;
    postalCodeController.text = postalCode;
    _selectedCity = city;
    _isDefault = isDefault;
    // notifyListeners() yahan mat lagao (screen build ke time issue hoga)
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

  // 💾 Update Address
  void updateAddress(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (_selectedCity == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select a city')));
        return;
      }

      if (_editIndex == null) return;

      final addressProvider = context.read<AddressProvider>();

      final fullAddress =
          '${addressLine1Controller.text}, ${addressLine2Controller.text.isNotEmpty ? "${addressLine2Controller.text}, " : ""}$_selectedCity - ${postalCodeController.text}';

      addressProvider.editAddress(
        index: _editIndex!,
        title: fullNameController.text,
        address: fullAddress,
        phone: phoneController.text,
        isDefault: _isDefault,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      clearForm();
      Navigator.pop(context);
    }
  }

  // 🗑️ Delete Address
  void deleteAddress(BuildContext context) {
    if (_editIndex == null) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Delete Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("Are you sure you want to delete this address?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final addressProvider = context.read<AddressProvider>();
              addressProvider.deleteAddress(_editIndex!);

              Navigator.pop(dialogContext); // dialog close
              Navigator.pop(context); // screen close

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Address deleted"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );

              clearForm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
    _editIndex = null;
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
