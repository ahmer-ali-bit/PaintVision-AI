import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  // ================= NOTIFICATIONS LIST =================
  final List<Map<String, dynamic>> _notifications = [
    {
      "title": "Order Delivered",
      "message": "Your order #PV12545 has been delivered successfully.",
      "time": "2 min ago",
      "type": "success",
      "isRead": false,
    },
    {
      "title": "Offer Alert",
      "message": "20% OFF on Asian Paints Royale Series",
      "time": "1 hour ago",
      "type": "offer",
      "isRead": false,
    },
    {
      "title": "New Colors Added",
      "message": "Check out new trendy colors in our palette.",
      "time": "3 hours ago",
      "type": "new",
      "isRead": false,
    },
    {
      "title": "Price Drop",
      "message": "Your favorite product price dropped!",
      "time": "1 day ago",
      "type": "success",
      "isRead": false,
    },
  ];

  // ================= GETTERS =================
  List<Map<String, dynamic>> get notifications => _notifications;

  int get totalNotifications => _notifications.length;

  // unread notifications count
  int get unreadCount {
    return _notifications.where((notif) => notif["isRead"] == false).length;
  }

  // ================= MARK SINGLE AS READ =================
  void markAsRead(int index) {
    _notifications[index]["isRead"] = true;
    notifyListeners();
  }

  // ================= MARK ALL AS READ =================
  void markAllAsRead() {
    for (var notif in _notifications) {
      notif["isRead"] = true;
    }
    notifyListeners();
  }

  // ================= DELETE NOTIFICATION =================
  void deleteNotification(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }

  // ================= CLEAR ALL NOTIFICATIONS =================
  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }
}
