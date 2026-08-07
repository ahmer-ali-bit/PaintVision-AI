// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/wall_detection.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class CropImageScreen extends StatefulWidget {
  final File? imageFile;
  const CropImageScreen({Key? key, this.imageFile}) : super(key: key);

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(),
                  const Text(
                    'Crop Image',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: height * 0.03),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Container(
                        height: height * 0.4,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: widget.imageFile != null
                            ? Image.file(widget.imageFile!, fit: BoxFit.cover)
                            : Center(child: Text('No Image Selected')),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.rotate_left_rounded,
                                color: Colors.black,
                              ),
                              SizedBox(width: width * 0.01),

                              Text(
                                'Rotate',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                            backgroundColor: const Color.fromARGB(
                              27,
                              37,
                              100,
                              235,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.restart_alt_rounded,
                                color: Colors.black,
                              ),
                              SizedBox(width: width * 0.01),

                              Text(
                                'Reset',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                            backgroundColor: const Color.fromARGB(
                              27,
                              37,
                              100,
                              235,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.03),

                    PrimaryButton(
                      text: 'Next',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WallDetectionScreen(),
                          ),
                        );
                      },
                    ),
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
