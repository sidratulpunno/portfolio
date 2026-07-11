import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = AppTheme.paddingScreenWide(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pad.horizontal, vertical: AppTheme.sectionSpacing(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSection(
            child: const SectionHeader(title: 'Achievements', subtitle: 'Honors and awards'),
          ),
          const SizedBox(height: 32),
          ...ResumeData.honors.map((h) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(h.$1, style: TextStyle(fontSize: 13, color: PortfolioColors.accent, fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: Text(h.$2, style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
