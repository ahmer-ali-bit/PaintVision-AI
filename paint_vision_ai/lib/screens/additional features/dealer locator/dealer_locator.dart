import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/additional%20features/book%20color%20consultant/book_color_cosultant.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';
import 'package:paint_vision_ai/widgets/search_field.dart';

class DealerLocatorScreen extends StatefulWidget {
  const DealerLocatorScreen({super.key});

  @override
  State<DealerLocatorScreen> createState() => _DealerLocatorScreenState();
}

class _DealerLocatorScreenState extends State<DealerLocatorScreen> {
  final TextEditingController searchController = TextEditingController(
    text: "Lahore, Pakistan",
  );

  // Nearby stores list
  List<Map<String, dynamic>> stores = [
    {
      "name": "Brighto Paints Store",
      "address": "DHA Phase 5, Lahore",
      "distance": "2.4 km",
      "hours": "09:00 - 21:00",
      "image": "assets/images/brighto.png",
      "borderColor": Colors.green,
    },
    {
      "name": "Nippon Paints Store",
      "address": "Model Town, Lahore",
      "distance": "3.1 km",
      "hours": "10 hrs open",
      "image": "assets/images/nipponpaints.png",
      "borderColor": Colors.red,
    },
    {
      "name": "Asian Paints Store",
      "address": "Gulberg, Lahore",
      "distance": "4.2 km",
      "hours": "09:00 - 21:00",
      "image": "assets/images/asianpaints.png",
      "borderColor": Colors.green,
    },
  ];

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
                  'Dealer Locator',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.015),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Text(
                      "Find Nearby Stores",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    // ✅ Search Field with refresh icon
                    Row(
                      children: [
                        Expanded(
                          child: SearchFieldWidget(
                            controller: searchController,
                            hintText: "Search location",
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        // Refresh Icon
                        GestureDetector(
                          onTap: () {
                            // Refresh location
                          },
                          child: Container(
                            padding: EdgeInsets.all(width * 0.025),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Icon(
                              Icons.refresh,
                              color: Colors.grey[700],
                              size: width * 0.055,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.02),

                    // ✅ Stores List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: stores.length,
                      itemBuilder: (context, index) {
                        return _buildStoreCard(
                          stores[index],
                          index,
                          width,
                          height,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // View on Map Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'View on Map',
                onTap: () {
                  // Open map view
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookColorConsultantScreen(),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // ✅ Store Card Widget
  Widget _buildStoreCard(
    Map<String, dynamic> store,
    int index,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to store details
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.008),
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // Store Logo with colored border
            Container(
              width: width * 0.13,
              height: width * 0.13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: store["borderColor"], width: 1.5),
              ),
              padding: EdgeInsets.all(width * 0.015),
              child: ClipOval(
                child: Image.asset(
                  store["image"],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.store,
                      color: Colors.grey[600],
                      size: width * 0.06,
                    );
                  },
                ),
              ),
            ),

            SizedBox(width: width * 0.04),

            // Store Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store["name"],
                    style: TextStyle(
                      fontSize: width * 0.043,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    store["address"],
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    store["hours"],
                    style: TextStyle(
                      fontSize: width * 0.032,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Distance
            Text(
              store["distance"],
              style: TextStyle(
                fontSize: width * 0.038,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
