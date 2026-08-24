import 'package:flutter/material.dart';

class AiPreviewProvider extends ChangeNotifier {
  // ================= STATE =================
  int _selectedColorIndex = 0;
  bool _isFavorite = false;

  // ================= PALETTE COLORS =================
  final List<Color> _paletteColors = [
    const Color(0xFFAEC6E4), // Light blue
    const Color(0xFF1A2B5C), // Dark navy
    const Color(0xFF2F4A7C), // Medium navy
    const Color(0xFFB0AC9E), // Beige/Grey
  ];

  // ================= GETTERS =================
  int get selectedColorIndex => _selectedColorIndex;

  bool get isFavorite => _isFavorite;

  List<Color> get paletteColors => _paletteColors;

  // selected color return karo
  Color get selectedColor => _paletteColors[_selectedColorIndex];

  // ================= SELECT COLOR =================
  void selectColor(int index) {
    _selectedColorIndex = index;
    notifyListeners();
  }

  // ================= TOGGLE FAVORITE =================
  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  // ================= RESET =================
  void reset() {
    _selectedColorIndex = 0;
    _isFavorite = false;
    notifyListeners();
  }
}
