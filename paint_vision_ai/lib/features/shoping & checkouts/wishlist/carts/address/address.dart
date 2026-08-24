import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/carts/address/checkout/checkout.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> addresses = [
    {"title": "Home", "address": "123, Model Town, Lahore, Punjab, Pakistan"},
    {"title": "Office", "address": "456, Gulberg, Lahore, Punjab, Pakistan"},
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
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),
            Expanded(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true, // ✅ Sirf content ki size lo
                    physics: const NeverScrollableScrollPhysics(), //
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      return _buildAddressCard(addresses[index], index);
                    },
                  ),

                  SizedBox(height: height * 0.015),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: GestureDetector(
                      onTap: () {
                        _showAddAddressDialog(width, height);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.primary,
                            size: width * 0.055,
                          ),
                          SizedBox(width: width * 0.015),
                          Text(
                            'Add New Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: width * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Checkout',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutScreen()),
                  );
                },
              ),
            ),

            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }

  // Address Card
  Widget _buildAddressCard(Map<String, String> address, int index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.01),
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(width * 0.035),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address["title"]!,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.008),
                  Text(
                    address["address"]!,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Custom Radio Button
            Container(
              height: width * 0.06,
              width: width * 0.06,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: width * 0.04)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ✅ FIX 3: Dialog function properly defined
  void _showAddAddressDialog(double width, double height) {
    final titleController = TextEditingController();
    final addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        title: Text(
          "Add New Address",
          style: TextStyle(fontSize: width * 0.045),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title (Home / Office)",
                labelStyle: TextStyle(fontSize: width * 0.035),
              ),
            ),
            SizedBox(height: height * 0.012),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Full Address",
                labelStyle: TextStyle(fontSize: width * 0.035),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: width * 0.035,
                color: AppColors.primary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  addressController.text.isNotEmpty) {
                setState(() {
                  addresses.add({
                    "title": titleController.text,
                    "address": addressController.text,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: Text(
              "Add",
              style: TextStyle(
                fontSize: width * 0.035,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
