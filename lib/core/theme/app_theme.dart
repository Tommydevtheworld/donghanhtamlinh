import 'package:flutter/material.dart';
import '../constants/app_colors.dart' as app_colors;

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: app_colors.AppColors.primary,
      scaffoldBackgroundColor: app_colors.AppColors.background,
      colorScheme: ColorScheme.light(
        primary: app_colors.AppColors.primary,
        secondary: app_colors.AppColors.secondary,
        surface: app_colors.AppColors.surfaceColor,
        background: app_colors.AppColors.background,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: app_colors.AppColors.textPrimary,
        onBackground: app_colors.AppColors.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: app_colors.AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: app_colors.AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: app_colors.AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: app_colors.AppColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: app_colors.AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: app_colors.AppColors.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
