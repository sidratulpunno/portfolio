import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/timeline_item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = AppTheme.paddingScreenWide(context);

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
              title: 'Experience',
              subtitle: 'Professional journey and research work',
              index: '09',
            ),
          ),
          const SizedBox(height: 48),
          ...ResumeData.experiences.asMap().entries.map(
            (entry) => AnimatedSection(
              delayMs: entry.key * 150,
              child: TimelineItem(
                company: entry.value.company,
                role: entry.value.role,
                period: entry.value.period,
                description: entry.value.description,
                highlights: entry.value.highlights,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
