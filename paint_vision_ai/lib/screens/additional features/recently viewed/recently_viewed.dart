import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/additional%20features/similar%20product/similar_product.dart';
import 'package:paint_vision_ai/widgets/transparent_primary_button.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  // ✅ Products list with matched image paths
  List<Map<String, dynamic>> products = [
    {
      "name": "Asian Paints Royale",
      "price": "Rs. 3,250",
      "image": "assets/images/fryola.png",
    },
    {
      "name": "Dulux Velvet Touch",
      "price": "Rs. 3,200",
      "image": "assets/images/fryola.png",
    },
    {
      "name": "Nippon Momento",
      "price": "Rs. 4,100",
      "image": "assets/images/fryola.png",
    },
    {
      "name": "Berger Silk Glamart",
      "price": "Rs. 2,800",
      "image": "assets/images/fryola.png",
    },
  ];

  // Clear all products
  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Clear All",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to clear all recently viewed items?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                products.clear();
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("All items cleared"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Clear", style: TextStyle(color: Colors.white)),
          ),
        ],
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
            // Header
            Row(
              children: const [
                BackButton(),
                Text(
                  'Recently Viewed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ✅ Products List
            Expanded(
              child: products.isEmpty
                  ? _buildEmptyState(width, height)
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return _buildProductCard(
                          products[index],
                          index,
                          width,
                          height,
                        );
                      },
                    ),
            ),

            // ✅ Clear All Button
            if (products.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: TransparentPrimaryButtonWidget(
                  text: 'Clear All',
                  onTap: _clearAll,
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
    int index,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SimilarProductsScreen()),
        );
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

            SizedBox(width: width * 0.04),

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
                  SizedBox(height: height * 0.008),
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

  // ✅ Empty State Widget
  Widget _buildEmptyState(double width, double height) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: width * 0.2, color: Colors.grey[400]),
          SizedBox(height: height * 0.02),
          Text(
            "No recently viewed items",
            style: TextStyle(
              fontSize: width * 0.045,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Products you view will appear here",
            style: TextStyle(fontSize: width * 0.035, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
