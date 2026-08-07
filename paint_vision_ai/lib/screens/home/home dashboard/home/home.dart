import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/ai_feature/ai%20dashboard/ai_dashboard.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/categories.dart';
import 'package:paint_vision_ai/widgets/search_field.dart';
import 'package:paint_vision_ai/widgets/see_all_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Interior', 'image': 'assets/images/interior_paint.png'},
    {'name': 'Exterior', 'image': 'assets/images/exterior_paint.png'},
    {'name': 'Waterproof', 'image': 'assets/images/waterproof.png'},
    {'name': 'Metal', 'image': 'assets/images/metal.png'},
    {'name': 'Wood', 'image': 'assets/images/wood_paint.png'},
    {'name': 'Wall', 'image': 'assets/images/wall_primer.png'},
    {
      'name': 'Putty & Accessories',
      'image': 'assets/images/putty_accesories.png',
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
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),
                SizedBox(
                  child: Row(
                    children: [
                      // ========== GREETING ==========
                      Text(
                        'Good Morning,',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      // ========== NAME ==========
                      Text(
                        'Kiran',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      Spacer(),

                      // ========== ICON ==========
                      Badge(
                        label: Text('2'),
                        textColor: Colors.white,
                        backgroundColor: AppColors.red,

                        child: Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                ),

                // ========== LOCATION ==========
                Text('Lahore, Pakistan'),

                SizedBox(height: height * 0.02),
                // ========== SEARCH & ICON ROW ==========
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ========== SEARCH ==========
                    SearchFieldWidget(
                      width: 0.75,
                      text: 'Search Paints, Brands, Colors',
                    ),
                    Container(
                      height: height * 0.055,
                      width: width * 0.14,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.textGrey),
                      ),
                      child: Icon(Icons.replay, color: AppColors.textGrey),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.02),

                // ========== AI COLOR PREVIEW SECTION ==========
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AiDashboardScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AI Color Preview',
                                  style: TextStyle(
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),

                                Text(
                                  'Visualize your room\nwith AI',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  height: height * 0.04,
                                  width: width * 0.2,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      61,
                                      255,
                                      255,
                                      255,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Try Now',
                                      style: TextStyle(
                                        fontSize: height * 0.015,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: SizedBox(
                            child: Image.asset(
                              fit: BoxFit.cover,
                              'assets/images/ai_color_preview.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                // ========== VIEW ALL BUTTON ==========
                SeeAllButton(
                  buttonText: 'View All',
                  desText: 'Categories',
                  navigateTo: CategoriesScreen(),
                ),

                SizedBox(height: height * 0.02),

                // ========== CATEGORIES ROW ==========
                SizedBox(
                  height: height * 0.12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // padding: EdgeInsets.symmetric(horizontal: 12),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      // final isSelected = _selectedIndex == index;
                      return GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: width * 0.17,
                          // margin: EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(8, 48, 91, 184),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(
                                  categories[index]['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 8),
                              Flexible(
                                child: Text(
                                  categories[index]['name'],
                                  style: TextStyle(fontSize: 12),
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
        ),
      ),
    );
  }
}
