import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // Tracking steps list
  final List<Map<String, String>> trackingSteps = [
    {"title": "Order Placed", "time": "May 14, 10:30 AM"},
    {"title": "Confirmed", "time": "May 14, 11:15 AM"},
    {"title": "Packed", "time": "May 14, 02:00 PM"},
    {"title": "Shipped", "time": "May 15, 09:30 AM"},
    {"title": "Out for Delivery", "time": "May 15, 11:30 AM"},
    {"title": "Delivered", "time": "May 15, 02:30 PM"},
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(),
                  Text(
                    'Order Tracking',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

              // TimeLine List
              Expanded(
                child: ListView.builder(
                  itemCount: trackingSteps.length,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  itemBuilder: (context, index) {
                    return _buildTimelineStep(
                      step: trackingSteps[index],

                      height: height,
                      width: width,
                      index: index,
                      isLast: index == trackingSteps.length - 1,
                    );
                  },
                ),
              ),

              // Live Location Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: PrimaryButton(text: 'Live Location', onTap: () {}),
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required Map<String, String> step,
    required int index,
    required bool isLast,
    required double width,
    required double height,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: height * 0.07,
                width: width * 0.07,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade600,
                ),

                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: width * 0.045,
                ),
              ),

              if (!isLast)
                Expanded(
                  child: Container(width: 3, color: Colors.green.shade600),
                ),
            ],
          ),

          SizedBox(width: width * 0.04),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: height * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step["title"]!,
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    step["time"]!,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
