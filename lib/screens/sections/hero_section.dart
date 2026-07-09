import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

final Uri url = Uri.parse(AppStrings.cvUrl);

Future<dynamic> launchCvUrl() async {
  if (await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      constraints: const BoxConstraints(minHeight: 700),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                AppStrings.name,
                style: TextStyle(
                  fontSize: isMobile ? 48 : 92,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  letterSpacing: -3,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                    ).createShader(const Rect.fromLTWH(0, 0, 600, 100)),
                ),
              ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2),
              const SizedBox(height: 16),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: isMobile ? 20 : 32,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(seconds: 2),
                  animatedTexts: [
                    TyperAnimatedText('Mobile Application Developer.'),
                    TyperAnimatedText('Flutter Engineer — Web & Mobile.'),
                    TyperAnimatedText('Building elegant, scalable apps.'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.shortdesc,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 18,
                  height: 1.6,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2),
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () => launchCvUrl(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.download_outlined),
                label: const Text('Download CV', style: TextStyle(fontWeight: FontWeight.w600)),
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
