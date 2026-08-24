import 'package:flutter/material.dart';

class SaveDesignProvider extends ChangeNotifier {
  // ================= CONTROLLER =================
  final TextEditingController designNameController = TextEditingController();

  // ================= STATE =================
  String? _selectedFolder;
  final List<String> _folders = [];

  // ================= GETTERS =================
  String? get selectedFolder => _selectedFolder;

  List<String> get folders => _folders;

  // design name valid hai ya nahi
  bool get isNameValid => designNameController.text.length >= 3;

  // design name empty hai ya nahi
  bool get isEmpty => designNameController.text.isEmpty;

  // ================= SELECT FOLDER =================
  void selectFolder(String folder) {
    _selectedFolder = folder;
    notifyListeners();
  }

  // ================= ADD NEW FOLDER =================
  void addFolder(String folderName) {
    if (folderName.trim().isEmpty) return;

    // duplicate check karo
    if (_folders.contains(folderName.trim())) return;

    _folders.add(folderName.trim());
    notifyListeners();
  }

  // ================= ON NAME CHANGED =================
  void onNameChanged(String value) {
    notifyListeners();
  }

  // ================= SAVE DESIGN =================
  bool saveDesign() {
    // validation
    if (designNameController.text.length < 3) {
      return false;
    }
    // yahan actual save logic hoga
    // jaise MyDesignsProvider mein add karna
    return true;
  }

  // ================= RESET =================
  void reset() {
    designNameController.clear();
    _selectedFolder = null;
    notifyListeners();
  }

  // ================= DISPOSE =================
  @override
  void dispose() {
    designNameController.dispose();
    super.dispose();
  }
}
