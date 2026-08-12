import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/additional%20features/paint%20calculator/paint_calculator.dart';
import 'package:paint_vision_ai/screens/profile/addressess/addressess.dart';
import 'package:paint_vision_ai/screens/profile/help%20&%20support/help&support.dart';
import 'package:paint_vision_ai/screens/profile/my%20designs/my_designs.dart';
import 'package:paint_vision_ai/screens/profile/payment%20method/payment_method.dart';
import 'package:paint_vision_ai/screens/profile/setting/setting.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/carts/address/checkout/card%20payment/order%20success/my%20orders/my_orders.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/wishlist.dart';
// Add more imports as needed

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User info
  final String userName = "Kiran Fatima";
  final String userEmail = "kiran@example.com";
  final String userPhone = "+92 300 1234567";
  final String userImage = "assets/images/profile.png";

  // ✅ Menu items with SCREEN navigation
  late final List<Map<String, dynamic>> menuItems = [
    {
      "icon": Icons.shopping_bag_outlined,
      "title": "My Orders",
      "screen": const MyOrdersScreen(),
    },
    {
      "icon": Icons.home_outlined,
      "title": "My Designs",
      "screen": const MyDesignsScreen(),
    },
    {
      "icon": Icons.location_on_outlined,
      "title": "Addresses",
      "screen": const MyAddressesScreen(),
    },
    {
      "icon": Icons.credit_card_outlined,
      "title": "Payment Methods",
      "screen": const PaymentMethodsScreen(),
    },
    {
      "icon": Icons.favorite_outline,
      "title": "Wishlist",
      "screen": const WishlistScreen(),
    },
    {
      "icon": Icons.settings_outlined,
      "title": "Settings",
      "screen": const SettingsScreen(),
    },
    {
      "icon": Icons.help_outline,
      "title": "Help & Support",
      "screen": const HelpSupportScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),

              // Profile Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaintCalculatorScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: width * 0.09,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: AssetImage(userImage),
                        onBackgroundImageError: (_, __) {},
                      ),
                    ),

                    SizedBox(width: width * 0.04),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: width * 0.035,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: height * 0.003),
                          Text(
                            userPhone,
                            style: TextStyle(
                              fontSize: width * 0.035,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.03),

              // Menu List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return _buildMenuItem(menuItems[index], width, height);
                },
              ),

              SizedBox(height: height * 0.02),

              // Logout Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: GestureDetector(
                  onTap: () {
                    _showLogoutDialog();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        color: Colors.red,
                        size: width * 0.06,
                      ),
                      SizedBox(width: width * 0.04),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Menu Item Widget WITH NAVIGATION
  Widget _buildMenuItem(
    Map<String, dynamic> item,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        // ✅ NAVIGATE to the screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item["screen"] as Widget),
        );
      },
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
            Icon(item["icon"], color: Colors.black87, size: width * 0.06),

            SizedBox(width: width * 0.04),

            Expanded(
              child: Text(
                item["title"],
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

  // Logout Dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add logout logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
