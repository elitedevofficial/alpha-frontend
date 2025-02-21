import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiLanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default language

  Locale get locale => _locale;

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language');
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  Future<void> setLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    notifyListeners();
  }

  Future<void> resetToDefault() async {
    _locale = const Locale('en'); // Reset to default
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('language');
    notifyListeners();
  }
}