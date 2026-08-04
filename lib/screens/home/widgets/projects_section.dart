import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/project_card.dart';
import '../../../widgets/bento_grid.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  List<List<int>> _spans(int cols) {
    switch (cols) {
      case 3:
        return const [
          [2, 1],
          [1, 1, 1],
        ];
      case 2:
        return const [
          [2],
          [1, 1],
          [1, 1],
        ];
      default:
        return const [
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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: pad.horizontal,
        vertical: AppTheme.sectionSpacing(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSection(
            child: const SectionHeader(
              title: 'Projects',
              subtitle: 'Selected work across HPC, AI, mobile, and IoT',
              index: '04',
            ),
          ),
          const SizedBox(height: 48),
          BentoGrid(
            rows: _spans(cols),
            spacing: 20,
            children: ResumeData.projects
                .asMap()
                .entries
                .map(
                  (e) => AnimatedSection(
                    delayMs: e.key * 100,
                    child: ProjectCard(project: e.value, index: e.key),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
