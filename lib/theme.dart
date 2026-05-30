import 'package:flutter/material.dart';

class AppColors {
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color cardBackground;
  final Color surfaceLight;
  final Color surface;
  final Color background;

  const AppColors({
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.cardBackground,
    required this.surfaceLight,
    required this.surface,
    required this.background,
  });
}

class AppTheme {
  AppTheme._();
  static const Color accent = Color(0xFF007AFF);

  static const AppColors dark = AppColors(
    textPrimary: Color(0xFFF5F5F7),
    textSecondary: Color(0xFF98989D),
    border: Color(0xFF2C2C2E),
    cardBackground: Color(0xFF1C1C1E),
    surfaceLight: Color(0xFF2C2C2E),
    surface: Color(0xFF1A1A1A),
    background: Color(0xFF0A0A0A),
  );

  static const AppColors light = AppColors(
    textPrimary: Color(0xFF1D1D1F),
    textSecondary: Color(0xFF6E6E73),
    border: Color(0xFFD2D2D7),
    cardBackground: Color(0xFFFFFFFF),
    surfaceLight: Color(0xFFE8E8ED),
    surface: Color(0xFFF5F5F7),
    background: Color(0xFFFFFFFF),
  );

  static AppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }

  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 1200) return 200;
    if (w > 800) return 80;
    if (w > 600) return 40;
    return 20;
  }

  static int crossAxisCount(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 1000) return 3;
    if (w > 700) return 2;
    return 1;
  }

  static TextTheme _textTheme(Brightness b) {
    final c = b == Brightness.dark ? dark : light;
    return TextTheme(
      displayLarge: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w700,
          color: c.textPrimary,
          letterSpacing: -1.5),
      displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
          letterSpacing: -0.5),
      headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
          letterSpacing: -0.3),
      headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
          letterSpacing: -0.2),
      titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: c.textPrimary),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: c.textPrimary),
      bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: c.textPrimary,
          height: 1.7),
      bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: c.textSecondary,
          height: 1.6),
      labelLarge: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: c.textSecondary,
          letterSpacing: 0.8),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: accent,
        secondary: accent,
        surface: dark.background,
      ),
      scaffoldBackgroundColor: dark.background,
      fontFamily: 'Inter',
      textTheme: _textTheme(Brightness.dark),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: accent,
        secondary: accent,
        surface: light.background,
      ),
      scaffoldBackgroundColor: light.background,
      fontFamily: 'Inter',
      textTheme: _textTheme(Brightness.light),
    );
  }
}
