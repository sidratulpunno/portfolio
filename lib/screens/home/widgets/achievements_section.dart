import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/credential_card.dart';

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
            child: const SectionHeader(title: 'Achievements', subtitle: 'Honors, awards, and digital credentials'),
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
          if (ResumeData.badges.isNotEmpty) ...[
            const SizedBox(height: 48),
            AnimatedSection(
              delayMs: 100,
              child: const SectionHeader(title: 'Badges'),
            ),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppTheme.gridColumns(context) == 1 ? 1 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 280,
              ),
              itemCount: ResumeData.badges.length,
              itemBuilder: (_, i) => AnimatedSection(
                delayMs: i * 100,
                child: CredentialCard(
                  title: ResumeData.badges[i].title,
                  imageUrl: ResumeData.badges[i].imageUrl,
                  verifyUrl: ResumeData.badges[i].verifyUrl,
                  verifyLabel: 'Verify Badge',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
