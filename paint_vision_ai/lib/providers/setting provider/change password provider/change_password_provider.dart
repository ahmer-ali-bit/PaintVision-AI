import 'package:flutter/material.dart';

class ChangePasswordProvider extends ChangeNotifier {
  // 🎯 Controllers
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // 📌 Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 👁️ Password Visibility
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isCurrentPasswordVisible => _isCurrentPasswordVisible;
  bool get isNewPasswordVisible => _isNewPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void toggleCurrentPasswordVisibility() {
    _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _isNewPasswordVisible = !_isNewPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  // 🎯 Password value track karo
  String _newPassword = '';
  String get newPassword => _newPassword;

  void updateNewPassword(String value) {
    _newPassword = value;
    notifyListeners();
  }

  // ✅ Password Checks Map (ValidationChecker ke liye)
  Map<String, bool> get passwordChecks => {
    'At least 8 characters': _newPassword.length >= 8,
    'One uppercase letter': _newPassword.contains(RegExp(r'[A-Z]')),
    'One number': _newPassword.contains(RegExp(r'[0-9]')),
    'One special character': _newPassword.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    ),
  };

  // ✅ All requirements met?
  bool get isPasswordValid => passwordChecks.values.every((valid) => valid);

  // ✅ Validators
  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter current password';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter new password';
    }
    if (!isPasswordValid) {
      return 'Password does not meet requirements';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // 💾 Update Password
  void updatePassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      debugPrint('Current: ${currentPasswordController.text}');
      debugPrint('New: ${newPasswordController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Password updated successfully!'),
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
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    _newPassword = '';
    _isCurrentPasswordVisible = false;
    _isNewPasswordVisible = false;
    _isConfirmPasswordVisible = false;
    notifyListeners();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
