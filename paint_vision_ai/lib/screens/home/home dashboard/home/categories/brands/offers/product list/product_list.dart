import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/brands/offers/product%20list/product%20details/product_details.dart';
import 'package:paint_vision_ai/widgets/search_field.dart';

class ProductListScren extends StatefulWidget {
  const ProductListScren({super.key});

  @override
  State<ProductListScren> createState() => _ProductListScrenState();
}

class _ProductListScrenState extends State<ProductListScren> {
  final List<Map<String, String>> productsList = [
    {
      'image': 'assets/images/fryola.png',
      'name': 'Asian Paints Royale',
      'desText': 'Premium',
      'price': 'RS 3350',
    },

    {
      'image': 'assets/images/fryola.png',
      'name': 'Berger Easy Clean',
      'desText': 'Luxary Emulsion',
      'price': 'RS 2050',
    },
    {
      'image': 'assets/images/fryola.png',
      'name': 'Nippon Momento',
      'desText': 'Special Paints',
      'price': 'RS 4100',
    },
    {
      'image': 'assets/images/fryola.png',
      'name': 'Dulux Volvet Touch',
      'desText': 'Premium Emulsion',
      'price': 'RS 3250',
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
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(),
                SearchFieldWidget(text: 'Search products...', width: 0.65),

                Container(
                  height: height * 0.055,
                  width: width * 0.14,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.textGrey),
                  ),
                  child: Icon(Icons.replay, color: AppColors.textGrey),
                ),

                SizedBox(width: width * 0.04),
              ],
            ),

            SizedBox(
              height: height * 0.06,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_alt_outlined),
                      Text(
                        'Filter',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(),

                  Row(
                    children: [
                      Icon(Icons.sort),
                      Text(
                        'Sort',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              width: width,
              height: height * 0.755,

              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: GridView.builder(
                itemCount: productsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio:
                      1, // Square boxes (image + text ke liye behtar)
                ),
                itemBuilder: (context, index) {
                  final product = productsList[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Image.asset(product['image']!)),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    product['name']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    product['desText']!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    product['price']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: AppColors.red,
                                ),
                                Icon(
                                  Icons.favorite_border,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
