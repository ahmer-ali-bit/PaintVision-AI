// lib/screens/login.dart

import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/auth/login/create%20account/create_account.dart';
import 'package:paint_vision_ai/screens/auth/login/forgot%20password/forgot_password.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home_dashboard.dart';
import 'package:paint_vision_ai/utils/validator.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';
import 'package:paint_vision_ai/widgets/text_form_field.dart';
import 'package:paint_vision_ai/widgets/validation_checker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Map<String, bool> _emailChecks = {};
  Map<String, bool> _passwordChecks = {};

  bool _obscurePassword = true; // 👈 Password show/hide

  bool get _isEmailValid =>
      _emailChecks.isNotEmpty && _emailChecks.values.every((v) => v);

  bool get _isPasswordValid =>
      _passwordChecks.isNotEmpty && _passwordChecks.values.every((v) => v);

  bool get _isFormValid => _isEmailValid && _isPasswordValid;

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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.04),

                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    Text(
                      "LoginScreen to continue",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.04),

                    // ========== EMAIL ==========
                    Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.01),

                    CTextFormField(
                      hintText: "Enter your email",
                      controller: _email,
                      isValid: _isEmailValid,
                      onChanged: (value) {
                        setState(() {
                          _emailChecks = Validators.emailChecks(value);
                        });
                      },
                    ),
                    SizedBox(height: height * 0.008),
                    ValidationChecker(checks: _emailChecks),

                    SizedBox(height: height * 0.03),

                    // ========== PASSWORD ==========
                    Text(
                      'Password',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.01),

                    CTextFormField(
                      hintText: "Enter your password",
                      controller: _password,
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onTogglePassword: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      isValid: _isPasswordValid,
                      onChanged: (value) {
                        setState(() {
                          _passwordChecks = Validators.passwordChecks(value);
                        });
                      },
                    ),
                    SizedBox(height: height * 0.008),
                    ValidationChecker(checks: _passwordChecks),

                    // ========== FORGOT PASSWORD BUTTON ==========
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
                      onTap: _isFormValid
                          ? () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeDashboardScreen(),
                                ),
                              );
                            }
                          : null,
                      isEnabled: _isFormValid,
                    ),

                    SizedBox(height: height * 0.03),

                    SizedBox(
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'or continue with',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== SOCIAL ICONS BUTTON ==========
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.transparent,
                            foregroundImage: AssetImage(
                              'assets/icons/google.png',
                            ),
                          ),
                          Icon(Icons.apple, size: 50),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== REGISTER TEXT BUTTON ==========
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
