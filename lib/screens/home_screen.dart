import 'package:flutter/material.dart';
import '../logic/cubits/navigation/navigation_cubit.dart';
import '../widgets/animated_background.dart';
import '../widgets/nav_bar.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scroll = ScrollController();
  final _keys = {for (final s in Section.values) s: GlobalKey()};

  void _jumpTo(Section s) {
    final ctx = _keys[s]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Column(
          children: [
            NavBar(onJump: _jumpTo),
            Expanded(
              child: SingleChildScrollView(
                controller: _scroll,
                child: Column(
                  children: [
                    KeyedSubtree(key: _keys[Section.home], child: const HeroSection()),
                    KeyedSubtree(key: _keys[Section.about], child: const AboutSection()),
                    KeyedSubtree(key: _keys[Section.skills], child: const SkillsSection()),
                    KeyedSubtree(key: _keys[Section.experience], child: const ExperienceSection()),
                    KeyedSubtree(key: _keys[Section.projects], child: const ProjectsSection()),
                    KeyedSubtree(key: _keys[Section.contact], child: const ContactSection()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
