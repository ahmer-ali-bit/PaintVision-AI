import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20home%20visit/book_home_visit.dart';
import 'package:paint_vision_ai/providers/additional%20feature/book%20consultant%20provider/book_consultant_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class BookConsultantScreen extends StatelessWidget {
  const BookConsultantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<BookConsultantProvider>(context);

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
                  'Book Color Consultant',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // 📝 FORM
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
                          'Fill details to book an appointment',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: width * 0.035,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.025),

                      // 👤 Full Name
                      _buildLabel('Full Name', width),
                      _buildTextField(
                        controller: provider.fullNameController,
                        hint: 'Enter your name',
                        validator: provider.validateName,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),

                      // 📱 Phone Number
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

                      // 📅 Preferred Date
                      _buildLabel('Preferred Date', width),
                      GestureDetector(
                        onTap: () => provider.pickDate(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                            vertical: height * 0.018,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  provider.selectedDate == null
                                      ? 'Select date'
                                      : provider.formattedDate,
                                  style: TextStyle(
                                    color: provider.selectedDate == null
                                        ? Colors.grey[500]
                                        : Colors.black87,
                                    fontSize: width * 0.035,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.grey[600],
                                size: width * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      // 🕐 Preferred Time (Dropdown)
                      _buildLabel('Preferred Time', width),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: provider.selectedTime,
                            hint: Text(
                              'Select time',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: width * 0.035,
                              ),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: provider.timeSlots.map((time) {
                              return DropdownMenuItem<String>(
                                value: time,
                                child: Text(
                                  time,
                                  style: TextStyle(fontSize: width * 0.035),
                                ),
                              );
                            }).toList(),
                            onChanged: provider.setTime,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      // 📍 Your Location
                      _buildLabel('Your Location', width),
                      _buildTextField(
                        controller: provider.locationController,
                        hint: 'Enter your location',
                        validator: provider.validateLocation,
                        width: width,
                        height: height,
                      ),

                      SizedBox(height: height * 0.02),

                      // 📝 Additional Notes (Optional)
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
                ),
              ),
            ),

            // 💾 BOOK BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Book Appointment',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookHomeVisitScreen(),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: height * 0.015),

            // ✅ Info Badge
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: width * 0.05,
                  ),
                  SizedBox(width: width * 0.02),
                  Text(
                    'Our expert will contact you soon',
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
