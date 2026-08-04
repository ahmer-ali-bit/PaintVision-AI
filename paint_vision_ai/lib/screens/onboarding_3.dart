import 'package:flutter/material.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

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
              image: AssetImage('assets/images/onboarding_3.png'),
            ),
          ),
        ),

        SizedBox(height: height * 0.02),

        Text(
          maxLines: 2,
          "Shop Premium\nPaints Online",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),

        SizedBox(height: height * 0.02),

        Text(
          'Explore top brands, compare\nprices and get the\nbest deals deliverd to you',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
