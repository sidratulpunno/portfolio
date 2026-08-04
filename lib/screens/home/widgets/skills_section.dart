import 'package:flutter/material.dart';
import '../../../models/models.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/skill_chip.dart';
import '../../../widgets/hover_card.dart';
import '../../../widgets/bento_grid.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  List<List<int>> _spans(int cols) {
    switch (cols) {
      case 3:
        return const [
          [2, 1],
          [1, 1, 1],
          [3],
        ];
      case 2:
        return const [
          [2],
          [1, 1],
          [1, 1],
          [2],
        ];
      default:
        return const [
          [1],
          [1],
          [1],
          [1],
          [1],
          [1],
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = AppTheme.paddingScreenWide(context);
    final cols = AppTheme.gridColumns(context);

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
              title: 'Technical Skills',
              subtitle: 'Technologies and tools I work with',
              index: '02',
            ),
          ),
          const SizedBox(height: 48),
          BentoGrid(
            rows: _spans(cols),
            spacing: 20,
            children: ResumeData.skills
                .asMap()
                .entries
                .map(
                  (e) => AnimatedSection(
                    delayMs: e.key * 100,
                    child: _SkillCard(skill: e.value),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final SkillCategory skill;
  const _SkillCard({required this.skill});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HoverCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      PortfolioColors.accent,
                      PortfolioColors.accentLight,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  _categoryIcon(skill.name),
                  size: 17,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  skill.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: skill.skills
                .map(
                  (s) => SkillChip(
                    label: s,
                    small: true,
                    palette: PortfolioColors.paletteForCategory(skill.name),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

IconData _categoryIcon(String category) {
  final c = category.toLowerCase();
  if (c.contains('hpc') || c.contains('gpu')) return Icons.memory;
  if (c.contains('ai') || c.contains('ml') || c.contains('machine learning')) {
    return Icons.psychology;
  }
  if (c.contains('mobile')) return Icons.phone_android;
  if (c.contains('language')) return Icons.code;
  if (c.contains('backend') || c.contains('iot')) {
    return Icons.memory_outlined;
  }
  if (c.contains('tool') || c.contains('platform')) return Icons.build;
  return Icons.widgets;
}
