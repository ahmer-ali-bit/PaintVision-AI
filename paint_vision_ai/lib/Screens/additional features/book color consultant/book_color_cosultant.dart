import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20color%20consultant/book%20consultant/book_consultant.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class BookColorConsultantScreen extends StatefulWidget {
  const BookColorConsultantScreen({super.key});

  @override
  State<BookColorConsultantScreen> createState() =>
      _BookColorConsultantScreenState();
}

class _BookColorConsultantScreenState extends State<BookColorConsultantScreen> {
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
                  'Book Color Consultant',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Consultant Illustration
                      SizedBox(
                        width: width * 0.7,
                        height: width * 0.7,
                        child: Image.asset(
                          "assets/images/bookcolorconsultant.png",
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.person_outline,
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
                      builder: (context) => const BookConsultantScreen(),
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
