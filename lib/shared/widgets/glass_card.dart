import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';

/// A glassmorphism card with blur, translucency, and border highlight.
class GlassCard extends StatelessWidget {
  const GlassCard({
    required this.child,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(20),
    this.blur = 16,
    this.opacity = 0.12,
    super.key,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final double blur;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: (isDark ? Colors.white : Colors.white)
                .withAlpha((opacity * 255).round()),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: AppColors.glassBorder, width: 1),
            boxShadow: AppShadows.card,
          ),
          child: child,
        ),
      ),
    );
  }
}
