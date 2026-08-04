import 'package:flutter/material.dart';
import 'glass_card.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final VoidCallback? onTap;
  const HoverCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = 16,
    this.onTap,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: _hover
              ? (Matrix4.translationValues(0, -3, 0)
                  ..scaleByDouble(1.01, 1.01, 1.01, 1.0))
              : Matrix4.identity(),
          child: GlassCard(
            emphasize: _hover,
            padding: widget.padding,
            radius: widget.radius,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
