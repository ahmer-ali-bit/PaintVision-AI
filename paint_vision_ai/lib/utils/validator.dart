// lib/utils/validator.dart

class Validators {
  static Map<String, bool> emailChecks(String value) {
    return {
      'Email is required': value.trim().isNotEmpty,
      'Must contain @': value.contains('@'),
      'Must contain domain (.)': value.contains('.'),
      'Valid email format': RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(value.trim()),
    };
  }

  static Map<String, bool> passwordChecks(String value) {
    return {
      'At least 8 characters': value.length >= 8,
      'One uppercase letter (A-Z)': value.contains(RegExp(r'[A-Z]')),
      'One lowercase letter (a-z)': value.contains(RegExp(r'[a-z]')),
      'One number (0-9)': value.contains(RegExp(r'[0-9]')),
      'One special character (!@#\$)': value.contains(
        RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
      ),
    };
  }
}
