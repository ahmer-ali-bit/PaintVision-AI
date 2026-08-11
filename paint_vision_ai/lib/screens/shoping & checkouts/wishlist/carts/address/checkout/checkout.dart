import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/carts/address/checkout/card%20payment/card_payment.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPaymentIndex = 1;

  final int itemsCount = 3;
  final int itemsTotal = 9400;
  final int deliveryCharges = 200;
  final int discount = 940;
  final String promoCode = "WELCOME20";

  final List<Map<String, dynamic>> paymentMethods = [
    {"name": "Cash on Delivery", "image": "assets/images/COD.png"},
    {"name": "Credit / Debit Card", "image": "assets/images/cardpayment.png"},
    {"name": "JazzCash", "image": "assets/images/jazzcash.png"},
    {"name": "EasyPaisa", "image": "assets/images/easypaisa.png"},
    {"name": "Bank Transfer", "image": "assets/images/banktransfer.png"},
  ];

  int get total => itemsTotal + deliveryCharges - discount;

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
                const BackButton(),
                Text(
                  "Checkout",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    _buildSummaryRow(
                      label: "Items ($itemsCount)",
                      value: "Rs. $itemsTotal",
                      width: width,
                    ),

                    SizedBox(height: height * 0.015),

                    _buildSummaryRow(
                      label: "Delivery Charges",
                      value: "Rs. $deliveryCharges",
                      width: width,
                    ),

                    SizedBox(height: height * 0.015),

                    _buildSummaryRow(
                      label: "Discount ",
                      value: "- Rs. $discount",
                      width: width,
                      valueColor: Colors.green,
                      labelSuffix: "($promoCode)",
                      suffixColor: Colors.green,
                    ),

                    SizedBox(height: height * 0.02),

                    Divider(color: Colors.grey.shade300, thickness: 1),

                    SizedBox(height: height * 0.015),

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

                    SizedBox(height: height * 0.03),

                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paymentMethods.length,
                      itemBuilder: (context, index) {
                        return _buildPaymentMethod(
                          method: paymentMethods[index],
                          index: index,
                          width: width,
                          height: height,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Place Order Button
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    // _placeOrder();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardPaymentScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                  ),
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Summary Row Widget
  Widget _buildSummaryRow({
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
                  fontWeight: FontWeight.w600,
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

  Widget _buildPaymentMethod({
    required Map<String, dynamic> method,
    required int index,
    required double width,
    required double height,
  }) {
    final bool isSelected = selectedPaymentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.008),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.015,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.025),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // ✅ IMAGE instead of Icon
            Container(
              width: width * 0.1,
              height: width * 0.1,
              padding: EdgeInsets.all(width * 0.01),
              child: Image.asset(
                method["image"],
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Agar image na mile to fallback icon
                  return Icon(
                    Icons.payment,
                    color: Colors.black54,
                    size: width * 0.06,
                  );
                },
              ),
            ),

            SizedBox(width: width * 0.03),

            // Payment method name
            Expanded(
              child: Text(
                method["name"],
                style: TextStyle(fontSize: width * 0.04, color: Colors.black87),
              ),
            ),

            // Custom Radio Button
            Container(
              width: width * 0.055,
              height: width * 0.055,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: width * 0.035)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Place Order Function
  // void _placeOrder() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const Icon(Icons.check_circle, color: Colors.green, size: 70),
  //           const SizedBox(height: 15),
  //           const Text(
  //             "Order Placed Successfully!",
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             textAlign: TextAlign.center,
  //           ),
  //           const SizedBox(height: 10),
  //           Text(
  //             "Your order of Rs. $total has been placed.",
  //             style: TextStyle(fontSize: 14, color: Colors.grey[700]),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         Center(
  //           child: ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: AppColors.primary,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             child: const Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 20),
  //               child: Text(
  //                 "Continue Shopping",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
