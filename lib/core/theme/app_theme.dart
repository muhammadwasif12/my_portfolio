import 'package:flutter/material.dart';


class AppTheme {
  static const Color primaryBlue = Color(0xFF4FC3F7);
//  static const Color primaryBlue = Color.fromARGB(255, 89, 104, 243);
//  static const Color secondaryBlue = Color(0xFF29B6F6);
  static const Color secondaryBlue = Color.fromARGB(255, 91, 105, 235);
  static const Color darkBackground = Color(0xFF0F1419);
  static const Color cardBackground = Color(0xFF1A2332);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textTertiary = Color(0xFF90A4AE);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: darkBackground,
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: primaryBlue,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: textSecondary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: textSecondary,
        ),
      ),
    );
  }
}
