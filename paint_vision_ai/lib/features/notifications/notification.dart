import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Notifications list
  List<Map<String, dynamic>> notifications = [
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

  // Mark all as read
  // Mark all as read
  void _markAllAsRead() {
    setState(() {
      for (var notif in notifications) {
        notif["isRead"] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("All notifications marked as read"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating, // ✅ Floating
        shape: RoundedRectangleBorder(
          // ✅ Rounded corners
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
            // ✅ Header with Back + Title + Mark All
            Padding(
              padding: EdgeInsets.only(right: width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      BackButton(),
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _markAllAsRead,
                    child: Text(
                      "Mark all as read",
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.015),

            // ✅ Notifications List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return _buildNotificationCard(
                    notifications[index],
                    index,
                    width,
                    height,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Notification Card Widget
  Widget _buildNotificationCard(
    Map<String, dynamic> notif,
    int index,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          notifications[index]["isRead"] = true;
        });
        // Navigate to relevant screen based on type
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.008),
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: notif["isRead"] == true ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Colored Icon
            _buildTypeIcon(notif["type"], width),

            SizedBox(width: width * 0.04),

            // Middle: Title + Message + Time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif["title"],
                    style: TextStyle(
                      fontSize: width * 0.043,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.006),
                  Text(
                    notif["message"],
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[800],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: height * 0.008),
                  Text(
                    notif["time"],
                    style: TextStyle(
                      fontSize: width * 0.03,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),

            // Right: Arrow
            Icon(
              Icons.arrow_forward_ios,
              size: width * 0.04,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Type-based Colored Icon
  Widget _buildTypeIcon(String type, double width) {
    Color bgColor;
    IconData icon;

    switch (type) {
      case "success":
        bgColor = Colors.green;
        icon = Icons.check;
        break;
      case "offer":
        bgColor = Colors.orange;
        icon = Icons.local_offer_outlined;
        break;
      case "new":
        bgColor = Colors.red;
        icon = Icons.circle;
        break;
      default:
        bgColor = Colors.blue;
        icon = Icons.notifications;
    }

    return Container(
      width: width * 0.09,
      height: width * 0.09,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
      child: Icon(icon, color: Colors.white, size: width * 0.05),
    );
  }
}
