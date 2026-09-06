import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/project_model.dart';
import '../../repositories/portfolio_repository.dart';
import '../../widgets/project_card.dart';
import '../../widgets/section_title.dart';

const Map<String, String> kFigmaLinks = {
  'UI/UX Design': 'https://www.figma.com/file/your-file-id/Raghad-UI-UX?type=design',
};

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

/// All UI/UX design work shown in the projects section. Add / edit here.
const List<UiUxItem> kUiUxItems = [
  UiUxItem(
    title: 'Ministry of Justice',
    subtitle: 'A comprehensive memorandum management  web design system & prototype',
    figmaUrl: 'https://awake-surly-65204296.figma.site',
    icon: Icons.dashboard_rounded,
    tags: ['web', 'Justice', 'Prototype'],
  ),
  UiUxItem(
    title: 'Ehsan',
    subtitle: 'Charity platform (many modules) & design system',
    figmaUrl: 'https://dried-trait-51891301.figma.site',
    icon: Icons.dashboard_rounded,
    tags: ['Web', 'internal care department', 'Design System'],
  ),
  UiUxItem(
    title: 'Ehsan Dashboards',
    subtitle: 'Data visualization & admin layout',
    figmaUrl: 'https://mace-satin-81635395.figma.site',
    icon: Icons.dashboard_rounded,
    tags: ['Web', 'Dashboard', 'Data Viz'],
  ),
  UiUxItem(
    title: 'Ministry of Justice',
    subtitle: 'Follow up System , Commite Management , Archive , Meetings Management , Projects Managements ',
    figmaUrl: 'https://early-bot-54196229.figma.site',
    icon: Icons.dashboard_rounded,
    tags: ['Web', 'Prototype', 'Designs Systems'],
  ),
  UiUxItem(
    title: 'Loyalty System ',
    subtitle: 'Points & vouchers platform for partner retail stores ',
    figmaUrl: 'https://www.figma.com/design/PyU8cSHACaCOTJuDIMDQBm/Untitled?node-id=0-1&t=5WxCKLrqNfGaKnqA-1',
    icon: Icons.dashboard_rounded,
    tags: ['Web', 'Points', 'Design Systems'],
  ),
 UiUxItem(
  title: 'Qchem',
  subtitle: 'B2B procurement & partner rewards portal for petrochemical distributors',
  figmaUrl: 'https://www.figma.com/design/zUH91XqKDpMu97SnQiTVWX/QChem?node-id=47-6734&t=9jm65jh9EtwJCdvY-0',
  icon: Icons.dashboard_rounded,
  tags: ['Web', 'B2B', 'Procurement', 'KBD'],
),
UiUxItem(
  title: 'Qatar Energy',
  subtitle: 'Renewable energy investment & project tracking platform for sustainable development',
  figmaUrl: 'https://reply-curry-88053644.figma.site',
  icon: Icons.dashboard_rounded,
  tags: ['Web', 'Renewable Energy', 'Investment', 'Sustainability'],
),
];

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final projects = context.read<PortfolioRepository>().getProjects();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(overline: '04 / Projects', title: 'Selected work.'),
              // ---- Code / engineering projects ----
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth > 1000
                      ? 3
                      : c.maxWidth > 650
                      ? 2
                      : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 290,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (_, i) => AnimationConfiguration.staggeredGrid(
                      position: i,
                      columnCount: cols,
                      duration: const Duration(milliseconds: 500),
                      child: ScaleAnimation(
                        scale: 0.9,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () => _openProjectDialog(context, projects[i]),
                            child: Hero(
                              tag: 'project-${projects[i].title}',
                              child: Material(
                                color: Colors.transparent,
                                child: ProjectCard(project: projects[i]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 72),

              // ---- UI/UX design projects (different card design) ----
              _UiUxHeader(),
              const SizedBox(height: 28),
              _UiUxDesignGrid(items: kUiUxItems),
            ],
          ),
        ),
      ),
    );
  }

  void _openProjectDialog(BuildContext context, ProjectModel project) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.55),
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (_, __, ___) => _ProjectDialog(project: project),
        transitionsBuilder: (_, anim, __, child) {
          final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18 * curved.value, sigmaY: 18 * curved.value),
            child: FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween<double>(begin: 0.92, end: 1).animate(curved), child: child),
            ),
          );
        },
      ),
    );
  }
}

// ===================== UI/UX design sub-section =====================

class _UiUxHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // animated palette icon
        _PulsingPalette(),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UI / UX DESIGN',
                style: TextStyle(
                  color: const Color(0xFFEC4899).withValues(alpha: 0.85),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Design projects — open in Figma',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700, height: 1.2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PulsingPalette extends StatefulWidget {
  @override
  State<_PulsingPalette> createState() => _PulsingPaletteState();
}

class _PulsingPaletteState extends State<_PulsingPalette> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
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
      builder: (_, __) {
        final v = Curves.easeInOut.transform(_c.value);
        return Container(
          width: 44 + v * 6,
          height: 44 + v * 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const SweepGradient(
              colors: [Color(0xFFEC4899), Color(0xFF8B5CF6), Color(0xFF06B6D4), Color(0xFFEC4899)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.3 + v * 0.25),
                blurRadius: 14 + v * 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Icon(Icons.palette_rounded, color: Colors.white, size: 22),
        );
      },
    );
  }
}

/// Responsive grid of UI/UX design cards. Different visual language from
/// the image-based ProjectCard: vertical glass card, big icon badge on a
/// gradient header strip, tags row, and an animated Figma pill.
class _UiUxDesignGrid extends StatelessWidget {
  final List<UiUxItem> items;
  const _UiUxDesignGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth > 1000 ? 3 : (c.maxWidth > 650 ? 2 : 1);
        return AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 300,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => AnimationConfiguration.staggeredGrid(
              position: i,
              columnCount: cols,
              duration: const Duration(milliseconds: 500),
              child: ScaleAnimation(
                scale: 0.9,
                child: FadeInAnimation(child: _UiUxDesignCard(item: items[i])),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _UiUxDesignCard extends StatefulWidget {
  final UiUxItem item;
  const _UiUxDesignCard({required this.item});

  @override
  State<_UiUxDesignCard> createState() => _UiUxDesignCardState();
}

class _UiUxDesignCardState extends State<_UiUxDesignCard> with TickerProviderStateMixin {
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

  Future<void> _open() async {
    final uri = Uri.parse(widget.item.figmaUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hover.value = true,
      onExit: (_) => _hover.value = false,
      child: GestureDetector(
        onTap: _open,
        child: ValueListenableBuilder<bool>(
          valueListenable: _hover,
          builder: (_, hovered, __) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              transform: hovered ? (Matrix4.identity()..translate(0, -5, 0)) : Matrix4.identity(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Stack(
                    children: [
                      // rotating accent glow ring
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: _glow,
                          builder: (_, __) => Transform.rotate(
                            angle: _glow.value * 6.2831,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: SweepGradient(
                                  colors: [
                                    const Color(0xFFEC4899).withValues(alpha: hovered ? 0.40 : 0.18),
                                    const Color(0xFF8B5CF6).withValues(alpha: hovered ? 0.40 : 0.18),
                                    const Color(0xFF06B6D4).withValues(alpha: hovered ? 0.40 : 0.18),
                                    const Color(0xFFEC4899).withValues(alpha: hovered ? 0.40 : 0.18),
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
                          borderRadius: BorderRadius.circular(22),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: hovered ? 0.13 : 0.07),
                              Colors.white.withValues(alpha: 0.03),
                            ],
                          ),
                          border: Border.all(color: Colors.white.withValues(alpha: hovered ? 0.26 : 0.12)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8B5CF6).withValues(alpha: hovered ? 0.32 : 0.12),
                              blurRadius: hovered ? 42 : 20,
                              spreadRadius: 1,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // gradient header strip with icon badge
                            Container(
                              height: 92,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 20,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 280),
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.22),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1.4),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.25),
                                              blurRadius: 14,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                        child: Icon(widget.item.icon, color: Colors.white, size: 26),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 16,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: AnimatedBuilder(
                                        animation: _glow,
                                        builder: (_, __) => Transform.rotate(
                                          angle: _glow.value * 6.2831,
                                          child: const Icon(
                                            Icons.auto_awesome_rounded,
                                            color: Colors.white70,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // body
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.item.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (widget.item.subtitle.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        widget.item.subtitle,
                                        style: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.6),
                                          fontSize: 12.5,
                                          height: 1.4,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                    if (widget.item.tags.isNotEmpty) ...[
                                      const SizedBox(height: 12),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        children: widget.item.tags
                                            .map(
                                              (t) => Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withValues(alpha: 0.06),
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                                                  ),
                                                ),
                                                child: Text(
                                                  t,
                                                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                    const Spacer(),
                                    // Figma pill
                                    _FigmaPill(hovered: hovered),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}

// ===================== Project dialog (unchanged) =====================

class _ProjectDialog extends StatefulWidget {
  final ProjectModel project;
  const _ProjectDialog({required this.project});

  @override
  State<_ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<_ProjectDialog> with TickerProviderStateMixin {
  late final AnimationController _glow;
  late final PageController _page;
  final ValueNotifier<int> _index = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _glow = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
    _page = PageController(viewportFraction: 0.88);
  }

  @override
  void dispose() {
    _glow.dispose();
    _page.dispose();
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPhone = size.width < 700;
    final isTablet = size.width >= 700 && size.width < 1100;
    final maxW = isPhone
        ? size.width * 0.94
        : isTablet
        ? size.width * 0.86
        : 1080.0;
    final maxH = size.height * 0.9;
    final images = widget.project.images;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.of(context).maybePop(),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // rotating glow
                  AnimatedBuilder(
                    animation: _glow,
                    builder: (_, __) => Transform.rotate(
                      angle: _glow.value * 6.2831,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: SweepGradient(
                            colors: [
                              const Color(0xFFEC4899).withValues(alpha: 0.55),
                              const Color(0xFF8B5CF6).withValues(alpha: 0.55),
                              const Color(0xFF06B6D4).withValues(alpha: 0.55),
                              const Color(0xFF10B981).withValues(alpha: 0.55),
                              const Color(0xFFEC4899).withValues(alpha: 0.55),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8B5CF6).withValues(alpha: 0.35),
                              blurRadius: 60,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // glass card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white.withValues(alpha: 0.10), Colors.white.withValues(alpha: 0.04)],
                          ),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                        ),
                        child: isPhone ? _buildMobile(images) : _buildDesktop(images),
                      ),
                    ),
                  ),
                  // close
                  Positioned(top: -14, right: -14, child: _CloseButton(onTap: () => Navigator.of(context).maybePop())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop(List<String> images) {
    return Row(
      children: [
        // gallery
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _Gallery(
              images: images.isEmpty ? ['assets/placeholder.png'] : images,
              controller: _page,
              index: _index,
              tag: 'project-${widget.project.title}',
            ),
          ),
        ),
        // details
        Expanded(flex: 5, child: _Details(project: widget.project)),
      ],
    );
  }

  Widget _buildMobile(List<String> images) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 360,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _Gallery(
                images: images.isEmpty ? ['assets/placeholder.png'] : images,
                controller: _page,
                index: _index,
                tag: 'project-${widget.project.title}',
              ),
            ),
          ),
          _Details(project: widget.project),
        ],
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  final List<String> images;
  final PageController controller;
  final ValueNotifier<int> index;
  final String tag;
  const _Gallery({required this.images, required this.controller, required this.index, required this.tag});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Hero(tag: tag, child: _placeholder());
    }
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: (v) => index.value = v,
            itemBuilder: (_, i) {
              final img = images[i];
              return AnimatedBuilder(
                animation: controller,
                builder: (_, child) {
                  double value = 1;
                  if (controller.position.haveDimensions) {
                    value = (controller.page ?? 0) - i;
                    value = (1 - value.abs().clamp(0, 1) * 0.15);
                  }
                  return Transform.scale(scale: value, child: child);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: i == 0
                          ? Hero(
                              tag: tag,
                              child: InteractiveViewer(
                                minScale: 1,
                                maxScale: 4,
                                child: Image.asset(img, fit: BoxFit.contain),
                              ),
                            )
                          : InteractiveViewer(minScale: 1, maxScale: 4, child: Image.asset(img, fit: BoxFit.contain)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: index,
          builder: (_, current, __) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (i) {
              final active = i == current;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: active ? 24 : 6,
                decoration: BoxDecoration(
                  color: active ? const Color(0xFFEC4899) : Colors.white.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _placeholder() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)]),
    ),
    child: const Center(child: Icon(Icons.image_outlined, color: Colors.white70, size: 60)),
  );
}

class _Details extends StatelessWidget {
  final ProjectModel project;
  const _Details({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            project.title,
            style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700, height: 1.15),
          ),
          const SizedBox(height: 10),
          Container(
            height: 3,
            width: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)]),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          if (kFigmaLinks[project.title] != null) ...[
            const SizedBox(height: 18),
            _FigmaButton(url: kFigmaLinks[project.title]!),
          ],
          const SizedBox(height: 18),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.longDescription,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.82), fontSize: 14.5, height: 1.6),
                  ),
                  if (project.features.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Highlights',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    ...project.features.map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6, right: 10),
                              child: Icon(Icons.check_circle, color: Color(0xFFEC4899), size: 14),
                            ),
                            Expanded(
                              child: Text(
                                f,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.78),
                                  fontSize: 13.5,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (project.tags.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.tags
                          .map(
                            (t) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.4)),
                              ),
                              child: Text(
                                t,
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatefulWidget {
  final VoidCallback onTap;
  const _CloseButton({required this.onTap});

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  final ValueNotifier<bool> _hover = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hover.value = true,
      onExit: (_) => _hover.value = false,
      child: GestureDetector(
        onTap: widget.onTap,
        child: ValueListenableBuilder<bool>(
          valueListenable: _hover,
          builder: (_, h, __) => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: h ? const Color(0xFFEC4899) : Colors.black87,
              border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: (h ? const Color(0xFFEC4899) : Colors.black).withValues(alpha: 0.5),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: h ? 0.25 : 0,
              child: const Icon(Icons.close, color: Colors.white, size: 22),
            ),
          ),
        ),
      ),
    );
  }
}

// ===================== Figma widgets (UI/UX card + dialog) =====================

/// Compact animated pill used inside the UI/UX design cards.
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.hovered
              ? const [Color.fromARGB(255, 26, 41, 91), Color.fromARGB(255, 73, 80, 186)]
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
            child: const Icon(Icons.open_in_new_rounded, color: Colors.white, size: 15),
          ),
          const SizedBox(width: 8),
          Text(
            'Open in Figma',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated "Open in Figma" call-to-action used in the project dialog.
class _FigmaButton extends StatefulWidget {
  final String url;
  const _FigmaButton({required this.url});

  @override
  State<_FigmaButton> createState() => _FigmaButtonState();
}

class _FigmaButtonState extends State<_FigmaButton> with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _hover = ValueNotifier(false);
  late final AnimationController _shine = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))
    ..repeat();

  @override
  void dispose() {
    _shine.dispose();
    _hover.dispose();
    super.dispose();
  }

  Future<void> _open() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _hover.value = true,
      onExit: (_) => _hover.value = false,
      child: GestureDetector(
        onTap: _open,
        child: ValueListenableBuilder<bool>(
          valueListenable: _hover,
          builder: (_, h, __) => AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, h ? -3 : 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(colors: [Color(0xFFF24E1E), Color(0xFFEC4899), Color(0xFF8B5CF6)]),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEC4899).withValues(alpha: h ? 0.55 : 0.28),
                  blurRadius: h ? 28 : 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Figma-style mark
                    AnimatedBuilder(
                      animation: _shine,
                      builder: (_, __) => Transform.rotate(
                        angle: _shine.value * 6.2831,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.18),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.4),
                          ),
                          child: const Icon(Icons.design_services, size: 12, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Open in Figma',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(width: 10),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 260),
                      offset: Offset(h ? 0.25 : 0, 0),
                      child: const Icon(Icons.arrow_outward_rounded, size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
