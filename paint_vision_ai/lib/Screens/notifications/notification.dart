import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/notification%20provider/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke isRead change hone par UI update ho
    final notifProvider = context.watch<NotificationProvider>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========== HEADER ==========
            Padding(
              padding: EdgeInsets.only(right: width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back + Title
                  const Row(
                    children: [
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

                  // Mark all as read
                  GestureDetector(
                    onTap: () {
                      // check karo koi unread hai ya nahi
                      if (notifProvider.unreadCount == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "All notifications already read",
                            ),
                            backgroundColor: Colors.grey[700],
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(16),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      // provider ka method call karo
                      context.read<NotificationProvider>().markAllAsRead();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "All notifications marked as read",
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(16),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        // unread count badge
                        if (notifProvider.unreadCount > 0)
                          Container(
                            margin: EdgeInsets.only(right: width * 0.015),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${notifProvider.unreadCount}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        Text(
                          "Mark all as read",
                          style: TextStyle(
                            fontSize: width * 0.035,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.015),

            // ========== NOTIFICATIONS LIST ==========
            Expanded(
              child: notifProvider.notifications.isEmpty
                  ? const Center(
                      child: Text(
                        'No notifications',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      itemCount: notifProvider.notifications.length,
                      itemBuilder: (context, index) {
                        return _buildNotificationCard(
                          context: context,
                          notif: notifProvider.notifications[index],
                          index: index,
                          width: width,
                          height: height,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== NOTIFICATION CARD ==========
  Widget _buildNotificationCard({
    required BuildContext context,
    required Map<String, dynamic> notif,
    required int index,
    required double width,
    required double height,
  }) {
    final bool isRead = notif["isRead"] ?? false;

    return Dismissible(
      // swipe se delete karo
      key: Key(notif["title"] + index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: width * 0.05),
        margin: EdgeInsets.symmetric(vertical: height * 0.008),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      onDismissed: (direction) {
        // provider ka delete method call karo
        context.read<NotificationProvider>().deleteNotification(index);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Notification deleted"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          // single notification mark as read
          context.read<NotificationProvider>().markAsRead(index);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: height * 0.008),
          padding: EdgeInsets.all(width * 0.04),
          decoration: BoxDecoration(
            // unread ho to light blue background
            color: isRead
                ? Colors.white
                : AppColors.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(width * 0.03),
            border: Border.all(
              color: isRead
                  ? Colors.grey.shade200
                  : AppColors.primary.withValues(alpha: 0.2),
            ),
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
                    // Title + unread dot
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif["title"],
                            style: TextStyle(
                              fontSize: width * 0.043,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // unread dot
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
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
      ),
    );
  }

  // ========== TYPE ICON ==========
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
