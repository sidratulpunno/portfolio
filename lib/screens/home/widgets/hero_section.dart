import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/app_theme.dart';
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
    final box = context.findRenderObject() as RenderBox;
    final local = box.globalToLocal(e.position);
    setState(() {
      _mouseX = (local.dx / box.size.width - 0.5) * 2;
      _mouseY = (local.dy / box.size.height - 0.5) * 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pad = AppTheme.paddingScreenWide(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 600;

    return MouseRegion(
      onHover: _onMouseMove,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: [
            _buildAnimatedBackground(isMobile),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pad.horizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    _buildGlow(),
                    const SizedBox(height: 24),
                    _buildName(theme, isMobile),
                    const SizedBox(height: 12),
                    _buildTagline(isMobile),
                    const SizedBox(height: 40),
                    isMobile
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildCta('View Projects', () {}),
                              const SizedBox(height: 12),
                              _buildCtaOutline('Download Resume', () => launchUrlExternal(ResumeData.resumeUrl), theme),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCta('View Projects', () {}),
                              const SizedBox(width: 16),
                              _buildCtaOutline('Download Resume', () => launchUrlExternal(ResumeData.resumeUrl), theme),
                            ],
                          ),
                    const Spacer(flex: 2),
                    _buildScrollIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildName(ThemeData theme, bool isMobile) {
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (_, _) {
        final float = math.sin(_floatAnim.value * 2 * math.pi) * 8;
        return Transform.translate(
          offset: Offset(0, float),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                theme.textTheme.displayLarge?.color ?? Colors.white,
                PortfolioColors.accent.withValues(alpha: 0.7),
                theme.textTheme.displayLarge?.color ?? Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            blendMode: BlendMode.srcIn,
            child: Text(
              ResumeData.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 44 : 72,
                fontWeight: FontWeight.w700,
                letterSpacing: isMobile ? 0 : -2,
                height: 1.1,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagline(bool isMobile) {
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
            color: PortfolioColors.accent,
            fontWeight: FontWeight.w500,
            letterSpacing: 4,
          ),
        ),
      ],
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
          painter: _MeshGradientPainter(dx, dy, Theme.of(context).brightness == Brightness.dark, isMobile),
        );
      },
    );
  }

  Widget _buildGlow() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            PortfolioColors.accent.withValues(alpha: 0.15),
            PortfolioColors.accent.withValues(alpha: 0.04),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildCta(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [PortfolioColors.accent, PortfolioColors.accentLight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: PortfolioColors.accent.withValues(alpha: 0.3),
              blurRadius: 20,
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

  Widget _buildCtaOutline(String label, VoidCallback onTap, ThemeData theme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.3) ?? Colors.grey,
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

  Widget _buildScrollIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
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
    _a = Tween<double>(begin: 0, end: 6).animate(
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

    paint.color = PortfolioColors.accent.withValues(alpha: dark ? 0.05 : 0.04);
    canvas.drawCircle(Offset(size.width * 0.3 + dx * offset, size.height * 0.3 + dy * offset), 200, paint);

    paint.color = dark
        ? PortfolioColors.accentLight.withValues(alpha: 0.04)
        : PortfolioColors.accentDark.withValues(alpha: 0.03);
    canvas.drawCircle(Offset(size.width * 0.7 - dx * offset, size.height * 0.6 - dy * offset), 180, paint);

    paint.color = PortfolioColors.accent.withValues(alpha: dark ? 0.03 : 0.02);
    canvas.drawCircle(Offset(size.width * 0.5 + dy * offset, size.height * 0.8 + dx * 0.5), 150, paint);

    if (!isMobile) {
      paint.color = PortfolioColors.accentLight.withValues(alpha: dark ? 0.02 : 0.015);
      canvas.drawCircle(Offset(size.width * 0.15 + dx * 0.3, size.height * 0.15 + dy * 0.3), 120, paint);
    }

    final gridPaint = Paint()
      ..color = (dark ? Colors.white : Colors.black).withValues(alpha: 0.015)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 60) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 60) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MeshGradientPainter old) => old.dx != dx || old.dy != dy;
}
