import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  // Selected language index (default: English)
  int selectedIndex = 0;

  // Languages list
  final List<Map<String, String>> languages = [
    {"name": "English", "code": "en"},
    {"name": "اردو", "code": "ur"},
    {"name": "العربية", "code": "ar"},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: const [
                BackButton(),
                Text(
                  'Language',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),

                    // Section Title
                    Text(
                      "Select Language",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.025),

                    // ✅ Language Options
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        return _buildLanguageCard(
                          languages[index],
                          index,
                          width,
                          height,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ✅ Save Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Save',
                onTap: () {
                  _saveLanguage();
                },
              ),
            ),

            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }

  // ✅ Language Card Widget
  Widget _buildLanguageCard(
    Map<String, String> language,
    int index,
    double width,
    double height,
  ) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.01),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.022,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Language Name
            Expanded(
              child: Text(
                language["name"]!,
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            // ✅ Custom Radio Button
            Container(
              width: width * 0.06,
              height: width * 0.06,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: width * 0.04)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Save Language Function
  void _saveLanguage() {
    final selectedLanguage = languages[selectedIndex]["name"];

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("Language changed to $selectedLanguage"),
    //     backgroundColor: Colors.green,
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //     margin: const EdgeInsets.all(16),
    //   ),
    // );

    // Save language logic here
    // e.g., SharedPreferences, Provider, etc.

    // Optional: Go back after save
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
