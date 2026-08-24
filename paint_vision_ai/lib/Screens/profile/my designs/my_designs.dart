import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/profile/my%20designs/create%20design/create_new_design.dart';
import 'package:paint_vision_ai/providers/my%20design%20provider/my_designs_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/transparent_primary_button.dart';

class MyDesignsScreen extends StatelessWidget {
  const MyDesignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final designsProvider = context.watch<MyDesignsProvider>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========== HEADER ==========
            const Row(
              children: [
                BackButton(),
                Text(
                  'My Designs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ========== TABS ==========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                children: List.generate(designsProvider.tabs.length, (index) {
                  return Expanded(
                    child: _buildTab(
                      context: context,
                      title: designsProvider.tabs[index],
                      index: index,
                      selectedTab: designsProvider.selectedTab,
                      width: width,
                      height: height,
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: height * 0.02),

            // ========== DESIGNS LIST ==========
            Expanded(
              child: designsProvider.currentDesigns.isEmpty
                  ? Center(
                      child: Text(
                        designsProvider.selectedTab == 0
                            ? 'No saved designs yet'
                            : 'No shared designs yet',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      itemCount: designsProvider.currentDesigns.length,
                      itemBuilder: (context, index) {
                        return _buildDesignCard(
                          context: context,
                          design: designsProvider.currentDesigns[index],
                          index: index,
                          width: width,
                          height: height,
                        );
                      },
                    ),
            ),

            // ========== CREATE NEW DESIGN BUTTON ==========
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 8, width * 0.04, 16),
              child: TransparentPrimaryButtonWidget(
                text: 'Create New Design',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNewDesignScreen(),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // ========== TAB WIDGET ==========
  Widget _buildTab({
    required BuildContext context,
    required String title,
    required int index,
    required int selectedTab,
    required double width,
    required double height,
  }) {
    final bool isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        context.read<MyDesignsProvider>().changeTab(index);
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: width * 0.042,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primary : Colors.grey[700],
            ),
          ),
          SizedBox(height: height * 0.008),
          Container(
            height: 3,
            width: width * 0.25,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  // ========== DESIGN CARD WIDGET ==========
  Widget _buildDesignCard({
    required BuildContext context,
    required Map<String, dynamic> design,
    required int index,
    required double width,
    required double height,
  }) {
    final bool isHighlighted = index == 0;

    final File? imageFile = design["imageFile"] is File
        ? design["imageFile"] as File
        : null;

    final String designName = (design["name"] ?? "Untitled Design").toString();
    final String designDate = (design["date"] ?? "No date").toString();

    return GestureDetector(
      onLongPress: () {
        _showDeleteDialog(context, index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.008),
        padding: EdgeInsets.all(width * 0.025),
        decoration: BoxDecoration(
          color: isHighlighted
              ? AppColors.primary.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(
            color: isHighlighted
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.grey.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ========== DESIGN IMAGE ==========
            Container(
              width: width * 0.2,
              height: width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.025),
                color: Colors.grey.shade200,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.025),
                child: imageFile != null
                    ? Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildImagePlaceholder(width);
                        },
                      )
                    : _buildImagePlaceholder(width),
              ),
            ),

            SizedBox(width: width * 0.04),

            // ========== DESIGN INFO ==========
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    designName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.006),
                  Text(
                    designDate,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // ========== DELETE ICON ==========
            IconButton(
              onPressed: () {
                _showDeleteDialog(context, index);
              },
              icon: Icon(
                Icons.delete_outline,
                color: Colors.grey[400],
                size: width * 0.055,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== IMAGE PLACEHOLDER ==========
  Widget _buildImagePlaceholder(double width) {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: Colors.grey[400],
          size: width * 0.08,
        ),
      ),
    );
  }

  // ========== DELETE DIALOG ==========
  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Delete Design",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("Are you sure you want to delete this design?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<MyDesignsProvider>().deleteDesign(index);
              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Design deleted"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
