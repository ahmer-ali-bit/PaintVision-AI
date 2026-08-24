import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/additional%20feature/home%20visit%20provider/home_visit_provider.dart';
import 'package:provider/provider.dart';

class Step2Details extends StatelessWidget {
  const Step2Details({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = context.watch<HomeVisitProvider>();

    return Form(
      key: provider.detailsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Full Name', width),
          _buildTextField(
            controller: provider.fullNameController,
            hint: 'Enter your name',
            validator: provider.validateName,
            width: width,
            height: height,
          ),
          SizedBox(height: height * 0.02),

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

          _buildLabel('Address', width),
          _buildTextField(
            controller: provider.addressController,
            hint: 'Enter your full address',
            validator: provider.validateAddress,
            width: width,
            height: height,
            maxLines: 2,
          ),
          SizedBox(height: height * 0.02),

          _buildLabel('Additional Notes (Optional)', width),
          _buildTextField(
            controller: provider.notesController,
            hint: 'Any specific requirements?',
            width: width,
            height: height,
            maxLines: 3,
          ),
          SizedBox(height: height * 0.03),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.035),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required double width,
    required double height,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
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
      ),
    );
  }
}
