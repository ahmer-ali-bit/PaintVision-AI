import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/setting%20provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke jab language change ho UI update ho
    final settingsProvider = context.watch<SettingsProvider>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Row(
              children: [
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

                    // Language Options
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: settingsProvider.languages.length,
                      itemBuilder: (context, index) {
                        final language = settingsProvider.languages[index];

                        // check karo ke ye language selected hai ya nahi
                        final bool isSelected =
                            settingsProvider.selectedLanguageCode ==
                            language["code"];

                        return _buildLanguageCard(
                          context: context,
                          language: language,
                          isSelected: isSelected,
                          width: width,
                          height: height,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Save Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Save',
                onTap: () {
                  _saveLanguage(context);
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Language Card Widget
  Widget _buildLanguageCard({
    required BuildContext context,
    required Map<String, String> language,
    required bool isSelected,
    required double width,
    required double height,
  }) {
    return GestureDetector(
      onTap: () {
        // provider ka method call karo
        context.read<SettingsProvider>().selectLanguage(language);
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

            // Custom Radio Button
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

  // Save Language Function
  void _saveLanguage(BuildContext context) {
    // current selected language ka naam lo
    final selectedName = context.read<SettingsProvider>().selectedLanguageName;

    // Snackbar dikhao
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Language changed to $selectedName"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );

    // 1 second baad wapis jao
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
