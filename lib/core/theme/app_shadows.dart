import 'package:flutter/material.dart';

/// Multi-layer realistic shadows for depth & relief.
abstract final class AppShadows {
  /// Subtle card elevation.
  static List<BoxShadow> get card => const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
        BoxShadow(
          color: Color(0x0F000000),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
        BoxShadow(
          color: Color(0x05000000),
          blurRadius: 24,
          offset: Offset(0, 12),
        ),
      ];

  /// Elevated floating element (nav bar, FAB).
  static List<BoxShadow> get elevated => const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 40,
          offset: Offset(0, 20),
        ),
      ];

  /// Pressed / active state (reduced shadow).
  static List<BoxShadow> get pressed => const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ];

  /// Glow effect for primary actions (indigo tint).
  static List<BoxShadow> glow(Color color) => [
        BoxShadow(
          color: color.withAlpha(60),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: color.withAlpha(30),
          blurRadius: 40,
          offset: const Offset(0, 16),
        ),
      ];
}
