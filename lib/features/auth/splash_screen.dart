import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _dotsController;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _dotAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: -12.0).animate(
        CurvedAnimation(
          parent: _dotsController,
          curve: Interval(
            0.1 * index,
            0.4 + 0.1 * index,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });

    _dotsController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _dotsController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _dotsController.forward();
      }
    });

    // Mulai semua animasi
    _fadeController.forward();
    _dotsController.forward();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final authService = getIt<AuthService>();

    if (authService.currentUser == null) {
      context.go(AppRoutes.login);
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            // Efek cahaya (glow)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.15),
                    blurRadius: 80.0,
                    spreadRadius: 40.0,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/logo/logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Ri-Kost',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black38,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Animasi titik
            AnimatedBuilder(
              animation: _dotsController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Transform.translate(
                      offset: Offset(0, _dotAnimations[index].value),
                      child: _buildDot(),
                    );
                  }),
                );
              },
            ),
            const Spacer(flex: 2),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text(
                  'Apps by Rizma Indra',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
