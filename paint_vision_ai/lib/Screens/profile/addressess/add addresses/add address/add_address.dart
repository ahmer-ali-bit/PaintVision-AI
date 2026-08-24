import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/address%20provider/add%20address/add_address_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<AddAddressProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔙 APP BAR
            Row(
              children: [
                const BackButton(),
                Text(
                  'Add New Address',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // 📝 FORM (Scrollable)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Enter your address details',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: width * 0.035,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.025),

                      // Full Name
                      _buildLabel('Full Name', width),
                      _buildTextField(
                        controller: provider.fullNameController,
                        hint: 'Enter full name',
                        validator: provider.validateName,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),

                      // Phone Number
                      _buildLabel('Phone Number', width),
                      _buildTextField(
                        controller: provider.phoneController,
                        hint: 'Enter phone number',
                        validator: provider.validatePhone,
                        keyboardType: TextInputType.phone,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),

                      // Address Line 1
                      _buildLabel('Address Line 1', width),
                      _buildTextField(
                        controller: provider.addressLine1Controller,
                        hint: 'House no., Street, Area',
                        validator: provider.validateAddress,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),

                      // Address Line 2 (Optional)
                      _buildLabel('Address Line 2 (Optional)', width),
                      _buildTextField(
                        controller: provider.addressLine2Controller,
                        hint: 'Apartment, Floor, etc.',
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),

                      // City Dropdown
                      _buildLabel('City', width),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: provider.selectedCity,
                            hint: Text(
                              'Select city',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: width * 0.035,
                              ),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: provider.cities.map((city) {
                              return DropdownMenuItem<String>(
                                value: city,
                                child: Text(city),
                              );
                            }).toList(),
                            onChanged: provider.setCity,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      // Postal Code
                      _buildLabel('Postal Code', width),
                      _buildTextField(
                        controller: provider.postalCodeController,
                        hint: 'Enter postal code',
                        validator: provider.validatePostalCode,
                        keyboardType: TextInputType.number,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.025),

                      // Set as Default Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Set as Default Address',
                            style: TextStyle(
                              fontSize: width * 0.038,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: provider.isDefault,
                            onChanged: provider.toggleDefault,
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFF2563EB),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
            ),

            // 💾 SAVE BUTTON (Fixed at Bottom)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Save Address',
                onTap: () => provider.saveAddress(context),
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // 🏷️ Label Widget
  Widget _buildLabel(String label, double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.035),
      ),
    );
  }

  // 📝 TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required double width,
    required double height,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: width * 0.035),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: width * 0.035),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.018,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
