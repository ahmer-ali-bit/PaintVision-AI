import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:paint_vision_ai/providers/home%20dashboard%20provider/AI%20color%20preview%20provider/Color%20matcher%20provider/color_matcher_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class ColorMatcherScreen extends StatelessWidget {
  const ColorMatcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ColorMatcherProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BackButton(),

                Text(
                  'Color Matcher',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.01),

            Center(
              child: Text(
                'Find the perfect match for any color',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: width * 0.035,
                ),
              ),
            ),

            Center(
              child: SizedBox(
                height: height * 0.26,
                width: width * 0.65,
                child: ColorPicker(
                  pickerColor: provider.selectedColor,
                  onColorChanged: (Color color) {
                    provider.changeColor(color);
                  },
                  colorPickerWidth: width * 0.4,
                  pickerAreaHeightPercent: 0.9,
                  enableAlpha: false,
                  displayThumbColor: true,
                  paletteType: PaletteType.hueWheel,
                  labelTypes: const [],
                  pickerAreaBorderRadius: BorderRadius.circular(300),
                  hexInputBar: false,
                ),
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.008,
                ),
                decoration: BoxDecoration(
                  color: provider.selectedColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  provider.hexCode,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.03),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Text(
                'Choose your input method',
                style: TextStyle(
                  fontSize: width * 0.035,
                  color: Colors.grey[700],
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.methods.length,
                itemBuilder: (context, index) {
                  final method = provider.methods[index];
                  return GestureDetector(
                    onTap: () => provider.onMethodTap(context, index),
                    child: Container(
                      margin: EdgeInsets.only(bottom: height * 0.015),
                      padding: EdgeInsets.all(width * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: width * 0.12,
                            width: width * 0.12,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF6C63FF,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              method.icon,
                              color: const Color(0xFF6C63FF),
                              size: width * 0.06,
                            ),
                          ),
                          SizedBox(width: width * 0.04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.04,
                                  ),
                                ),
                                SizedBox(height: height * 0.004),
                                Text(
                                  method.subtitle,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: width * 0.032,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: width * 0.04,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: height * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Find Matching Colors',
                onTap: () {
                  provider.findMatchingColors();
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
