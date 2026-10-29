import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20home%20visit/home%20visit/home_visit.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class BookHomeVisitScreen extends StatefulWidget {
  const BookHomeVisitScreen({super.key});

  @override
  State<BookHomeVisitScreen> createState() => _BookHomeVisitScreenState();
}

class _BookHomeVisitScreenState extends State<BookHomeVisitScreen> {
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
            // 🔙 Header
            Row(
              children: const [
                BackButton(),
                Text(
                  'Book Home Visit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            // 🎯 Content (Expanded direct child of Column - center karega)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Illustration
                      SizedBox(
                        width: width * 0.7,
                        height: width * 0.7,
                        child: Image.asset(
                          "assets/images/bookhomevisit.png",
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

                      SizedBox(height: height * 0.03),

                      // ✅ Heading
                      Text(
                        "Need Expert Advice?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.055,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      // ✅ Subheading
                      Text(
                        "Book a color consultant for\npersonalized color suggestions.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ✅ Book Now Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Book Now',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeVisitScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
