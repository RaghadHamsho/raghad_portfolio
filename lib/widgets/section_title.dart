import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionTitle extends StatelessWidget {
  final String overline;
  final String title;
  const SectionTitle({super.key, required this.overline, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overline.toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 4,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            height: 1.1,
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(begin: 0.15),
        const SizedBox(height: 28),
      ],
    );
  }
}
