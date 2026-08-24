import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/cart%20provider/cart_provider.dart';
import 'package:paint_vision_ai/providers/wishlist%20provider/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/shoping%20&%20checkouts/wishlist/carts/carts.dart';
import 'package:paint_vision_ai/shared/widgets/transparent_primary_button.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = context.watch<WishlistProvider>();
    final cartProvider = context.read<CartProvider>();

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Row(
              children: [
                const BackButton(),
                Text(
                  "WishList (${wishlistProvider.itemCount})",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Product List
            Expanded(
              child: wishlistProvider.paints.isEmpty
                  ? const Center(
                      child: Text(
                        'Your wishlist is empty',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: 8,
                      ),
                      itemCount: wishlistProvider.paints.length,
                      itemBuilder: (context, index) {
                        final paint = wishlistProvider.paints[index];
                        return _buildPaintCard(context, paint, width, index);
                      },
                    ),
            ),

            // Bottom Button
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 12, width * 0.04, 16),
              child: TransparentPrimaryButtonWidget(
                onTap: () {
                  if (wishlistProvider.paints.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Wishlist is empty')),
                    );
                    return;
                  }

                  cartProvider.addMultipleItems(wishlistProvider.paints);
                  wishlistProvider.clearWishlist();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartsScreen(),
                    ),
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

  Widget _buildPaintCard(
    BuildContext context,
    Map<String, dynamic> paint,
    double width,
    int index,
  ) {
    final wishlistProvider = context.read<WishlistProvider>();

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
          // Paint image
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
              wishlistProvider.toggleFavorite(index);
            },
            icon: Icon(
              paint["isFavorite"] ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
