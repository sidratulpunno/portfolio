import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/home/home_screen.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp>
    with SingleTickerProviderStateMixin {
  ThemeMode _themeMode = ThemeMode.light;
  bool _showSplash = true;
  bool _showHome = false;
  late final AnimationController _fadeController;
  late final Animation<double> _splashFade;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _splashFade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onSplashComplete() {
    setState(() => _showHome = true);
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) setState(() => _showSplash = false);
    });
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sidratul Punno',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Stack(
        children: [
          if (_showHome)
            HomeScreen(
              key: const ValueKey('home'),
              onToggleTheme: _toggleTheme,
              isDarkMode: _themeMode == ThemeMode.dark,
            ),
          if (_showSplash)
            FadeTransition(
              opacity: _splashFade,
              child: SplashScreen(onComplete: _onSplashComplete),
            ),
        ],
      ),
    );
  }
}
