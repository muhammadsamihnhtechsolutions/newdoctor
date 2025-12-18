import 'package:flutter/material.dart';

class AppColors {
  static const Color color008541 = Color(0xFF008541); // parrot green
  static const Color white = Colors.white;
  static const Color greyText = Colors.grey;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // 🌟 Primary color FIXED
      primaryColor: AppColors.color008541,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.color008541,
      ),

      // Scaffold background
      scaffoldBackgroundColor: Colors.white,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.color008541,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),

      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: AppColors.color008541,
            fontSize: 32,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            color: AppColors.color008541,
            fontSize: 28,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: AppColors.color008541,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.greyText,
          fontSize: 14,
        ),
        titleMedium: TextStyle(
          color: AppColors.greyText,
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          color: AppColors.greyText,
          fontSize: 14,
        ),
        labelLarge: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.color008541,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),

      // FAB theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.color008541,
        foregroundColor: AppColors.white,
      ),
    );
  }
}
