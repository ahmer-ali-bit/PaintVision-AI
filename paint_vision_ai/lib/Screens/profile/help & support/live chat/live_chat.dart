import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paint_vision_ai/providers/live%20chat%20provider/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';

class LiveChatScreen extends StatelessWidget {
  const LiveChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch isliye ke naya message aane par UI update ho
    final chatProvider = context.watch<ChatProvider>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ========== HEADER ==========
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Row(
                children: [
                  const BackButton(),
                  CircleAvatar(
                    radius: width * 0.06,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[600],
                      size: width * 0.06,
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Support Agent",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.015),

            // ========== MESSAGES LIST ==========
            Expanded(
              child: chatProvider.messages.isEmpty
                  ? const Center(
                      child: Text(
                        'No messages yet',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      itemCount: chatProvider.messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessage(
                          chatProvider.messages[index],
                          width,
                          height,
                        );
                      },
                    ),
            ),

            // ========== MESSAGE INPUT ==========
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Row(
                children: [
                  // Attachment Icon
                  GestureDetector(
                    onTap: () => _showImageSourceOptions(context),
                    child: Container(
                      width: width * 0.11,
                      height: width * 0.11,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.grey[700],
                        size: width * 0.055,
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.02),

                  // Text Field
                  Expanded(
                    child: TextField(
                      // provider ka controller use karo
                      controller: chatProvider.messageController,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.015,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.02),

                  // Send Button
                  GestureDetector(
                    onTap: () {
                      context.read<ChatProvider>().sendMessage();
                    },
                    child: Container(
                      width: width * 0.12,
                      height: width * 0.12,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: width * 0.055,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== IMAGE SOURCE BOTTOM SHEET ==========
  void _showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Send Photo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),

                // Camera
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, color: AppColors.primary),
                  ),
                  title: const Text("Camera"),
                  subtitle: const Text("Take a new photo"),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    context.read<ChatProvider>().pickImage(
                      source: ImageSource.camera,
                      context: context,
                    );
                  },
                ),

                // Gallery
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.photo_library, color: AppColors.primary),
                  ),
                  title: const Text("Gallery"),
                  subtitle: const Text("Choose from gallery"),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    context.read<ChatProvider>().pickImage(
                      source: ImageSource.gallery,
                      context: context,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ========== MESSAGE WIDGET ==========
  Widget _buildMessage(
    Map<String, dynamic> message,
    double width,
    double height,
  ) {
    final bool isMe = message["isMe"] ?? false;
    final String type = message["type"] ?? "text";

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          // Agent avatar
          if (!isMe)
            CircleAvatar(
              radius: width * 0.045,
              backgroundColor: Colors.grey.shade200,
              child: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: width * 0.045,
              ),
            ),

          if (!isMe) SizedBox(width: width * 0.02),

          // Message bubble
          Flexible(
            child: type == "image"
                ? _buildImageMessage(message, isMe, width, height)
                : _buildTextMessage(message, isMe, width, height),
          ),
        ],
      ),
    );
  }

  // ========== TEXT MESSAGE BUBBLE ==========
  Widget _buildTextMessage(
    Map<String, dynamic> message,
    bool isMe,
    double width,
    double height,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.015,
      ),
      decoration: BoxDecoration(
        color: isMe
            ? AppColors.primary.withValues(alpha: 0.15)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(width * 0.04),
      ),
      child: Text(
        message["text"] ?? "",
        style: TextStyle(
          fontSize: width * 0.04,
          color: Colors.black87,
          height: 1.4,
        ),
      ),
    );
  }

  // ========== IMAGE MESSAGE BUBBLE ==========
  Widget _buildImageMessage(
    Map<String, dynamic> message,
    bool isMe,
    double width,
    double height,
  ) {
    final String? imagePath = message["image"];

    // agar image path nahi hai
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(width * 0.04),
        ),
        child: const Text("Image not available"),
      );
    }

    return Container(
      padding: EdgeInsets.all(width * 0.015),
      decoration: BoxDecoration(
        color: isMe
            ? AppColors.primary.withValues(alpha: 0.15)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(width * 0.04),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.03),
        child: Image.file(
          File(imagePath),
          width: width * 0.55,
          height: width * 0.55,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width * 0.55,
              height: width * 0.55,
              color: Colors.grey.shade300,
              child: Icon(
                Icons.broken_image,
                color: Colors.grey[600],
                size: width * 0.1,
              ),
            );
          },
        ),
      ),
    );
  }
}
