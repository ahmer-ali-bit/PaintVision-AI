import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paint_vision_ai/providers/create%20account%20provider/create_account_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/auth/login/create%20account/verify%20number/verify_number.dart';
import 'package:paint_vision_ai/Screens/auth/login/login.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';
import 'package:paint_vision_ai/shared/widgets/text_form_field.dart';
import 'package:paint_vision_ai/shared/widgets/validation_checker.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke validation changes par UI update ho
    final createProvider = context.watch<CreateAccountProvider>();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.background,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Form(
                key: createProvider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.035),

                    // ========== HEADER ==========
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Create Account",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              const Text(
                                "Begin to continue",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Fill your details to create\nyour account',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              height: 2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.04),

                    // ========== NAME & EMAIL ROW ==========
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // NAME
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Full Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: height * 0.01),
                                CTextFormField(
                                  hintText: "Enter your name",
                                  controller: createProvider.nameController,
                                  isValid: createProvider.isNameValid,
                                  onChanged: (value) {
                                    context
                                        .read<CreateAccountProvider>()
                                        .onNameChanged(value);
                                  },
                                ),
                                // empty space match karne ke liye
                                const ValidationChecker(checks: {}),
                              ],
                            ),
                          ),

                          const SizedBox(width: 10),

                          // EMAIL
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Email',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: height * 0.01),
                                CTextFormField(
                                  hintText: "Enter your email",
                                  controller: createProvider.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  isValid: createProvider.isEmailValid,
                                  onChanged: (value) {
                                    context
                                        .read<CreateAccountProvider>()
                                        .onEmailChanged(value);
                                  },
                                ),
                                ValidationChecker(
                                  checks: createProvider.emailChecks,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // ========== PHONE & PASSWORD ROW ==========
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // PHONE
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Phone',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: height * 0.01),
                                CTextFormField(
                                  hintText: "Enter your phone number",
                                  controller: createProvider.phoneController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 15,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9+]'),
                                    ),
                                  ],
                                  isValid: createProvider.isPhoneValid,
                                  onChanged: (value) {
                                    context
                                        .read<CreateAccountProvider>()
                                        .onPhoneChanged(value);
                                  },
                                ),
                                ValidationChecker(
                                  checks: createProvider.phoneChecks,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 10),

                          // PASSWORD
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Password',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: height * 0.01),
                                CTextFormField(
                                  hintText: "Enter your password",
                                  controller: createProvider.passwordController,
                                  isPassword: true,
                                  obscureText: createProvider.obscurePassword,
                                  onTogglePassword: () {
                                    context
                                        .read<CreateAccountProvider>()
                                        .togglePassword();
                                  },
                                  isValid: createProvider.isPasswordValid,
                                  onChanged: (value) {
                                    context
                                        .read<CreateAccountProvider>()
                                        .onPasswordChanged(value);
                                  },
                                ),
                                ValidationChecker(
                                  checks: createProvider.passwordChecks,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== TERMS & CONDITIONS ==========
                    Row(
                      children: [
                        Checkbox(
                          value: createProvider.isChecked,
                          activeColor: AppColors.primary,
                          onChanged: (bool? newValue) {
                            context
                                .read<CreateAccountProvider>()
                                .toggleCheckbox(newValue);
                          },
                        ),
                        const Text('I agree to'),
                        TextButton(
                          onPressed: () {
                            // Terms screen navigate karo
                          },
                          child: Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ========== SIGN UP BUTTON ==========
                    PrimaryButton(
                      text: 'Sign Up',
                      isEnabled: createProvider.isFormValid,
                      onTap: createProvider.isFormValid
                          ? () {
                              _onSignUp(context);
                            }
                          : null,
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== OR CONTINUE WITH ==========
                    const Center(
                      child: Text(
                        'or continue with',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== SOCIAL ICONS ==========
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Google
                        GestureDetector(
                          onTap: () {
                            // Google signup logic
                          },
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.transparent,
                            foregroundImage: AssetImage(
                              'assets/icons/google.png',
                            ),
                          ),
                        ),

                        // Apple
                        GestureDetector(
                          onTap: () {
                            // Apple signup logic
                          },
                          child: const Icon(Icons.apple, size: 50),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== LOGIN TEXT BUTTON ==========
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ========== SIGN UP ACTION ==========
  void _onSignUp(BuildContext context) {
    final createProvider = context.read<CreateAccountProvider>();

    // validation check
    if (!createProvider.isFormValid) return;

    // VerifyNumber screen par navigate karo
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const VerifyNumber()),
    );
  }
}
