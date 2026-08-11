import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/color_palette/ai%20preview/ai_preview.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/color_palette/ai%20preview/lighting%20preview/save%20design/save_design.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class ColorPaletteScreen extends StatefulWidget {
  const ColorPaletteScreen({super.key});

  @override
  State<ColorPaletteScreen> createState() => _ColorPaletteScreenState();
}

class _ColorPaletteScreenState extends State<ColorPaletteScreen> {
  final List<Map<String, dynamic>> paintColors = [
    {'name': 'Warm White', 'color': Color(0xFFEDE6D3)},
    {'name': 'Soft Grey', 'color': Color(0xFFC5C0B0)},
    {'name': 'Sage Green', 'color': Color(0xFF9CAF88)},
    {'name': 'Ocean Blue', 'color': Color(0xFF7A9E9F)},
    {'name': 'Sand Beige', 'color': Color(0xFFD9C9A8)},
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========== TITLE ==========
            Row(
              children: [
                const BackButton(),
                const Text(
                  'Color Palette',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: height * 0.01),

            // ========== HEADING ==========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Suggested Colors',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on your room',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.02),

            // ========== COLORS LIST ==========
            Expanded(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: paintColors.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = paintColors[index];

                  return Row(
                    children: [
                      // ===== Color Box =====
                      Container(
                        width: width * 0.2,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      const SizedBox(width: 24),

                      // ===== Color Name =====
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // ========== VIEW MORE COLORS BUTTON ==========
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: 16,
              ),
              child: PrimaryButton(
                text: 'View More Colors',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AiPreviewScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
