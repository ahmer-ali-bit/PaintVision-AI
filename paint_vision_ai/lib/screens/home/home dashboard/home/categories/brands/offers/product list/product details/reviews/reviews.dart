import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';
import 'package:paint_vision_ai/widgets/rating_star%20widget.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  // ========== TEMPORARY DUMMY LIST ==========
  final List<Map<String, String>> reviews = [
    {
      'image': 'assets/images/user1.png',
      'name': 'Ayesha Khan',
      'review': 'Excellent quality paint,\nColors are so beautiful.',
    },
    {
      'image': 'assets/images/user2.png',
      'name': 'Usman Ali',
      'review': 'Good coverage and finish.\nHighly recommended.',
    },
    {
      'image': 'assets/images/user3.png',
      'name': 'Sara Khan',
      'review': 'Loved the product quality.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ========== TITLE ==========
            Row(
              children: [
                const BackButton(),
                const Text(
                  'Reviews (230)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ========== RATING SUMMARY ==========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Container(
                width: width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ===== LEFT SIDE =====
                    SizedBox(
                      width: width * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '4.6',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < 4.6.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.orange,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '230 reviews',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ===== RIGHT SIDE =====
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingRow(star: 5, percent: 0.70, percentText: "70%"),
                          RatingRow(star: 4, percent: 0.20, percentText: "20%"),
                          RatingRow(star: 3, percent: 0.07, percentText: "7%"),
                          RatingRow(star: 2, percent: 0.02, percentText: "2%"),
                          RatingRow(star: 1, percent: 0.01, percentText: "1%"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            // ========== REVIEWS LIST ==========
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: reviews.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: AssetImage(review['image']!),
                        ),

                        const SizedBox(width: 12),

                        // Name + Review
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                review['review']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: height * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(text: 'See All Reviews', onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
