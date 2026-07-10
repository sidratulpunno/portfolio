import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = AppTheme.paddingScreenWide(context);
    final cols = AppTheme.gridColumns(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pad.horizontal, vertical: AppTheme.sectionSpacing(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSection(
            child: const SectionHeader(
              title: 'Projects',
              subtitle: 'Selected work across HPC, AI, mobile, and IoT',
            ),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 260,
            ),
            itemCount: ResumeData.projects.length,
            itemBuilder: (_, i) => AnimatedSection(
              delayMs: i * 100,
              child: ProjectCard(project: ResumeData.projects[i], index: i),
            ),
          ),
        ],
      ),
    );
  }
}
