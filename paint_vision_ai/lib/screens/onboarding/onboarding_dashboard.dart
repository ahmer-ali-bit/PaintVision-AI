import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/auth/login/login.dart';

import 'package:paint_vision_ai/widgets/onboarding_page.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class OnboardingDashboard extends StatefulWidget {
  const OnboardingDashboard({super.key});

  @override
  State<OnboardingDashboard> createState() => _OnboardingDashboardState();
}

class _OnboardingDashboardState extends State<OnboardingDashboard> {
  final _pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.background,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04), // ✅ FIXED
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ========== SKIP BUTTON ==========
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // ========== CONTENT AREA ==========
                SizedBox(
                  height: height * 0.55,
                  width: double.infinity,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        index = value;
                      });
                    },
                    children: [
                      OnboardingPageWidget(
                        text: 'Visualize your\nDream Space',
                        desText:
                            'Upload your room photo and\nsee perfect colors instantly',
                        imgPath: 'assets/images/onboarding_1.png',
                      ),

                      OnboardingPageWidget(
                        text: 'AI Color\nRecommendation',
                        desText:
                            'Get smart color suggestions\nbased on your room lighting\nand style',
                        imgPath: 'assets/images/onboarding_2.png',
                      ),

                      OnboardingPageWidget(
                        text: 'Shop Premium\nPaints Online',
                        desText:
                            'Explore top brands, compare\nprices and get the\nbest deals deliverd to you',
                        imgPath: 'assets/images/onboarding_3.png',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.04),

                // ========== INDEX CIRCLES ==========
                SizedBox(
                  width: width * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => _pageController.jumpToPage(0),
                        child: Icon(
                          Icons.circle,
                          color: index == 0
                              ? AppColors.primary
                              : AppColors.buttonDisabled,
                          size: index == 0 ? 18 : 16,
                        ),
                      ),
                      InkWell(
                        onTap: () => _pageController.jumpToPage(1),
                        child: Icon(
                          Icons.circle,
                          color: index == 1
                              ? AppColors.primary
                              : AppColors.buttonDisabled,
                          size: index == 1 ? 18 : 16,
                        ),
                      ),
                      InkWell(
                        onTap: () => _pageController.jumpToPage(2),
                        child: Icon(
                          Icons.circle,
                          color: index == 2
                              ? AppColors.primary
                              : AppColors.buttonDisabled,
                          size: index == 2 ? 18 : 16,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.04),

                // ========== NEXT BUTTON ==========
                PrimaryButton(
                  text: index == 2 ? 'Get Start' : 'Next',
                  onTap: () {
                    if (index == 2) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
