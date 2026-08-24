import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({super.key});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // ✅ FIXED: All messages have "type" now
  List<Map<String, dynamic>> messages = [
    {
      "text": "Hi Kiran, how can I help you today?",
      "isMe": false,
      "type": "text", // ✅ Added
    },
    {
      "text": "I want to know about paint for bedroom.",
      "isMe": true,
      "type": "text", // ✅ Added
    },
    {
      "text":
          "Sure! Share your room photo or select a color and I will suggest best options for you.",
      "isMe": false,
      "type": "text", // ✅ Added
    },
  ];

  // Send text message
  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "text": messageController.text.trim(),
        "isMe": true,
        "type": "text", // ✅ Type include
      });
    });

    messageController.clear();
  }

  // Send image message
  void _sendImage(String imagePath) {
    setState(() {
      messages.add({
        "image": imagePath,
        "isMe": true,
        "type": "image", // ✅ Type include
      });
    });
  }

  // Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        _sendImage(pickedFile.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Show bottom sheet
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
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
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, color: AppColors.primary),
                  ),
                  title: const Text("Camera"),
                  subtitle: const Text("Take a new photo"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.photo_library, color: AppColors.primary),
                  ),
                  title: const Text("Gallery"),
                  subtitle: const Text("Choose from gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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

            // Messages List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(messages[index], width, height);
                },
              ),
            ),

            // Message Input
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Row(
                children: [
                  // Attachment Icon
                  GestureDetector(
                    onTap: _showImageSourceOptions,
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
                      controller: messageController,
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
                    onTap: _sendMessage,
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

  // ✅ FIXED: Null-safe with default values
  Widget _buildMessage(
    Map<String, dynamic> message,
    double width,
    double height,
  ) {
    final bool isMe = message["isMe"] ?? false; // ✅ Null safe
    final String type = message["type"] ?? "text"; // ✅ Default "text"

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
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

          Flexible(
            child: type == "image"
                ? _buildImageMessage(message, isMe, width, height)
                : _buildTextMessage(message, isMe, width, height),
          ),
        ],
      ),
    );
  }

  // ✅ Text Message Bubble (null-safe)
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
            ? AppColors.primary.withOpacity(0.15)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(width * 0.04),
      ),
      child: Text(
        message["text"] ?? "", // ✅ Null safe
        style: TextStyle(
          fontSize: width * 0.04,
          color: Colors.black87,
          height: 1.4,
        ),
      ),
    );
  }

  // ✅ Image Message Bubble (null-safe)
  Widget _buildImageMessage(
    Map<String, dynamic> message,
    bool isMe,
    double width,
    double height,
  ) {
    final String? imagePath = message["image"];

    // If no image path, show fallback
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
            ? AppColors.primary.withOpacity(0.15)
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

  // Show full image preview
}
