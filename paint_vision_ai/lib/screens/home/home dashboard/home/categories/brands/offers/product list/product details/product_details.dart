// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/cart/cart.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/brands/offers/product%20list/product%20details/reviews/reviews.dart';
import 'package:paint_vision_ai/widgets/rating_star%20widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========== BACK BUTTON ==========
              BackButton(),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ========== IMAGE ==========
                      SizedBox(
                        height: height * 0.3,
                        width: width,
                        child: ImageWithShadow(
                          imagePath: 'assets/images/fryola.png',
                          width: width,
                          height: height * 0.3,
                          shadowColor: Colors.black,
                          blur: 10,
                          offset: Offset(0, 4),
                        ),
                      ),

                      // SizedBox(height: height * 0.03),

                      // ========== PRODUCT DETAIL ==========
                      Text(
                        'Asian Paints Royale',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // SizedBox(height: height * 0.01),
                      Text(
                        'Premium Emulsion',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // SizedBox(height: height * 0.01),
                      ProductRating(
                        rating: 4.6,
                        reviewCount: 330,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewsScreen(),
                            ),
                          );
                        },
                      ),

                      // SizedBox(height: height * 0.02),

                      // ========== SELECT SIZE ==========
                      Text(
                        'Select Size',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // SizedBox(height: height * 0.01),
                      SizedBox(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SelectSize(text: '1L'),
                            SelectSize(text: '4L'),
                            SelectSize(text: '10L'),
                            SelectSize(text: '20L'),
                          ],
                        ),
                      ),

                      // SizedBox(height: height * 0.02),

                      // ========== SELECT SIZE ==========
                      Text(
                        'Select Color',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // SizedBox(height: height * 0.01),
                      SizedBox(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SelectColor(color: Colors.blue),
                            SelectColor(color: Colors.amber),
                            SelectColor(color: Colors.blueGrey),
                            SelectColor(color: Colors.black),
                            SelectColor(color: Colors.deepOrange),
                            SelectColor(color: Colors.red),
                            SelectColor(color: Colors.green),
                          ],
                        ),
                      ),

                      // SizedBox(height: height * 0.02),

                      // ========== BUTTONS ==========
                      SizedBox(
                        width: width,
                        child: Row(
                          children: [
                            Expanded(
                              child: ButtonWidget(
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CartScreen(),
                                    ),
                                  );
                                },
                                bgColor: AppColors.primary,
                                buttonText: 'Add to Cart',
                              ),
                            ),

                            SizedBox(width: width * 0.01),

                            Expanded(
                              child: ButtonWidget(
                                ontap: () {},
                                bgColor: AppColors.accent,
                                buttonText: 'Buy Now',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final VoidCallback ontap;
  final Color bgColor;
  String buttonText;
  ButtonWidget({
    super.key,
    required this.ontap,
    required this.bgColor,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ImageWithShadow extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Color shadowColor;
  final double blur;
  final Offset offset;

  const ImageWithShadow({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.shadowColor = Colors.black,
    this.blur = 8,
    this.offset = const Offset(0, 5),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Shadow
        Transform.translate(
          offset: offset,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                shadowColor.withValues(alpha: 0.5),
                BlendMode.srcATop,
              ),
              child: Image.asset(imagePath, width: width, height: height),
            ),
          ),
        ),

        // Image
        Image.asset(imagePath, width: width, height: height),
      ],
    );
  }
}

class SelectSize extends StatelessWidget {
  final Color? bgColor;
  String text;

  SelectSize({super.key, this.bgColor, required this.text});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.04,
      width: width * 0.15,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class SelectColor extends StatelessWidget {
  final Color color;
  const SelectColor({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.04,
      width: width * 0.08,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
