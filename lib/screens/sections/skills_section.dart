import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../repositories/portfolio_repository.dart';
import '../../widgets/section_title.dart';

/// Maps a skill name to a representative Material icon.
IconData skillIcon(String rawName) {
  final n = rawName.toLowerCase();

  bool has(List<String> keys) => keys.any(n.contains);

  if (has(['flutter'])) return Icons.flutter_dash;
  if (has(['dart'])) return Icons.change_history_rounded;
  if (has(['bloc', 'cubit', 'state'])) return Icons.account_tree_rounded;
  if (has(['provider', 'riverpod', 'getx'])) return Icons.hub_rounded;
  if (has(['firebase'])) return Icons.local_fire_department_rounded;
  if (has(['sql', 'postgres', 'mysql', 'sqlite', 'database', 'hive', 'db'])) {
    return Icons.storage_rounded;
  }
  if (has(['rest', 'api', 'http', 'dio', 'graphql'])) return Icons.api_rounded;
  if (has(['git', 'github', 'gitlab'])) return Icons.commit_rounded;
  if (has(['figma', 'ui', 'ux', 'design'])) return Icons.brush_rounded;
  if (has(['android'])) return Icons.android_rounded;
  if (has(['ios', 'apple', 'swift'])) return Icons.phone_iphone_rounded;
  if (has(['web', 'html', 'css', 'javascript', 'js', 'react', 'angular'])) {
    return Icons.language_rounded;
  }
  if (has(['java', 'kotlin', 'c#', 'c++', 'python', 'language'])) {
    return Icons.code_rounded;
  }
  if (has(['clean', 'architecture', 'mvvm', 'mvc', 'solid'])) {
    return Icons.architecture_rounded;
  }
  if (has(['test', 'unit', 'debug'])) return Icons.bug_report_rounded;
  if (has(['animation', 'motion'])) return Icons.auto_awesome_motion_rounded;
  if (has(['notification', 'push', 'fcm'])) return Icons.notifications_active_rounded;
  if (has(['map', 'location', 'gps'])) return Icons.map_rounded;
  if (has(['payment', 'stripe', 'wallet'])) return Icons.payments_rounded;
  if (has(['cloud', 'aws', 'docker', 'ci', 'cd', 'devops'])) return Icons.cloud_rounded;
  if (has(['store', 'deploy', 'publish', 'play'])) return Icons.rocket_launch_rounded;
  if (has(['team', 'agile', 'scrum', 'communication', 'soft'])) return Icons.groups_rounded;
  if (has(['performance', 'optimiz'])) return Icons.speed_rounded;
  if (has(['security', 'auth', 'jwt'])) return Icons.lock_rounded;
  if (has(['localization', 'i18n', 'language pack', 'arabic', 'english'])) {
    return Icons.translate_rounded;
  }
  if (has(['responsive', 'adaptive'])) return Icons.devices_rounded;

  return Icons.auto_awesome_rounded;
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final skills = context.read<PortfolioRepository>().getSkills();

    final palette = <Color>[
      const Color(0xFF7C5CFF),
      const Color(0xFF22D3EE),
      const Color(0xFFFF6B9A),
      const Color(0xFF34D399),
      const Color(0xFFF59E0B),
      const Color(0xFF60A5FA),
    ];

    final flat = <_SkillChipData>[];

    for (var i = 0; i < skills.length; i++) {
      final category = skills[i];
      final color = palette[i % palette.length];

      for (var j = 0; j < category.items.length; j++) {
        final name = category.items[j];
        flat.add(_SkillChipData(name, category.title, color, skillIcon(name)));
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 80, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(overline: '02 / Skills', title: 'My toolbox.'),
              const SizedBox(height: 16),

              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth > 1000
                      ? 5
                      : c.maxWidth > 720
                      ? 4
                      : c.maxWidth > 480
                      ? 3
                      : 2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: flat.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (_, i) {
                      final s = flat[i];

                      return AnimationConfiguration.staggeredGrid(
                        position: i,
                        columnCount: cols,
                        duration: const Duration(milliseconds: 450),
                        child: ScaleAnimation(
                          scale: 0.9,
                          child: FadeInAnimation(child: _SkillTile(data: s)),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChipData {
  final String name;
  final String category;
  final Color color;
  final IconData icon;

  _SkillChipData(this.name, this.category, this.color, this.icon);
}

class _SkillTile extends StatefulWidget {
  final _SkillChipData data;

  const _SkillTile({required this.data});

  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> {
  final ValueNotifier<bool> _hover = ValueNotifier(false);

  @override
  void dispose() {
    _hover.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.data.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => _hover.value = true,
      onExit: (_) => _hover.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _hover,
        builder: (_, hovered, __) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: hovered
                    ? [c.withOpacity(0.30), c.withOpacity(0.10)]
                    : [Colors.white.withOpacity(0.04), Colors.white.withOpacity(0.015)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: hovered ? c.withOpacity(0.6) : Colors.white.withOpacity(0.08)),
              boxShadow: hovered ? [BoxShadow(color: c.withOpacity(0.35), blurRadius: 24, spreadRadius: -4)] : const [],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ✅ ICON FIRST (replaces image)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutBack,
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [c.withOpacity(hovered ? 0.35 : 0.18), c.withOpacity(0.06)],
                      ),
                      border: Border.all(color: c.withOpacity(hovered ? 0.75 : 0.35), width: 1.2),
                      boxShadow: hovered
                          ? [BoxShadow(color: c.withOpacity(0.45), blurRadius: 18, spreadRadius: -2)]
                          : const [],
                    ),
                    child: AnimatedScale(
                      scale: hovered ? 1.12 : 1.0,
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOut,
                      child: Icon(widget.data.icon, size: 28, color: c),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // NAME
                  Text(
                    widget.data.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 1.15),
                  ),

                  const SizedBox(height: 4),

                  // CATEGORY
                  Text(
                    widget.data.category,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 0.6,
                      color: isDark ? Colors.white.withOpacity(0.55) : const Color.fromARGB(255, 34, 23, 129),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
