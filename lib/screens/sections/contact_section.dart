import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(overline: '05 / Contact', title: "Let's build something."),
              GlassCard(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Have a project in mind ? My inbox is always open.",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: [
                        _ContactBtn(
                          icon: Icons.email_outlined,
                          label: AppStrings.email,
                          onTap: () => _open('mailto:${AppStrings.email}'),
                        ),
                        _ContactBtn(
                          icon: Icons.phone_outlined,
                          label: AppStrings.phone,
                          onTap: () => _open('tel:${AppStrings.phone}'),
                        ),
                      //  _ContactBtn(icon: Icons.location_on_outlined, label: AppStrings.location, onTap: () {}),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _open('https://github.com/RaghadHamsho'),
                          icon: const FaIcon(FontAwesomeIcons.github),
                        ),
                        IconButton(
                          onPressed: () => _open('https://www.linkedin.com/in/raghad-hamsho-'),
                          icon: const FaIcon(FontAwesomeIcons.linkedin),
                        ),
                        IconButton(
                          onPressed: () => _open('https://wa.me/${AppStrings.phone.replaceAll('+', '')}'),
                          icon: const FaIcon(FontAwesomeIcons.whatsapp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  '© 2026  ${AppStrings.name}  ·  Crafted with Flutter',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactBtn extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ContactBtn({required this.icon, required this.label, required this.onTap});
  @override
  State<_ContactBtn> createState() => _ContactBtnState();
}

class _ContactBtnState extends State<_ContactBtn> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: _hover
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: _hover ? Colors.white : Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _hover ? Colors.white : Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
