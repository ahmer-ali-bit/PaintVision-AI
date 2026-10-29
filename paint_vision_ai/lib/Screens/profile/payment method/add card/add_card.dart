import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paint_vision_ai/providers/add%20card%20provider/add_card_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<AddCardProvider>(context);

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
                  'Add New Card',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // 📝 FORM
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your card details',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: width * 0.035,
                        ),
                      ),

                      SizedBox(height: height * 0.025),

                      // 💳 Card Number
                      _buildLabel('Card Number', width),
                      _buildTextField(
                        controller: provider.cardNumberController,
                        hint: '1234 5678 9012 3456',
                        validator: provider.validateCardNumber,
                        keyboardType: TextInputType.number,
                        width: width,
                        height: height,
                        maxLength: 19,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                        ],
                        onChanged: provider.detectCardType,
                        suffixIcon: provider.cardType.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.all(width * 0.025),
                                child: Text(
                                  provider.cardType,
                                  style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.035,
                                  ),
                                ),
                              )
                            : null,
                      ),

                      SizedBox(height: height * 0.02),

                      // 👤 Card Holder Name
                      _buildLabel('Card Holder Name', width),
                      _buildTextField(
                        controller: provider.cardHolderController,
                        hint: 'Enter card holder name',
                        validator: provider.validateCardHolder,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),

                      // 📅 Expiry & CVV (Fixed Row)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Expiry Date
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Expiry Date', width),
                                _buildTextField(
                                  controller: provider.expiryController,
                                  hint: 'MM/YY',
                                  validator: provider.validateExpiry,
                                  keyboardType: TextInputType.number,
                                  width: width,
                                  height: height,
                                  maxLength: 5,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ExpiryDateFormatter(),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: width * 0.03),

                          // CVV
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('CVV', width),
                                _buildTextField(
                                  controller: provider.cvvController,
                                  hint: '123',
                                  validator: provider.validateCVV,
                                  keyboardType: TextInputType.number,
                                  width: width,
                                  height: height,
                                  maxLength: 4,
                                  obscureText: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  suffixIcon: Icon(
                                    Icons.help_outline,
                                    size: width * 0.05,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.02),

                      // 🔄 Save Card Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Save card for future use',
                            style: TextStyle(
                              fontSize: width * 0.038,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: provider.saveCard,
                            onChanged: provider.toggleSaveCard,
                            activeThumbColor: Colors.white,
                            activeTrackColor: AppColors.primary,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade300,
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.04),

                      // 🔒 Secure Payment Badge
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: width * 0.05,
                            ),
                            SizedBox(width: width * 0.02),
                            Text(
                              '100% Secure Payment',
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
            ),

            // 💾 SAVE BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Save Card',
                onTap: () => provider.saveCardData(context),
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

  // 📝 TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required double width,
    required double height,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLength,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: TextStyle(fontSize: width * 0.035),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: width * 0.035),
        filled: true,
        fillColor: Colors.white,
        counterText: '',
        contentPadding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.018,
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: BoxConstraints(
          minWidth: width * 0.1,
          minHeight: width * 0.1,
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
