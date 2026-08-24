import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/auth/login/login.dart';

class OnboardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  bool get isLastPage => _currentIndex == 2;
  String get buttonText => isLastPage ? 'Get Start' : 'Netx';

  void onPageChanged(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void goToPage(int page) {
    pageController.jumpToPage(page);
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void handleNextOrFinish(BuildContext context) {
    if (isLastPage) {
      _navigateToLogin(context);
    } else {
      nextPage();
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void skip(BuildContext context) {
    void dispose() {
      pageController.dispose();
      super.dispose();
    }

    _navigateToLogin(context);
  }
}
