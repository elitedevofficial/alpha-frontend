import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  String? email;
  String? password;
  String? username;
  String? userId;
  String? coverImg;
  String? birthDate;
  String? gender;
  List<String> selectedLanguages = [];
  List<String> favArtist = [];
  int? _age;
  DateTime? _birthdate;

  // Set initial values for email and password
  void setInitialData(String email, String password) {
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  // Setter for email
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  // Setter for password
  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  // Setter for username
  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  // Setter for userId
  void setUserId(String userId) {
    this.userId = userId;
    notifyListeners();
  }

  // Setter for cover image
  void setCoverImg(String coverImg) {
    this.coverImg = coverImg;
    notifyListeners();
  }

  // Setter for gender
  void setGender(String? value) {
    gender = value;
    notifyListeners();
  }

  // Setter for age
  void setAge(int age) {
    _age = age;
    notifyListeners();
  }

  // Setter for birthdate
  void setBirthdate(DateTime birthdate) {
    _birthdate = birthdate;
    notifyListeners();
  }

  // Getter for age
  int? get age => _age;

  // Getter for birthdate
  DateTime? get birthdate => _birthdate;

  // Getter for gender
  String? getGender() {
    return gender;
  }

  void setSelectedLanguages(List<String> languages) {
    selectedLanguages = languages;
    notifyListeners();
  }

  // Getter for selected languages
  List<String> getSelectedLanguages() {
    return selectedLanguages;
  }

  final List<String> _selectedLanguages = [];
  final List<String> _selectedArtists = [];

  //List<String> get selectedLanguages => _selectedLanguages;
  List<String> get selectedArtists => _selectedArtists;

  void addLanguage(String language) {
    if (!_selectedLanguages.contains(language)) {
      _selectedLanguages.add(language);
      notifyListeners();
    }
  }

  // Method to remove a language
  void removeLanguage(String language) {
    _selectedLanguages.remove(language);
    notifyListeners();
  }

  // Method to toggle artist selection
  void toggleArtistSelection(String artist) {
    if (_selectedArtists.contains(artist)) {
      _selectedArtists.remove(artist); // Deselect artist
    } else {
      if (_selectedArtists.length < 10) {
        _selectedArtists.add(artist); // Select artist
      }
    }
    notifyListeners();
  }

  // Method to set selected artists
  void setSelectedArtists(List<String> artists) {
    _selectedArtists.clear();
    _selectedArtists.addAll(artists);
    notifyListeners();
  }

  // Method to clear all artists
  void clearArtists() {
    _selectedArtists.clear();
    notifyListeners();
  }

  // Print user data
  void printUserData() {
    print('Email: $email');
    print('Password: $password');
    print('Username: $username');
    print('Gender: $gender');
    print('Age: $_age');
    print('User ID: $userId');
    print('Cover Image: $coverImg');
    print('Birth Date: $birthdate');
    print('Favorite Languages: $selectedLanguages');
    print('Favorite Artists: $_selectedArtists');
  }

  // Consolidate user data into a single map for API calls
  Map<String, dynamic> getUserData() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'userId': userId,
      'coverImg': coverImg,
      'birthDate': birthDate?.toString(), // Convert to string
      'gender': gender,
      'age': _age,
      'selectedLanguages': selectedLanguages,
      'favoriteArtists': _selectedArtists,
    };
  }
}
