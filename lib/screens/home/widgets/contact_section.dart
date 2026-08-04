import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../utils/launch.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/hover_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        children: [
          AnimatedSection(
            child: Column(
              children: [
                Text(
                  '08',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: PortfolioColors.accent,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        PortfolioColors.accent,
                        PortfolioColors.accentLight,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Let's Connect",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Feel free to reach out for collaborations or opportunities',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          AnimatedSection(
            delayMs: 200,
            child: LayoutBuilder(
              builder: (context, c) {
                final blocks = [
                  _ContactBlock(
                    icon: Icons.code,
                    label: 'GitHub',
                    handle: '@${ResumeData.github}',
                    url: 'https://github.com/${ResumeData.github}',
                    brandColor: const Color(0xFF24292F),
                  ),
                  _ContactBlock(
                    icon: Icons.workspace_premium,
                    label: 'LinkedIn',
                    handle: 'in/${ResumeData.linkedin}',
                    url: 'https://linkedin.com/in/${ResumeData.linkedin}',
                    brandColor: const Color(0xFF0A66C2),
                  ),
                  _ContactBlock(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    handle: ResumeData.email,
                    url: 'mailto:${ResumeData.email}',
                    brandColor: const Color(0xFFEA4335),
                  ),
                ];
                if (c.maxWidth > 640) {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var i = 0; i < blocks.length; i++) ...[
                          if (i > 0) const SizedBox(width: 16),
                          Expanded(child: blocks[i]),
                        ],
                      ],
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < blocks.length; i++) ...[
                      if (i > 0) const SizedBox(height: 16),
                      blocks[i],
                    ],
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 64),
          AnimatedSection(delayMs: 400, child: _buildFooter(context)),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => launchUrlExternal(ResumeData.portfolioRepo),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.code, size: 14, color: PortfolioColors.accent),
                  const SizedBox(width: 6),
                  Text(
                    'View Source',
                    style: TextStyle(
                      fontSize: 13,
                      color: PortfolioColors.accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Text(
              'Built with Flutter',
              style: TextStyle(
                fontSize: 13,
                color: PortfolioColors.textTertiaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '\u00a9 ${DateTime.now().year} Sidratul Punno. All rights reserved.',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(
              context,
            ).textTheme.bodySmall?.color?.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _ContactBlock extends StatelessWidget {
  final IconData icon;
  final String label;
  final String handle;
  final String url;
  final Color brandColor;
  const _ContactBlock({
    required this.icon,
    required this.label,
    required this.handle,
    required this.url,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final fg = dark ? Color.lerp(brandColor, Colors.white, 0.4)! : brandColor;
    return HoverCard(
      padding: const EdgeInsets.all(18),
      onTap: () => launchUrlExternal(url),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: fg),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.titleMedium?.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            handle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: PortfolioColors.accent,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
