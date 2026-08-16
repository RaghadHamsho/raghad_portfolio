import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/section_title.dart';

/// A single UI/UX design entry: a title + its Figma link (+ optional subtitle).
class UiUxItem {
  final String title;
  final String subtitle;
  final String figmaUrl;
  final IconData icon;
  final List<String> tags;

  const UiUxItem({
    required this.title,
    required this.figmaUrl,
    this.subtitle = '',
    this.icon = Icons.design_services_rounded,
    this.tags = const [],
  });
}

/// All UI/UX design work. Add / edit entries here.
const List<UiUxItem> kUiUxItems = [
  UiUxItem(
    title: 'Al Meera — Shopping App',
    subtitle: 'E-commerce mobile design system & prototype',
    figmaUrl: 'https://www.figma.com/file/your-file-id/al-meera?type=design',
    icon: Icons.shopping_bag_rounded,
    tags: ['Mobile', 'E-commerce', 'Prototype'],
  ),
  UiUxItem(
    title: 'Raghad — Portfolio Web',
    subtitle: 'Personal brand site, dark/light themes',
    figmaUrl: 'https://www.figma.com/file/your-file-id/portfolio-web?type=design',
    icon: Icons.web_rounded,
    tags: ['Web', 'Branding', 'Design System'],
  ),
  UiUxItem(
    title: 'Dashboard — Analytics UI',
    subtitle: 'Data visualization & admin layout',
    figmaUrl: 'https://www.figma.com/file/your-file-id/analytics-dashboard?type=design',
    icon: Icons.dashboard_rounded,
    tags: ['Web', 'Dashboard', 'Data Viz'],
  ),
];

class UiUxScreen extends StatelessWidget {
  const UiUxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B0B1A), Color(0xFF13132A), Color(0xFF1A1033)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 40),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SectionTitle(overline: '05 / UI-UX', title: 'Design Projects.'),
                  const SizedBox(height: 8),
                  Text(
                    'Tap any card to open the live Figma prototype.',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 14),
                  ),
                  const SizedBox(height: 28),
                ]),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
              sliver: AnimationLimiter(
                child: SliverList(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    final item = kUiUxItems[i];
                    return AnimationConfiguration.staggeredList(
                      position: i,
                      duration: const Duration(milliseconds: 550),
                      child: SlideAnimation(
                        verticalOffset: 60,
                        child: FadeInAnimation(child: _UiUxCard(item: item)),
                      ),
                    );
                  }, childCount: kUiUxItems.length),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }
}

// ----------------------------- Card -----------------------------

class _UiUxCard extends StatefulWidget {
  final UiUxItem item;
  const _UiUxCard({required this.item});

  @override
  State<_UiUxCard> createState() => _UiUxCardState();
}

class _UiUxCardState extends State<_UiUxCard> with TickerProviderStateMixin {
  late final AnimationController _glow;
  final ValueNotifier<bool> _hover = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _glow = AnimationController(vsync: this, duration: const Duration(seconds: 7))..repeat();
  }

  @override
  void dispose() {
    _glow.dispose();
    _hover.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: MouseRegion(
        onEnter: (_) => _hover.value = true,
        onExit: (_) => _hover.value = false,
        child: GestureDetector(
          onTap: () => _launchUrl(widget.item.figmaUrl),
          child: ValueListenableBuilder<bool>(
            valueListenable: _hover,
            builder: (_, hovered, __) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                transform: hovered ? (Matrix4.identity()..translate(0, -4, 0)) : Matrix4.identity(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Stack(
                      children: [
                        // accent glow ring (rotating)
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: _glow,
                            builder: (_, __) => Transform.rotate(
                              angle: _glow.value * 6.2831,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  gradient: SweepGradient(
                                    colors: [
                                      const Color(0xFFEC4899).withValues(alpha: hovered ? 0.45 : 0.22),
                                      const Color(0xFF8B5CF6).withValues(alpha: hovered ? 0.45 : 0.22),
                                      const Color(0xFF06B6D4).withValues(alpha: hovered ? 0.45 : 0.22),
                                      const Color(0xFFEC4899).withValues(alpha: hovered ? 0.45 : 0.22),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // glass body
                        Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withValues(alpha: hovered ? 0.14 : 0.08),
                                Colors.white.withValues(alpha: 0.03),
                              ],
                            ),
                            border: Border.all(color: Colors.white.withValues(alpha: hovered ? 0.28 : 0.14)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF8B5CF6).withValues(alpha: hovered ? 0.35 : 0.15),
                                blurRadius: hovered ? 50 : 24,
                                spreadRadius: 2,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: isMobile ? _buildColumnLayout(hovered) : _buildRowLayout(hovered),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRowLayout(bool hovered) {
    return Row(
      children: [
        // icon badge
        _IconBadge(icon: widget.item.icon, hovered: hovered),
        const SizedBox(width: 22),
        // titles
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.title,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700, height: 1.2),
              ),
              if (widget.item.subtitle.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  widget.item.subtitle,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13.5),
                ),
              ],
              if (widget.item.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.item.tags
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.4)),
                          ),
                          child: Text(t, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 18),
        _FigmaPill(hovered: hovered),
      ],
    );
  }

  Widget _buildColumnLayout(bool hovered) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _IconBadge(icon: widget.item.icon, hovered: hovered),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.item.title,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, height: 1.2),
              ),
            ),
          ],
        ),
        if (widget.item.subtitle.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(widget.item.subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
        ],
        if (widget.item.tags.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.item.tags
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.4)),
                    ),
                    child: Text(t, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ),
                )
                .toList(),
          ),
        ],
        const SizedBox(height: 16),
        _FigmaPill(hovered: hovered),
      ],
    );
  }
}

// ----------------------------- Icon badge -----------------------------

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final bool hovered;
  const _IconBadge({required this.icon, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [Color(0xFFEC4899), Color(0xFF8B5CF6)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEC4899).withValues(alpha: hovered ? 0.55 : 0.25),
            blurRadius: hovered ? 26 : 14,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 26),
    );
  }
}

// ----------------------------- Figma pill -----------------------------

class _FigmaPill extends StatefulWidget {
  final bool hovered;
  const _FigmaPill({required this.hovered});

  @override
  State<_FigmaPill> createState() => _FigmaPillState();
}

class _FigmaPillState extends State<_FigmaPill> with SingleTickerProviderStateMixin {
  late final AnimationController _spin;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.hovered
              ? const [Color(0xFFEC4899), Color(0xFF8B5CF6)]
              : [const Color(0xFF8B5CF6).withValues(alpha: 0.25), const Color(0xFF06B6D4).withValues(alpha: 0.25)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: widget.hovered ? 0.3 : 0.16)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: widget.hovered ? 0.4 : 0.12),
            blurRadius: widget.hovered ? 22 : 10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _spin,
            builder: (_, child) => Transform.rotate(angle: _spin.value * 6.2831, child: child),
            child: const Icon(Icons.open_in_new_rounded, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Text(
            'Open in Figma',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------- launcher -----------------------------

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
