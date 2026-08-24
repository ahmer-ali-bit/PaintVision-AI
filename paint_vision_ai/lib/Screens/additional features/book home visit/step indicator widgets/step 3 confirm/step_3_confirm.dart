import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/additional%20feature/home%20visit%20provider/home_visit_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';

class Step3Confirm extends StatelessWidget {
  const Step3Confirm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = context.watch<HomeVisitProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Your Booking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width * 0.045,
          ),
        ),
        SizedBox(height: height * 0.02),

        // 📋 SUMMARY CARD
        Container(
          padding: EdgeInsets.all(width * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              _buildRow(
                Icons.calendar_today_outlined,
                'Date',
                provider.formattedDate,
                width,
              ),
              const Divider(height: 24),
              _buildRow(
                Icons.access_time,
                'Time Slot',
                provider.selectedTimeSlot ?? '',
                width,
              ),
              const Divider(height: 24),
              _buildRow(
                Icons.person_outline,
                'Full Name',
                provider.fullNameController.text,
                width,
              ),
              const Divider(height: 24),
              _buildRow(
                Icons.phone_outlined,
                'Phone',
                provider.phoneController.text,
                width,
              ),
              const Divider(height: 24),
              _buildRow(
                Icons.location_on_outlined,
                'Address',
                provider.addressController.text,
                width,
              ),
              if (provider.notesController.text.isNotEmpty) ...[
                const Divider(height: 24),
                _buildRow(
                  Icons.note_outlined,
                  'Notes',
                  provider.notesController.text,
                  width,
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: height * 0.025),

        // ✅ Info Badge
        Container(
          padding: EdgeInsets.all(width * 0.035),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: width * 0.055,
              ),
              SizedBox(width: width * 0.03),
              Expanded(
                child: Text(
                  'Our expert will visit you at the scheduled time',
                  style: TextStyle(
                    fontSize: width * 0.033,
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: height * 0.02),
      ],
    );
  }

  Widget _buildRow(IconData icon, String label, String value, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: width * 0.05),
        SizedBox(width: width * 0.03),
        Text(
          '$label:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.035,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(width: width * 0.02),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: width * 0.035, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
