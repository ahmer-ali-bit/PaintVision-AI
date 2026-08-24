// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';

class TransparentPrimaryButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  String text;
  TransparentPrimaryButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.background,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
