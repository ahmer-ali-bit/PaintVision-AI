import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/additional%20features/recently%20viewed/recently_viewed.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  // Products to compare
  List<Map<String, dynamic>> compareProducts = [
    {
      "name": "Asian Paints Royale",
      "image": "assets/images/fryola.png",
      "price": "Rs. 3,250",
      "finish": "Premium",
      "washability": "High",
      "coverage": "120-140 sq.ft/L",
      "rating": "4.6",
    },
    {
      "name": "Berger Easy Clean",
      "image": "assets/images/fryola.png",
      "price": "Rs. 2,950",
      "finish": "Luxury",
      "washability": "Very High",
      "coverage": "110-130 sq.ft/L",
      "rating": "4.4",
    },
  ];

  // Remove product from comparison
  void _removeProduct(int index) {
    setState(() {
      compareProducts.removeAt(index);
    });
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
                  'Compare Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),

                    // Compare (N) Title
                    Text(
                      "Compare (${compareProducts.length})",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // ✅ Products Row (Images + Names + Remove)
                    Row(
                      children: [
                        // Empty space (for labels column)
                        SizedBox(width: width * 0.25),

                        // Products
                        ...List.generate(compareProducts.length, (index) {
                          return Expanded(
                            child: _buildProductHeader(
                              compareProducts[index],
                              index,
                              width,
                              height,
                            ),
                          );
                        }),
                      ],
                    ),

                    SizedBox(height: height * 0.02),

                    // ✅ Comparison Table
                    _buildComparisonRow(
                      label: "Price",
                      values: compareProducts
                          .map((p) => p["price"] as String)
                          .toList(),
                      width: width,
                      height: height,
                    ),
                    _buildDivider(),

                    _buildComparisonRow(
                      label: "Finish",
                      values: compareProducts
                          .map((p) => p["finish"] as String)
                          .toList(),
                      width: width,
                      height: height,
                    ),
                    _buildDivider(),

                    _buildComparisonRow(
                      label: "Washability",
                      values: compareProducts
                          .map((p) => p["washability"] as String)
                          .toList(),
                      width: width,
                      height: height,
                    ),
                    _buildDivider(),

                    _buildComparisonRow(
                      label: "Coverage",
                      values: compareProducts
                          .map((p) => p["coverage"] as String)
                          .toList(),
                      width: width,
                      height: height,
                    ),
                    _buildDivider(),

                    _buildComparisonRow(
                      label: "Rating",
                      values: compareProducts
                          .map((p) => p["rating"] as String)
                          .toList(),
                      width: width,
                      height: height,
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),

            // View Full Comparison Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'View Full Comparison',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecentlyViewedScreen(),
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

  // ✅ Product Header Widget (Image + Name + Remove)
  Widget _buildProductHeader(
    Map<String, dynamic> product,
    int index,
    double width,
    double height,
  ) {
    return Column(
      children: [
        // Product Image
        Container(
          width: width * 0.22,
          height: width * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.02),
          ),
          child: Image.asset(
            product["image"],
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: Icon(
                  Icons.format_paint,
                  color: Colors.white,
                  size: width * 0.09,
                ),
              );
            },
          ),
        ),

        SizedBox(height: height * 0.01),

        // Product Name
        Text(
          product["name"],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.037,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),

        SizedBox(height: height * 0.008),

        // Remove Button
        GestureDetector(
          onTap: () {
            _removeProduct(index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, size: width * 0.04, color: AppColors.primary),
              SizedBox(width: width * 0.01),
              Text(
                "Remove",
                style: TextStyle(
                  fontSize: width * 0.035,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ✅ Comparison Row Widget (Label + Values)
  Widget _buildComparisonRow({
    required String label,
    required List<String> values,
    required double width,
    required double height,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.015),
      child: Row(
        children: [
          // Label (Left)
          SizedBox(
            width: width * 0.25,
            child: Text(
              label,
              style: TextStyle(
                fontSize: width * 0.04,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Values (Right)
          ...values.map((value) {
            return Expanded(
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.038,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // ✅ Divider between rows
  Widget _buildDivider() {
    return Divider(height: 1, thickness: 0.5, color: Colors.grey.shade200);
  }
}
