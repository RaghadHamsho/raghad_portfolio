import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../models/project_model.dart';
import '../../repositories/portfolio_repository.dart';
import '../../widgets/project_card.dart';
import '../../widgets/section_title.dart';

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
        barrierColor: Colors.black.withOpacity(0.55),
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
                              const Color(0xFFEC4899).withOpacity(0.55),
                              const Color(0xFF8B5CF6).withOpacity(0.55),
                              const Color(0xFF06B6D4).withOpacity(0.55),
                              const Color(0xFF10B981).withOpacity(0.55),
                              const Color(0xFFEC4899).withOpacity(0.55),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8B5CF6).withOpacity(0.35),
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
                            colors: [Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.04)],
                          ),
                          border: Border.all(color: Colors.white.withOpacity(0.14)),
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
                        color: Colors.black.withOpacity(0.4),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 30, offset: const Offset(0, 12)),
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
                  color: active ? const Color(0xFFEC4899) : Colors.white.withOpacity(0.35),
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
          const SizedBox(height: 18),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.longDescription,
                    style: TextStyle(color: Colors.white.withOpacity(0.82), fontSize: 14.5, height: 1.6),
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
                                style: TextStyle(color: Colors.white.withOpacity(0.78), fontSize: 13.5, height: 1.5),
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
                                color: Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.4)),
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
              border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: (h ? const Color(0xFFEC4899) : Colors.black).withOpacity(0.5),
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
