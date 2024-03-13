import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  String _selectedGenderValue = 'Male'; // Default gender
  String _selectedLanguageValue = 'English'; // Default language

  String get pickedGender => _selectedGenderValue;
  String get pickedLanguage => _selectedLanguageValue;

  void setPickedGender(String gender) {
    _selectedGenderValue = gender;
    notifyListeners(); // Notify listeners of the change
  }

  void setPickedLanguage(String language) {
    _selectedLanguageValue = language;
    notifyListeners(); // Notify listeners of the change
  }
}
