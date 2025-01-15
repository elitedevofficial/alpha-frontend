import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  List<String> _selectedLanguages = [];

  List<String> get selectedLanguages => _selectedLanguages;

  void selectLanguage(String language) {
    if (_selectedLanguages.contains(language)) {
      _selectedLanguages.remove(language);
    } else if (_selectedLanguages.length < 7) {
      _selectedLanguages.add(language);
    }
    notifyListeners();
  }

  void clearLanguages() {
    _selectedLanguages.clear();
    notifyListeners();
  }
}
