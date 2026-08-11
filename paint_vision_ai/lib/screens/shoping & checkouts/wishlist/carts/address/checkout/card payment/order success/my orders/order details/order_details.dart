import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/carts/address/checkout/card%20payment/order%20success/my%20orders/order%20details/order%20tracking/order_tracking.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  // Order info
  final String orderId = "#PV12545";
  final String orderDate = "May 14, 2025 at 10:30 AM";
  final String orderStatus = "Delivered";

  // Order items
  final List<Map<String, dynamic>> items = [
    {
      "name": "Asian Paints Royale",
      "type": "Premium Emulsion",
      "size": "4L",
      "price": "Rs. 3,250",
      "quantity": "x1",
      "image": "assets/images/fryola.png",
    },
    {
      "name": "Berger Easy Clean",
      "type": "Luxury Emulsion",
      "size": "4L",
      "price": "Rs. 2,950",
      "quantity": "x1",
      "image": "assets/images/fryola.png",
    },
    {
      "name": "Dulux Velvet Touch",
      "type": "Premium Emulsion",
      "size": "4L",
      "price": "Rs. 3,200",
      "quantity": "x1",
      "image": "assets/images/fryola.png",
    },
  ];

  // Price details
  final int subtotal = 9400;
  final int discount = 940;
  final int deliveryCharges = 200;
  final String promoCode = "WELCOME20";

  int get total => subtotal - discount + deliveryCharges;

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
            // Back button
            const BackButton(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Header (ID + Date + Status)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order $orderId",
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              orderDate,
                              style: TextStyle(
                                fontSize: width * 0.033,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        _buildStatusBadge(orderStatus, width, height),
                      ],
                    ),

                    SizedBox(height: height * 0.025),

                    // Items List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _buildItemCard(items[index], width, height);
                      },
                    ),

                    SizedBox(height: height * 0.02),

                    // Price Summary
                    _buildPriceRow(
                      label: "Subtotal",
                      value: "Rs. $subtotal",
                      width: width,
                    ),

                    SizedBox(height: height * 0.012),

                    _buildPriceRow(
                      label: "Discount ",
                      value: "- Rs. $discount",
                      width: width,
                      valueColor: Colors.green,
                      labelSuffix: "($promoCode)",
                      suffixColor: Colors.grey[700],
                    ),

                    SizedBox(height: height * 0.012),

                    _buildPriceRow(
                      label: "Delivery Charges",
                      value: "Rs. $deliveryCharges",
                      width: width,
                    ),

                    SizedBox(height: height * 0.015),

                    Divider(color: Colors.grey.shade300, thickness: 1),

                    SizedBox(height: height * 0.012),

                    // Total Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Rs. $total",
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),

            // Download Invoice Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Download Invoice',
                onTap: () {
                  _downloadInvoice();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderTrackingScreen(),
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

  // Item Card Widget
  Widget _buildItemCard(
    Map<String, dynamic> item,
    double width,
    double height,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008),
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product image
          Container(
            width: width * 0.18,
            height: width * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.02),
            ),
            child: Image.asset(
              item["image"],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: Icon(
                  Icons.format_paint,
                  color: Colors.white,
                  size: width * 0.09,
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
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.004),
                Text(
                  item["type"],
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: height * 0.006),
                Row(
                  children: [
                    Text(
                      item["size"],
                      style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      item["price"],
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quantity
          Text(
            item["quantity"],
            style: TextStyle(
              fontSize: width * 0.035,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Price Row Widget (reusable)
  Widget _buildPriceRow({
    required String label,
    required String value,
    required double width,
    Color? valueColor,
    String? labelSuffix,
    Color? suffixColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: width * 0.038, color: Colors.black87),
            ),
            if (labelSuffix != null)
              Text(
                labelSuffix,
                style: TextStyle(
                  fontSize: width * 0.038,
                  color: suffixColor ?? Colors.black87,
                ),
              ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: width * 0.038,
            color: valueColor ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Status Badge Widget
  Widget _buildStatusBadge(String status, double width, double height) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case "Delivered":
      case "Shipped":
        bgColor = Colors.green.withOpacity(0.15);
        textColor = Colors.green.shade700;
        break;
      case "Processing":
        bgColor = Colors.orange.withOpacity(0.15);
        textColor = Colors.orange.shade800;
        break;
      case "Cancelled":
        bgColor = Colors.red.withOpacity(0.15);
        textColor = Colors.red.shade700;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.15);
        textColor = Colors.grey.shade700;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.035,
        vertical: height * 0.008,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(width * 0.02),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: width * 0.032,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Download Invoice function
  void _downloadInvoice() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Invoice downloaded successfully!"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
