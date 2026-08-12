import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/additional%20features/dealer%20locator/dealer_locator.dart';
import 'package:paint_vision_ai/widgets/transparent_primary_button.dart';

class SimilarProductsScreen extends StatefulWidget {
  const SimilarProductsScreen({super.key});

  @override
  State<SimilarProductsScreen> createState() => _SimilarProductsScreenState();
}

class _SimilarProductsScreenState extends State<SimilarProductsScreen> {
  // Similar products list
  final List<Map<String, dynamic>> similarProducts = [
    {
      "name": "Asian Paints Apex",
      "price": "Rs. 2,950",
      "image": "assets/images/fryola.png",
    },
    {
      "name": "Asian Paints Tractor",
      "price": "Rs. 2,750",
      "image": "assets/images/fryola.png",
    },
    {
      "name": "Asian Paints Ace",
      "price": "Rs. 2,650",
      "image": "assets/images/fryola.png",
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
                  'Similar Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // Products List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: similarProducts.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(
                    similarProducts[index],
                    width,
                    height,
                  );
                },
              ),
            ),

            // View All Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: TransparentPrimaryButtonWidget(
                text: 'View All',
                onTap: () {
                  // Navigate to all products screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DealerLocatorScreen(),
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

  // ✅ Product Card Widget
  Widget _buildProductCard(
    Map<String, dynamic> product,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.01),
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              width: width * 0.16,
              height: width * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.02),
              ),
              child: Image.asset(
                product["image"],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    child: Icon(
                      Icons.format_paint,
                      color: Colors.white,
                      size: width * 0.08,
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: width * 0.05),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.012),
                  Text(
                    product["price"],
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
