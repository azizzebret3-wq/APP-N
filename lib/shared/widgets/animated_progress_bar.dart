import 'package:flutter/material.dart';

/// An animated progress bar with rounded ends and gradient fill.
class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    required this.value,
    this.height = 8,
    this.backgroundColor,
    this.foregroundColor,
    this.gradient,
    this.duration = const Duration(milliseconds: 800),
    super.key,
  });

  final double value;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Gradient? gradient;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? scheme.primary.withAlpha(30);
    final fg = foregroundColor ?? scheme.primary;
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Container(
        height: height,
        color: bg,
        child: AnimatedFractionallySizedBox(
          duration: duration,
          curve: Curves.easeOutCubic,
          alignment: Alignment.centerLeft,
          widthFactor: value.clamp(0.0, 1.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(colors: [fg, fg.withAlpha(200)]),
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ),
      ),
    );
  }
}
