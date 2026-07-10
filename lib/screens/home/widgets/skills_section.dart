import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/skill_chip.dart';
import '../../../widgets/glass_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pad = AppTheme.paddingScreenWide(context);
    final cols = AppTheme.gridColumns(context);

    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? PortfolioColors.cardDark
          : PortfolioColors.borderLight.withValues(alpha: 0.3),
      padding: EdgeInsets.symmetric(horizontal: pad.horizontal, vertical: AppTheme.sectionSpacing(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSection(
            child: const SectionHeader(title: 'Technical Skills', subtitle: 'Technologies and tools I work with'),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 220,
                ),
                itemCount: ResumeData.skills.length,
                itemBuilder: (_, i) {
                  final skill = ResumeData.skills[i];
                  return AnimatedSection(
                    delayMs: i * 100,
                    child: GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skill.name,
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: skill.skills
                                .map((s) => SkillChip(label: s, small: true))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
