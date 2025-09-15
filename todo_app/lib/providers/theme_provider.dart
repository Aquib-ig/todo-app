import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  double _textSize = 1.0; // Font scale factor

  bool get isDarkMode => _isDarkMode;
  double get textSize => _textSize;
  
  ThemeProvider() {
    _loadThemeFromPreferences();
  }

  // Toggle theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemeToPreferences();
    notifyListeners();
  }

  // Change text size
  void setTextSize(double size) {
    _textSize = size;
    _saveTextSizeToPreferences();
    notifyListeners();
  }

  // Load theme from SharedPreferences
  void _loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _textSize = prefs.getDouble('textSize') ?? 1.0;
    notifyListeners();
  }

  // Save theme to SharedPreferences
  void _saveThemeToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  // Save text size to SharedPreferences
  void _saveTextSizeToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('textSize', _textSize);
  }
}
