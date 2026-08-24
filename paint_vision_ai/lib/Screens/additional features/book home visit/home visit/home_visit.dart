import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20home%20visit/step%20indicator%20widgets/step%201%20schedule/step_1_schedule.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20home%20visit/step%20indicator%20widgets/step%202%20details/step_2_details.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20home%20visit/step%20indicator%20widgets/step%203%20confirm/step_3_confirm.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20home%20visit/step%20indicator%20widgets/step_indicator.dart';
import 'package:paint_vision_ai/providers/additional%20feature/home%20visit%20provider/home_visit_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class HomeVisitScreen extends StatelessWidget {
  const HomeVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final provider = context.watch<HomeVisitProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔙 APP BAR
            Row(
              children: [
                const BackButton(),
                Text(
                  'Schedule Home Visit',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Text(
              'Choose your preferred slot',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: width * 0.035,
              ),
            ),

            SizedBox(height: height * 0.025),

            // 🔵 STEP INDICATOR
            StepIndicator(currentStep: provider.currentStep),

            SizedBox(height: height * 0.025),

            // 📝 STEP CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: _buildStepContent(provider.currentStep),
              ),
            ),

            // 💾 NEXT/CONFIRM BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: provider.currentStep == 2 ? 'Confirm Booking' : 'Next',
                onTap: () {
                  if (provider.currentStep == 2) {
                    provider.confirmBooking(context);
                  } else {
                    provider.nextStep(context);
                  }
                },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return const Step1Schedule();
      case 1:
        return const Step2Details();
      case 2:
        return const Step3Confirm();
      default:
        return const SizedBox();
    }
  }
}
