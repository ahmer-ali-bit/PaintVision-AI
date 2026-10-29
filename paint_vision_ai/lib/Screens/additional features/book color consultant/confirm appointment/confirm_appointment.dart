import 'package:flutter/material.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class ConfirmedAppointmentScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String location;
  final String consultant;
  final String infoMessage;

  const ConfirmedAppointmentScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.location,
    required this.consultant,
    required this.infoMessage,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.02),

            // ✅ Title
            Text(
              title,
              style: TextStyle(
                fontSize: width * 0.055,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: height * 0.008),

            // ✅ Subtitle
            Text(
              subtitle,
              style: TextStyle(
                fontSize: width * 0.035,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: height * 0.025),

            // 🏠 IMAGE WITH CHECK ICON
            SizedBox(
              width: width * 0.7,
              height: width * 0.55,
              child: Image.asset(
                "assets/images/confirm.png", // 👈 Fixed image
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.home_outlined,
                      color: AppColors.primary,
                      size: width * 0.3,
                    ),
                  );
                },
              ),
            ),

            // ✅ Check Circle
            SizedBox(height: height * 0.03),

            // 📋 DETAILS CARD
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visit Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    _buildDetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Date',
                      value: date,
                      width: width,
                    ),
                    SizedBox(height: height * 0.015),

                    _buildDetailRow(
                      icon: Icons.access_time,
                      label: 'Time',
                      value: time,
                      width: width,
                    ),
                    SizedBox(height: height * 0.015),

                    _buildDetailRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: location,
                      width: width,
                    ),
                    SizedBox(height: height * 0.015),

                    _buildDetailRow(
                      icon: Icons.person_outline,
                      label: 'Consultant',
                      value: consultant,
                      width: width,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            // ✅ Info Badge
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: width * 0.05,
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: Text(
                      infoMessage,
                      style: TextStyle(
                        fontSize: width * 0.033,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 💾 DONE BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Done',
                onTap: () {
                  // Pop until home
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),

            SizedBox(height: height * 0.01),

            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }

  // 📋 Detail Row Widget
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required double width,
  }) {
    return Row(
      children: [
        Container(
          height: width * 0.08,
          width: width * 0.08,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: width * 0.045),
        ),
        SizedBox(width: width * 0.035),
        SizedBox(
          width: width * 0.22,
          child: Text(
            label,
            style: TextStyle(
              fontSize: width * 0.035,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: width * 0.035,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
