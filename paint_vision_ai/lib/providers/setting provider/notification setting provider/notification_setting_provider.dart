import 'package:flutter/material.dart';

class NotificationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  bool isEnabled;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isEnabled,
  });
}

class NotificationSettingsProvider extends ChangeNotifier {
  // 📋 Notification Items List
  final List<NotificationItem> _notifications = [
    NotificationItem(
      icon: Icons.shopping_bag_outlined,
      title: 'Order Updates',
      subtitle: 'Get notified about your orders',
      isEnabled: true,
    ),
    NotificationItem(
      icon: Icons.local_offer_outlined,
      title: 'Offers & Discounts',
      subtitle: 'Receive offers and discounts',
      isEnabled: true,
    ),
    NotificationItem(
      icon: Icons.new_releases_outlined,
      title: 'New Arrivals',
      subtitle: 'Get notified about new products',
      isEnabled: true,
    ),
    NotificationItem(
      icon: Icons.trending_down_outlined,
      title: 'Price Drop Alerts',
      subtitle: 'Get alerts on price drops',
      isEnabled: true,
    ),
    NotificationItem(
      icon: Icons.campaign_outlined,
      title: 'Promotions',
      subtitle: 'Receive promotional notifications',
      isEnabled: false,
    ),
    NotificationItem(
      icon: Icons.email_outlined,
      title: 'Email Notifications',
      subtitle: 'Receive email notifications',
      isEnabled: true,
    ),
  ];

  List<NotificationItem> get notifications => _notifications;

  // 🔄 Toggle Notification
  void toggleNotification(int index, bool value) {
    _notifications[index].isEnabled = value;
    notifyListeners();
  }

  // 💾 Save Preferences
  void savePreferences(BuildContext context) {
    // 🎯 Yahan API call ya database save logic add karo
    for (var notif in _notifications) {
      debugPrint('${notif.title}: ${notif.isEnabled}');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Preferences saved successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context);
  }
}
