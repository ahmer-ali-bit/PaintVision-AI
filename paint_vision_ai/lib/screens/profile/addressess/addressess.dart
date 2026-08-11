import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/transparent_primary_button.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({super.key});

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  final List<Map<String, dynamic>> addresses = [
    {
      "title": "Home",
      "address": "123, Model Town, Lahore, Punjab, Pakistan",
      "phone": "+92 300 1234567",
      "isDefault": true,
    },
    {
      "title": "Office",
      "address": "456, Gulberg, Lahore, Punjab, Pakistan",
      "phone": "+92 300 1234567",
      "isDefault": false,
    },
    {
      "title": "Parents Home",
      "address": "789, DHA Phase 5, Lahore, Punjab, Pakistan",
      "phone": "+92 300 1234567",
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
            Row(
              children: const [
                BackButton(),
                Text(
                  'My Addresses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return _buildAddressCard(
                    addresses[index],
                    index,
                    width,
                    height,
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: TransparentPrimaryButtonWidget(
                text: '+ Add New Address',
                onTap: () {
                  _showAddressDialog(width, height);
                },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // ✅ Address Card with Edit + Delete Icons
  Widget _buildAddressCard(
    Map<String, dynamic> address,
    int index,
    double width,
    double height,
  ) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                Text(
                  address["address"],
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),

                SizedBox(height: height * 0.005),

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

          // ✅ Edit + Delete Icons (Column - vertical)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✏️ Edit Icon
              GestureDetector(
                onTap: () {
                  _showAddressDialog(width, height, editIndex: index);
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

              SizedBox(height: height * 0.005),

              // 🗑️ Delete Icon
              GestureDetector(
                onTap: () {
                  _showDeleteDialog(index);
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

  // ✅ Add / Edit Address Dialog
  void _showAddressDialog(double width, double height, {int? editIndex}) {
    final bool isEditing = editIndex != null;

    final titleController = TextEditingController(
      text: isEditing ? addresses[editIndex]["title"] : "",
    );
    final addressController = TextEditingController(
      text: isEditing ? addresses[editIndex]["address"] : "",
    );
    final phoneController = TextEditingController(
      text: isEditing ? addresses[editIndex]["phone"] : "",
    );
    bool isDefault = isEditing ? addresses[editIndex]["isDefault"] : false;

    showDialog(
      context: context,
      builder: (context) {
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
                          activeColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                          onChanged: (value) {
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
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
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

                    setState(() {
                      if (isDefault) {
                        for (var addr in addresses) {
                          addr["isDefault"] = false;
                        }
                      }

                      if (isEditing) {
                        addresses[editIndex] = {
                          "title": titleController.text,
                          "address": addressController.text,
                          "phone": phoneController.text,
                          "isDefault": isDefault,
                        };
                      } else {
                        addresses.add({
                          "title": titleController.text,
                          "address": addressController.text,
                          "phone": phoneController.text,
                          "isDefault": isDefault,
                        });
                      }
                    });

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEditing
                              ? "Address updated successfully"
                              : "Address added successfully",
                        ),
                        backgroundColor: Colors.green,
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

  // ✅ Delete Confirmation Dialog
  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Delete Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to delete '${addresses[index]["title"]}'?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                addresses.removeAt(index);
              });
              Navigator.pop(context);

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
