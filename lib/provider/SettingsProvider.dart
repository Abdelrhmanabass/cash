import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsProvider with ChangeNotifier {
  late String _selectedGenderValue ; // Default gender
  late String _selectedLanguageValue ; // Default language

  SettingsProvider() {
    loadPreferences();
    _selectedGenderValue = 'Male';
    _selectedLanguageValue = 'English';
  }

  String get pickedGender => _selectedGenderValue;
  String get pickedLanguage => _selectedLanguageValue;

  void setGenderLanguage(String gender , String language) {
    _selectedGenderValue = gender;
    _selectedLanguageValue = language;
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedGenderValue = prefs.getString('pickedGender') ?? 'Male';
    _selectedLanguageValue = prefs.getString('pickedLanguage') ?? 'English';
    notifyListeners();
  }

  // Save preferences to SharedPreferences
  Future<void> savePreferences(String gender, String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pickedGender', gender);
    await prefs.setString('pickedLanguage', language);
    _selectedGenderValue = gender;
    _selectedLanguageValue = language;
    notifyListeners();
  }

}
