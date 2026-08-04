import 'package:flutter/material.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/onboarding_2.png'),
            ),
          ),
        ),

        SizedBox(height: height * 0.02),

        Text(
          maxLines: 2,
          "AI Color\nRecommendation",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),

        SizedBox(height: height * 0.02),

        Text(
          'Get smart color suggestions\nbased on your room lighting\nand style',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
