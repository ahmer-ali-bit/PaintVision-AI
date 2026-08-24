import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/AI%20preview%20provider/ai_preview_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/color_palette/ai%20preview/lighting%20preview/lighting_preview.dart';

class AiPreviewScreen extends StatelessWidget {
  const AiPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke color aur favorite change hone par UI update ho
    final aiPreviewProvider = context.watch<AiPreviewProvider>();

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
                    'AI Preview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  children: [
                    // ========== BEFORE / AFTER IMAGES ==========
                    SizedBox(
                      height: height * 0.4,
                      width: width,
                      child: Row(
                        children: [
                          // Before Image
                          Expanded(
                            child: Container(
                              height: height,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: height * 0.01,
                                    left: width * 0.02,
                                    child: Container(
                                      height: height * 0.03,
                                      width: width * 0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Colors.black,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Before',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: width * 0.02),

                          // After Image
                          // selected color se After image ka
                          // background change hoga
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: aiPreviewProvider.selectedColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: height * 0.01,
                                    right: width * 0.02,
                                    child: Container(
                                      height: height * 0.03,
                                      width: width * 0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Colors.black,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'After',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // ========== COLOR PALETTE SECTION ==========
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: height * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left brand/icon
                          Container(
                            width: width * 0.11,
                            height: width * 0.11,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "5oo",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          // Color Swatches
                          Row(
                            children: List.generate(
                              aiPreviewProvider.paletteColors.length,
                              (index) {
                                final bool isSelected =
                                    aiPreviewProvider.selectedColorIndex ==
                                    index;

                                return GestureDetector(
                                  onTap: () {
                                    // provider ka method call karo
                                    context
                                        .read<AiPreviewProvider>()
                                        .selectColor(index);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: width * 0.008,
                                    ),
                                    width: width * 0.12,
                                    height: width * 0.12,
                                    decoration: BoxDecoration(
                                      color: aiPreviewProvider
                                          .paletteColors[index],
                                      borderRadius: BorderRadius.circular(12),
                                      border: isSelected
                                          ? Border.all(
                                              color: Colors.black87,
                                              width: 2,
                                            )
                                          : null,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withValues(
                                            alpha: 0.15,
                                          ),
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Favorite + Navigate Icon
                          GestureDetector(
                            onTap: () {
                              // favorite toggle karo
                              context
                                  .read<AiPreviewProvider>()
                                  .toggleFavorite();

                              // navigate karo
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LightingPreviewScreen(),
                                ),
                              );
                            },
                            child: Icon(
                              aiPreviewProvider.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: aiPreviewProvider.isFavorite
                                  ? Colors.red
                                  : Colors.grey,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // ========== SELECTED COLOR INFO ==========
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // selected color box
                          Container(
                            width: width * 0.1,
                            height: width * 0.1,
                            decoration: BoxDecoration(
                              color: aiPreviewProvider.selectedColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                          ),

                          SizedBox(width: width * 0.04),

                          // color info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selected Color",
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                // hex code dikhao
                                "#${aiPreviewProvider.selectedColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}",
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
