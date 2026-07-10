import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final bool small;
  final bool filled;
  const SkillChip({super.key, required this.label, this.small = false, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 10 : 14,
        vertical: small ? 5 : 8,
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
        color: filled ? null : PortfolioColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: filled
              ? Colors.transparent
              : PortfolioColors.accent.withValues(alpha: 0.2),
        ),
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
          color: filled ? Colors.white : PortfolioColors.accent,
        ),
      ),
    );
  }
}
