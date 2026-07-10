import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTypography {
  AppTypography._();

  static TextTheme _build(bool dark) {
    final c = dark ? PortfolioColors.textPrimaryDark : PortfolioColors.textPrimaryLight;
    final s = dark ? PortfolioColors.textSecondaryDark : PortfolioColors.textSecondaryLight;

    return GoogleFonts.interTextTheme(TextTheme(
      displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: c, letterSpacing: -2, height: 1.1),
      displayMedium: TextStyle(fontSize: 56, fontWeight: FontWeight.w600, color: c, letterSpacing: -1.5, height: 1.1),
      displaySmall: TextStyle(fontSize: 44, fontWeight: FontWeight.w600, color: c, letterSpacing: -1, height: 1.2),
      headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: c, letterSpacing: -0.5, height: 1.2),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: c, letterSpacing: -0.3, height: 1.3),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: c, height: 1.3),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: c, height: 1.4),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: c, height: 1.4),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: c, height: 1.4),
      bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: s, height: 1.7),
      bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: s, height: 1.6),
      bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: s, height: 1.5),
      labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: s, letterSpacing: 0.8, height: 1.4),
      labelMedium: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: s, letterSpacing: 1, height: 1.3),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: s, letterSpacing: 1.2, height: 1.3),
    ));
  }

  static TextTheme get dark => _build(true);
  static TextTheme get light => _build(false);
}
