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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller untuk animasi fade-in pada teks.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Mulai animasi.
    _controller.forward();

    // Panggil fungsi navigasi setelah animasi selesai.
    _navigateToNextScreen();
  }

  /// Logika untuk navigasi otomatis setelah splash screen.
  Future<void> _navigateToNextScreen() async {
    // Tunggu selama durasi animasi ditambah sedikit jeda.
    await Future.delayed(_controller.duration! + const Duration(milliseconds: 500));
    if (!mounted) return; // Pastikan widget masih ada sebelum navigasi.

    final authService = getIt<AuthService>();

    // Cek apakah ada pengguna yang sedang login.
    if (authService.currentUser == null) {
      // Jika tidak ada, arahkan ke halaman login.
      context.go(AppRoutes.login);
    } else {
      // Jika ada, arahkan ke halaman utama.
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: _animation,
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
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _animation,
              child: const Text(
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
    );
  }
}
