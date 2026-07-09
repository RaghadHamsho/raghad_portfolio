import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../repositories/portfolio_repository.dart';
import '../../widgets/section_title.dart';

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

        final image = (j < category.images.length) ? category.images[j] : 'assets/default.png';

        flat.add(_SkillChipData(name, category.title, color, image));
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
  final String image;

  _SkillChipData(this.name, this.category, this.color, this.image);
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
                  // ✅ IMAGE FIRST (FIXED ORDER)
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      widget.data.image,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 18),
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
