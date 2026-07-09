import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../repositories/portfolio_repository.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  int getCrossAxisCount(double width) {
    if (width < 600) return 1; // mobile
    return 2; // 👈 always 2 cards otherwise
  }

  double getAspectRatio(double width) {
    if (width < 600) return 1.5;
    if (width < 900) return 1.6;
    return 0.9;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = context.read<PortfolioRepository>().getExperiences();
    final crossAxisCount = getCrossAxisCount(width);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(overline: '03 / Experience', title: 'Where I worked.'),
              const SizedBox(height: 32),

              AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: width < 600 ? 1.5 : 0.95,
                  ),
                  itemBuilder: (context, i) {
                    final e = items[i];

                    return AnimationConfiguration.staggeredGrid(
                      position: i,
                      columnCount: crossAxisCount,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 30,
                        child: FadeInAnimation(
                          child: GlassCard(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e.role, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                      const SizedBox(height: 4),
                                      Text(
                                        e.company,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${e.period}  ·  ${e.location}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isDark ? Theme.of(context).textTheme.bodySmall?.color : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: e.description.map((desc) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('• ', style: TextStyle(fontSize: 14)),
                                                Expanded(
                                                  child: Text(
                                                    desc,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      height: 1.8,
                                                      color: Theme.of(context).textTheme.bodySmall?.color,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
