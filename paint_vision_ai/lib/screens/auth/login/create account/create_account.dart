import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/auth/login/create%20account/verify%20number/verify_number.dart';
import 'package:paint_vision_ai/screens/auth/login/login.dart';
import 'package:paint_vision_ai/utils/validator.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';
import 'package:paint_vision_ai/widgets/text_form_field.dart';
import 'package:paint_vision_ai/widgets/validation_checker.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccountScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _pNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Map<String, bool> _emailChecks = {};
  Map<String, bool> _passwordChecks = {};
  Map<String, bool> _phoneChecks = {};

  bool _obscurePassword = true;
  bool _isChecked = false;

  bool get _isEmailValid =>
      _emailChecks.isNotEmpty && _emailChecks.values.every((v) => v);

  bool get _isPasswordValid =>
      _passwordChecks.isNotEmpty && _passwordChecks.values.every((v) => v);

  bool get _isPhoneValid =>
      _phoneChecks.isNotEmpty && _phoneChecks.values.every((v) => v);

  bool get _isNameValid => _name.text.trim().isNotEmpty;

  bool get _isFormValid =>
      _isEmailValid && _isPasswordValid && _isPhoneValid && _isNameValid;

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
                    SizedBox(height: height * 0.035),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Create Account",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                "Begin to continue",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
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

                    // ========== NAME & EMAIL ==========
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ========== NAME ==========
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Full Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: height * 0.01),
                                CTextFormField(
                                  hintText: "Enter your name",
                                  controller: _name,
                                  isValid: _isNameValid,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                                // Empty space to match email validation area
                                ValidationChecker(checks: {}),
                              ],
                            ),
                          ),

                          SizedBox(width: 10),

                          // ========== EMAIL ==========
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: height * 0.01),
                                CTextFormField(
                                  hintText: "Enter your email",
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  isValid: _isEmailValid,
                                  onChanged: (value) {
                                    setState(() {
                                      _emailChecks = Validators.emailChecks(
                                        value,
                                      );
                                    });
                                  },
                                ),
                                ValidationChecker(checks: _emailChecks),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // ========== PHONE & PASSWORD ==========
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ========== PHONE ==========
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: height * 0.01),
                                CTextFormField(
                                  hintText: "Enter your phone number",
                                  controller: _pNumber,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 15,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9+]'),
                                    ),
                                  ],
                                  isValid: _isPhoneValid,
                                  onChanged: (value) {
                                    setState(() {
                                      _phoneChecks = Validators.phoneChecks(
                                        value,
                                      );
                                    });
                                  },
                                ),
                                ValidationChecker(checks: _phoneChecks),
                              ],
                            ),
                          ),

                          SizedBox(width: 10),

                          // ========== PASSWORD ==========
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                      _passwordChecks =
                                          Validators.passwordChecks(value);
                                    });
                                  },
                                ),
                                ValidationChecker(checks: _passwordChecks),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== TERMS & CONDITIONS ==========
                    SizedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked = newValue!;
                              });
                            },
                          ),
                          Text('I agree to'),
                          TextButton(
                            onPressed: () {},
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
                    ),

                    // ========== REGISTER BUTTON ==========
                    PrimaryButton(
                      text: 'Sign Up',
                      onTap: _isFormValid
                          ? () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerifyNumber(),
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

                    // ========== LOGIN TEXT BUTTON ==========
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
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
    _name.dispose();
    _pNumber.dispose();
    super.dispose();
  }
}
