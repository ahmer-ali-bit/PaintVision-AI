import 'dart:io';
import 'dart:ui' as BorderType;
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/crop_image.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/color_palette/color_palette.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  File? _selectImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectImage = File(image.path);
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CropImageScreen(imageFile: _selectImage),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera, // 👈 Sirf ye change - camera use
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectImage = File(image.path);
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CropImageScreen(imageFile: _selectImage),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

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
            children: [
              Row(
                children: [
                  BackButton(),
                  Text(
                    'Upload Photo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: _pickImageFromGallery,
                          child: DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              color: const BorderType.Color.fromARGB(
                                150,
                                37,
                                100,
                                235,
                              ),
                              strokeWidth: 2,
                              radius: const Radius.circular(16),
                              dashPattern: const [5, 3],
                            ),
                            child: Container(
                              height: height * 0.4,
                              width: width,
                              color: const BorderType.Color.fromARGB(
                                18,
                                37,
                                100,
                                235,
                              ),

                              child: _selectImage != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(12),

                                      child: Image.file(
                                        _selectImage!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cloud_upload_outlined,
                                          size: 60,
                                          color: AppColors.primary,
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Upload Image',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                text: 'Choose from Gallery',
                                onTap: () {
                                  _pickImageFromGallery();
                                },
                              ),
                            ),
                            SizedBox(width: width * 0.01),
                            Expanded(
                              child: PrimaryButton(
                                text: 'Take Photo',
                                onTap: () {
                                  _pickImageFromCamera();
                                },
                              ),
                            ),
                          ],
                        ),
                        PrimaryButton(
                          text: 'Use Sample Room',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ColorPaletteScreen(),
                              ),
                            );
                          },
                        ),

                        Text(
                          textAlign: TextAlign.center,
                          'Tips: Good lighting gives\nbetter result',
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
