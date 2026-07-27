import 'package:flutter/material.dart';

/// Application theme configuration - Pixel perfect Moodle colors
class AppTheme {
  AppTheme._();

  static const Color moodleOrange = Color(0xFFD47A3A);
  static const Color moodleGrey = Color(0xFFF2F2F2);

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: moodleOrange,
    onPrimary: Colors.white,
    secondary: Color(0xFF2F353E),
    onSecondary: Colors.white,
    error: Color(0xFFBA1A1A),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF1C1B1F),
    outline: Color(0xFFE0E0E0),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: moodleGrey,
      // Use standard sizes here; responsive scaling happens in widgets
      // This prevents the 'fontSize > 0' assertion error during startup
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }

  static ThemeData get darkTheme => lightTheme;
}
