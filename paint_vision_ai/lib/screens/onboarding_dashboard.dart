import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/login.dart';
import 'package:paint_vision_ai/screens/onboarding_1.dart';
import 'package:paint_vision_ai/screens/onboarding_2.dart';
import 'package:paint_vision_ai/screens/onboarding_3.dart';

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
            padding: EdgeInsetsGeometry.symmetric(horizontal: width * 0.04),
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

                // ========== CONTEXT AREA ==========
                Container(
                  height: height * 0.55,
                  width: double.infinity,

                  child: PageView(
                    children: [Onboarding1(), Onboarding2(), Onboarding3()],

                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        index = value;
                      });
                    },
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
                        onTap: () {
                          _pageController.jumpToPage(0);
                        },
                        child: Icon(
                          color: index == 0
                              ? AppColors.primary
                              : AppColors.buttonDisabled,

                          Icons.circle,
                          size: index == 0 ? 18 : 16,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          _pageController.jumpToPage(1);
                        },
                        child: Icon(
                          color: index == 1
                              ? AppColors.primary
                              : AppColors.buttonDisabled,

                          Icons.circle,
                          size: index == 1 ? 18 : 16,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          _pageController.jumpToPage(2);
                        },
                        child: Icon(
                          color: index == 2
                              ? AppColors.primary
                              : AppColors.buttonDisabled,

                          Icons.circle,
                          size: index == 2 ? 18 : 16,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.04),

                // ========== NEXT BUTTON ==========
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (index == 2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      index == 2 ? 'Get Start' : 'Next',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
