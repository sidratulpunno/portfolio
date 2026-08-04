import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/glass_card.dart';

class PublicationsSection extends StatelessWidget {
  const PublicationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pad = AppTheme.paddingScreenWide(context);
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? PortfolioColors.sectionAltDark
          : PortfolioColors.sectionAltLight,
      padding: EdgeInsets.symmetric(
        horizontal: pad.horizontal,
        vertical: AppTheme.sectionSpacing(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSection(
            child: const SectionHeader(
              title: 'Publications',
              subtitle: 'Peer-reviewed research papers',
              index: '03',
            ),
          ),
          const SizedBox(height: 48),
          ...List.generate(ResumeData.publications.length, (i) {
            final pub = ResumeData.publications[i];
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < ResumeData.publications.length - 1 ? 20 : 0,
              ),
              child: AnimatedSection(
                delayMs: i * 100,
                child: GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: PortfolioColors.accent.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  pub.date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: PortfolioColors.accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pub.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: theme.textTheme.titleMedium?.color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    pub.venue,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: PortfolioColors.accent.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                pub.date,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PortfolioColors.accent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              pub.title,
                              style: TextStyle(
                                fontSize: 15,
                                color: theme.textTheme.titleMedium?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(pub.venue, style: theme.textTheme.bodySmall),
                          ],
                        ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
