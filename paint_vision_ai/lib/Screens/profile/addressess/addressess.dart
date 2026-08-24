import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/profile/addressess/add%20addresses/add%20address/add_address.dart';
import 'package:paint_vision_ai/Screens/profile/addressess/edit%20address/edit_address.dart';
import 'package:paint_vision_ai/providers/address%20provider/address_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/transparent_primary_button.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke list change hone par UI update ho
    final addressProvider = context.watch<AddressProvider>();

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
                  'My Addresses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ========== ADDRESS LIST ==========
            Expanded(
              child: addressProvider.addresses.isEmpty
                  ? const Center(
                      child: Text(
                        'No addresses added yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      itemCount: addressProvider.addresses.length,
                      itemBuilder: (context, index) {
                        return _buildAddressCard(
                          context: context,
                          address: addressProvider.addresses[index],
                          index: index,
                          width: width,
                          height: height,
                        );
                      },
                    ),
            ),

            // ========== ADD NEW ADDRESS BUTTON ==========
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 8, width * 0.04, 16),
              child: TransparentPrimaryButtonWidget(
                text: '+ Add New Address',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAddressScreen()),
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

  // ========== ADDRESS CARD ==========
  Widget _buildAddressCard({
    required BuildContext context,
    required Map<String, dynamic> address,
    required int index,
    required double width,
    required double height,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Address Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Default badge
                Row(
                  children: [
                    Text(
                      address["title"],
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (address["isDefault"] == true)
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.015),
                        child: Text(
                          "(Default)",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: height * 0.008),

                // Full Address
                Text(
                  address["address"],
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),

                SizedBox(height: height * 0.005),

                // Phone
                Text(
                  address["phone"],
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          // Edit + Delete Icons
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Edit Icon
              GestureDetector(
                onTap: () {
                  _showAddressDialog(
                    context: context,
                    width: width,
                    height: height,
                    editIndex: index,
                  );
                },
                child: // Edit Icon
                GestureDetector(
                  onTap: () {
                    // 👇 EditAddressScreen pe navigate karo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditAddressScreen(
                          index: index,
                          fullName: address["title"] ?? "",
                          phone: address["phone"] ?? "",
                          addressLine1:
                              address["address"] ??
                              "", // Ya split logic use karo
                          addressLine2: "",
                          city:
                              "Lahore", // Address se extract karo ya alag store karo
                          postalCode: "",
                          isDefault: address["isDefault"] ?? false,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.black87,
                      size: width * 0.055,
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.005),

              // Delete Icon
              GestureDetector(
                onTap: () {
                  _showDeleteDialog(context: context, index: index);
                },
                child: Container(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: width * 0.055,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== ADD / EDIT ADDRESS DIALOG ==========
  void _showAddressDialog({
    required BuildContext context,
    required double width,
    required double height,
    int? editIndex,
  }) {
    final addressProvider = context.read<AddressProvider>();
    final bool isEditing = editIndex != null;

    // agar editing hai to purani values lo
    final titleController = TextEditingController(
      text: isEditing ? addressProvider.addresses[editIndex]["title"] : "",
    );
    final addressController = TextEditingController(
      text: isEditing ? addressProvider.addresses[editIndex]["address"] : "",
    );
    final phoneController = TextEditingController(
      text: isEditing ? addressProvider.addresses[editIndex]["phone"] : "",
    );

    // isDefault ki value
    bool isDefault = isEditing
        ? addressProvider.addresses[editIndex]["isDefault"]
        : false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        // StatefulBuilder isliye ke dialog ke andar switch kaam kare
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text(
                isEditing ? "Edit Address" : "Add New Address",
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Field
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        hintText: "e.g. Home, Office",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    // Address Field
                    TextField(
                      controller: addressController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: "Full Address",
                        hintText: "Street, City, Country",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    // Phone Field
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintText: "+92 XXX XXXXXXX",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.01),

                    // Set as Default Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Set as Default",
                          style: TextStyle(
                            fontSize: width * 0.038,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Switch(
                          value: isDefault,
                          activeThumbColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                          onChanged: (value) {
                            // dialog ke andar switch update karo
                            setDialogState(() {
                              isDefault = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                // Cancel
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),

                // Add / Update
                ElevatedButton(
                  onPressed: () {
                    // validation
                    if (titleController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all fields"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (isEditing) {
                      // provider ka edit method call karo
                      addressProvider.editAddress(
                        index: editIndex,
                        title: titleController.text,
                        address: addressController.text,
                        phone: phoneController.text,
                        isDefault: isDefault,
                      );
                    } else {
                      // provider ka add method call karo
                      addressProvider.addAddress(
                        title: titleController.text,
                        address: addressController.text,
                        phone: phoneController.text,
                        isDefault: isDefault,
                      );
                    }

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEditing
                              ? "Address updated successfully"
                              : "Address added successfully",
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isEditing ? "Update" : "Add",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ========== DELETE DIALOG ==========
  void _showDeleteDialog({required BuildContext context, required int index}) {
    final addressProvider = context.read<AddressProvider>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Delete Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to delete"
          " '${addressProvider.addresses[index]["title"]}'?",
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
              addressProvider.deleteAddress(index);

              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Address deleted"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
