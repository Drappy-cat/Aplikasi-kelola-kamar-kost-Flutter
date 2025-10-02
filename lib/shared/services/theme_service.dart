
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  final SharedPreferences _prefs;
  
  // Default theme is light
  bool _isDarkMode = false;

  ThemeService(this._prefs) {
    // Load theme preference on startup
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void _loadTheme() {
    // Read from shared_preferences, default to false (light mode) if not found
    _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    // Save the new preference
    await _prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
