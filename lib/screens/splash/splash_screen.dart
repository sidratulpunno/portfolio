import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _taglineOpacity;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _glowPulse;
  late final Animation<double> _progress;

  String _typedText = '';
  final String _fullTagline = 'HPC & AI Engineer';
  int _charIndex = 0;
  Timer? _typeTimer;

  final List<_FloatingDot> _dots = [];
  final math.Random _random = math.Random(42);

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 30; i++) {
      _dots.add(_FloatingDot(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 3 + 1.5,
        speed: _random.nextDouble() * 0.3 + 0.1,
        phase: _random.nextDouble() * math.pi * 2,
        opacity: _random.nextDouble() * 0.4 + 0.1,
      ));
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack)),
    );
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3, curve: Curves.easeOut)),
    );
    _taglineOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.55, curve: Curves.easeOut)),
    );
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 12), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.55, curve: Curves.easeOutCubic)));
    _glowPulse = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0, curve: Curves.easeInOut)),
    );
    _progress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9, curve: Curves.easeInOut)),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 400), () {
          widget.onComplete();
        });
      }
    });

    _controller.forward();

    _startTyping();
  }

  void _startTyping() {
    _typeTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      if (_charIndex < _fullTagline.length) {
        setState(() => _typedText += _fullTagline[_charIndex]);
        _charIndex++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PortfolioColors.surfaceDark,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, _) => Stack(
          children: [
            _buildParticleField(),
            _buildCenterContent(),
            _buildBottomLoader(),
          ],
        ),
      ),
    );
  }

  Widget _buildParticleField() {
    return CustomPaint(
      size: Size.infinite,
      painter: _DotPainter(_dots, _controller.value, _random),
    );
  }

  Widget _buildCenterContent() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: _logoScale.value,
            child: Opacity(
              opacity: _logoOpacity.value,
              child: _buildLogo(),
            ),
          ),
          const SizedBox(height: 32),
          Opacity(
            opacity: _taglineOpacity.value,
            child: SlideTransition(
              position: _taglineSlide,
              child: _buildTagline(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: PortfolioColors.accent.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: PortfolioColors.accent.withValues(alpha: 0.15 * _glowPulse.value),
            blurRadius: 30 * _glowPulse.value,
            spreadRadius: 5 * _glowPulse.value,
          ),
        ],
      ),
      child: Center(
        child: Text(
          'SP',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: PortfolioColors.accent,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildTagline() {
    return Column(
      children: [
        Text(
          'Sheikh Sidratul Muntaha Punno',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: PortfolioColors.textPrimaryDark,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _typedText + (charIndex < _fullTagline.length ? '|' : ''),
          style: TextStyle(
            fontSize: 14,
            color: PortfolioColors.accent,
            fontWeight: FontWeight.w400,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }

  int get charIndex => _charIndex;

  Widget _buildBottomLoader() {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 2,
            decoration: BoxDecoration(
              color: PortfolioColors.borderDark.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(1),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _progress.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [PortfolioColors.accent, PortfolioColors.accentLight],
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'LOADING',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              color: PortfolioColors.textTertiaryDark.withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingDot {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double phase;
  final double opacity;
  _FloatingDot({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.phase,
    required this.opacity,
  });
}

class _DotPainter extends CustomPainter {
  final List<_FloatingDot> dots;
  final double time;
  final math.Random random;

  _DotPainter(this.dots, this.time, this.random);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final dot in dots) {
      final driftX = math.sin(time * dot.speed * 2 + dot.phase) * 20;
      final driftY = math.cos(time * dot.speed * 2 + dot.phase * 1.3) * 15;
      final x = dot.x * size.width + driftX;
      final y = dot.y * size.height + driftY;
      final opacity = dot.opacity * (0.6 + 0.4 * math.sin(time * 0.5 + dot.phase));

      paint.color = PortfolioColors.accent.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), dot.size, paint);
    }

    final glow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60)
      ..color = PortfolioColors.accent.withValues(alpha: 0.03 + 0.02 * math.sin(time * math.pi));
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 120, glow);
  }

  @override
  bool shouldRepaint(covariant _DotPainter old) => old.time != time;
}
