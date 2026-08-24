import 'dart:ui' as BorderType;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/upload%20photo%20provider/upload_photo_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/crop_image.dart';
import 'package:paint_vision_ai/Screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/color_palette/color_palette.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class UploadPhotoScreen extends StatelessWidget {
  const UploadPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke image change hone par UI update ho
    final uploadProvider = context.watch<UploadPhotoProvider>();

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
              // ========== HEADER ==========
              const Row(
                children: [
                  BackButton(),
                  Text(
                    'Upload Photo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),

              // ========== CONTENT ==========
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ========== UPLOAD AREA ==========
                      InkWell(
                        onTap: () async {
                          final file = await context
                              .read<UploadPhotoProvider>()
                              .pickFromGallery();

                          if (file != null && context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CropImageScreen(imageFile: file),
                              ),
                            );
                          }
                        },
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
                            child: uploadProvider.hasImage
                                ? Stack(
                                    children: [
                                      // selected image
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(12),
                                        child: Image.file(
                                          uploadProvider.selectedImage!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),

                                      // clear button
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<UploadPhotoProvider>()
                                                .clearImage();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      const SizedBox(height: 6),
                                      Text(
                                        'Tap to choose from gallery',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      // ========== GALLERY + CAMERA BUTTONS ==========
                      Row(
                        children: [
                          // Gallery Button
                          Expanded(
                            child: PrimaryButton(
                              text: 'Choose from Gallery',
                              onTap: () async {
                                final file = await context
                                    .read<UploadPhotoProvider>()
                                    .pickFromGallery();

                                if (file != null && context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CropImageScreen(imageFile: file),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),

                          SizedBox(width: width * 0.01),

                          // Camera Button
                          Expanded(
                            child: PrimaryButton(
                              text: 'Take Photo',
                              onTap: () async {
                                final file = await context
                                    .read<UploadPhotoProvider>()
                                    .pickFromCamera();

                                if (file != null && context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CropImageScreen(imageFile: file),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      // ========== SAMPLE ROOM BUTTON ==========
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

                      // ========== TIP TEXT ==========
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
            ],
          ),
        ),
      ),
    );
  }
}
