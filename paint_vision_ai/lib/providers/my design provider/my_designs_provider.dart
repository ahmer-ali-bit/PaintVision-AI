import 'dart:io';
import 'package:flutter/material.dart';

class MyDesignsProvider extends ChangeNotifier {
  // ================= TAB STATE =================
  int _selectedTab = 0;

  // ================= TABS LIST =================
  final List<String> _tabs = ['Saved Designs', 'Shared Designs'];

  // ================= SAVED DESIGNS =================
  final List<Map<String, dynamic>> _savedDesigns = [
    {
      "name": "My Living Room Blue",
      "date": "May 12, 2025",
      "image": "assets/images/design1.png",
      "imageFile": null,
    },
    {
      "name": "Soft Green Room",
      "date": "May 10, 2025",
      "image": "assets/images/design1.png",
      "imageFile": null,
    },
    {
      "name": "Warm Beige Room",
      "date": "May 8, 2025",
      "image": "assets/images/design1.png",
      "imageFile": null,
    },
    {
      "name": "Modern Grey Room",
      "date": "May 6, 2025",
      "image": "assets/images/design1.png",
      "imageFile": null,
    },
  ];

  // ================= SHARED DESIGNS =================
  final List<Map<String, dynamic>> _sharedDesigns = [
    {
      "name": "Cozy Bedroom",
      "date": "May 5, 2025",
      "image": "assets/images/design1.png",
      "imageFile": null,
    },
    {
      "name": "Elegant Dining",
      "date": "May 3, 2025",
      "image": "assets/images/design1.png",
      "imageFile": null,
    },
  ];

  // ================= GETTERS =================
  int get selectedTab => _selectedTab;

  List<String> get tabs => _tabs;

  List<Map<String, dynamic>> get savedDesigns => _savedDesigns;

  List<Map<String, dynamic>> get sharedDesigns => _sharedDesigns;

  // current tab ki list return karo
  List<Map<String, dynamic>> get currentDesigns {
    return _selectedTab == 0 ? _savedDesigns : _sharedDesigns;
  }

  // saved designs count
  int get savedCount => _savedDesigns.length;

  // shared designs count
  int get sharedCount => _sharedDesigns.length;

  // ================= METHODS =================

  // tab change karo
  void changeTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  // ================= ADD SAVED DESIGN =================
  // File bhi optional support karta hai
  void addSavedDesign({
    required String name,
    required String date,
    // required String image,
    File? imageFile,
  }) {
    _savedDesigns.insert(0, {
      "name": name,
      "date": date,
      // "image": image,
      "imageFile": imageFile,
    });
    notifyListeners();
  }

  // ================= ADD SHARED DESIGN =================
  void addSharedDesign({
    required String name,
    required String date,
    required String image,
    File? imageFile,
  }) {
    _sharedDesigns.insert(0, {
      "name": name,
      "date": date,
      "image": image,
      "imageFile": imageFile,
    });
    notifyListeners();
  }

  // ================= DELETE DESIGN =================
  // current tab se design delete karo
  void deleteDesign(int index) {
    if (_selectedTab == 0) {
      _savedDesigns.removeAt(index);
    } else {
      _sharedDesigns.removeAt(index);
    }
    notifyListeners();
  }

  // ================= DELETE SAVED DESIGN =================
  void deleteSavedDesign(int index) {
    _savedDesigns.removeAt(index);
    notifyListeners();
  }

  // ================= DELETE SHARED DESIGN =================
  void deleteSharedDesign(int index) {
    _sharedDesigns.removeAt(index);
    notifyListeners();
  }

  // ================= MOVE TO SHARED =================
  // saved se shared mein move karo
  void moveToShared(int index) {
    if (index < _savedDesigns.length) {
      final design = _savedDesigns.removeAt(index);
      _sharedDesigns.insert(0, design);
      notifyListeners();
    }
  }

  // ================= MOVE TO SAVED =================
  // shared se saved mein move karo
  void moveToSaved(int index) {
    if (index < _sharedDesigns.length) {
      final design = _sharedDesigns.removeAt(index);
      _savedDesigns.insert(0, design);
      notifyListeners();
    }
  }

  // ================= RENAME DESIGN =================
  // design ka naam change karo current tab mein
  void renameDesign(int index, String newName) {
    if (newName.trim().isEmpty) return;

    if (_selectedTab == 0) {
      _savedDesigns[index]["name"] = newName.trim();
    } else {
      _sharedDesigns[index]["name"] = newName.trim();
    }
    notifyListeners();
  }

  // ================= CLEAR ALL SAVED =================
  void clearAllSaved() {
    _savedDesigns.clear();
    notifyListeners();
  }

  // ================= CLEAR ALL SHARED =================
  void clearAllShared() {
    _sharedDesigns.clear();
    notifyListeners();
  }
}
