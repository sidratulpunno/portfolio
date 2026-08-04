import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../data/resume_data.dart';
import '../../../utils/launch.dart';

class HeroSection extends StatefulWidget {
  final AnimationController? scrollAnim;
  const HeroSection({super.key, this.scrollAnim});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatAnim;
  double _mouseX = 0;
  double _mouseY = 0;

  @override
  void initState() {
    super.initState();
    _floatAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatAnim.dispose();
    super.dispose();
  }

  void _onMouseMove(PointerEvent e) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final local = box.globalToLocal(e.position);
    setState(() {
      _mouseX = (local.dx / box.size.width - 0.5) * 2;
      _mouseY = (local.dy / box.size.height - 0.5) * 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 600;

    return MouseRegion(
      onHover: _onMouseMove,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final viewportHeight = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: math.max(viewportHeight, 560),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _buildAnimatedBackground(isMobile),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: isMobile ? 88 : 84,
                        left: isMobile ? 20 : 48,
                        right: isMobile ? 20 : 48,
                        bottom: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildAvatar(isMobile),
                          const SizedBox(height: 28),
                          _buildName(isMobile),
                          const SizedBox(height: 20),
                          _buildTagline(isMobile),
                          const SizedBox(height: 32),
                          _buildStats(isMobile),
                          const SizedBox(height: 32),
                          _buildCtAs(isMobile),
                          const SizedBox(height: 48),
                          _buildScrollIndicator(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildName(bool isMobile) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final baseText = dark
        ? PortfolioColors.textPrimaryDark
        : PortfolioColors.textPrimaryLight;
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (_, _) {
        final float = math.sin(_floatAnim.value * 2 * math.pi) * 8;
        return Transform.translate(
          offset: Offset(0, float),
          child: ShaderMask(
            shaderCallback: (bounds) {
              final phase = _floatAnim.value;
              final begin = Alignment(-0.6 + phase, 0.5);
              final end = Alignment(0.9 + phase, -0.5);
              return LinearGradient(
                colors: [
                  baseText,
                  PortfolioColors.accent,
                  PortfolioColors.accentLight,
                  baseText,
                ],
                begin: begin,
                end: end,
                stops: const [0, 0.45, 0.75, 1],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: Text(
              ResumeData.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 34 : 64,
                fontWeight: FontWeight.w700,
                letterSpacing: isMobile ? -0.5 : -2,
                height: 1.12,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagline(bool isMobile) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          width: 40,
          height: 3,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [PortfolioColors.accent, PortfolioColors.accentLight],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(
          ResumeData.tagline,
          style: TextStyle(
            fontSize: isMobile ? 16 : 20,
            color: dark
                ? PortfolioColors.accentLight
                : PortfolioColors.accentDark,
            fontWeight: FontWeight.w500,
            letterSpacing: isMobile ? 2 : 4,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(bool isMobile) {
    final size = isMobile ? 96.0 : 132.0;
    return Center(
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: const [
              PortfolioColors.accent,
              PortfolioColors.accentLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: PortfolioColors.accent.withValues(alpha: 0.35),
              blurRadius: 32,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: PortfolioColors.surfaceLight,
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: size * 0.09),
              child: Text(
                'SP',
                style: TextStyle(
                  fontSize: size * 0.34,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: PortfolioColors.accentDark,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStats(bool isMobile) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    Color statColor(Color c) =>
        dark ? Color.lerp(c, Colors.white, 0.4)! : c;
    final stats = [
      (
        ResumeData.publications.length.toString(),
        'Publications',
        statColor(PortfolioColors.purple.foreground),
      ),
      (
        ResumeData.projects.length.toString(),
        'Projects',
        statColor(PortfolioColors.cyan.foreground),
      ),
      (
        ResumeData.certifications.length.toString(),
        'Certifications',
        statColor(PortfolioColors.amber.foreground),
      ),
    ];

    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 420) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                _StatPill(value: stats[i].$1, label: stats[i].$2),
              ],
            ],
          );
        }
                return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < stats.length; i++) ...[
              if (i > 0)
                Container(
                  width: 1,
                  height: 40,
                  color: theme.dividerColor.withValues(alpha: 0.5),
                ),
              _StatBlock(
                value: stats[i].$1,
                label: stats[i].$2,
                color: stats[i].$3,
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildCtAs(bool isMobile) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, c) {
        final primary = _buildCta('View Projects', _scrollToProjects);
        final outline = _buildCtaOutline(
          'Download Resume',
          () => launchUrlExternal(ResumeData.resumeUrl),
          theme,
        );
        if (c.maxWidth < 380 || isMobile) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              primary,
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: outline),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            primary,
            const SizedBox(width: 16),
            outline,
          ],
        );
      },
    );
  }

  void _scrollToProjects() {
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) return;
    scrollable.position.animateTo(
      scrollable.position.pixels + MediaQuery.of(context).size.height * 0.9,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  Widget _buildCta(String label, VoidCallback onTap) {
    return _MagneticButton(
      onTap: onTap,
      child: (hover, scale) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: hover
            ? (Matrix4.translationValues(0, -3, 0)..scaleByDouble(scale, scale, 1.0, 1.0))
            : Matrix4.identity(),
        padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? 24 : 30,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              PortfolioColors.accent,
              PortfolioColors.accentLight,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: PortfolioColors.accent.withValues(
                alpha: hover ? 0.45 : 0.3,
              ),
              blurRadius: hover ? 32 : 20,
              spreadRadius: hover ? 2 : 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  bool get isNarrow =>
      MediaQuery.of(context).size.width < 420;

  Widget _buildCtaOutline(String label, VoidCallback onTap, ThemeData theme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground(bool isMobile) {
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (_, _) {
        final dx = _mouseX * 20 + math.sin(_floatAnim.value * 2 * math.pi) * 15;
        final dy = _mouseY * 20 + math.cos(_floatAnim.value * 2 * math.pi) * 15;
        return CustomPaint(
          size: Size.infinite,
          painter: _MeshGradientPainter(
            dx,
            dy,
            Theme.of(context).brightness == Brightness.dark,
            isMobile,
          ),
        );
      },
    );
  }

  Widget _buildScrollIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Text(
            'SCROLL DOWN',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: PortfolioColors.textTertiaryDark.withValues(alpha: 0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          _BounceArrow(),
        ],
      ),
    );
  }
}

class _MagneticButton extends StatefulWidget {
  final Widget Function(bool hover, double scale) child;
  final VoidCallback onTap;
  const _MagneticButton({required this.child, required this.onTap});

  @override
  State<_MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<_MagneticButton> {
  bool _hover = false;
  double _pull = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() {
        _hover = false;
        _pull = 0;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: 1 + _pull * 0.03,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: widget.child(_hover, 1 + _pull * 0.02),
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatBlock({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w700,
              height: 1,
              color: color,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1.5,
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String value;
  final String label;
  const _StatPill({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: PortfolioColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PortfolioColors.accent.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1,
              color: dark
                  ? PortfolioColors.accentLight
                  : PortfolioColors.accentDark,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: dark
                  ? PortfolioColors.textSecondaryDark
                  : Colors.black54,
            ),
          ),
        ],
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
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _a = Tween<double>(
      begin: 0,
      end: 6,
    ).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
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
        child: Icon(
          Icons.keyboard_arrow_down,
          color: PortfolioColors.textTertiaryDark.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

class _MeshGradientPainter extends CustomPainter {
  final double dx;
  final double dy;
  final bool dark;
  final bool isMobile;

  _MeshGradientPainter(this.dx, this.dy, this.dark, this.isMobile);

  @override
  void paint(Canvas canvas, Size size) {
    final blur = isMobile ? 60.0 : 100.0;
    final paint = Paint()..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);
    final offset = isMobile ? 0.5 : 1.0;

    paint.color = PortfolioColors.accent.withValues(alpha: dark ? 0.06 : 0.05);
    canvas.drawCircle(
      Offset(size.width * 0.3 + dx * offset, size.height * 0.3 + dy * offset),
      200,
      paint,
    );

    paint.color = dark
        ? PortfolioColors.accentLight.withValues(alpha: 0.05)
        : PortfolioColors.accentDark.withValues(alpha: 0.04);
    canvas.drawCircle(
      Offset(size.width * 0.7 - dx * offset, size.height * 0.6 - dy * offset),
      180,
      paint,
    );

    paint.color = PortfolioColors.accent.withValues(alpha: dark ? 0.04 : 0.03);
    canvas.drawCircle(
      Offset(size.width * 0.5 + dy * offset, size.height * 0.8 + dx * 0.5),
      150,
      paint,
    );

    if (!isMobile) {
      paint.color = PortfolioColors.accentLight.withValues(
        alpha: dark ? 0.03 : 0.02,
      );
      canvas.drawCircle(
        Offset(size.width * 0.15 + dx * 0.3, size.height * 0.15 + dy * 0.3),
        120,
        paint,
      );
    }

    final gridPaint = Paint()
      ..color = (dark ? Colors.white : Colors.black).withValues(alpha: 0.02)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 60) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 60) {
      canvas.drawLine(Offset(0, y), Offset(size.width, size.height), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MeshGradientPainter old) =>
      old.dx != dx || old.dy != dy;
}