import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorProvider with ChangeNotifier {
  // Updated default colors
  Color _headingColor = Colors.white; // White for heading color
  Color _subHeadingColor = Color(0xFFF5F5F5); // Light white (off-white) for subheading color

  Color get headingColor => _headingColor;
  Color get subHeadingColor => _subHeadingColor;

  void setHeadingColor(Color color) {
    _headingColor = color;
    _saveColors();
    notifyListeners();
  }

  void setSubHeadingColor(Color color) {
    _subHeadingColor = color;
    _saveColors();
    notifyListeners();
  }

  // Save colors to SharedPreferences
  Future<void> _saveColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('headingColor', _headingColor.value);
    prefs.setInt('subHeadingColor', _subHeadingColor.value);
  }

  // Load colors from SharedPreferences
  Future<void> loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _headingColor = Color(prefs.getInt('headingColor') ?? Colors.white.value); // Default to white
    _subHeadingColor = Color(prefs.getInt('subHeadingColor') ?? Color(0xFFF5F5F5).value); // Default to light white
    notifyListeners();
  }

  // Reset to default colors (white and light white)
  void resetToDefault() {
    _headingColor = Colors.white;
    _subHeadingColor = Color(0xFFF5F5F5);
    _saveColors();
    notifyListeners();
  }
}
