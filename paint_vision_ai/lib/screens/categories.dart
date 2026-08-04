import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Interior Paints',
      'image': 'assets/images/interior_paint.png',
      'bgColor': Color(0xFFE8DFFF),
    },
    {
      'name': 'Exterior Paints',
      'image': 'assets/images/exterior_paint.png',
      'bgColor': Color.fromARGB(255, 182, 178, 193),
    },
    {
      'name': 'Wood Paints',
      'image': 'assets/images/wood_paint.png',
      'bgColor': Color(0xFFFFE4CC),
    },
    {
      'name': 'Metal Paints',
      'image': 'assets/images/metal.png',
      'bgColor': Color(0xFFE0E0E0),
    },
    {
      'name': 'Waterproof Paints',
      'image': 'assets/images/waterproof.png',
      'bgColor': Color(0xFFD4E9FF),
    },
    {
      'name': 'Wall Primers',
      'image': 'assets/images/wall_primer.png',
      'bgColor': Color.fromARGB(255, 236, 212, 255),
    },
    {
      'name': 'Putty & Accessories',
      'image': 'assets/images/putty_accesories.png',
      'bgColor': Color.fromARGB(255, 157, 203, 195),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Categories List
              Expanded(
                child: ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      name: categories[index]['name'],
                      imagePath: categories[index]['image'],
                      bgColor: categories[index]['bgColor'],
                      onTap: () {},
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

// Reusable Category Card Widget
class CategoryCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final Color bgColor;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.bgColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            border: Border.all(width: 0.5, color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.15),
            //     blurRadius: 8,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
          child: Row(
            children: [
              // Image Container
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.format_paint, color: Colors.grey);
                  },
                ),
              ),
              SizedBox(width: 16),

              // Category Name
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Arrow Icon
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
