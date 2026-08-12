import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/transparent_primary_button.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  // Payment methods list
  List<Map<String, dynamic>> paymentMethods = [
    {
      "type": "visa",
      "name": "Visa",
      "number": "**** 4242",
      "expiry": "12/26",
      "image": "assets/images/visa.png",
      "isDefault": true,
    },
    {
      "type": "mastercard",
      "name": "Mastercard",
      "number": "**** 8888",
      "expiry": "10/25",
      "image": "assets/images/mastercard.png",
      "isDefault": false,
    },
    {
      "type": "jazzcash",
      "name": "JazzCash",
      "number": "03xx-xxxxxxx",
      "expiry": "",
      "image": "assets/images/jazzcash.png",
      "isDefault": false,
    },
    {
      "type": "easypaisa",
      "name": "EasyPaisa",
      "number": "03xx-xxxxxxx",
      "expiry": "",
      "image": "assets/images/easypaisa.png",
      "isDefault": false,
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
                  'Payment Methods',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // Payment Methods List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  final method = paymentMethods[index];

                  // ✅ Default card (Visa) - different design
                  if (method["isDefault"] == true) {
                    return _buildDefaultCard(method, index, width, height);
                  }

                  // ✅ Other cards
                  return _buildPaymentCard(method, index, width, height);
                },
              ),
            ),

            // Add New Card Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: TransparentPrimaryButtonWidget(
                text: '+ Add New Card',
                onTap: () {
                  _showAddCardDialog(width, height);
                },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // ✅ Default Card Widget (Highlighted)
  Widget _buildDefaultCard(
    Map<String, dynamic> method,
    int index,
    double width,
    double height,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08), // ✅ Light blue bg
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Card name + number + check icon
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
              // Default indicator
              Icon(
                Icons.check_circle_outline,
                color: Colors.black87,
                size: width * 0.05,
              ),
            ],
          ),

          SizedBox(height: height * 0.012),

          // Bottom row: Expiry + Card logo
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

  // ✅ Regular Payment Card Widget
  Widget _buildPaymentCard(
    Map<String, dynamic> method,
    int index,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        _showCardOptions(index);
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
            // Card logo image
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

            // Middle: Name + Number/Expiry
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

            // Right arrow
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

  // ✅ Card Options Bottom Sheet (Set Default / Delete)
  void _showCardOptions(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: const Text("Set as Default"),
                onTap: () {
                  setState(() {
                    for (var m in paymentMethods) {
                      m["isDefault"] = false;
                    }
                    paymentMethods[index]["isDefault"] = true;
                  });
                  Navigator.pop(context);

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
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  "Delete Card",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteDialog(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ✅ Delete Confirmation
  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Delete Card",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("Are you sure you want to delete this payment method?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                paymentMethods.removeAt(index);
              });
              Navigator.pop(context);

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

  // ✅ Add New Card Dialog
  void _showAddCardDialog(double width, double height) {
    final nameController = TextEditingController();
    final numberController = TextEditingController();
    final expiryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Add New Card",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Card Name",
                  hintText: "Visa, Mastercard...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),
              TextField(
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Card Number (last 4 digits)",
                  hintText: "1234",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),
              TextField(
                controller: expiryController,
                decoration: InputDecoration(
                  labelText: "Expiry (MM/YY)",
                  hintText: "12/26",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty ||
                  numberController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Please fill all fields"),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
                return;
              }

              setState(() {
                paymentMethods.add({
                  "type": "card",
                  "name": nameController.text,
                  "number": "**** ${numberController.text}",
                  "expiry": expiryController.text,
                  "image": "assets/images/card.png",
                  "isDefault": false,
                });
              });

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Card added successfully"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Add", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
