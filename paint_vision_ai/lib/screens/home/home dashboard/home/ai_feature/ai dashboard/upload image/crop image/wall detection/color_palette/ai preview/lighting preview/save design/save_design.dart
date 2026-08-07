import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';
import 'package:paint_vision_ai/widgets/text_form_field.dart';

class SaveDesignScreen extends StatefulWidget {
  const SaveDesignScreen({super.key});

  @override
  State<SaveDesignScreen> createState() => _SaveDesignScreenState();
}

class _SaveDesignScreenState extends State<SaveDesignScreen> {
  final TextEditingController designNameController = TextEditingController();

  String? selectedFolder; // null = blank
  final List<String> folders = []; // Empty list

  @override
  void dispose() {
    designNameController.dispose();
    super.dispose();
  }

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
            // ========== TITLE WITH BACK BUTTON ==========
            Row(
              children: [
                const BackButton(),
                const Text(
                  'Save Design',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ========== MAIN CONTENT ==========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Heading =====
                  const Text(
                    'Save Your Design',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: height * 0.03),

                  // ===== Design Name Label =====
                  Text(
                    'Design Name',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ===== Design Name TextField =====
                  CTextFormField(
                    hintText: 'My Living Room Blue',
                    controller: designNameController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    isValid: designNameController.text.length >= 3,
                  ),

                  SizedBox(height: height * 0.025),

                  // ===== Save to Label =====
                  Text(
                    'Save to',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ===== Custom Dropdown (Opens Downward) =====
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedFolder ?? '', // Blank if null
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textGrey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.04),

                  // ===== Save Design Button =====
                  PrimaryButton(text: 'Save Design', onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
