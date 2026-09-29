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
    final count = ResumeData.skills.length;
    List<List<int>> chunk(int c) {
      final rows = <List<int>>[];
      var remaining = count;
      // First row highlight: [2,1] when possible on 3-col
      if (c == 3 && remaining >= 2) {
        rows.add(const [2, 1]);
        remaining -= 2;
      } else if (c == 2 && remaining >= 1) {
        rows.add(const [2]);
        remaining -= 1;
      }
      while (remaining > 0) {
        if (remaining >= c) {
          rows.add(List.filled(c, 1));
          remaining -= c;
        } else if (remaining == 1 && c == 3) {
          rows.add(const [3]);
          remaining -= 1;
        } else if (remaining == 1 && c == 2) {
          rows.add(const [2]);
          remaining -= 1;
        } else {
          rows.add(List.filled(remaining, 1));
          remaining = 0;
        }
      }
      return rows;
    }
    return chunk(cols);
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
  if (c.contains('backend')) return Icons.dns;
  if (c.contains('language')) return Icons.code;
  if (c.contains('iot')) return Icons.sensors;
  if (c.contains('pcb')) return Icons.developer_board;
  if (c.contains('operating') || c.contains('system') && c.contains('oper')) return Icons.computer;
  if (c.contains('typeset') || c.contains('latex')) return Icons.text_fields;
  if (c.contains('database')) return Icons.storage;
  if (c.contains('tool') || c.contains('platform')) return Icons.build;
  return Icons.widgets;
}
