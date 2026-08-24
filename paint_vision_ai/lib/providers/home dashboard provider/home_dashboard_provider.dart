import 'package:flutter/material.dart';

class HomeDashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  // current selected index
  int get selectedIndex => _selectedIndex;

  // tab change karo
  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // optional: home par wapis lana ho
  void goToHome() {
    _selectedIndex = 0;
    notifyListeners();
  }
}
