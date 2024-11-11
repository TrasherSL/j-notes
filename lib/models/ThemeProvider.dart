import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false; // Track dark mode state
  double _fontSize = 16.0;  // Default font size
  bool _notificationsEnabled = true; // Notifications setting
  String _backgroundType = 'solid'; // Background type (solid, gradient)
  Color _backgroundColor = Colors.white; // Default background color
  Gradient _backgroundGradient = LinearGradient(
    colors: [Colors.blue, Colors.green],
  ); // Default gradient background

  // Getters
  bool get isDarkMode => _isDarkMode;
  double get fontSize => _fontSize;
  bool get notificationsEnabled => _notificationsEnabled;
  String get backgroundType => _backgroundType;
  Color get backgroundColor => _backgroundColor;
  Gradient get backgroundGradient => _backgroundGradient;

  // Toggle dark mode
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Set font size
  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Toggle notifications
  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Set background type to solid
  void setSolidBackground(Color color) {
    _backgroundType = 'solid';
    _backgroundColor = color;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Set background type to gradient
  void setGradientBackground(Gradient gradient) {
    _backgroundType = 'gradient';
    _backgroundGradient = gradient;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Reset to default background (white solid)
  void resetBackground() {
    _backgroundType = 'solid';
    _backgroundColor = Colors.white;
    _backgroundGradient = LinearGradient(
      colors: [Colors.blue, Colors.green],
    );
    notifyListeners(); // Notify listeners to update the UI
  }
}
