import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/profile/help%20&%20support/live%20chat/live_chat.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
                  'Help & Support',
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

                    // Section 1 Title
                    Text(
                      "How can we help you?",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    // Help Topics Container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width * 0.03),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          _buildHelpItem(
                            Icons.shopping_bag_outlined,
                            "Order Issues",
                            width,
                            height,
                            () {},
                          ),
                          _buildDivider(width),
                          _buildHelpItem(
                            Icons.payment_outlined,
                            "Payment Issues",
                            width,
                            height,
                            () {},
                          ),
                          _buildDivider(width),
                          _buildHelpItem(
                            Icons.info_outline,
                            "Product Information",
                            width,
                            height,
                            () {},
                          ),
                          _buildDivider(width),
                          _buildHelpItem(
                            Icons.refresh_outlined,
                            "Return & Refund",
                            width,
                            height,
                            () {},
                          ),
                          _buildDivider(width),
                          _buildHelpItem(
                            Icons.help_outline,
                            "Other Issues",
                            width,
                            height,
                            () {},
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // Section 2 Title
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    // Contact Container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width * 0.03),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          _buildContactItem(
                            Icons.chat_bubble_outline,
                            "Live Chat",
                            "Chat with our support team",
                            width,
                            height,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LiveChatScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(width),
                          _buildContactItem(
                            Icons.email_outlined,
                            "Email Support",
                            "support@paintvision.ai",
                            width,
                            height,
                            () {},
                          ),
                          _buildDivider(width),
                          _buildContactItem(
                            Icons.phone_outlined,
                            "Call Us",
                            "+92 300 1234567",
                            width,
                            height,
                            () {},
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Help Topic Item (Simple)
  Widget _buildHelpItem(
    IconData icon,
    String title,
    double width,
    double height,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.018,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: width * 0.055),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: width * 0.04,
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

  // Contact Item (with circle icon)
  Widget _buildContactItem(
    IconData icon,
    String title,
    String subtitle,
    double width,
    double height,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015,
        ),
        child: Row(
          children: [
            // Circle icon
            Container(
              width: width * 0.11,
              height: width * 0.11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.08),
              ),
              child: Icon(icon, color: AppColors.primary, size: width * 0.055),
            ),

            SizedBox(width: width * 0.04),

            // Title + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.004),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
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

  // Divider between items
  Widget _buildDivider(double width) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: Colors.grey.shade200,
      indent: width * 0.04,
      endIndent: width * 0.04,
    );
  }
}
