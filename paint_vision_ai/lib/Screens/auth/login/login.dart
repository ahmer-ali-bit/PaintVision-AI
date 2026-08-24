import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/login%20provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/auth/login/create%20account/create_account.dart';
import 'package:paint_vision_ai/Screens/auth/login/forgot%20password/forgot_password.dart';
import 'package:paint_vision_ai/Screens/home/home%20dashboard/home_dashboard.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';
import 'package:paint_vision_ai/shared/widgets/text_form_field.dart';
import 'package:paint_vision_ai/shared/widgets/validation_checker.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke validation changes par UI update ho
    final loginProvider = context.watch<LoginProvider>();

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
                key: loginProvider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.04),

                    // ========== WELCOME TEXT ==========
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    const Text(
                      "Login to continue",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: height * 0.04),

                    // ========== EMAIL ==========
                    const Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: height * 0.01),

                    CTextFormField(
                      hintText: "Enter your email",
                      controller: loginProvider.emailController,
                      isValid: loginProvider.isEmailValid,
                      onChanged: (value) {
                        context.read<LoginProvider>().onEmailChanged(value);
                      },
                    ),

                    SizedBox(height: height * 0.008),

                    // Email validation checks
                    ValidationChecker(checks: loginProvider.emailChecks),

                    SizedBox(height: height * 0.03),

                    // ========== PASSWORD ==========
                    const Text(
                      'Password',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: height * 0.01),

                    CTextFormField(
                      hintText: "Enter your password",
                      controller: loginProvider.passwordController,
                      isPassword: true,
                      obscureText: loginProvider.obscurePassword,
                      onTogglePassword: () {
                        context.read<LoginProvider>().togglePassword();
                      },
                      isValid: loginProvider.isPasswordValid,
                      onChanged: (value) {
                        context.read<LoginProvider>().onPasswordChanged(value);
                      },
                    ),

                    SizedBox(height: height * 0.008),

                    // Password validation checks
                    ValidationChecker(checks: loginProvider.passwordChecks),

                    // ========== FORGOT PASSWORD ==========
                    Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== LOGIN BUTTON ==========
                    PrimaryButton(
                      text: 'Login',
                      isEnabled: loginProvider.isFormValid,
                      onTap: loginProvider.isFormValid
                          ? () {
                              _onLogin(context);
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
                            // Google login logic
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
                            // Apple login logic
                          },
                          child: const Icon(Icons.apple, size: 50),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== REGISTER TEXT BUTTON ==========
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateAccountScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
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

  // ========== LOGIN ACTION ==========
  void _onLogin(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();

    // form validate karo
    if (!loginProvider.isFormValid) return;

    // provider reset karo
    loginProvider.reset();

    // Home screen par navigate karo
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeDashboardScreen()),
    );
  }
}
