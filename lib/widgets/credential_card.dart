import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../utils/launch.dart';
import 'glass_card.dart';

class CredentialCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String verifyUrl;
  final String verifyLabel;

  const CredentialCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.verifyUrl,
    this.verifyLabel = 'Verify',
  });

  @override
  State<CredentialCard> createState() => _CredentialCardState();
}

class _CredentialCardState extends State<CredentialCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _hover ? Matrix4.translationValues(0, -4, 0) : Matrix4.identity(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            gradient: _hover
                ? LinearGradient(
                    colors: [
                      PortfolioColors.accent.withValues(alpha: 0.35),
                      PortfolioColors.accentLight.withValues(alpha: 0.1),
                      PortfolioColors.accent.withValues(alpha: 0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          padding: const EdgeInsets.all(1),
          child: GlassCard(
            glow: _hover,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.titleSmall?.copyWith(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: dark ? PortfolioColors.cardDark : PortfolioColors.borderLight,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: PortfolioColors.textTertiaryDark.withValues(alpha: 0.5),
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => launchUrlExternal(widget.verifyUrl),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      gradient: _hover
                          ? LinearGradient(
                              colors: [PortfolioColors.accent, PortfolioColors.accentLight],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color: _hover ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: PortfolioColors.accent.withValues(alpha: _hover ? 0 : 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, size: 13, color: _hover ? Colors.white : PortfolioColors.accent),
                        const SizedBox(width: 5),
                        Text(
                          widget.verifyLabel,
                          style: TextStyle(
                            fontSize: 11,
                            color: _hover ? Colors.white : PortfolioColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
