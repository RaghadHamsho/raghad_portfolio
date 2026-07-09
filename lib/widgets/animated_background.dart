import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/theme_config.dart';

/// Perfect animated gradient + floating orbs + particle background.
/// Pure CustomPainter — no setState, driven by AnimationController.
class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    final rnd = math.Random(7);
    _particles = List.generate(
      60,
      (i) => _Particle(
        position: Offset(rnd.nextDouble(), rnd.nextDouble()),
        radius: rnd.nextDouble() * 2.5 + 0.6,
        speed: rnd.nextDouble() * 0.4 + 0.1,
        phase: rnd.nextDouble() * math.pi * 2,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => CustomPaint(
            painter: _BackgroundPainter(
              t: _controller.value,
              particles: _particles,
              isDark: isDark,
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _Particle {
  final Offset position;
  final double radius;
  final double speed;
  final double phase;
  _Particle({
    required this.position,
    required this.radius,
    required this.speed,
    required this.phase,
  });
}

class _BackgroundPainter extends CustomPainter {
  final double t;
  final List<_Particle> particles;
  final bool isDark;
  _BackgroundPainter({
    required this.t,
    required this.particles,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Base gradient
    final bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xFF0A0F1E), Color(0xFF0F172A), Color(0xFF111827)]
            : const [Color(0xFFFAFBFC), Color(0xFFEEF2FF), Color(0xFFF5F3FF)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    // Floating orbs
    _drawOrb(canvas, size, 0.25 + 0.1 * math.sin(t * 2 * math.pi),
        0.3 + 0.05 * math.cos(t * 2 * math.pi), 280, AppColors.primary.withOpacity(isDark ? 0.35 : 0.18));
    _drawOrb(canvas, size, 0.75 + 0.08 * math.cos(t * 2 * math.pi),
        0.7 + 0.06 * math.sin(t * 2 * math.pi), 320, AppColors.primaryGlow.withOpacity(isDark ? 0.3 : 0.15));
    _drawOrb(canvas, size, 0.6 + 0.12 * math.sin(t * 2 * math.pi + 1),
        0.2 + 0.08 * math.cos(t * 2 * math.pi + 1), 240, AppColors.accent.withOpacity(isDark ? 0.25 : 0.12));

    // Particles
    final pPaint = Paint()
      ..color = (isDark ? Colors.white : AppColors.primary).withOpacity(0.5);
    for (final p in particles) {
      final dy = (p.position.dy + t * p.speed) % 1.0;
      final dx = p.position.dx + 0.03 * math.sin(t * 2 * math.pi + p.phase);
      canvas.drawCircle(
        Offset(dx * size.width, dy * size.height),
        p.radius,
        pPaint,
      );
    }
  }

  void _drawOrb(Canvas canvas, Size size, double fx, double fy, double r, Color color) {
    final center = Offset(fx * size.width, fy * size.height);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withOpacity(0)],
      ).createShader(Rect.fromCircle(center: center, radius: r))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    canvas.drawCircle(center, r, paint);
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter old) => true;
}
