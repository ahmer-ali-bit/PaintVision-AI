import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/my%20design%20provider/my_designs_provider.dart';
import 'package:paint_vision_ai/providers/save%20design%20provider/create%20design%20provider/create_design_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';

class CreateNewDesignScreen extends StatelessWidget {
  const CreateNewDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createProvider = context.watch<CreateDesignProvider>();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ========== HEADER ==========
            Padding(
              padding: EdgeInsets.only(top: height * 0.01),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(),
                  ),
                  const Column(
                    children: [
                      Text(
                        "Create New Design",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Start your new room transformation",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.025),

            // ========== SCROLLABLE CONTENT ==========
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ========== TOP IMAGE / PLACEHOLDER ==========
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: height * 0.22,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: createProvider.hasImage
                            ? Stack(
                                children: [
                                  Image.file(
                                    createProvider.selectedImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),

                                  // clear button
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<CreateDesignProvider>()
                                            .clearImage();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : _buildPlaceholder(width),
                      ),
                    ),

                    SizedBox(height: height * 0.025),

                    // ========== CHOOSE HOW TEXT ==========
                    const Text(
                      "Choose how you want to begin",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // ========== OPTION 1: TAKE PHOTO ==========
                    _buildOptionCard(
                      icon: Icons.camera_alt_outlined,
                      title: "Take Photo",
                      subtitle: "Take a new photo",
                      onTap: () async {
                        await context
                            .read<CreateDesignProvider>()
                            .pickFromCamera();
                      },
                    ),

                    SizedBox(height: height * 0.012),

                    // ========== OPTION 2: SAMPLE ROOM ==========
                    _buildOptionCard(
                      icon: Icons.dashboard_customize_outlined,
                      title: "Choose Sample Room",
                      subtitle: "Currently shows placeholder preview",
                      onTap: () {
                        context.read<CreateDesignProvider>().useSampleRoom();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Sample room placeholder selected",
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(16),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: height * 0.012),

                    // ========== OPTION 3: SELECT FROM GALLERY ==========
                    _buildOptionCard(
                      icon: Icons.image_outlined,
                      title: "Select from Gallery",
                      subtitle: "Pick from your gallery",
                      onTap: () async {
                        await context
                            .read<CreateDesignProvider>()
                            .pickFromGallery();
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ========== SAVE DESIGN BUTTON ==========
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 12, width * 0.04, 16),
              child: PrimaryButton(
                text: 'Save Design',
                onTap: () {
                  _onSaveDesign(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== PLACEHOLDER ==========
  Widget _buildPlaceholder(double width) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 60,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 10),
          Text(
            "Select an image below",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ========== OPTION CARD WIDGET ==========
  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),

            const SizedBox(width: 14),

            // Title + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[500]),
          ],
        ),
      ),
    );
  }

  // ========== SAVE DESIGN ACTION ==========
  void _onSaveDesign(BuildContext context) {
    final createProvider = context.read<CreateDesignProvider>();
    final designsProvider = context.read<MyDesignsProvider>();

    _showNameInputDialog(
      context: context,
      createProvider: createProvider,
      designsProvider: designsProvider,
    );
  }

  // ========== NAME INPUT DIALOG ==========
  void _showNameInputDialog({
    required BuildContext context,
    required CreateDesignProvider createProvider,
    required MyDesignsProvider designsProvider,
  }) {
    final TextEditingController nameController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Name Your Design",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: "e.g. Living Room Design",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    prefixIcon: const Icon(Icons.edit_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a design name";
                    }
                    if (value.trim().length < 3) {
                      return "Name must be at least 3 characters";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final designName = nameController.text.trim();

                  designsProvider.addSavedDesign(
                    name: designName,
                    date: _getTodayDate(),
                    imageFile: createProvider.selectedImage,
                  );

                  createProvider.clearImage();

                  Navigator.pop(dialogContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("\"$designName\" saved successfully!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                    ),
                  );

                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // ========== TODAY DATE ==========
  String _getTodayDate() {
    final now = DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[now.month - 1]} ${now.day}, ${now.year}";
  }
}
