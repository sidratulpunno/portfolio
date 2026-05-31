import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'safe_image.dart';
import 'theme.dart';
import 'data.dart';

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final int delayMs;
  const AnimatedSection({super.key, required this.child, this.delayMs = 0});

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted && !_started) {
        _started = true;
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _started = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  const SectionHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(subtitle!, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ],
    );
  }
}

class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppTheme.accent,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class Hero3D extends StatefulWidget {
  const Hero3D({super.key});

  @override
  State<Hero3D> createState() => _Hero3DState();
}

class _Hero3DState extends State<Hero3D> with SingleTickerProviderStateMixin {
  late final AnimationController _autoRotate;
  double _tiltX = 0;
  double _tiltY = 0;
  bool _idle = true;

  @override
  void initState() {
    super.initState();
    _autoRotate = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _autoRotate.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent e) {
    if (!mounted) return;
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final local = box.globalToLocal(e.position);
    setState(() {
      _idle = false;
      _tiltX = ((local.dy - size.height / 2) / (size.height / 2)) * 12;
      _tiltY = ((local.dx - size.width / 2) / (size.width / 2)) * 12;
    });
  }

  void _onExit(PointerEvent _) {
    setState(() {
      _idle = true;
      _tiltX = 0;
      _tiltY = 0;
    });
  }

  void _launch(String url) => launchUrl(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: MouseRegion(
        onHover: _onHover,
        onExit: _onExit,
        child: AnimatedBuilder(
          animation: _autoRotate,
          builder: (context, _) {
            final breathe = _idle
                ? math.sin(_autoRotate.value * 2 * math.pi) * 2.5
                : 0.0;
            final rx = (_tiltX + breathe) * math.pi / 180;
            final ry = _tiltY * math.pi / 180;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateX(rx)
                ..rotateY(ry),
              alignment: Alignment.center,
              child: _buildContent(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    final pad = AppTheme.horizontalPadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pad),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          _buildGlow(),
          const SizedBox(height: 8),
          Text(
            ResumeData.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          Text(
            ResumeData.tagline,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.accent,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIcon(
                icon: Icons.code,
                label: 'GitHub',
                onTap: () => _launch('https://github.com/${ResumeData.github}'),
              ),
              const SizedBox(width: 8),
              _SocialIcon(
                icon: Icons.workspace_premium,
                label: 'LinkedIn',
                onTap: () =>
                    _launch('https://linkedin.com/in/${ResumeData.linkedin}'),
              ),
              const SizedBox(width: 8),
              _SocialIcon(
                icon: Icons.email_outlined,
                label: 'Email',
                onTap: () => _launch('mailto:${ResumeData.email}'),
              ),
            ],
          ),
          const Spacer(flex: 2),
          _buildScrollIndicator(),
        ],
      ),
    );
  }

  Widget _buildGlow() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.accent.withValues(alpha: 0.15),
            AppTheme.accent.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Text(
            'SCROLL DOWN',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.of(context).textSecondary.withValues(alpha: 0.5),
                  letterSpacing: 3,
                ),
          ),
          const SizedBox(height: 12),
          _BounceArrow(),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SocialIcon(
      {required this.icon, required this.label, required this.onTap});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _hover
                ? AppTheme.accent.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hover ? AppTheme.accent.withValues(alpha: 0.3) : AppTheme.of(context).border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 18,
                  color: _hover ? AppTheme.accent : AppTheme.of(context).textSecondary),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
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

class _BounceArrow extends StatefulWidget {
  @override
  State<_BounceArrow> createState() => _BounceArrowState();
}

class _BounceArrowState extends State<_BounceArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _a = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, _) => Transform.translate(
        offset: Offset(0, _a.value),
        child: Icon(Icons.keyboard_arrow_down,
            color: AppTheme.of(context).textSecondary.withValues(alpha: 0.5)),
      ),
    );
  }
}

class ProjectFlipCard extends StatefulWidget {
  final Project project;
  const ProjectFlipCard({super.key, required this.project});

  @override
  State<ProjectFlipCard> createState() => _ProjectFlipCardState();
}

class _ProjectFlipCardState extends State<ProjectFlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _flipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_flipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _flipped = !_flipped;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, _) {
          final progress = _animation.value;
          final squeeze = 1.0 - (progress - 0.5).abs() * 2;
          final showBack = progress >= 0.5;
          return SizedBox(
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: showBack ? 0.0 : 1.0,
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: progress < 0.5 ? 1.0 - progress * 2 : 0.0,
                    child: _buildFront(),
                  ),
                ),
                Opacity(
                  opacity: showBack ? 1.0 : 0.0,
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: showBack ? squeeze : 0.0,
                    child: _buildBack(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.of(context).cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.of(context).border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(widget.project.tech,
                style: TextStyle(fontSize: 11, color: AppTheme.accent)),
          ),
          const Spacer(),
          Text(
            widget.project.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('Tap to explore',
                  style: TextStyle(fontSize: 13, color: AppTheme.of(context).textSecondary)),
              const Spacer(),
              Icon(Icons.arrow_forward,
                  size: 16, color: AppTheme.of(context).textSecondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.of(context).cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.of(context).border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key Highlights',
              style: TextStyle(fontSize: 13, color: AppTheme.accent)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: widget.project.points.length,
              separatorBuilder: (_, _) => const SizedBox(height: 6),
              itemBuilder: (_, i) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\u2022 ',
                      style: TextStyle(color: AppTheme.accent, fontSize: 14)),
                  Expanded(
                    child: Text(
                      widget.project.points[i],
                      style: TextStyle(
                          fontSize: 13, color: AppTheme.of(context).textSecondary, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TiltWidget extends StatefulWidget {
  final Widget child;
  final double maxTilt;
  final double perspective;

  const TiltWidget({
    super.key,
    required this.child,
    this.maxTilt = 10,
    this.perspective = 0.001,
  });

  @override
  State<TiltWidget> createState() => _TiltWidgetState();
}

class _TiltWidgetState extends State<TiltWidget>
    with SingleTickerProviderStateMixin {
  double _tiltX = 0;
  double _tiltY = 0;
  bool _idle = true;
  late final AnimationController _idleAnim;

  @override
  void initState() {
    super.initState();
    _idleAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _idleAnim.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent e) {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final local = box.globalToLocal(e.position);
    setState(() {
      _idle = false;
      _tiltX = ((local.dy - size.height / 2) / (size.height / 2)) * widget.maxTilt;
      _tiltY = ((local.dx - size.width / 2) / (size.width / 2)) * widget.maxTilt;
    });
  }

  void _onExit(PointerEvent _) {
    setState(() {
      _idle = true;
      _tiltX = 0;
      _tiltY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _idleAnim,
        builder: (context, _) {
          final breath = _idle
              ? math.sin(_idleAnim.value * 2 * math.pi) * 0.5
              : 0.0;
          final rx = (_tiltX + breath) * math.pi / 180;
          final ry = _tiltY * math.pi / 180;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, widget.perspective)
              ..rotateX(rx)
              ..rotateY(ry),
            alignment: Alignment.center,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class CredentialCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String verifyUrl;
  final String verifyLabel;

  const CredentialCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.verifyUrl,
    this.verifyLabel = 'Verify',
  });

  @override
  State<CredentialCard> createState() => _CredentialCardState();
}

class _CredentialCardState extends State<CredentialCard> {
  bool _hover = false;

  void _launch(String url) => launchUrl(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    return TiltWidget(
      maxTilt: 6,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.of(context).cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hover
                  ? AppTheme.accent.withValues(alpha: 0.4)
                  : AppTheme.of(context).border.withValues(alpha: 0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: _hover
                    ? AppTheme.accent.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.15),
                blurRadius: _hover ? 24 : 12,
                offset: Offset(0, _hover ? 10 : 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.of(context).textPrimary,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SafeImage(
                    src: widget.imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: AppTheme.of(context).surface,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.of(context).surface,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppTheme.of(context).textSecondary,
                            size: 28,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _launch(widget.verifyUrl),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: _hover
                        ? AppTheme.accent.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.accent.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        size: 13,
                        color: AppTheme.accent,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.verifyLabel,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.of(context).surfaceLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppTheme.of(context).border.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 13, color: AppTheme.of(context).textSecondary)),
    );
  }
}

class GlowCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const GlowCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.of(context).cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.of(context).border.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accent.withValues(alpha: 0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
