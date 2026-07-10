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
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: _showDetails,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          transform: _hover ? Matrix4.translationValues(0, -6, 0) : Matrix4.identity(),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              gradient: _hover
                  ? LinearGradient(
                      colors: [
                        PortfolioColors.accent.withValues(alpha: 0.4),
                        PortfolioColors.accentLight.withValues(alpha: 0.15),
                        PortfolioColors.accent.withValues(alpha: 0.25),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            padding: const EdgeInsets.all(1),
            child: GlassCard(
              glow: _hover,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: PortfolioColors.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.project.tech,
                          style: TextStyle(fontSize: 11, color: PortfolioColors.accent, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Spacer(),
                      if (widget.project.githubUrl != null)
                        _IconBtn(Icons.code, 'GitHub', () => launchUrlExternal(widget.project.githubUrl!)),
                      if (widget.project.liveUrl != null)
                        _IconBtn(Icons.open_in_new, 'Live', () => launchUrlExternal(widget.project.liveUrl!)),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    widget.project.title,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.project.points.join(' \u2022 '),
                    style: theme.textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          children: [
                            Text(
                              _hover ? 'View Details' : 'Explore Project',
                              style: TextStyle(
                                fontSize: 13,
                                color: PortfolioColors.accent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: PortfolioColors.accent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                        color: (dark ? PortfolioColors.textTertiaryDark : PortfolioColors.textTertiaryLight).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: PortfolioColors.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(project.tech, style: TextStyle(fontSize: 12, color: PortfolioColors.accent, fontWeight: FontWeight.w500)),
                      ),
                      const Spacer(),
                      if (project.githubUrl != null)
                        _ActionBtn(Icons.code, 'GitHub', () { Navigator.pop(context); launchUrlExternal(project.githubUrl!); }),
                      if (project.liveUrl != null) ...[
                        const SizedBox(width: 8),
                        _ActionBtn(Icons.open_in_new, 'Live Demo', () { Navigator.pop(context); launchUrlExternal(project.liveUrl!); }),
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
                  Text(project.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(width: 3, height: 16,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [PortfolioColors.accent, PortfolioColors.accentLight],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('Key Highlights', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: PortfolioColors.accent)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...project.points.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 6, height: 6,
                          decoration: BoxDecoration(
                            color: PortfolioColors.accent,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: PortfolioColors.accent.withValues(alpha: 0.4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(p, style: theme.textTheme.bodyMedium?.copyWith(height: 1.7))),
                      ],
                    ),
                  )),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: PortfolioColors.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: PortfolioColors.accent),
            const SizedBox(width: 5),
            Text(label, style: TextStyle(fontSize: 12, color: PortfolioColors.accent, fontWeight: FontWeight.w500)),
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
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: PortfolioColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 14, color: PortfolioColors.accent),
        ),
      ),
    );
  }
}
