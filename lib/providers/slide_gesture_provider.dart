import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlideGestureProvider extends ChangeNotifier {
  bool _isSlideEnabled = true; // Default value

  bool get isSlideEnabled => _isSlideEnabled;

  SlideGestureProvider() {
    _loadSlideGestureSetting();
  }

  // Load setting from SharedPreferences
  Future<void> _loadSlideGestureSetting() async {
    final prefs = await SharedPreferences.getInstance();
    _isSlideEnabled = prefs.getBool('slideGestureEnabled') ?? true;
    notifyListeners();
  }

  // Toggle setting and save it
  Future<void> toggleSlideGesture(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('slideGestureEnabled', value);
    _isSlideEnabled = value;
    notifyListeners();
  }
}
