import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/ai_feature/ai%20dashboard/upload%20image/upload_photo.dart';

class AiDashboardScreen extends StatefulWidget {
  const AiDashboardScreen({super.key});

  @override
  State<AiDashboardScreen> createState() => _AiDashboardScreenState();
}

class _AiDashboardScreenState extends State<AiDashboardScreen> {
  final List<Map<String, dynamic>> features = [
    {
      'icon': Icons.search,
      'title': 'AI Color Preview',
      'subtitle': 'Transform your space\nwith AI',
      'color': Colors.blue,
      'screen': const UploadPhotoScreen(),
    },
    {
      'icon': Icons.auto_awesome,
      'title': 'AI Recommendation',
      'subtitle': 'Get smart color ideas',
      'color': Colors.indigo,
      'screen': const UploadPhotoScreen(),
    },
    {
      'icon': Icons.calculate,
      'title': 'Paint Calculator',
      'subtitle': 'Calculate how much\npaint you need',
      'color': Colors.teal,
      'screen': const UploadPhotoScreen(),
    },
    {
      'icon': Icons.color_lens,
      'title': 'Color Matcher',
      'subtitle': 'Match any color',
      'color': Colors.green,
      'screen': const UploadPhotoScreen(),
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
                  'AI Dashboard',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ========== FEATURES LIST ==========
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: features.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = features[index];
                  return GestureDetector(
                    // ===== NAVIGATION YAHAN =====
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item['screen']),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4F8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: item['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              item['icon'],
                              color: item['color'],
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['subtitle'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
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
