import 'package:flutter/material.dart';

class PortfolioColors {
  PortfolioColors._();

  static const accent = Color(0xFF66BB6A);
  static const accentLight = Color(0xFFA5D6A7);
  static const accentDark = Color(0xFF1B5E20);

  static const surfaceDark = Color(0xFF0E1510);
  static const surfaceLight = Color(0xFFF5FAF6);
  static const cardDark = Color(0xFF16211A);
  static const cardLight = Color(0xFFFFFFFF);
  static const sectionAltDark = Color(0xFF121C15);
  static const sectionAltLight = Color(0xFFE8F5E9);
  static const borderDark = Color(0xFF2C4030);
  static const borderLight = Color(0xFFD5E8D6);

  static const textPrimaryDark = Color(0xFFE8F5E9);
  static const textSecondaryDark = Color(0xFFA5D6A7);
  static const textTertiaryDark = Color(0xFF7A8F7C);
  static const textPrimaryLight = Color(0xFF1A2B1B);
  static const textSecondaryLight = Color(0xFF4C6650);
  static const textTertiaryLight = Color(0xFF7A8F7C);

  static const shimmerDark = Color(0xFF2C4030);
  static const shimmerLight = Color(0xFFD5E8D6);

  static const error = Color(0xFFDC2626);
  static const success = Color(0xFF1B5E20);

  static const navBarDark = Color(0xF40E1510);
  static const navBarLight = Color(0xF2F5FAF6);

  static const SkillPalette mint = SkillPalette(
    background: Color(0xFFE8F5E9),
    foreground: Color(0xFF1B5E20),
    border: Color(0xFFA5D6A7),
  );

  static const SkillPalette purple = SkillPalette(
    background: Color(0xFFF0EDF8),
    foreground: Color(0xFF5C5CA8),
    border: Color(0xFFD6CFEA),
  );

  static const SkillPalette blue = SkillPalette(
    background: Color(0xFFEAF1FA),
    foreground: Color(0xFF4A7CB8),
    border: Color(0xFFCFD9E4),
  );

  static const SkillPalette amber = SkillPalette(
    background: Color(0xFFFBF2E1),
    foreground: Color(0xFFB8860B),
    border: Color(0xFFEBD9B0),
  );

  static const SkillPalette cyan = SkillPalette(
    background: Color(0xFFE0F2F1),
    foreground: Color(0xFF3B8A86),
    border: Color(0xFFB2DFDB),
  );

  static const SkillPalette slate = SkillPalette(
    background: Color(0xFFEFF1F0),
    foreground: Color(0xFF5A6B60),
    border: Color(0xFFD8DACC),
  );

  static SkillPalette paletteForCategory(String category) {
    final c = category.toLowerCase();
    if (c.contains('hpc') || c.contains('gpu')) {
      return mint;
    }
    if (c.contains('ai') || c.contains('ml') || c.contains('machine learning')) {
      return purple;
    }
    if (c.contains('mobile')) {
      return amber;
    }
    if (c.contains('language')) {
      return blue;
    }
    if (c.contains('backend') || c.contains('iot')) {
      return cyan;
    }
    return slate;
  }

  static SkillPalette paletteForInterest(String interest) {
    final s = interest.toLowerCase();
    if (s.contains('high-performance') || s.contains('parallel')) {
      return mint;
    }
    if (s.contains('ai') || s.contains('machine learning') || s.contains('llm')) {
      return purple;
    }
    if (s.contains('mobile')) {
      return amber;
    }
    return mint;
  }
}

class SkillPalette {
  final Color background;
  final Color foreground;
  final Color border;
  const SkillPalette({
    required this.background,
    required this.foreground,
    required this.border,
  });
}
