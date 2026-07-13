import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/colors.dart';
import '../../data/resume_data.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/publications_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/achievements_section.dart';
import 'widgets/certifications_section.dart';
import 'widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  const HomeScreen({super.key, required this.onToggleTheme, required this.isDarkMode});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'publications': GlobalKey(),
    'projects': GlobalKey(),
    'achievements': GlobalKey(),
    'certification': GlobalKey(),
    'contact': GlobalKey(),
  };
  String _activeSection = 'hero';

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
      if (pos <= 200) active = entry.key;
    }
    if (active != null && active != _activeSection) {
      setState(() => _activeSection = active!);
    }
  }

  void _scrollTo(String section) {
    if (section == 'resume') {
      _launch(ResumeData.resumeUrl);
      return;
    }
    final key = _sectionKeys[section];
    if (key?.currentContext == null) return;
    Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.06,
    );
  }

  void _launch(String url) => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Scaffold(
      drawer: isMobile ? _buildDrawer() : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeroSection(),
                _SectionContainer(key: _sectionKeys['about'], child: const AboutSection()),
                _SectionContainer(key: _sectionKeys['skills'], child: const SkillsSection()),
                _SectionContainer(key: _sectionKeys['publications'], child: const PublicationsSection()),
                _SectionContainer(key: _sectionKeys['projects'], child: const ProjectsSection()),
                _SectionContainer(key: _sectionKeys['achievements'], child: const AchievementsSection()),
                _SectionContainer(key: _sectionKeys['certification'], child: const CertificationsSection()),
                _SectionContainer(key: _sectionKeys['contact'], child: const ContactSection()),
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

  Widget _buildDrawer() {
    final items = ['about', 'skills', 'publications', 'projects', 'achievements', 'certification', 'contact', 'resume'];
    return Drawer(
      child: Container(color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Text('SP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Theme.of(context).textTheme.titleLarge?.color)),
            ),
            Divider(color: Theme.of(context).dividerColor),
            ...items.map((item) => Builder(builder: (ctx) => ListTile(
              leading: Icon(item == 'resume' ? Icons.description : Icons.circle,
                size: item == 'resume' ? 20 : 8,
                color: PortfolioColors.accent,
              ),
              title: Text(item[0].toUpperCase() + item.substring(1), style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color, fontWeight: FontWeight.w500)),
              onTap: () {
                _scrollTo(item);
                Scaffold.of(ctx).closeDrawer();
              },
            ))),
          ],
        ),
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final Widget child;
  const _SectionContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) => child;
}

class _NavBar extends StatelessWidget {
  final String activeSection;
  final void Function(String) onTap;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  final bool isMobile;

  const _NavBar({required this.activeSection, required this.onTap, required this.onToggleTheme, required this.isDarkMode, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final items = ['about', 'skills', 'publications', 'projects', 'achievements', 'certification', 'contact', 'resume'];
    return Positioned(
      top: 0, left: 0, right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: (isDarkMode ? PortfolioColors.navBarDark : PortfolioColors.navBarLight),
              border: Border(bottom: BorderSide(color: (isDarkMode ? PortfolioColors.borderDark : PortfolioColors.borderLight).withValues(alpha: 0.3))),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Text('SP', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Theme.of(context).textTheme.titleLarge?.color, letterSpacing: 1)),
                  const SizedBox(width: 24),
                  Expanded(
                    child: isMobile ? const SizedBox() : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: items.map((item) => _NavItem(
                        label: item[0].toUpperCase() + item.substring(1),
                        isActive: activeSection == item && item != 'resume',
                        onTap: () => onTap(item),
                        isDarkMode: isDarkMode,
                      )).toList()),
                    ),
                  ),
                  if (isMobile)
                    GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(color: PortfolioColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.menu_rounded, size: 20, color: isDarkMode ? PortfolioColors.textSecondaryDark : PortfolioColors.textSecondaryLight),
                      ),
                    ),
                  IconButton(
                    icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, size: 20),
                    color: isDarkMode ? PortfolioColors.textSecondaryDark : PortfolioColors.textSecondaryLight,
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
  final bool isDarkMode;
  const _NavItem({required this.label, required this.isActive, required this.onTap, this.isDarkMode = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? PortfolioColors.accent.withValues(alpha: 0.1) : Colors.transparent,
        ),
        child: Text(label, style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isActive ? PortfolioColors.accent : (isDarkMode ? PortfolioColors.textSecondaryDark : PortfolioColors.textSecondaryLight),
        )),
      ),
    );
  }
}
