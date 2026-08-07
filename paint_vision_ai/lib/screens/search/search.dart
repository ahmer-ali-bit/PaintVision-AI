import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [
    'Interior Paint',
    'Asian Paints',
    'Royal Blue',
    'Waterproof Paint',
  ];

  List<String> popularSearches = [
    'Blue',
    'White',
    'Grey',
    'Interior',
    'Exterior',
    'Wood',
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
            padding: EdgeInsetsGeometry.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),

                SearchFieldWidget(text: 'Search Paints, Brands, Colors'),

                SizedBox(height: height * 0.03),

                Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.02,
                  ),
                ),

                SizedBox(height: height * 0.01),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        Divider(height: 1, color: Colors.grey[200]),
                    itemCount: recentSearches.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          recentSearches[index],
                          style: TextStyle(fontSize: 15),
                        ),

                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                        onTap: () {},
                      );
                    },
                  ),
                ),

                SizedBox(height: height * 0.03),

                Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.02,
                  ),
                ),

                SizedBox(height: height * 0.03),

                Wrap(
                  spacing: 10, // Horizontal space between chips
                  runSpacing: 10, // Vertical space between rows
                  children: popularSearches.map((search) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = search;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          search,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
