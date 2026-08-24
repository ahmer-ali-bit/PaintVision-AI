import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/my%20design%20provider/my_designs_provider.dart';
import 'package:paint_vision_ai/providers/save%20design%20provider/save_design_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';
import 'package:paint_vision_ai/shared/widgets/primary_button.dart';
import 'package:paint_vision_ai/shared/widgets/text_form_field.dart';

class SaveDesignScreen extends StatelessWidget {
  const SaveDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke name change hone par UI update ho
    final saveProvider = context.watch<SaveDesignProvider>();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                  'Save Design',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // ========== MAIN CONTENT ==========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  const Text(
                    'Save Your Design',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: height * 0.03),

                  // ========== DESIGN NAME LABEL ==========
                  Text(
                    'Design Name',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ========== DESIGN NAME TEXTFIELD ==========
                  CTextFormField(
                    hintText: 'My Living Room Blue',
                    controller: saveProvider.designNameController,
                    onChanged: (value) {
                      // provider ko batao name change hua
                      context.read<SaveDesignProvider>().onNameChanged(value);
                    },
                    isValid: saveProvider.isNameValid,
                  ),

                  SizedBox(height: height * 0.025),

                  // ========== SAVE TO LABEL ==========
                  Text(
                    'Save to',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ========== FOLDER DROPDOWN ==========
                  GestureDetector(
                    onTap: () {
                      _showFolderOptions(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              saveProvider.selectedFolder ?? '',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textGrey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.04),

                  // ========== SAVE DESIGN BUTTON ==========
                  PrimaryButton(
                    text: 'Save Design',
                    onTap: () {
                      _onSaveDesign(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== FOLDER OPTIONS BOTTOM SHEET ==========
  void _showFolderOptions(BuildContext context) {
    final saveProvider = context.read<SaveDesignProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                "Select Folder",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Agar folders empty hain
              if (saveProvider.folders.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "No folders yet. Create one below.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

              // Folder List
              ...saveProvider.folders.map((folder) {
                return ListTile(
                  leading: const Icon(Icons.folder_outlined),
                  title: Text(folder),
                  trailing: saveProvider.selectedFolder == folder
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    context.read<SaveDesignProvider>().selectFolder(folder);
                    Navigator.pop(bottomSheetContext);
                  },
                );
              }),

              const Divider(),

              // Add New Folder
              ListTile(
                leading: Icon(
                  Icons.create_new_folder_outlined,
                  color: AppColors.primary,
                ),
                title: Text(
                  "Create New Folder",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _showCreateFolderDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ========== CREATE FOLDER DIALOG ==========
  void _showCreateFolderDialog(BuildContext context) {
    final folderController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Create New Folder",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: folderController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "e.g. Bedroom, Living Room",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          // Cancel
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),

          // Create
          ElevatedButton(
            onPressed: () {
              if (folderController.text.trim().isEmpty) {
                return;
              }

              // provider mein folder add karo
              context.read<SaveDesignProvider>().addFolder(
                folderController.text,
              );

              // naya folder automatically select karo
              context.read<SaveDesignProvider>().selectFolder(
                folderController.text.trim(),
              );

              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Folder '${folderController.text}' created"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Create", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ========== SAVE DESIGN LOGIC ==========
  void _onSaveDesign(BuildContext context) {
    final saveProvider = context.read<SaveDesignProvider>();
    final designsProvider = context.read<MyDesignsProvider>();

    // validation check
    if (!saveProvider.isNameValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Design name must be at least 3 characters"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    // MyDesignsProvider mein design save karo
    designsProvider.addSavedDesign(
      name: saveProvider.designNameController.text,
      date: _getTodayDate(),
      // image: "assets/images/design1.png",
    );

    // form reset karo
    saveProvider.reset();

    // success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Design saved successfully!"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );

    // wapis jao
    Navigator.pop(context);
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
