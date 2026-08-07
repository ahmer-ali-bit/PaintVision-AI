// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OnboardingPageWidget extends StatelessWidget {
  String text;
  String desText;
  String imgPath;
  OnboardingPageWidget({
    super.key,
    required this.text,
    required this.desText,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imgPath)),
          ),
        ),

        SizedBox(height: height * 0.02),

        Text(
          maxLines: 2,
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),

        SizedBox(height: height * 0.02),

        Text(
          desText,
          // 'Explore top brands, compare\nprices and get the\nbest deals deliverd to you',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
