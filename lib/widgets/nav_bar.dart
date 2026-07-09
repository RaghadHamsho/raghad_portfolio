import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubits/navigation/navigation_cubit.dart';
import '../logic/cubits/theme/theme_cubit.dart';
import '../logic/cubits/theme/theme_state.dart';

class NavBar extends StatelessWidget {
  final void Function(Section) onJump;
  const NavBar({super.key, required this.onJump});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 800;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 64, vertical: 14),
          decoration: BoxDecoration(
            color: (isDark ? Colors.black : Colors.white).withOpacity(0.35),
            border: Border(
              bottom: BorderSide(
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.06),
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                'RH.',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  letterSpacing: -0.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              if (!isMobile)
                ...Section.values.map((s) => _NavItem(section: s, onTap: onJump)),
              const SizedBox(width: 12),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) => IconButton(
                  onPressed: () => context.read<ThemeCubit>().toggle(),
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      state.isDark ? Icons.light_mode : Icons.dark_mode,
                      key: ValueKey(state.isDark),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final Section section;
  final void Function(Section) onTap;
  const _NavItem({required this.section, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final name = widget.section.name;
    final label = name[0].toUpperCase() + name.substring(1);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () {
          context.read<NavigationCubit>().select(widget.section);
          widget.onTap(widget.section);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hover
                ? Theme.of(context).colorScheme.primary.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: _hover
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
    );
  }
}
