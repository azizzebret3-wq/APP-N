import 'package:flutter/material.dart';

/// Nourou Academy color palette.
/// Indigo deep, gold/amber, coral, mint green – vivid & rich.
abstract final class AppColors {
  // ── Primary palette ──────────────────────────────────────────────
  static const Color indigo = Color(0xFF1E1B4B);
  static const Color indigoLight = Color(0xFF3730A3);
  static const Color indigoSurface = Color(0xFF312E81);

  static const Color gold = Color(0xFFF59E0B);
  static const Color goldLight = Color(0xFFFBBF24);
  static const Color goldDark = Color(0xFFD97706);

  static const Color coral = Color(0xFFEF4444);
  static const Color coralLight = Color(0xFFFCA5A5);
  static const Color coralSoft = Color(0xFFFF7B72);

  static const Color mint = Color(0xFF10B981);
  static const Color mintLight = Color(0xFF6EE7B7);
  static const Color mintDark = Color(0xFF047857);

  // ── Neutrals ──────────────────────────────────────────────────────
  static const Color surface = Color(0xFFF8FAFC);
  static const Color surfaceDim = Color(0xFFE2E8F0);
  static const Color card = Colors.white;
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textOnPrimary = Colors.white;

  // ── Dark mode ─────────────────────────────────────────────────────
  static const Color darkSurface = Color(0xFF0F0D1A);
  static const Color darkCard = Color(0xFF1C1A2E);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // ── Glassmorphism ─────────────────────────────────────────────────
  static const Color glassLight = Color(0x33FFFFFF);
  static const Color glassDark = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
}
