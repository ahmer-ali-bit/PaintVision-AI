import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatProvider extends ChangeNotifier {
  // ================= MESSAGE CONTROLLER =================
  final TextEditingController messageController = TextEditingController();

  // ================= IMAGE PICKER =================
  final ImagePicker _picker = ImagePicker();

  // ================= MESSAGES LIST =================
  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hi Kiran, how can I help you today?",
      "isMe": false,
      "type": "text",
    },
    {
      "text": "I want to know about paint for bedroom.",
      "isMe": true,
      "type": "text",
    },
    {
      "text":
          "Sure! Share your room photo or select a color and I will suggest best options for you.",
      "isMe": false,
      "type": "text",
    },
  ];

  // ================= GETTERS =================
  List<Map<String, dynamic>> get messages => _messages;

  int get messageCount => _messages.length;

  // ================= SEND TEXT MESSAGE =================
  void sendMessage() {
    // agar message empty ho to kuch mat karo
    if (messageController.text.trim().isEmpty) return;

    _messages.add({
      "text": messageController.text.trim(),
      "isMe": true,
      "type": "text",
    });

    // input field clear karo
    messageController.clear();

    notifyListeners();
  }

  // ================= SEND IMAGE MESSAGE =================
  void sendImage(String imagePath) {
    _messages.add({"image": imagePath, "isMe": true, "type": "image"});

    notifyListeners();
  }

  // ================= PICK IMAGE =================
  Future<void> pickImage({
    required ImageSource source,
    required BuildContext context,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        sendImage(pickedFile.path);
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

  // ================= CLEAR ALL MESSAGES =================
  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  // ================= DISPOSE =================
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
