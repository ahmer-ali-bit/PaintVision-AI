import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/cart%20provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/Screens/shoping%20&%20checkouts/wishlist/carts/address/address.dart';
import 'package:paint_vision_ai/shared/widgets/transparent_primary_button.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            if (!showBackButton) SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: showBackButton ? 0 : width * 0.04),
              child: Row(
                children: [
                  if (showBackButton) const BackButton(),
                  Text(
                    'My Cart (${cartProvider.itemCount} Items)',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Cart Items List
            Expanded(
              child: cartProvider.cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        return _buildCartItem(
                          cartProvider.cartItems[index],
                          index,
                          width,
                          cartProvider,
                        );
                      },
                    ),
            ),

            // Subtotal
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 8, width * 0.04, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Subtotal",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    "Rs. ${cartProvider.subtotal}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Checkout Button
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 8, width * 0.04, 16),
              child: TransparentPrimaryButtonWidget(
                onTap: () {
                  if (cartProvider.cartItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cart is empty')),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddressScreen()),
                  );
                },
                text: 'Proceed To Checkout',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(
    Map<String, dynamic> item,
    int index,
    double width,
    CartProvider cartProvider,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Container(
            width: width * 0.18,
            height: width * 0.22,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              item['image'],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
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
                  item["name"],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Rs. ${item["price"]}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 12),

                // Quantity controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => cartProvider.decrement(index),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              child: Icon(Icons.remove, size: 18),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Text(
                              "${item["quantity"]}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => cartProvider.increment(index),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              child: Icon(Icons.add, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => cartProvider.removeItem(index),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
