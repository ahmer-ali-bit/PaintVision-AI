import 'package:flutter/material.dart';
import 'package:paint_vision_ai/core/utils/validator.dart';

class CreateAccountProvider extends ChangeNotifier {
  // ================= CONTROLLERS =================
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ================= FORM KEY =================
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ================= STATE =================
  Map<String, bool> _emailChecks = {};
  Map<String, bool> _passwordChecks = {};
  Map<String, bool> _phoneChecks = {};
  bool _obscurePassword = true;
  bool _isChecked = false;

  // ================= GETTERS =================
  Map<String, bool> get emailChecks => _emailChecks;
  Map<String, bool> get passwordChecks => _passwordChecks;
  Map<String, bool> get phoneChecks => _phoneChecks;
  bool get obscurePassword => _obscurePassword;
  bool get isChecked => _isChecked;

  // ===== VALIDATION GETTERS =====
  bool get isEmailValid =>
      _emailChecks.isNotEmpty && _emailChecks.values.every((v) => v);

  bool get isPasswordValid =>
      _passwordChecks.isNotEmpty && _passwordChecks.values.every((v) => v);

  bool get isPhoneValid =>
      _phoneChecks.isNotEmpty && _phoneChecks.values.every((v) => v);

  bool get isNameValid => nameController.text.trim().isNotEmpty;

  // sab valid hone chahiye + terms checked
  bool get isFormValid =>
      isEmailValid &&
      isPasswordValid &&
      isPhoneValid &&
      isNameValid &&
      _isChecked;

  // ================= ON FIELD CHANGED =================
  void onNameChanged(String value) {
    notifyListeners();
  }

  void onEmailChanged(String value) {
    _emailChecks = Validators.emailChecks(value);
    notifyListeners();
  }

  void onPhoneChanged(String value) {
    _phoneChecks = Validators.phoneChecks(value);
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _passwordChecks = Validators.passwordChecks(value);
    notifyListeners();
  }

  // ================= TOGGLE PASSWORD =================
  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // ================= TOGGLE CHECKBOX =================
  void toggleCheckbox(bool? value) {
    _isChecked = value ?? false;
    notifyListeners();
  }

  // ================= RESET =================
  void reset() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    _emailChecks = {};
    _passwordChecks = {};
    _phoneChecks = {};
    _obscurePassword = true;
    _isChecked = false;
    notifyListeners();
  }

  // ================= DISPOSE =================
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
