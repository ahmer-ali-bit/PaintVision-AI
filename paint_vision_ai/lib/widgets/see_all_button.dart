// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:paint_vision_ai/constants/app_colors.dart';

class SeeAllButton extends StatelessWidget {
  String buttonText;
  String desText;
  final Widget navigateTo;
  final double? fontsize;

  SeeAllButton({
    Key? key,
    required this.buttonText,
    required this.desText,
    required this.navigateTo,
    this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          desText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontsize ?? 16,
          ),
        ),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigateTo),
            );
          },
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
