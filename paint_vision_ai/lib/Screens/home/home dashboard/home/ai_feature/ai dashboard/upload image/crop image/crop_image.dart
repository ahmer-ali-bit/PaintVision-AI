import 'dart:io';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/crop%20image%20provider/crop_image_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/wall_detection.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class CropImageScreen extends StatefulWidget {
  final File? imageFile;
  const CropImageScreen({super.key, this.imageFile});

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.imageFile != null) {
        context.read<CropImageProvider>().setImage(widget.imageFile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cropProvider = context.watch<CropImageProvider>();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ========== HEADER ==========
            const Row(
              children: [
                BackButton(),
                Text(
                  'Crop Image',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ========== CROP AREA ==========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Container(
                height: height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: cropProvider.hasImage
                      ? Crop(
                          image: cropProvider.imageBytes!,
                          controller: cropProvider.cropController,
                          onCropped: (result) {
                            if (result is CropSuccess) {
                              context.read<CropImageProvider>().onCropped(
                                result.croppedImage,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const WallDetectionScreen(),
                                ),
                              );
                            }
                          },

                          // 4 corners white circles (dots)
                          cornerDotBuilder: (size, edgeAlignment) =>
                              const DotControl(color: Colors.white),

                          // baaqi area dark
                          baseColor: Colors.black,
                          maskColor: Colors.black.withValues(alpha: 0.5),
                        )
                      : const Center(
                          child: Text(
                            'No Image Selected',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                ),
              ),
            ),

            SizedBox(height: height * 0.03),

            // ========== RESET BUTTON ==========
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    context.read<CropImageProvider>().reset();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Crop reset"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  },
                  icon: Icon(Icons.refresh, color: AppColors.primary),
                  label: Text(
                    'Reset',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // ========== NEXT BUTTON ==========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: cropProvider.isCropping ? 'Cropping...' : 'Next',
                onTap: cropProvider.isCropping
                    ? null
                    : () {
                        if (!cropProvider.hasImage) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                "Please select an image first",
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(16),
                            ),
                          );
                          return;
                        }

                        context.read<CropImageProvider>().crop();
                      },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
