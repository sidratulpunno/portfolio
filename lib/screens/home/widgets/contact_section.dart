import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../utils/launch.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/glass_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pad = AppTheme.paddingScreenWide(context);

    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? PortfolioColors.cardDark
          : PortfolioColors.borderLight.withValues(alpha: 0.3),
      padding: EdgeInsets.symmetric(horizontal: pad.horizontal, vertical: AppTheme.sectionSpacing(context)),
      child: Column(
        children: [
          AnimatedSection(
            child: Column(
              children: [
                Text(
                  "Let's Connect",
                  style: theme.textTheme.headlineMedium,
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
            child: GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _ContactIcon(Icons.code, 'GitHub',
                      'https://github.com/${ResumeData.github}'),
                  _ContactIcon(Icons.workspace_premium, 'LinkedIn',
                      'https://linkedin.com/in/${ResumeData.linkedin}'),
                  _ContactIcon(Icons.email_outlined, 'Email',
                      'mailto:${ResumeData.email}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 64),
          AnimatedSection(
            delayMs: 400,
            child: _buildFooter(context),
          ),
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
            color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _ContactIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  const _ContactIcon(this.icon, this.label, this.url);

  @override
  State<_ContactIcon> createState() => _ContactIconState();
}

class _ContactIconState extends State<_ContactIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => launchUrlExternal(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hover ? PortfolioColors.accent.withValues(alpha: 0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hover
                  ? PortfolioColors.accent.withValues(alpha: 0.3)
                  : (dark ? PortfolioColors.borderDark : PortfolioColors.borderLight),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18,
                color: _hover ? PortfolioColors.accent : (dark ? PortfolioColors.textSecondaryDark : PortfolioColors.textSecondaryLight),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  color: _hover ? PortfolioColors.accent : (dark ? PortfolioColors.textSecondaryDark : PortfolioColors.textSecondaryLight),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
