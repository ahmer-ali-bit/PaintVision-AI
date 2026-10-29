import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/setting%20provider/notification%20setting%20provider/notification_setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final provider = context.watch<NotificationSettingsProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔙 HEADER
            Row(
              children: [
                const BackButton(),
                Text(
                  'Notification Settings',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Center(
              child: Text(
                'Manage your notification preferences',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: width * 0.035,
                ),
              ),
            ),

            SizedBox(height: height * 0.025),

            // 📋 NOTIFICATION LIST
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: provider.notifications.length,
                itemBuilder: (context, index) {
                  final item = provider.notifications[index];
                  return _buildNotificationItem(
                    item: item,
                    index: index,
                    width: width,
                    height: height,
                    onChanged: (value) {
                      provider.toggleNotification(index, value);
                    },
                  );
                },
              ),
            ),

            // 💾 SAVE BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Save Preferences',
                onTap: () => provider.savePreferences(context),
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // 🔔 Notification Item Widget
  Widget _buildNotificationItem({
    required NotificationItem item,
    required int index,
    required double width,
    required double height,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008),
      padding: EdgeInsets.all(width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // 🎯 Icon Container
          Container(
            height: width * 0.11,
            width: width * 0.11,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(width * 0.025),
            ),
            child: Icon(
              item.icon,
              color: AppColors.primary,
              size: width * 0.055,
            ),
          ),

          SizedBox(width: width * 0.035),

          // 📝 Title + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: width * 0.03,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // 🔄 Switch
          Switch(
            value: item.isEnabled,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
