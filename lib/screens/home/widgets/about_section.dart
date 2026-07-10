import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../utils/launch.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/skill_chip.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pad = AppTheme.paddingScreenWide(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pad.horizontal, vertical: AppTheme.sectionSpacing(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSection(
            child: Row(
              children: [
                Container(width: 5, height: 28,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [PortfolioColors.accent, PortfolioColors.accentLight],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 14),
                Text('About', style: theme.textTheme.headlineMedium),
              ],
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              if (isWide) return _buildWideLayout(theme);
              return _buildNarrowLayout(theme);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWideLayout(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: AnimatedSection(
            child: GlassCard(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ResumeData.summary, style: theme.textTheme.bodyLarge?.copyWith(height: 1.8)),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildStat('Publications', ResumeData.publications.length.toString()),
                      _buildStat('Projects', ResumeData.projects.length.toString()),
                      _buildStat('Certifications', ResumeData.certifications.length.toString()),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildResumeButton(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 48),
        Flexible(
          flex: 2,
          child: AnimatedSection(
            delayMs: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Research Interests', style: theme.textTheme.titleLarge),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ResumeData.interests
                      .map((e) => SkillChip(label: e))
                      .toList(),
                ),
                const SizedBox(height: 48),
                Text('Education', style: theme.textTheme.titleLarge),
                const SizedBox(height: 16),
                ...ResumeData.education.map((e) => _EducationTile(edu: e)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSection(
          child: GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ResumeData.summary, style: theme.textTheme.bodyLarge?.copyWith(height: 1.8)),
                const SizedBox(height: 24),
                Wrap(spacing: 12, runSpacing: 12,
                  children: [
                    _buildStat('Publications', ResumeData.publications.length.toString()),
                    _buildStat('Projects', ResumeData.projects.length.toString()),
                    _buildStat('Certifications', ResumeData.certifications.length.toString()),
                  ],
                ),
                const SizedBox(height: 24),
                _buildResumeButton(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        AnimatedSection(
          delayMs: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Research Interests', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ResumeData.interests
                    .map((e) => SkillChip(label: e))
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        AnimatedSection(
          delayMs: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Education', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              ...ResumeData.education.map((e) => _EducationTile(edu: e)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: PortfolioColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: PortfolioColors.accent,
          )),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(
            fontSize: 13, color: PortfolioColors.accent,
          )),
        ],
      ),
    );
  }

  Widget _buildResumeButton() {
    return GestureDetector(
      onTap: () => launchUrlExternal(ResumeData.resumeUrl),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [PortfolioColors.accent, PortfolioColors.accentLight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Text('Download Resume', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class _EducationTile extends StatelessWidget {
  final dynamic edu;
  const _EducationTile({required this.edu});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: [
            Container(width: 8, height: 8,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: PortfolioColors.accent),
            ),
            Container(width: 1.5, height: 40,
              color: dark ? PortfolioColors.borderDark.withValues(alpha: 0.3) : PortfolioColors.borderLight.withValues(alpha: 0.3),
            ),
          ]),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(edu.year, style: TextStyle(fontSize: 12, color: PortfolioColors.accent, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(edu.title, style: TextStyle(fontSize: 15, color: theme.textTheme.titleMedium?.color, fontWeight: FontWeight.w500)),
            if (edu.institution.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(edu.institution, style: theme.textTheme.bodySmall),
            ],
            if (edu.detail.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(edu.detail, style: theme.textTheme.bodySmall?.copyWith(fontSize: 12)),
            ],
          ])),
        ],
      ),
    );
  }
}
