import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';
import 'data.dart';
import 'widgets.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  const HomePage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'publications': GlobalKey(),
    'projects': GlobalKey(),
    'achievements': GlobalKey(),
    'certifications': GlobalKey(),
    'contact': GlobalKey(),
  };
  String _activeSection = 'about';
  static const _resumeUrl = 'https://drive.google.com/file/d/1nR40C2p7q3Zfxd9ihVOl7iD_vItlwAI3/view';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    String? active;
    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero).dy;
      if (pos <= 150) active = entry.key;
    }
    if (active != null && active != _activeSection) {
      setState(() => _activeSection = active!);
    }
  }

  void _scrollTo(String section) {
    if (section == 'resume') {
      _launch(_resumeUrl);
      return;
    }
    final key = _sectionKeys[section];
    if (key?.currentContext == null) return;
    Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }

  void _launch(String url) => launchUrl(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Scaffold(
      key: _scaffoldKey,
      drawer: isMobile ? _buildDrawer(context) : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Hero3D(),
                _SectionContainer(
                  key: _sectionKeys['about'],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSection(
                        delayMs: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(title: 'About'),
                            const SizedBox(height: 8),
                            const DividerLine(),
                            const SizedBox(height: 24),
                            Text(
                              ResumeData.summary,
                              style: TextStyle(
                                fontSize: 17,
                                color: AppTheme.of(context).textSecondary,
                                height: 1.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 64),
                      AnimatedSection(
                        delayMs: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(title: 'Research Interests'),
                            const SizedBox(height: 8),
                            const DividerLine(),
                            const SizedBox(height: 24),
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
                      const SizedBox(height: 64),
                      AnimatedSection(
                        delayMs: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(title: 'Education'),
                            const SizedBox(height: 8),
                            const DividerLine(),
                            const SizedBox(height: 24),
                            ...ResumeData.education
                                .map((e) => _EducationTile(edu: e)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _SectionContainer(
                  key: _sectionKeys['skills'],
                  color: true,
                  child: _buildSkills(context),
                ),
                _SectionContainer(
                  key: _sectionKeys['publications'],
                  child: _buildPublications(context),
                ),
                _SectionContainer(
                  key: _sectionKeys['projects'],
                  color: true,
                  child: _buildProjects(context),
                ),
                _SectionContainer(
                  key: _sectionKeys['achievements'],
                  child: _buildAchievements(context),
                ),
                _SectionContainer(
                  key: _sectionKeys['contact'],
                  color: true,
                  child: _buildFooter(context),
                ),
              ],
            ),
          ),
          _NavBar(
            activeSection: _activeSection,
            onTap: _scrollTo,
            onToggleTheme: widget.onToggleTheme,
            isDarkMode: widget.isDarkMode,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    return AnimatedSection(
      delayMs: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Technical Skills'),
          const SizedBox(height: 8),
          const DividerLine(),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = AppTheme.crossAxisCount(context);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.6,
                ),
                itemCount: ResumeData.skills.length,
                itemBuilder: (_, i) {
                  final skill = ResumeData.skills[i];
                  return GlowCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill.$1,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.of(context).textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: skill.$2
                                .map((s) => SkillChip(label: s))
                                .toList(),
                          ),
                        ),
                      ],
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

  Widget _buildPublications(BuildContext context) {
    return AnimatedSection(
      delayMs: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Publications'),
          const SizedBox(height: 8),
          const DividerLine(),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = AppTheme.crossAxisCount(context);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.4,
                ),
                itemCount: ResumeData.publications.length,
                itemBuilder: (_, i) {
                  final pub = ResumeData.publications[i];
                  return GlowCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pub.date,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.accent,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(pub.title,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.of(context).textPrimary,
                                  fontWeight: FontWeight.w500),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(height: 8),
                        Text(pub.venue,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.of(context).textSecondary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ],
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

  Widget _buildProjects(BuildContext context) {
    return AnimatedSection(
      delayMs: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Projects'),
          const SizedBox(height: 8),
          const DividerLine(),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = AppTheme.crossAxisCount(context);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.3,
                ),
                itemCount: ResumeData.projects.length,
                itemBuilder: (_, i) =>
                    ProjectFlipCard(project: ResumeData.projects[i]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(BuildContext context) {
    final cols = AppTheme.crossAxisCount(context);
    return AnimatedSection(
      delayMs: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Achievements'),
          const SizedBox(height: 8),
          const DividerLine(),
          const SizedBox(height: 32),
          Text('Honors & Awards',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.of(context).textPrimary)),
          const SizedBox(height: 16),
          ...ResumeData.honors.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(h.$1,
                          style: TextStyle(
                              fontSize: 13, color: AppTheme.accent)),
                    ),
                    Expanded(
                      child: Text(h.$2,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.of(context).textSecondary)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 48),
          Text('Certifications',
              key: _sectionKeys['certifications'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.of(context).textPrimary)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 280,
            ),
            itemCount: ResumeData.certifications.length,
            itemBuilder: (_, i) {
              final c = ResumeData.certifications[i];
              return CredentialCard(
                title: c.title,
                imageUrl: c.imageUrl,
                verifyUrl: c.verifyUrl,
                verifyLabel: 'Verify Certificate',
              );
            },
          ),
          const SizedBox(height: 48),
          Text('Badges',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.of(context).textPrimary)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols == 1 ? 1 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 280,
            ),
            itemCount: ResumeData.badges.length,
            itemBuilder: (_, i) {
              final b = ResumeData.badges[i];
              return CredentialCard(
                title: b.$1,
                imageUrl: b.$3,
                verifyUrl: b.$2,
                verifyLabel: 'Verify Badge',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          "Let's Connect",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Feel free to reach out for collaborations or opportunities',
          style: TextStyle(
              fontSize: 15, color: AppTheme.of(context).textSecondary),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterIcon(Icons.code, 'GitHub',
                'https://github.com/${ResumeData.github}'),
            const SizedBox(width: 16),
            _FooterIcon(Icons.workspace_premium, 'LinkedIn',
                'https://linkedin.com/in/${ResumeData.linkedin}'),
            const SizedBox(width: 16),
            _FooterIcon(Icons.email_outlined, 'Email',
                'mailto:${ResumeData.email}'),
          ],
        ),
        const SizedBox(height: 48),
        Text(
          '\u00a9 ${DateTime.now().year} Sidratul Punno. Built with Flutter.',
          style: TextStyle(
              fontSize: 12, color: AppTheme.of(context).textSecondary),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final items = ['about', 'skills', 'publications', 'projects', 'achievements', 'certifications', 'contact', 'resume'];
    return Drawer(
      child: Container(
        color: AppTheme.of(context).background,
        child: ListView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Text(
                'SP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.of(context).textPrimary,
                ),
              ),
            ),
            Divider(color: AppTheme.of(context).border),
            ...items.map((item) => ListTile(
              leading: Icon(
                item == 'resume' ? Icons.description : Icons.circle,
                size: item == 'resume' ? 20 : 8,
                color: AppTheme.accent,
              ),
              title: Text(
                item[0].toUpperCase() + item.substring(1),
                style: TextStyle(
                  color: AppTheme.of(context).textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                _scrollTo(item);
                _scaffoldKey.currentState?.closeDrawer();
              },
            )),
          ],
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final String activeSection;
  final void Function(String) onTap;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  final bool isMobile;

  const _NavBar({
    required this.activeSection,
    required this.onTap,
    required this.onToggleTheme,
    required this.isDarkMode,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final items = ['about', 'skills', 'publications', 'projects', 'achievements', 'certifications', 'contact', 'resume'];
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.black.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.7),
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.of(context).border.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'SP',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.of(context).textPrimary,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: isMobile
                        ? const SizedBox()
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: items.map((item) => _NavItem(
                                label: item[0].toUpperCase() + item.substring(1),
                                isActive: activeSection == item && item != 'resume',
                                onTap: () => onTap(item),
                              )).toList(),
                            ),
                          ),
                  ),
                  if (isMobile)
                    GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.of(context).surfaceLight.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.menu_rounded,
                          size: 20,
                          color: AppTheme.of(context).textSecondary,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      size: 20,
                    ),
                    color: AppTheme.of(context).textSecondary,
                    onPressed: onToggleTheme,
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

class _NavItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive
              ? AppTheme.accent.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isActive ? AppTheme.accent : AppTheme.of(context).textSecondary,
          ),
        ),
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final Widget child;
  final bool color;
  const _SectionContainer({required this.child, this.color = false, super.key});

  @override
  Widget build(BuildContext context) {
    final pad = AppTheme.horizontalPadding(context);
    return Container(
      width: double.infinity,
      color: color ? AppTheme.of(context).surface : null,
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: 80),
      child: child,
    );
  }
}

class _EducationTile extends StatelessWidget {
  final Education edu;
  const _EducationTile({required this.edu});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accent,
                ),
              ),
              Container(
                width: 2,
                height: 60,
                color: AppTheme.of(context).border.withValues(alpha: 0.5),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(edu.year,
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.accent,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(edu.title,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.of(context).textPrimary,
                        fontWeight: FontWeight.w500)),
                if (edu.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(edu.subtitle,
                      style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.of(context).textSecondary)),
                ],
                const SizedBox(height: 2),
                Text(edu.detail,
                    style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.of(context).textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  const _FooterIcon(this.icon, this.label, this.url);

  @override
  State<_FooterIcon> createState() => _FooterIconState();
}

class _FooterIconState extends State<_FooterIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hover
                ? AppTheme.accent.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hover
                  ? AppTheme.accent.withValues(alpha: 0.3)
                  : AppTheme.of(context).border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 18,
                  color: _hover ? AppTheme.accent : AppTheme.of(context).textSecondary),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  color: _hover ? AppTheme.accent : AppTheme.of(context).textSecondary,
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
