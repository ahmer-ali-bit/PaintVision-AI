import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';
import 'package:paint_vision_ai/widgets/text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _resetmail = TextEditingController();
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
                SizedBox(height: height * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                SizedBox(height: height * 0.1),

                // ========== FORGOT TEXT ==========
                Text(
                  "Forgot Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),

                SizedBox(height: height * 0.03),

                // ========== DESCRIPTION TEXT ==========
                Text(
                  "Enter your email and we'll\nsend you a reset link",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),

                SizedBox(height: height * 0.03),

                // ========== TEXT FIELD ==========
                CTextFormField(
                  hintText: 'Enter your email',
                  controller: _resetmail,
                ),

                SizedBox(height: height * 0.03),

                // ========== SEND RESET LINK BUTTON ==========
                PrimaryButton(text: 'Send Reset Link', onTap: () {}),

                SizedBox(height: height * 0.03),

                // ========== IMAGE ==========
                Container(
                  width: double.infinity,
                  height: height * 0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/reset_mail.png'),
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
