import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/setting%20provider/change%20password%20provider/change_password_provider.dart';
import 'package:paint_vision_ai/shared/widgets/validation_checker.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ChangePasswordProvider>(context);

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
                  'Change Password',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // 📝 FORM (Scrollable)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Update your account password',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: width * 0.035,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.025),

                      // 🔒 Current Password
                      _buildLabel('Current Password', width),
                      _buildPasswordField(
                        controller: provider.currentPasswordController,
                        hint: 'Enter current password',
                        isVisible: provider.isCurrentPasswordVisible,
                        onToggle: provider.toggleCurrentPasswordVisibility,
                        validator: provider.validateCurrentPassword,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),

                      // 🔒 New Password
                      _buildLabel('New Password', width),
                      _buildPasswordField(
                        controller: provider.newPasswordController,
                        hint: 'Enter new password',
                        isVisible: provider.isNewPasswordVisible,
                        onToggle: provider.toggleNewPasswordVisibility,
                        validator: provider.validateNewPassword,
                        onChanged: provider.updateNewPassword,
                        width: width,
                        height: height,
                      ),

                      // ✅ VALIDATION CHECKER (Custom Widget)
                      ValidationChecker(checks: provider.passwordChecks),

                      SizedBox(height: height * 0.02),

                      // 🔒 Confirm New Password
                      _buildLabel('Confirm New Password', width),
                      _buildPasswordField(
                        controller: provider.confirmPasswordController,
                        hint: 'Confirm new password',
                        isVisible: provider.isConfirmPasswordVisible,
                        onToggle: provider.toggleConfirmPasswordVisibility,
                        validator: provider.validateConfirmPassword,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
            ),

            // 💾 UPDATE BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Update Password',
                onTap: () => provider.updatePassword(context),
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // 🏷️ Label Widget
  Widget _buildLabel(String label, double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.035),
      ),
    );
  }

  // 🔐 Password Field Widget
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    required double width,
    required double height,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: !isVisible,
      style: TextStyle(fontSize: width * 0.035),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: width * 0.035),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.018,
        ),
        suffixIcon: GestureDetector(
          onTap: onToggle,
          child: Icon(
            isVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey[600],
            size: width * 0.055,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
