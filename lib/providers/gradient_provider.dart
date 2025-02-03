import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradientProvider with ChangeNotifier {
  // Default gradient colors using hex values
  List<Color> _colors = [
    const Color(0xFF25263A), // Dark bluish center
    const Color.fromARGB(255, 26, 30, 61), // Deep dark blue
    const Color(0xFF101118) // Purple (Hex: #382C74)
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
      const Color(0xFF25263A), // Dark bluish center
    const Color.fromARGB(255, 26, 30, 61), // Deep dark blue
    const Color(0xFF101118)  // Purple (Hex: #382C74)
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