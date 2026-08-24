import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/comapre%20product%20provider/compare_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/additional%20features/recently%20viewed/recently_viewed.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke product remove hone par UI update ho
    final compareProvider = context.watch<CompareProvider>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========== HEADER ==========
            const Row(
              children: [
                BackButton(),
                Text(
                  'Compare Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            // ========== SCROLLABLE CONTENT ==========
            Expanded(
              child: compareProvider.compareProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.compare_arrows,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No products to compare',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.02),

                          // Compare (N) Title
                          Text(
                            "Compare (${compareProvider.productCount})",
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: height * 0.02),

                          // ========== PRODUCTS ROW ==========
                          Row(
                            children: [
                              // Labels ke liye empty space
                              SizedBox(width: width * 0.25),

                              // Products
                              ...List.generate(
                                compareProvider.compareProducts.length,
                                (index) {
                                  return Expanded(
                                    child: _buildProductHeader(
                                      context: context,
                                      product: compareProvider
                                          .compareProducts[index],
                                      index: index,
                                      width: width,
                                      height: height,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: height * 0.02),

                          // ========== COMPARISON TABLE ==========
                          _buildComparisonRow(
                            label: "Price",
                            values: compareProvider.getValuesByKey("price"),
                            width: width,
                            height: height,
                          ),
                          _buildDivider(),

                          _buildComparisonRow(
                            label: "Finish",
                            values: compareProvider.getValuesByKey("finish"),
                            width: width,
                            height: height,
                          ),
                          _buildDivider(),

                          _buildComparisonRow(
                            label: "Washability",
                            values: compareProvider.getValuesByKey(
                              "washability",
                            ),
                            width: width,
                            height: height,
                          ),
                          _buildDivider(),

                          _buildComparisonRow(
                            label: "Coverage",
                            values: compareProvider.getValuesByKey("coverage"),
                            width: width,
                            height: height,
                          ),
                          _buildDivider(),

                          _buildComparisonRow(
                            label: "Rating",
                            values: compareProvider.getValuesByKey("rating"),
                            width: width,
                            height: height,
                          ),

                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
            ),

            // ========== VIEW FULL COMPARISON BUTTON ==========
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

  // ========== PRODUCT HEADER WIDGET ==========
  Widget _buildProductHeader({
    required BuildContext context,
    required Map<String, dynamic> product,
    required int index,
    required double width,
    required double height,
  }) {
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
            // provider ka method call karo
            context.read<CompareProvider>().removeProduct(index);
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

  // ========== COMPARISON ROW WIDGET ==========
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
          // Label
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

          // Values
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
          }),
        ],
      ),
    );
  }

  // ========== DIVIDER ==========
  Widget _buildDivider() {
    return Divider(height: 1, thickness: 0.5, color: Colors.grey.shade200);
  }
}
