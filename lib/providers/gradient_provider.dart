import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradientProvider with ChangeNotifier {
  // Default gradient colors
  List<Color> _colors = [
    const Color(0xFF292555),
    const Color(0xFF1F1D42),
    const Color(0xFF0F0F27)
  ];

  List<Color> get colors => _colors;

  // Getters for individual colors
  Color get primaryColor => _colors.first; // First (darkest or base color)
  Color get secondaryColor =>
      _colors.length > 1 ? _colors[1] : _colors.first; // Middle (lighter color)
  Color get tertiaryColor => _colors.length > 2
      ? _colors.last
      : _colors.first; // Last (darkest/lightest)

  GradientProvider() {
    _loadColorsFromPreferences();
  }

  void updateColors(List<Color> newColors) {
    _colors = newColors;
    notifyListeners();
    _saveColorsToPreferences();
  }

  void resetColors() {
    _colors = [
      const Color(0xFF292555),
      const Color(0xFF1F1D42),
      const Color(0xFF0F0F27)
    ];
    notifyListeners();
    _saveColorsToPreferences();
  }

  Future<void> _loadColorsFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedColors = prefs.getStringList('gradientColors');
    if (savedColors != null) {
      _colors = savedColors.map((color) => Color(int.parse(color))).toList();
      notifyListeners();
    }
  }

  Future<void> _saveColorsToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorStrings =
        _colors.map((color) => color.value.toString()).toList();
    await prefs.setStringList('gradientColors', colorStrings);
  }
}
