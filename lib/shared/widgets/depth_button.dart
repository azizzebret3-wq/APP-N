import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';

/// A premium button with depth, glow, and press animation.
class DepthButton extends StatefulWidget {
  const DepthButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
    this.width,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;
  final double? width;

  @override
  State<DepthButton> createState() => _DepthButtonState();
}

class _DepthButtonState extends State<DepthButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _controller.forward();
    setState(() => _pressed = true);
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    setState(() => _pressed = false);
    widget.onPressed();
  }

  void _onTapCancel() {
    _controller.reverse();
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.indigo;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: Container(
          width: widget.width,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                Color.lerp(color, Colors.black, 0.15)!,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _pressed
                ? AppShadows.pressed
                : AppShadows.glow(color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white, size: 20),
                const SizedBox(width: 10),
              ],
              Text(
                widget.label,
                style: AppTypography.labelLarge
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
