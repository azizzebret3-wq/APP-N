import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_shadows.dart';

/// A small floating info chip with shadow and optional animate-in.
class FloatingChip extends StatelessWidget {
  const FloatingChip({
    required this.icon,
    required this.label,
    this.color,
    this.delay = Duration.zero,
    super.key,
  });

  final IconData icon;
  final String label;
  final Color? color;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: AppShadows.elevated,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: chipColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: chipColor,
            ),
          ),
        ],
      ),
    )
        .animate(delay: delay)
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }
}
