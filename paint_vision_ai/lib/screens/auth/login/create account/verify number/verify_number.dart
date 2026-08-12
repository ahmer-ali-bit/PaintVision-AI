import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home_dashboard.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';
import 'package:pinput/pinput.dart';

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({super.key});

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),

                // ========== VERIFY YOUR NUMBER ==========
                Text(
                  "Verify Your Number",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),

                SizedBox(height: height * 0.04),

                // ========== DESCRIPTION TEXT ==========
                Text(
                  "Enter th 6 digit code sent to",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),

                SizedBox(height: height * 0.005),

                // ========== NUMBER ==========
                Text(
                  "1234567890",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),

                SizedBox(height: height * 0.04),

                // ========== PINPUT ==========
                Pinput(
                  length: 6,
                  onCompleted: (pin) => print(pin),
                  defaultPinTheme: PinTheme(
                    width: 55,
                    height: 50,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),

                // ========== RESEND CODE ==========
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Resend code in',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '00:45',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: height * 0.1),

                // ========== VERIFY BUTTON ==========
                PrimaryButton(
                  text: 'Verify',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeDashboardScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
