import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/colors.dart';
import '../utils/launch.dart';
import 'glass_card.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;
  const ProjectCard({super.key, required this.project, required this.index});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  void _showDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ProjectDetailSheet(project: widget.project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final techs = widget.project.tech
        .split('|')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: _showDetails,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: _hover
              ? (Matrix4.translationValues(0, -3, 0)
                  ..scaleByDouble(1.01, 1.01, 1.01, 1.0))
              : Matrix4.identity(),
          child: GlassCard(
            emphasize: _hover,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _GradientHeader(techs: techs, title: widget.project.title),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: techs.map((t) => _TechTag(t)).toList(),
                      ),
                    ),
                    if (widget.project.githubUrl != null)
                      _IconBtn(
                        Icons.code,
                        'GitHub',
                        () => launchUrlExternal(widget.project.githubUrl!),
                      ),
                    if (widget.project.liveUrl != null)
                      _IconBtn(
                        Icons.open_in_new,
                        'Live',
                        () => launchUrlExternal(widget.project.liveUrl!),
                      ),
                  ],
                ),
                const Spacer(),
                const SizedBox(height: 16),
                Text(
                  widget.project.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.project.points.join(' \u2022 '),
                  style: theme.textTheme.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                _hover ? 'View Details' : 'Explore Project',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: PortfolioColors.accent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            AnimatedSlide(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              offset: _hover ? const Offset(0.4, 0) : Offset.zero,
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                size: 15,
                                color: PortfolioColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientHeader extends StatelessWidget {
  final List<String> techs;
  final String title;
  const _GradientHeader({required this.techs, required this.title});

  @override
  Widget build(BuildContext context) {
    final initials = title
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0])
        .join();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            PortfolioColors.accent.withValues(alpha: 0.22),
            PortfolioColors.accentLight.withValues(alpha: 0.1),
            Colors.transparent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PortfolioColors.accent.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  PortfolioColors.accent,
                  PortfolioColors.accentLight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FEATURED PROJECT',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: PortfolioColors.accent,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  techs.join(' \u2022 '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag(this.label);

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: dark
            ? PortfolioColors.accent.withValues(alpha: 0.14)
            : PortfolioColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: PortfolioColors.accent.withValues(alpha: dark ? 0.35 : 0.25),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: PortfolioColors.accent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ProjectDetailSheet extends StatelessWidget {
  final Project project;
  const _ProjectDetailSheet({required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final pad = MediaQuery.of(context).padding;
    final bottom = pad.bottom + 24;

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: dark ? PortfolioColors.cardDark : PortfolioColors.cardLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    PortfolioColors.accent.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color:
                            (dark
                                    ? PortfolioColors.textTertiaryDark
                                    : PortfolioColors.textTertiaryLight)
                                .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: PortfolioColors.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          project.tech,
                          style: TextStyle(
                            fontSize: 12,
                            color: PortfolioColors.accent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (project.githubUrl != null)
                        _ActionBtn(Icons.code, 'GitHub', () {
                          Navigator.pop(context);
                          launchUrlExternal(project.githubUrl!);
                        }),
                      if (project.liveUrl != null) ...[
                        const SizedBox(width: 8),
                        _ActionBtn(Icons.open_in_new, 'Live Demo', () {
                          Navigator.pop(context);
                          launchUrlExternal(project.liveUrl!);
                        }),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.fromLTRB(24, 8, 24, bottom),
                children: [
                  Text(
                    project.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 16,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              PortfolioColors.accent,
                              PortfolioColors.accentLight,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Key Highlights',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: PortfolioColors.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...project.points.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: PortfolioColors.accent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: PortfolioColors.accent.withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              p,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionBtn(this.icon, this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: dark
              ? PortfolioColors.accent.withValues(alpha: 0.12)
              : PortfolioColors.accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: PortfolioColors.accent.withValues(alpha: dark ? 0.3 : 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: PortfolioColors.accent),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: PortfolioColors.accent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _IconBtn(this.icon, this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: dark
                ? PortfolioColors.accent.withValues(alpha: 0.12)
                : PortfolioColors.accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: PortfolioColors.accent.withValues(alpha: dark ? 0.3 : 0.2),
            ),
          ),
          child: Icon(icon, size: 14, color: PortfolioColors.accent),
        ),
      ),
    );
  }
}
