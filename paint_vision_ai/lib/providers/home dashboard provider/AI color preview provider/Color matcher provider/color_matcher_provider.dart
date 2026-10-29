import 'package:flutter/material.dart';

// 👇 InputMethod class YAHAN hai
class InputMethod {
  final IconData icon;
  final String title;
  final String subtitle;

  InputMethod(this.icon, this.title, this.subtitle);
}

class ColorMatcherProvider extends ChangeNotifier {
  Color _selectedColor = Colors.blue;
  Color get selectedColor => _selectedColor;

  final List<InputMethod> _methods = [
    InputMethod(
      Icons.image_outlined,
      'Pick from Image',
      'Extract color from your photo',
    ),
    InputMethod(Icons.tag, 'Enter Color Code', 'Enter HEX or RGB code'),
    InputMethod(
      Icons.palette_outlined,
      'Choose from Palette',
      'Select from color palette',
    ),
  ];

  List<InputMethod> get methods => _methods;

  String get hexCode {
    return '#${_selectedColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  }

  void changeColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  // ✅ Context aur index dono lete hain
  void onMethodTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigator.push(context, MaterialPageRoute(builder: (_) => PickFromImageScreen()));
        debugPrint('Pick from Image tapped');
        break;
      case 1:
        // Navigator.push(context, MaterialPageRoute(builder: (_) => EnterColorCodeScreen()));
        debugPrint('Enter Color Code tapped');
        break;
      case 2:
        // Navigator.push(context, MaterialPageRoute(builder: (_) => ChooseFromPaletteScreen()));
        debugPrint('Choose from Palette tapped');
        break;
    }
  }

  void findMatchingColors() {
    debugPrint('Finding matches for: $hexCode');
  }
}
