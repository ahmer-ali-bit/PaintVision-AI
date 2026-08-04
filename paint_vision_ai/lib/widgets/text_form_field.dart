// lib/widgets/text_form_field.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';

class CTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onTogglePassword;
  final Function(String)? onChanged;
  final bool isValid;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const CTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onTogglePassword,
    this.onChanged,
    this.isValid = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    bool hasText = controller.text.isNotEmpty;

    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textHint),
        counterText: '',

        // Suffix Icons
        suffixIcon: _buildSuffixIcon(hasText),

        // Normal Border
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

        // Enabled Border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: !hasText
                ? AppColors.border
                : isValid
                ? AppColors.green
                : AppColors.red,
            width: hasText ? 1.5 : 1,
          ),
        ),

        // Focused Border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: !hasText
                ? AppColors.primary
                : isValid
                ? AppColors.green
                : AppColors.red,
            width: 2,
          ),
        ),

        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon(bool hasText) {
    // ========== PASSWORD FIELD ==========
    if (isPassword) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasText)
            Icon(
              isValid ? Icons.check_circle : Icons.cancel,
              color: isValid ? AppColors.green : AppColors.red,
              size: 22,
            ),
          IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.textGrey,
            ),
            onPressed: onTogglePassword,
          ),
        ],
      );
    }

    // ========== NORMAL FIELD ==========
    if (!hasText) return null;

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Icon(
        isValid ? Icons.check_circle : Icons.cancel,
        color: isValid ? AppColors.green : AppColors.red,
        size: 22,
      ),
    );
  }
}
