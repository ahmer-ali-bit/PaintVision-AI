import 'package:flutter/material.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
      child: Row(
        children: [
          _buildStep(1, 'Schedule', 0, width),
          _buildLine(0, width),
          _buildStep(2, 'Details', 1, width),
          _buildLine(1, width),
          _buildStep(3, 'Confirm', 2, width),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String label, int stepIndex, double width) {
    final bool isActive = currentStep >= stepIndex;
    final bool isCompleted = currentStep > stepIndex;

    return Column(
      children: [
        Container(
          height: width * 0.09,
          width: width * 0.09,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: width * 0.05)
                : Text(
                    '$number',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.038,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black87 : Colors.grey[600],
            fontSize: width * 0.03,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(int stepIndex, double width) {
    final bool isActive = currentStep > stepIndex;
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.only(bottom: width * 0.05),
        color: isActive ? AppColors.primary : Colors.grey.shade300,
      ),
    );
  }
}
