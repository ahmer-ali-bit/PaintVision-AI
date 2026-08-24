import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class CropImageProvider extends ChangeNotifier {
  // ================= CROP CONTROLLER =================
  final CropController cropController = CropController();

  // ================= STATE =================
  File? _imageFile;
  Uint8List? _imageBytes;
  Uint8List? _croppedImage;
  bool _isCropping = false;

  // ================= GETTERS =================
  File? get imageFile => _imageFile;
  Uint8List? get imageBytes => _imageBytes;
  Uint8List? get croppedImage => _croppedImage;
  bool get isCropping => _isCropping;
  bool get hasImage => _imageBytes != null;
  bool get hasCropped => _croppedImage != null;

  // ================= SET IMAGE =================
  Future<void> setImage(File? file) async {
    if (file == null) return;

    _imageFile = file;
    _imageBytes = await file.readAsBytes();
    _croppedImage = null;
    notifyListeners();
  }

  // ================= RESET =================
  // image ko wapis original state mein le jao
  void reset() {
    if (_imageBytes != null) {
      final bytes = _imageBytes;
      _imageBytes = null;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 50), () {
        _imageBytes = bytes;
        _croppedImage = null;
        notifyListeners();
      });
    }
  }

  // ================= CROP IMAGE =================
  void crop() {
    _isCropping = true;
    notifyListeners();

    cropController.crop();
  }

  // ================= ON CROPPED =================
  void onCropped(Uint8List croppedData) {
    _croppedImage = croppedData;
    _isCropping = false;
    notifyListeners();
  }

  // ================= CLEAR =================
  void clearAll() {
    _imageFile = null;
    _imageBytes = null;
    _croppedImage = null;
    _isCropping = false;
    notifyListeners();
  }
}
