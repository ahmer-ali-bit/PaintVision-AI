import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  // ================= SELECTED VALUES =================
  // language ab Map ke saath store hogi
  Map<String, String> _selectedLanguage = {"name": "English", "code": "en"};

  String _selectedCurrency = "PKR - Pakistani Rupee";
  String _selectedTheme = "Light";
  final String _appVersion = "1.0.0";

  // ================= LISTS =================
  final List<Map<String, String>> _languages = [
    {"name": "English", "code": "en"},
    {"name": "اردو", "code": "ur"},
    {"name": "العربية", "code": "ar"},
  ];

  final List<String> _currencies = [
    "PKR - Pakistani Rupee",
    "USD - US Dollar",
    "EUR - Euro",
    "GBP - British Pound",
    "SAR - Saudi Riyal",
  ];

  final List<String> _themes = ["Light", "Dark", "System Default"];

  // ================= GETTERS =================

  // selected language ka naam
  String get selectedLanguageName => _selectedLanguage["name"]!;

  // selected language ka code
  String get selectedLanguageCode => _selectedLanguage["code"]!;

  // puri language map
  Map<String, String> get selectedLanguage => _selectedLanguage;

  String get selectedCurrency => _selectedCurrency;
  String get selectedTheme => _selectedTheme;
  String get appVersion => _appVersion;

  List<Map<String, String>> get languages => _languages;
  List<String> get currencies => _currencies;
  List<String> get themes => _themes;

  // ================= METHODS =================

  // language Map ke saath save hogi
  void selectLanguage(Map<String, String> language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void selectCurrency(String value) {
    _selectedCurrency = value;
    notifyListeners();
  }

  void selectTheme(String value) {
    _selectedTheme = value;
    notifyListeners();
  }
}
