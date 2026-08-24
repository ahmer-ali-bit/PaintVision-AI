import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoProvider extends ChangeNotifier {
  // ================= STATE =================
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // ================= GETTERS =================
  File? get selectedImage => _selectedImage;

  // image selected hai ya nahi
  bool get hasImage => _selectedImage != null;

  // ================= PICK FROM GALLERY =================
  Future<File?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        _selectedImage = File(image.path);
        notifyListeners();
        return _selectedImage;
      }
    } catch (e) {
      debugPrint("Gallery Error: $e");
    }
    return null;
  }

  // ================= PICK FROM CAMERA =================
  Future<File?> pickFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        _selectedImage = File(image.path);
        notifyListeners();
        return _selectedImage;
      }
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
    return null;
  }

  // ================= CLEAR IMAGE =================
  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
