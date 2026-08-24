import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateDesignProvider extends ChangeNotifier {
  // ================= IMAGE PICKER =================
  final ImagePicker _picker = ImagePicker();

  // ================= NAME CONTROLLER =================
  final TextEditingController nameController = TextEditingController();

  // ================= STATE =================
  File? _selectedImage;

  // ================= GETTERS =================
  File? get selectedImage => _selectedImage;

  bool get hasImage => _selectedImage != null;

  bool get isNameValid => nameController.text.trim().length >= 3;

  // ================= PICK FROM CAMERA =================
  Future<void> pickFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        _selectedImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
  }

  // ================= PICK FROM GALLERY =================
  Future<void> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        _selectedImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Gallery Error: $e");
    }
  }

  // ================= USE SAMPLE ROOM =================
  void useSampleRoom() {
    _selectedImage = null;
    notifyListeners();
  }

  // ================= CLEAR IMAGE =================
  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  // ================= ON NAME CHANGED =================
  void onNameChanged(String value) {
    notifyListeners();
  }

  // ================= CLEAR NAME =================
  void clearName() {
    nameController.clear();
    notifyListeners();
  }

  // ================= RESET ALL =================
  void reset() {
    _selectedImage = null;
    nameController.clear();
    notifyListeners();
  }

  // ================= DISPOSE =================
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
