import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';

class SearchFieldWidget extends StatelessWidget {
  final String? text;
  final double? width; // Ye ratio hoga (0.75 matlab 75% width)
  final double? height;

  const SearchFieldWidget({Key? key, this.text, this.width, this.height})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * (width ?? 1.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(Icons.search),
          hintText: text ?? 'Search...',
          hintStyle: TextStyle(color: AppColors.textGrey),
        ),
      ),
    );
  }
}
