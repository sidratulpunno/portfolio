import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double blur;
  final double opacity;
  final VoidCallback? onTap;
  final bool gradientBorder;
  final bool glow;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.blur = 16,
    this.opacity = 0.06,
    this.onTap,
    this.gradientBorder = false,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = (dark ? Colors.white : Colors.black).withValues(alpha: opacity);

    Widget card = Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (dark ? Colors.white : Colors.black).withValues(alpha: 0.08),
        ),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: PortfolioColors.accent.withValues(alpha: dark ? 0.08 : 0.06),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (gradientBorder) {
      card = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              PortfolioColors.accent.withValues(alpha: 0.3),
              PortfolioColors.accentLight.withValues(alpha: 0.1),
              PortfolioColors.accent.withValues(alpha: 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(1),
        child: card,
      );
    }

    final result = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: card,
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: result);
    }
    return result;
  }
}
