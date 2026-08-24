import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/profile/setting/change%20password/change_password.dart';
import 'package:paint_vision_ai/Screens/profile/setting/notification%20setting/notification_setting.dart';
import 'package:paint_vision_ai/providers/setting%20provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/profile/setting/language/language.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // Settings List
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  children: [
                    // 1. Account Settings
                    _buildArrowItem(
                      icon: Icons.person_outline,
                      title: "Account Settings",
                      width: width,
                      height: height,
                      onTap: () {
                        // Navigate to Account Settings
                      },
                    ),

                    // 2. Change Password (👇 ARROW ITEM with Navigation)
                    _buildArrowItem(
                      icon: Icons.lock_outline,
                      title: "Change Password",
                      width: width,
                      height: height,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),

                    // 3. Notification Settings
                    _buildArrowItem(
                      icon: Icons.notifications_none,
                      title: "Notification Setting",
                      width: width,
                      height: height,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NotificationSettingsScreen(),
                          ),
                        );
                      },
                    ),

                    // 4. Language
                    _buildValueItem(
                      icon: Icons.language_outlined,
                      title: "Language",
                      value: settingsProvider.selectedLanguageName,
                      width: width,
                      height: height,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectLanguageScreen(),
                          ),
                        );
                      },
                    ),

                    // 5. Currency
                    _buildValueItem(
                      icon: Icons.attach_money_outlined,
                      title: "Currency",
                      value: settingsProvider.selectedCurrency,
                      width: width,
                      height: height,
                      onTap: () {
                        _showCurrencyDialog(context);
                      },
                    ),

                    // 6. Theme
                    _buildValueItem(
                      icon: Icons.color_lens_outlined,
                      title: "Theme",
                      value: settingsProvider.selectedTheme,
                      width: width,
                      height: height,
                      onTap: () {
                        _showThemeDialog(context);
                      },
                    ),

                    // 7. App Version
                    _buildInfoItem(
                      icon: Icons.info_outline,
                      title: "App Version",
                      value: settingsProvider.appVersion,
                      width: width,
                      height: height,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Arrow Item
  Widget _buildArrowItem({
    required IconData icon,
    required String title,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.006),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.018,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: width * 0.06),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: width * 0.04,
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
    );
  }

  // Value Item
  Widget _buildValueItem({
    required IconData icon,
    required String title,
    required String value,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.006),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.018,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: width * 0.06),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: width * 0.035,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(width: width * 0.02),
            Icon(
              Icons.arrow_forward_ios,
              size: width * 0.04,
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
    );
  }

  // Info Item
  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
    required double width,
    required double height,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.006),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.018,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87, size: width * 0.06),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: width * 0.04,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: width * 0.035,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Currency Dialog
  void _showCurrencyDialog(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Select Currency",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: settingsProvider.currencies.map((curr) {
              return RadioListTile<String>(
                title: Text(curr),
                value: curr,
                groupValue: settingsProvider.selectedCurrency,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  if (value != null) {
                    settingsProvider.selectCurrency(value);
                    Navigator.pop(dialogContext);
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Theme Dialog
  void _showThemeDialog(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Select Theme",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: settingsProvider.themes.map((theme) {
            return RadioListTile<String>(
              title: Text(theme),
              value: theme,
              groupValue: settingsProvider.selectedTheme,
              activeColor: AppColors.primary,
              onChanged: (value) {
                if (value != null) {
                  settingsProvider.selectTheme(value);
                  Navigator.pop(dialogContext);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
