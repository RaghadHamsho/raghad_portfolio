import 'dart:math' show pi;

import 'package:flutter/material.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 60, vertical: isMobile ? 24 : 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(overline: '01 / About', title: 'A bit about me.'),
              const SizedBox(height: 16),
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Education block
                    _EducationRow(
                      degree: "Bachelor's Degree",
                      field: 'Information Technology Engineering',
                      school: 'Damascus University',
                      period: '2019 – 2024',
                      animation: _entranceController,
                    ),
                    const SizedBox(height: 32),
                    // Divider
                    AnimatedBuilder(
                      animation: _entranceController,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          widthFactor: _entranceController.value,
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary.withOpacity(0.0),
                                  Theme.of(context).colorScheme.primary.withOpacity(0.4),
                                  Theme.of(context).colorScheme.primary.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    // Circular stats
                    isMobile
                        ? Column(
                            children: const [
                              _CircularStat(
                                value: 4,
                                suffix: '+',
                                label: 'Years',
                                icon: Icons.work_outline,
                                delay: 0.0,
                              ),
                              SizedBox(height: 24),
                              _CircularStat(
                                value: 8,
                                suffix: '+',
                                label: 'Apps',
                                icon: Icons.app_shortcut,
                                delay: 0.15,
                              ),
                              SizedBox(height: 24),
                              _CircularStat(value: 2, suffix: '', label: 'Countries', icon: Icons.public, delay: 0.3),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              _CircularStat(
                                value: 4,
                                suffix: '+',
                                label: 'Years',
                                icon: Icons.work_outline,
                                delay: 0.0,
                              ),
                              _CircularStat(
                                value: 10,
                                suffix: '+',
                                label: 'Apps',
                                icon: Icons.app_shortcut,
                                delay: 0.15,
                              ),
                              _CircularStat(value: 2, suffix: '', label: 'Countries', icon: Icons.public, delay: 0.3),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EducationRow extends StatelessWidget {
  final String degree;
  final String field;
  final String school;
  final String period;
  final Animation<double> animation;

  const _EducationRow({
    required this.degree,
    required this.field,
    required this.school,
    required this.period,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final opacity = CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        ).value;

        final offset =
            (1 -
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
                ).value) *
            24;

        return Opacity(
          opacity: opacity,
          child: Transform.translate(offset: Offset(0, offset), child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: primary.withOpacity(0.18)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primary.withOpacity(0.08), primary.withOpacity(0.02)],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: primary.withOpacity(0.12), shape: BoxShape.circle),
              child: Icon(Icons.school, size: 28, color: primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EDUCATION',
                    style: TextStyle(fontSize: 11, letterSpacing: 2.5, fontWeight: FontWeight.w800, color: primary),
                  ),
                  const SizedBox(height: 8),
                  Text(degree, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(
                    field,
                    style: TextStyle(fontSize: 14, color: Colors.grey[400], fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_city, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Text(school, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          period,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularStat extends StatefulWidget {
  final int value;
  final String suffix;
  final String label;
  final IconData icon;
  final double delay;

  const _CircularStat({
    required this.value,
    required this.suffix,
    required this.label,
    required this.icon,
    required this.delay,
  });

  @override
  State<_CircularStat> createState() => _CircularStatState();
}

class _CircularStatState extends State<_CircularStat> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _count;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));

    _count = IntTween(begin: 0, end: widget.value).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
          if (mounted) _controller.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    const size = 132.0;
    const stroke = 6.0;
    const radius = (size - stroke) / 2;
    const circumference = 2 * pi * radius;
    final max = 10;
    final progress = (widget.value / max).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final entrance = CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
        ).value;

        return Opacity(
          opacity: entrance,
          child: Transform.scale(scale: 0.6 + (entrance * 0.4), child: child),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating dashed outer ring
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * pi * 2,
                      child: CustomPaint(
                        size: const Size(size, size),
                        painter: _DashedRingPainter(
                          color: primary.withOpacity(0.25),
                          radius: radius + 8,
                          dashLength: 4,
                          gapLength: 8,
                        ),
                      ),
                    );
                  },
                ),
                // Background circle
                CustomPaint(
                  size: const Size(size, size),
                  painter: _SolidRingPainter(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                    radius: radius,
                    stroke: stroke,
                  ),
                ),
                // Animated progress arc
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    final progressValue = CurvedAnimation(
                      parent: _controller,
                      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
                    ).value;

                    return CustomPaint(
                      size: const Size(size, size),
                      painter: _ProgressArcPainter(
                        color: primary,
                        radius: radius,
                        stroke: stroke,
                        progress: progress * progressValue,
                      ),
                    );
                  },
                ),
                // Center content
                AnimatedBuilder(
                  animation: _count,
                  builder: (_, __) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(widget.icon, size: 22, color: primary),
                        const SizedBox(height: 4),
                        Text(
                          '${_count.value}${widget.suffix}',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            widget.label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[400], letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}

class _DashedRingPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashLength;
  final double gapLength;

  _DashedRingPainter({required this.color, required this.radius, required this.dashLength, required this.gapLength});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);
    final circumference = 2 * pi * radius;
    final totalDashAndGap = dashLength + gapLength;
    final count = (circumference / totalDashAndGap).floor();

    for (int i = 0; i < count; i++) {
      final startAngle = (i * totalDashAndGap / radius) - pi / 2;
      final sweepAngle = dashLength / radius;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SolidRingPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double stroke;

  _SolidRingPainter({required this.color, required this.radius, required this.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter) => false;
}

class _ProgressArcPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double stroke;
  final double progress;

  _ProgressArcPainter({required this.color, required this.radius, required this.stroke, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ProgressArcPainter oldDelegate) => oldDelegate.progress != progress;
}
