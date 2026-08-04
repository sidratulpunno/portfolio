import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final bool small;
  final bool filled;
  final SkillPalette? palette;
  const SkillChip({
    super.key,
    required this.label,
    this.small = false,
    this.filled = false,
    this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final p = palette ?? PortfolioColors.mint;
    final bg = dark ? p.foreground.withValues(alpha: 0.16) : p.background;
    final fg = dark
        ? Color.lerp(p.foreground, Colors.white, 0.45)!
        : p.foreground;
    final border = dark ? p.foreground.withValues(alpha: 0.35) : p.border;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 12 : 12,
        vertical: small ? 6 : 6,
      ),
      decoration: BoxDecoration(
        gradient: filled
            ? LinearGradient(
                colors: [
                  PortfolioColors.accent.withValues(alpha: 0.9),
                  PortfolioColors.accentLight.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: filled ? null : bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: filled ? Colors.transparent : border),
        boxShadow: filled
            ? [
                BoxShadow(
                  color: PortfolioColors.accent.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: small ? 11 : 13,
          fontWeight: FontWeight.w500,
          color: filled ? Colors.white : fg,
        ),
      ),
    );
  }
}
