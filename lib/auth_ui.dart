// lib/auth_ui.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

// === SHARED COLORS ===
const Color gradStart = Color(0xFF5B2EBC); // ungu
const Color gradEnd   = Color(0xFFF72585); // pink
const double cardRadius = 24.0;

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

/// Panel kiri ANIMASI: gradient berputar + gelembung kecil menyebar MERATA (full panel).
/// Gerak Lissajous (multidirectional), loop halus (periodik).
class AnimatedLeftPanel extends StatefulWidget {
  final String title;
  final String subtitle;
  /// Banyak gelembung (naikkan jika ingin super padat).
  final int bubbleCount;

  const AnimatedLeftPanel({
    super.key,
    this.title = 'Welcome Page',
    this.subtitle = 'Sign in to continue access',
    this.bubbleCount = 220, // default padat
  });

  @override
  State<AnimatedLeftPanel> createState() => _AnimatedLeftPanelState();
}

class _AnimatedLeftPanelState extends State<AnimatedLeftPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final List<_Bubble> _bubbles;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 18))
      ..repeat();

    _bubbles = _generateGridBubbles(widget.bubbleCount, seed: 99);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final t = _c.value * 2 * math.pi; // 0..2π

        return Container(
          padding: const EdgeInsets.fromLTRB(40, 48, 40, 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [gradStart, gradEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(t * .28), // rotasi halus
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Gelembung (pakai Align ⇒ aman tanpa ukuran piksel)
              ..._bubbles.map((b) => _AlignedBubble(b: b, t: t)),
              // Konten tengah (logo + teks)
              Center(
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
                      widget.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Membuat gelembung tersebar rata memakai grid terstratifikasi + jitter.
  List<_Bubble> _generateGridBubbles(int target, {int seed = 42}) {
    // Grid mendekati persegi dari target (agar area terisi merata)
    final cols = (math.sqrt(target)).ceil();
    final rows = (target / cols).ceil();
    final rnd = math.Random(seed);
    final bubbles = <_Bubble>[];

    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        if (bubbles.length >= target) break;

        // Pusat sel (Alignment space -1..1)
        final axCenter = -1.0 + (i + 0.5) * (2.0 / cols);
        final ayCenter = -1.0 + (j + 0.5) * (2.0 / rows);

        // Jitter agak besar (≈60% ukuran sel) supaya tak terlihat gridy
        final jx = (rnd.nextDouble() - 0.5) * (2.0 / cols) * 0.6;
        final jy = (rnd.nextDouble() - 0.5) * (2.0 / rows) * 0.6;

        final ax = (axCenter + jx).clamp(-1.0, 1.0);
        final ay = (ayCenter + jy).clamp(-1.0, 1.0);

        // Ukuran dominan kecil 3..12 px (beberapa 12..18 px untuk variasi)
        final base = 3.0 + rnd.nextDouble() * 9.0;
        final boost = rnd.nextDouble() < 0.18 ? 6.0 + rnd.nextDouble() * 6.0 : 0.0;
        final size = base + boost;

        // Amplitudo relatif 0.03..0.10
        final ampX = 0.03 + rnd.nextDouble() * 0.07;
        final ampY = 0.03 + rnd.nextDouble() * 0.07;

        // Frekuensi Lissajous X/Y berbeda 0.6..1.4
        final freqX = 0.6 + rnd.nextDouble() * 0.8;
        final freqY = 0.6 + rnd.nextDouble() * 0.8;

        // Kecepatan 0.35..0.85
        final speed = 0.35 + rnd.nextDouble() * 0.50;

        final phaseX = rnd.nextDouble() * 2 * math.pi;
        final phaseY = rnd.nextDouble() * 2 * math.pi;

        bubbles.add(_Bubble(
          size: size,
          ax: ax.toDouble(),
          ay: ay.toDouble(),
          ampX: ampX,
          ampY: ampY,
          freqX: freqX,
          freqY: freqY,
          speed: speed,
          phaseX: phaseX,
          phaseY: phaseY,
        ));
      }
    }
    return bubbles;
  }
}

class _Bubble {
  final double size;              // px
  final double ax, ay;            // alignment dasar (-1..1)
  final double ampX, ampY;        // amplitudo relatif (0..~0.10)
  final double freqX, freqY;      // frekuensi relatif sumbu X/Y
  final double speed;             // pengali kecepatan
  final double phaseX, phaseY;    // fase awal

  const _Bubble({
    required this.size,
    required this.ax,
    required this.ay,
    required this.ampX,
    required this.ampY,
    required this.freqX,
    required this.freqY,
    required this.speed,
    required this.phaseX,
    required this.phaseY,
  });
}

class _AlignedBubble extends StatelessWidget {
  final _Bubble b;
  final double t;
  const _AlignedBubble({required this.b, required this.t});

  @override
  Widget build(BuildContext context) {
    // Lintasan Lissajous → multidirectional & periodik (loop rapi)
    final dx = b.ax + math.sin(t * b.freqX * b.speed + b.phaseX) * b.ampX;
    final dy = b.ay + math.cos(t * b.freqY * b.speed + b.phaseY) * b.ampY;

    return Align(
      alignment: Alignment(dx.clamp(-1.0, 1.0), dy.clamp(-1.0, 1.0)),
      child: IgnorePointer(
        child: Container(
          width: b.size,
          height: b.size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Color(0x66FFFFFF), Color(0x11FFFFFF)],
              radius: 0.85,
            ),
          ),
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
