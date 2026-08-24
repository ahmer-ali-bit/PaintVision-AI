import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/transparent_primary_button.dart';

class MyDesignsScreen extends StatefulWidget {
  const MyDesignsScreen({super.key});

  @override
  State<MyDesignsScreen> createState() => _MyDesignsScreenState();
}

class _MyDesignsScreenState extends State<MyDesignsScreen> {
  int selectedTab = 0;

  final List<String> tabs = ['Saved Designs', 'Shared Designs'];

  // Saved Designs list
  final List<Map<String, String>> savedDesigns = [
    {
      "name": "My Living Room Blue",
      "date": "May 12, 2025",
      "image": "assets/images/design1.png",
    },
    {
      "name": "Soft Green Room",
      "date": "May 10, 2025",
      "image": "assets/images/design2.png",
    },
    {
      "name": "Warm Beige Room",
      "date": "May 8, 2025",
      "image": "assets/images/design3.png",
    },
    {
      "name": "Modern Grey Room",
      "date": "May 6, 2025",
      "image": "assets/images/design4.png",
    },
  ];

  // Shared Designs list
  final List<Map<String, String>> sharedDesigns = [
    {
      "name": "Cozy Bedroom",
      "date": "May 5, 2025",
      "image": "assets/images/design5.png",
    },
    {
      "name": "Elegant Dining",
      "date": "May 3, 2025",
      "image": "assets/images/design6.png",
    },
  ];

  // Get current tab's designs
  List<Map<String, String>> get currentDesigns {
    return selectedTab == 0 ? savedDesigns : sharedDesigns;
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
            // Header
            Row(
              children: const [
                BackButton(),
                Text(
                  'My Designs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ✅ Tabs (Saved / Shared)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  return Expanded(
                    child: _buildTab(tabs[index], index, width, height),
                  );
                }),
              ),
            ),

            SizedBox(height: height * 0.02),

            // ✅ Designs List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: currentDesigns.length,
                itemBuilder: (context, index) {
                  return _buildDesignCard(
                    currentDesigns[index],
                    index,
                    width,
                    height,
                  );
                },
              ),
            ),

            // ✅ Create New Design Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: TransparentPrimaryButtonWidget(
                text: 'Create New Design',
                onTap: () {
                  // Navigate to create new design
                },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // ✅ Tab Widget
  Widget _buildTab(String title, int index, double width, double height) {
    final bool isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: width * 0.042,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primary : Colors.grey[700],
            ),
          ),
          SizedBox(height: height * 0.008),
          // Underline
          Container(
            height: 3,
            width: width * 0.25,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Design Card Widget
  Widget _buildDesignCard(
    Map<String, String> design,
    int index,
    double width,
    double height,
  ) {
    // First card highlighted (jaisa image mein hai)
    final bool isHighlighted = index == 0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008),
      padding: EdgeInsets.all(width * 0.025),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.primary.withOpacity(0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(
          color: isHighlighted
              ? AppColors.primary.withOpacity(0.3)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Design image
          Container(
            width: width * 0.2,
            height: width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.025),
              color: Colors.grey.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.025),
              child: Image.asset(
                design["image"]!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.grey[600],
                      size: width * 0.08,
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(width: width * 0.04),

          // Design info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  design["name"]!,
                  style: TextStyle(
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: height * 0.006),
                Text(
                  design["date"]!,
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
