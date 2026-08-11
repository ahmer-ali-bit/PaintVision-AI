import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Toggle states
  bool changePasswordEnabled = true;
  bool notificationsEnabled = true;

  // Selectable values
  String selectedLanguage = "English";
  String selectedCurrency = "PKR - Pakistani Rupee";
  String selectedTheme = "Light";
  final String appVersion = "1.0.0";

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
                    // ✅ 1. Account Settings (Arrow)
                    _buildArrowItem(
                      icon: Icons.person_outline,
                      title: "Account Settings",
                      width: width,
                      height: height,
                      onTap: () {
                        // Navigate to Account Settings
                      },
                    ),

                    // ✅ 2. Change Password (Switch)
                    _buildSwitchItem(
                      icon: Icons.lock_outline,
                      title: "Change Password",
                      value: changePasswordEnabled,
                      width: width,
                      height: height,
                      onChanged: (val) {
                        setState(() {
                          changePasswordEnabled = val;
                        });
                      },
                    ),

                    // ✅ 3. Notification Settings (Switch)
                    _buildSwitchItem(
                      icon: Icons.notifications_outlined,
                      title: "Notification Settings",
                      value: notificationsEnabled,
                      width: width,
                      height: height,
                      onChanged: (val) {
                        setState(() {
                          notificationsEnabled = val;
                        });
                      },
                    ),

                    // ✅ 4. Language (Value + Arrow)
                    _buildValueItem(
                      icon: Icons.language_outlined,
                      title: "Language",
                      value: selectedLanguage,
                      width: width,
                      height: height,
                      onTap: () {
                        _showLanguageDialog();
                      },
                    ),

                    // ✅ 5. Currency (Value + Arrow)
                    _buildValueItem(
                      icon: Icons.attach_money_outlined,
                      title: "Currency",
                      value: selectedCurrency,
                      width: width,
                      height: height,
                      onTap: () {
                        _showCurrencyDialog();
                      },
                    ),

                    // ✅ 6. Theme (Value + Arrow)
                    _buildValueItem(
                      icon: Icons.color_lens_outlined,
                      title: "Theme",
                      value: selectedTheme,
                      width: width,
                      height: height,
                      onTap: () {
                        _showThemeDialog();
                      },
                    ),

                    // ✅ 7. App Version (Value - No arrow)
                    _buildInfoItem(
                      icon: Icons.info_outline,
                      title: "App Version",
                      value: appVersion,
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

  // ✅ Arrow Item (like Account Settings)
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

  // ✅ Switch Item (like Change Password, Notifications)
  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required double width,
    required double height,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.006),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.008,
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
          Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // ✅ Value Item (like Language, Currency, Theme)
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

  // ✅ Info Item (like App Version - no arrow)
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

  // ✅ Language Selection Dialog
  void _showLanguageDialog() {
    final List<String> languages = [
      "English",
      "Urdu",
      "Arabic",
      "Spanish",
      "French",
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Select Language",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) {
            return RadioListTile<String>(
              title: Text(lang),
              value: lang,
              groupValue: selectedLanguage,
              activeColor: AppColors.primary,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ✅ Currency Selection Dialog
  void _showCurrencyDialog() {
    final List<String> currencies = [
      "PKR - Pakistani Rupee",
      "USD - US Dollar",
      "EUR - Euro",
      "GBP - British Pound",
      "SAR - Saudi Riyal",
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Select Currency",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: currencies.map((curr) {
              return RadioListTile<String>(
                title: Text(curr),
                value: curr,
                groupValue: selectedCurrency,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // ✅ Theme Selection Dialog
  void _showThemeDialog() {
    final List<String> themes = ["Light", "Dark", "System Default"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Select Theme",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: themes.map((theme) {
            return RadioListTile<String>(
              title: Text(theme),
              value: theme,
              groupValue: selectedTheme,
              activeColor: AppColors.primary,
              onChanged: (value) {
                setState(() {
                  selectedTheme = value!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
