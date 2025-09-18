import 'dart:math' as math;
import 'package:flutter/material.dart';

// === SHARED COLORS ===
const Color gradStart = Color(0xFF5B2EBC); // ungu
const Color gradEnd   = Color(0xFFF72585); // pink
const double cardRadius = 12.0; // DIUBAH: dari 24.0 menjadi 12.0

/// Kartu kontainer 2 kolom (left/right). Ada shadow lembut di belakang.
class AuthCard extends StatelessWidget {
  final bool wide;
  final Widget left;
  final Widget right;

  const AuthCard({
    super.key,
    required this.wide,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    final child = wide
        ? Row(children: [Expanded(child: left), Expanded(child: right)])
        : Column(children: [left, right]);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 40,
              offset: Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cardRadius),
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(cardRadius),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Panel kiri STATIS: Hanya gradient dan konten, tanpa animasi gelembung.
class AnimatedLeftPanel extends StatelessWidget {
  final String title;
  final String subtitle;

  const AnimatedLeftPanel({
    super.key,
    this.title = 'Welcome Page',
    this.subtitle = 'Sign in to continue access',
    int bubbleCount = 0, // Parameter bubbleCount diabaikan
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 48, 40, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [gradStart, gradEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo/logo.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}


/// Panel kanan (judul + subjudul + form)
class RightForm extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget form;

  const RightForm({
    super.key,
    required this.title,
    required this.subtitle,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(36, 40, 36, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(subtitle, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 28),
          form,
        ],
      ),
    );
  }
}
