import 'package:flutter/material.dart';
import '../theme/colors.dart';

class TimelineItem extends StatelessWidget {
  final String company;
  final String role;
  final String period;
  final String description;
  final List<String> highlights;

  const TimelineItem({
    super.key,
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    this.highlights = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [PortfolioColors.accent, PortfolioColors.accentLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: dark ? PortfolioColors.surfaceDark : PortfolioColors.surfaceLight,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: PortfolioColors.accent.withValues(alpha: 0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          PortfolioColors.accent.withValues(alpha: 0.4),
                          PortfolioColors.accent.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          PortfolioColors.accent.withValues(alpha: 0.12),
                          PortfolioColors.accent.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      period,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: PortfolioColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    role,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company,
                    style: TextStyle(
                      fontSize: 15,
                      color: PortfolioColors.accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  if (highlights.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    ...highlights.asMap().entries.map((entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: PortfolioColors.accent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: PortfolioColors.accent.withValues(alpha: 0.3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
