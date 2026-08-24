// lib/features/onboarding/onboarding_dashboard.dart

import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/onboarding%20provider/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/onboarding_page.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class OnboardingDashboard extends StatelessWidget {
  // ========== StatefulWidget ki zaroorat NAHI, Provider state handle karega ==========
  const OnboardingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // ========== PROVIDER SE DATA ACCESS KARO ==========
    final onboardingProvider = Provider.of<OnboardingProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.background,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ========== SKIP BUTTON ==========
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => onboardingProvider.skip(context),
                    child: const Text(
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
                    controller: onboardingProvider.pageController,
                    onPageChanged: onboardingProvider.onPageChanged,
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
                            'Explore top brands, compare\nprices and get the\nbest deals delivered to you',
                        imgPath: 'assets/images/onboarding_3.png',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.04),

                // ========== INDEX CIRCLES (Consumer se optimize) ==========
                Consumer<OnboardingProvider>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      width: width * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (i) {
                          return InkWell(
                            onTap: () => provider.goToPage(i),
                            child: Icon(
                              Icons.circle,
                              color: provider.currentIndex == i
                                  ? AppColors.primary
                                  : AppColors.buttonDisabled,
                              size: provider.currentIndex == i ? 18 : 16,
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),

                SizedBox(height: height * 0.04),

                // ========== NEXT BUTTON ==========
                PrimaryButton(
                  text: onboardingProvider.buttonText,
                  onTap: () => onboardingProvider.handleNextOrFinish(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
