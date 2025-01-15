import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradientProvider with ChangeNotifier {
  // Default gradient colors using hex values
  List<Color> _colors = [
    Color(0xFF080F20), // Dark blue (Hex: #080F20)
    Color(0xFF151A4D), // Medium blue (Hex: #151A4D)
    Color(0xFF382C74), // Purple (Hex: #382C74)
  ];

  // Getter for accessing gradient colors
  List<Color> get colors => _colors;

  GradientProvider() {
    _loadColorsFromPreferences();
  }

  // Update colors dynamically and save to preferences
  void updateColors(List<Color> newColors) {
    _colors = newColors;
    notifyListeners();
    _saveColorsToPreferences();
  }

  // Reset to default gradient colors
  void resetColors() {
    _colors = [
      Color(0xFF080F20), // Dark blue (Hex: #080F20)
      Color(0xFF151A4D), // Medium blue (Hex: #151A4D)
      Color(0xFF382C74), // Purple (Hex: #382C74)
    ];
    notifyListeners();
    _saveColorsToPreferences(); // Save default colors to SharedPreferences
  }

  // Load colors from SharedPreferences
  Future<void> _loadColorsFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedColors = prefs.getStringList('gradientColors');
    if (savedColors != null) {
      _colors = savedColors.map((color) => Color(int.parse(color))).toList();
      notifyListeners();
    }
  }

  // Save colors to SharedPreferences
  Future<void> _saveColorsToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorStrings =
        _colors.map((color) => color.value.toString()).toList();
    await prefs.setStringList('gradientColors', colorStrings);
  }
}
