import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTypography {
  AppTypography._();

  static TextTheme _build(bool dark) {
    final h = dark
        ? PortfolioColors.textPrimaryDark
        : PortfolioColors.textPrimaryLight;
    final s = dark
        ? PortfolioColors.textSecondaryDark
        : PortfolioColors.textSecondaryLight;

    final display = GoogleFonts.spaceGrotesk(
      color: h,
      fontSize: 72,
      fontWeight: FontWeight.w700,
      letterSpacing: -2.5,
      height: 1.05,
    );

    return GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: display.copyWith(fontSize: 76),
        displayMedium: display.copyWith(fontSize: 60),
        displaySmall: display.copyWith(fontSize: 46),
        headlineLarge: GoogleFonts.spaceGrotesk(
          color: h,
          fontSize: 38,
          fontWeight: FontWeight.w700,
          letterSpacing: -1,
          height: 1.15,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          color: h,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineSmall: GoogleFonts.spaceGrotesk(
          color: h,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          color: h,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
        titleMedium: GoogleFonts.spaceGrotesk(
          color: h,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        titleSmall: GoogleFonts.spaceGrotesk(
          color: h,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: s,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: s,
          height: 1.6,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: s,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: s,
          letterSpacing: 0.8,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: s,
          letterSpacing: 1,
          height: 1.3,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: s,
          letterSpacing: 1.2,
          height: 1.3,
        ),
      ),
    );
  }

  static TextTheme get dark => _build(true);
  static TextTheme get light => _build(false);
}
