import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/main.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/brands/offers/offers.dart';
import 'package:paint_vision_ai/widgets/see_all_button.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final List<Map<String, String>> topBrands = [
    {'name': 'Asian Paints', 'image': 'assets/images/asianpaints.png'},
    {'name': 'Berger', 'image': 'assets/images/berger.png'},
    {'name': 'Brighto', 'image': 'assets/images/brighto.png'},
    {'name': 'Color Wave Paint', 'image': 'assets/images/colorswave.png'},
    {'name': 'Master Paints', 'image': 'assets/images/masterpaints.png'},
    {'name': 'Dulux', 'image': 'assets/images/dulux.png'},
    {'name': 'Nippon Paints', 'image': 'assets/images/nipponpaints.png'},
    {'name': 'Color Max', 'image': 'assets/images/colormax.png'},
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
              children: [
                BackButton(),
                Expanded(
                  child: SeeAllButton(
                    buttonText: 'See All',
                    desText: 'Top Brands',
                    fontsize: 20,
                    navigateTo: MyApp(),
                  ),
                ),
                SizedBox(width: width * 0.02),
              ],
            ),

            // ========== GRID ==========

            // Grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: GridView.builder(
                  itemCount: topBrands.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio:
                        1.3, // Square boxes (image + text ke liye behtar)
                  ),
                  itemBuilder: (context, index) {
                    final brand = topBrands[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OffersScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ========== IMAGE SECTION ==========
                            Expanded(
                              flex: 3, // Image ko zyada space
                              child:
                                  brand['image'] != null &&
                                      brand['image']!.isNotEmpty
                                  ? Image.asset(
                                      brand['image']!,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        // Agar image nahi mile to icon dikhega
                                        return Icon(
                                          Icons.image_not_supported,
                                          size: 40,
                                          color: Colors.grey,
                                        );
                                      },
                                    )
                                  : Icon(
                                      Icons.broken_image,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                            ),

                            SizedBox(height: 8),

                            // ========== TEXT SECTION ==========
                            Expanded(
                              flex: 1, // Text ko kam space
                              child: Text(
                                brand['name']!,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
