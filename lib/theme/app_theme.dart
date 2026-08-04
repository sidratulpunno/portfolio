import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  AppTheme._();

  static const double radiusSmall = 6;
  static const double radiusMedium = 10;
  static const double radiusLarge = 16;
  static const double radiusXl = 24;

  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(horizontal: 24);
  static EdgeInsets paddingScreenWide(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 1200) return const EdgeInsets.symmetric(horizontal: 200);
    if (w > 900) return const EdgeInsets.symmetric(horizontal: 80);
    if (w > 600) return const EdgeInsets.symmetric(horizontal: 40);
    return const EdgeInsets.symmetric(horizontal: 24);
  }

  static int gridColumns(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 1100) return 3;
    if (w > 700) return 2;
    return 1;
  }

  static double sectionSpacing(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w > 600 ? 120 : 80;
  }

  static ThemeData _themeData(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: PortfolioColors.accent,
        onPrimary: Colors.white,
        secondary: PortfolioColors.accent,
        onSecondary: Colors.white,
        tertiary: dark
            ? PortfolioColors.accentLight
            : PortfolioColors.accentDark,
        error: PortfolioColors.error,
        onError: Colors.white,
        surface: dark
            ? PortfolioColors.surfaceDark
            : PortfolioColors.surfaceLight,
        onSurface: dark
            ? PortfolioColors.textPrimaryDark
            : PortfolioColors.textPrimaryLight,
        surfaceContainerHighest: dark
            ? PortfolioColors.cardDark
            : PortfolioColors.cardLight,
        outline: dark
            ? PortfolioColors.borderDark
            : PortfolioColors.borderLight,
      ),
      scaffoldBackgroundColor: dark
          ? PortfolioColors.surfaceDark
          : PortfolioColors.surfaceLight,
      textTheme: dark ? AppTypography.dark : AppTypography.light,
      dividerColor: dark
          ? PortfolioColors.borderDark
          : PortfolioColors.borderLight,
      dividerTheme: DividerThemeData(
        color: dark ? PortfolioColors.borderDark : PortfolioColors.borderLight,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: dark ? PortfolioColors.cardDark : PortfolioColors.cardLight,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: dark ? 0.4 : 0.05),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          side: BorderSide(
            color: dark
                ? PortfolioColors.accent.withValues(alpha: 0.2)
                : PortfolioColors.accent.withValues(alpha: 0.25),
            width: 0.5,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: dark
            ? PortfolioColors.navBarDark
            : PortfolioColors.navBarLight,
        indicatorColor: PortfolioColors.accent.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (_) => TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: dark
                ? PortfolioColors.textSecondaryDark
                : PortfolioColors.textSecondaryLight,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme => _themeData(Brightness.dark);
  static ThemeData get lightTheme => _themeData(Brightness.light);
}
