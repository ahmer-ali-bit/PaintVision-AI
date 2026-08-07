import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/brands/offers/product%20list/product_list.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final List<Map<String, String>> offers = [
    {
      'text': 'Buy 2 Get 1',
      'desText': 'On Emulsion',
      'offerText': '',
      'image': 'assets/images/buy.png',
    },
    {
      'text': 'Free Home Delivery',
      'desText': 'On Emulsion',
      'offerText': 'RS 5000',
      'image': 'assets/images/freedelivery.png',
    },
    {
      'text': 'Bank Discount',
      'desText': 'On Emulsion',
      'offerText': 'T&Cs apply',
      'image': 'assets/images/discount.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              BackButton(),
              // ========== OFFER CARD ==========
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Container(
                  height: height * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/offers.jpeg'),
                    ),
                  ),

                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,

                              children: [
                                Text(
                                  '20%',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(width: width * 0.01),

                                Text(
                                  'OFF',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              'On Selected Paints',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              'Limited Time Offer',
                              style: TextStyle(
                                // fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    final offer = offers[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListScren(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: height * 0.02),
                        height: height * 0.1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(24, 247, 194, 148),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: height * 0.08,
                                width: width * 0.18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color.fromARGB(
                                    44,
                                    193,
                                    161,
                                    132,
                                  ),

                                  image: DecorationImage(
                                    image: AssetImage(offer['image']!),
                                  ),
                                ),
                              ),

                              SizedBox(width: width * 0.05),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      offer['text']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(offer['desText']!),

                                    Text(offer['offerText'] ?? ''),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppColors.textGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
