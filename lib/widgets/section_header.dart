import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  const SectionHeader({super.key, required this.title, this.subtitle, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 5,
              height: 28,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [PortfolioColors.accent, PortfolioColors.accentLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 14),
            Text(title, style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            )),
            if (onAction != null && actionLabel != null) ...[
              const Spacer(),
              TextButton.icon(
                onPressed: onAction,
                icon: Text(actionLabel!, style: TextStyle(fontSize: 14, color: PortfolioColors.accent)),
                label: Icon(Icons.arrow_forward, size: 16, color: PortfolioColors.accent),
              ),
            ],
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Text(
              subtitle!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
