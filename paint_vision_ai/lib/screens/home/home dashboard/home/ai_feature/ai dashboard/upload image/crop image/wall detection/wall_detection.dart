// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/color_palette/color_palette.dart';

class WallDetectionScreen extends StatefulWidget {
  const WallDetectionScreen({Key? key}) : super(key: key);

  @override
  State<WallDetectionScreen> createState() => _WallDetectionScreenState();
}

class _WallDetectionScreenState extends State<WallDetectionScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(),
                  Text(
                    'Wall Detecttion',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: height * 0.01),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.4,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ColorPaletteScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Detecting Walls...',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    Text(
                      'We are analyzing your image',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    CustomProgressBar(percentage: 0.85),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final double percentage;

  const CustomProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Background bar
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              // Filled bar
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: 10,
                    width: constraints.maxWidth * percentage,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E4FEB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          "${(percentage * 100).toInt()}%",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }
}
