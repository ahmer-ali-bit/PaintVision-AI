import 'package:flutter/material.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';
import 'package:paint_vision_ai/shared/widgets/transparent_primary_button.dart';

class ColorItem {
  final String name;
  final String hex;
  final Color color;

  ColorItem(this.name, this.hex, this.color);
}

class ProductItem {
  final String name;
  final String type;
  final String size;
  final String price;
  final String image;

  ProductItem(this.name, this.type, this.size, this.price, this.image);
}

class AiRecommendationScreen extends StatefulWidget {
  const AiRecommendationScreen({super.key});

  @override
  State<AiRecommendationScreen> createState() => _AiRecommendationScreenState();
}

class _AiRecommendationScreenState extends State<AiRecommendationScreen> {
  final List<ColorItem> colors = [
    ColorItem('Mystic Purple', '#6C63FF', const Color(0xFF6C63FF)),
    ColorItem('Soft Lavender', '#BBADFF', const Color(0xFFBBADFF)),
    ColorItem('Warm Gray', '#A6A6A6', const Color(0xFFA6A6A6)),
  ];

  final List<ProductItem> products = [
    ProductItem(
      'Asian Paints Royale',
      'Premium Emulsion',
      '4L',
      'Rs. 2,350',
      'assets/images/fryola.png', // apna image path
    ),
  ];

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
              Row(
                children: [
                  BackButton(),
                  Text(
                    'AI Recommendation',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.085),
                      child: Text('Recommended for your room'),
                    ),

                    SizedBox(height: height * 0.03),

                    Container(
                      height: height * 0.2,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    Text(
                      'Recommended Colors',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: height * 0.02),

                    SizedBox(
                      width: width,
                      child: Row(
                        children: [
                          SizedBox(
                            height: height * 0.12,
                            width: width * 0.85,
                            child: GridView.builder(
                              padding: EdgeInsets.all(width * 0.02),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: width * 0.02,
                                    mainAxisSpacing: height * 0.01,
                                    childAspectRatio: 0.9,
                                  ),
                              itemCount: colors.length,
                              itemBuilder: (context, index) {
                                final item = colors[index];
                                return Column(
                                  children: [
                                    Container(
                                      height: height * 0.07,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: item.color,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.005),
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.025,
                                      ),
                                    ),
                                    Text(
                                      item.hex,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: width * 0.022,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          Spacer(),

                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: Icon(Icons.favorite_border),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    Text(
                      'Recommended Products',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: height * 0.02),

                    // 🎯 PRODUCTS LIST
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: height * 0.015),
                          padding: EdgeInsets.all(width * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Product Image
                              Container(
                                height: height * 0.09,
                                width: width * 0.18,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF6C63FF,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    product.image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: width * 0.08,
                                      );
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(width: width * 0.04),

                              // Product Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.038,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.004),
                                    Text(
                                      product.type,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: width * 0.03,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.006),
                                    Row(
                                      children: [
                                        Text(
                                          product.size,
                                          style: TextStyle(
                                            fontSize: width * 0.032,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: width * 0.03),
                                        Text(
                                          product.price,
                                          style: TextStyle(
                                            fontSize: width * 0.032,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Favorite Icon
                              Icon(
                                Icons.favorite_border,
                                color: const Color(0xFF6C63FF),
                                size: width * 0.06,
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: height * 0.03),

                    PrimaryButton(text: 'View All Products', onTap: () {}),

                    SizedBox(height: height * 0.01),

                    TransparentPrimaryButtonWidget(
                      onTap: () {},
                      text: 'Apply to My Room',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
