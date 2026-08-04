import 'package:flutter/material.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

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
              image: AssetImage('assets/images/onboarding_1.png'),
            ),
          ),
        ),

        SizedBox(height: height * 0.02),

        Text(
          maxLines: 2,
          "Visualize Your\nDream Space",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),

        SizedBox(height: height * 0.02),

        Text(
          maxLines: 2,
          'Upload your room photo and\nsee perfect colors instantly',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
