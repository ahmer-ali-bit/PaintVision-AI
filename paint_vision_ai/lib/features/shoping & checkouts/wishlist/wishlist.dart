import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/carts/carts.dart';
import 'package:paint_vision_ai/widgets/transparent_primary_button.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Map<String, dynamic>> paints = [
    {
      "name": "Asian Paints Royale",
      "type": "Premium Emulsion",
      "price": "Rs. 3,250",
      "image": "assets/images/fryola.png",
      "isFavorite": true,
    },
    {
      "name": "Berger Easy Clean",
      "type": "Luxary Emulsion",
      "price": "Rs. 2,950",
      "image": "assets/images/fryola.png",
      "isFavorite": true,
    },
    {
      "name": "Dulux Velvot Touch",
      "type": "Premium Emulsion",
      "price": "Rs. 3,200",
      "image": "assets/images/fryola.png",
      "isFavorite": true,
    },
    {
      "name": "Nippon Momento",
      "type": "Premium Emulsion",
      "price": "Rs. 4,100",
      "image": "assets/images/fryola.png",
      "isFavorite": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Row(
              children: const [
                BackButton(),
                Text(
                  "WishList",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // Product List (Expanded taake bacha space le le)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: 8,
                ),
                itemCount: paints.length,
                itemBuilder: (context, index) {
                  final paint = paints[index];
                  return _buildPaintCard(paint, width, index);
                },
              ),
            ),

            // Bottom Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: 12,
              ),
              child: TransparentPrimaryButtonWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartsScreen()),
                  );
                },
                text: 'Move All To Cart',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Paint Card Widget
  Widget _buildPaintCard(Map<String, dynamic> paint, double width, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Paint bucket image
          Container(
            width: width * 0.18,
            height: width * 0.22,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              paint["image"],
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.format_paint,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),

          SizedBox(width: width * 0.04),

          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paint["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  paint["type"],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 6),
                Text(
                  paint["price"],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Favorite icon
          IconButton(
            onPressed: () {
              setState(() {
                paints[index]["isFavorite"] = !paints[index]["isFavorite"];
              });
            },
            icon: Icon(
              paints[index]["isFavorite"]
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
