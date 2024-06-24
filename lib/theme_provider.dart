import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    _saveThemeMode(themeMode);
    notifyListeners();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? ThemeMode.light.toString();
    _themeMode = ThemeMode.values.firstWhere((e) => e.toString() == themeModeString, orElse: () => ThemeMode.light);
    notifyListeners();
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', themeMode.toString());
  }

  void toggleTheme(bool isDarkMode) {
    setThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
