import 'package:flutter/material.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';

class SearchFieldWidget extends StatelessWidget {
  final String? text;
  final String? hintText; // ✅ Optional hintText
  final TextEditingController? controller; // ✅ Optional controller
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const SearchFieldWidget({
    super.key,
    this.text,
    this.hintText, // ✅ Add here
    this.controller, // ✅ Add here
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * (width ?? 1.0),
      child: TextField(
        controller: controller, // ✅ Use controller
        onTap: onTap,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: const Icon(Icons.search),
          hintText: hintText ?? text ?? 'Search...', // ✅ Priority order
          hintStyle: TextStyle(color: AppColors.textGrey),
        ),
      ),
    );
  }
}
