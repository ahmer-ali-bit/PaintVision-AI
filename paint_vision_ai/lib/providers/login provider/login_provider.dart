import 'package:flutter/material.dart';
import 'package:paint_vision_ai/core/utils/validator.dart';

class LoginProvider extends ChangeNotifier {
  // ================= CONTROLLERS =================
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ================= FORM KEY =================
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ================= STATE =================
  Map<String, bool> _emailChecks = {};
  Map<String, bool> _passwordChecks = {};
  bool _obscurePassword = true;

  // ================= GETTERS =================
  Map<String, bool> get emailChecks => _emailChecks;
  Map<String, bool> get passwordChecks => _passwordChecks;
  bool get obscurePassword => _obscurePassword;

  // email valid hai ya nahi
  bool get isEmailValid =>
      _emailChecks.isNotEmpty && _emailChecks.values.every((v) => v);

  // password valid hai ya nahi
  bool get isPasswordValid =>
      _passwordChecks.isNotEmpty && _passwordChecks.values.every((v) => v);

  // dono valid hain to form valid hai
  bool get isFormValid => isEmailValid && isPasswordValid;

  // ================= ON EMAIL CHANGED =================
  void onEmailChanged(String value) {
    _emailChecks = Validators.emailChecks(value);
    notifyListeners();
  }

  // ================= ON PASSWORD CHANGED =================
  void onPasswordChanged(String value) {
    _passwordChecks = Validators.passwordChecks(value);
    notifyListeners();
  }

  // ================= TOGGLE PASSWORD =================
  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // ================= RESET =================
  void reset() {
    emailController.clear();
    passwordController.clear();
    _emailChecks = {};
    _passwordChecks = {};
    _obscurePassword = true;
    notifyListeners();
  }

  // ================= DISPOSE =================
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
