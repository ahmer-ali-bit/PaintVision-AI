import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/profile/payment%20method/add%20card/add_card.dart';
import 'package:paint_vision_ai/providers/payment%20provider/payment_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/transparent_primary_button.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke list change hone par UI update ho
    final paymentProvider = context.watch<PaymentProvider>();

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
                  'Payment Methods',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ========== PAYMENT METHODS LIST ==========
            Expanded(
              child: paymentProvider.paymentMethods.isEmpty
                  ? const Center(
                      child: Text(
                        'No payment methods added',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      itemCount: paymentProvider.paymentMethods.length,
                      itemBuilder: (context, index) {
                        final method = paymentProvider.paymentMethods[index];

                        // default card alag design
                        if (method["isDefault"] == true) {
                          return _buildDefaultCard(
                            context,
                            method,
                            index,
                            width,
                            height,
                          );
                        }

                        // baaki cards
                        return _buildPaymentCard(
                          context,
                          method,
                          index,
                          width,
                          height,
                        );
                      },
                    ),
            ),

            // ========== ADD NEW CARD BUTTON ==========
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 8, width * 0.04, 16),
              child: TransparentPrimaryButtonWidget(
                text: '+ Add New Card',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCardScreen()),
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

  // ========== DEFAULT CARD WIDGET ==========
  Widget _buildDefaultCard(
    BuildContext context,
    Map<String, dynamic> method,
    int index,
    double width,
    double height,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            children: [
              Text(
                method["name"],
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: width * 0.02),
              Text(
                method["number"],
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle_outline,
                color: Colors.black87,
                size: width * 0.05,
              ),
            ],
          ),

          SizedBox(height: height * 0.012),

          // Bottom row
          Row(
            children: [
              Text(
                method["expiry"],
                style: TextStyle(
                  fontSize: width * 0.038,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: width * 0.12,
                height: height * 0.03,
                child: Image.asset(
                  method["image"],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      "VISA",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        fontStyle: FontStyle.italic,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== REGULAR PAYMENT CARD WIDGET ==========
  Widget _buildPaymentCard(
    BuildContext context,
    Map<String, dynamic> method,
    int index,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        _showCardOptions(context, index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.008),
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // Card logo
            SizedBox(
              width: width * 0.1,
              height: width * 0.1,
              child: Image.asset(
                method["image"],
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.payment,
                    color: Colors.grey[600],
                    size: width * 0.06,
                  );
                },
              ),
            ),

            SizedBox(width: width * 0.04),

            // Name + Number
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${method["name"]} ${method["number"]}",
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    method["expiry"].isNotEmpty
                        ? method["expiry"]
                        : method["number"],
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              size: width * 0.04,
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
    );
  }

  // ========== CARD OPTIONS BOTTOM SHEET ==========
  void _showCardOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Set as Default
              ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: const Text("Set as Default"),
                onTap: () {
                  // provider ka method call karo
                  context.read<PaymentProvider>().setDefault(index);

                  Navigator.pop(bottomSheetContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Set as default payment method"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                },
              ),

              // Delete Card
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  "Delete Card",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _showDeleteDialog(context, index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ========== DELETE CONFIRMATION DIALOG ==========
  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Delete Card",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to delete this payment method?",
        ),
        actions: [
          // Cancel
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),

          // Delete
          ElevatedButton(
            onPressed: () {
              // provider ka method call karo
              context.read<PaymentProvider>().deleteMethod(index);

              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Payment method deleted"),
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
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ========== ADD NEW CARD DIALOG ==========
}
