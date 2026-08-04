import 'package:flutter/material.dart';
import '../theme/colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final VoidCallback? onTap;
  final bool gradientBorder;
  final bool glow;
  final bool emphasize;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = 16,
    this.onTap,
    this.gradientBorder = true,
    this.glow = false,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg = dark
        ? PortfolioColors.cardDark.withValues(alpha: 0.88)
        : Colors.white.withValues(alpha: 0.9);

    Widget card = Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: gradientBorder
            ? null
            : Border.all(
                color: dark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade200,
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.35 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
          if (glow || emphasize)
            BoxShadow(
              color: PortfolioColors.accent.withValues(
                alpha: dark ? 0.3 : 0.18,
              ),
              blurRadius: emphasize ? 30 : 18,
              spreadRadius: emphasize ? 2 : 0,
            ),
        ],
      ),
      child: child,
    );

    if (gradientBorder) {
      card = Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            colors: emphasize
                ? [
                    PortfolioColors.accent.withValues(alpha: 0.9),
                    PortfolioColors.accentLight.withValues(alpha: 0.45),
                    PortfolioColors.accent.withValues(alpha: 0.75),
                  ]
                : [
                    PortfolioColors.accent.withValues(alpha: 0.22),
                    PortfolioColors.accentLight.withValues(alpha: 0.12),
                    PortfolioColors.accent.withValues(alpha: 0.18),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: card,
      );
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }
    return card;
  }
}
