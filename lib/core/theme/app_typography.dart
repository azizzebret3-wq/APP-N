import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typographic scale for Nourou Academy.
/// Display: Bricolage Grotesque (strong, bold).
/// Body: Inter (highly legible).
abstract final class AppTypography {
  static String? _displayFamily;
  static String? _bodyFamily;

  static String get displayFamily =>
      _displayFamily ??= GoogleFonts.bricolageGrotesque().fontFamily!;

  static String get bodyFamily =>
      _bodyFamily ??= GoogleFonts.inter().fontFamily!;

  // ── Display ────────────────────────────────────────────────────────
  static TextStyle get displayLarge => TextStyle(
        fontFamily: displayFamily,
        fontSize: 40,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -1.5,
      );

  static TextStyle get displayMedium => TextStyle(
        fontFamily: displayFamily,
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 1.15,
        letterSpacing: -1.0,
      );

  static TextStyle get displaySmall => TextStyle(
        fontFamily: displayFamily,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
      );

  // ── Headline ───────────────────────────────────────────────────────
  static TextStyle get headlineLarge => TextStyle(
        fontFamily: displayFamily,
        fontSize: 22,
        fontWeight: FontWeight.w800,
        height: 1.25,
        letterSpacing: -0.4,
      );

  static TextStyle get headlineMedium => TextStyle(
        fontFamily: displayFamily,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.3,
      );

  static TextStyle get headlineSmall => TextStyle(
        fontFamily: displayFamily,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.35,
      );

  // ── Body ───────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => TextStyle(
        fontFamily: bodyFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.55,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontFamily: bodyFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: bodyFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.45,
      );

  // ── Label ──────────────────────────────────────────────────────────
  static TextStyle get labelLarge => TextStyle(
        fontFamily: bodyFamily,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.4,
        letterSpacing: 0.1,
      );

  static TextStyle get labelMedium => TextStyle(
        fontFamily: bodyFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.3,
      );

  static TextStyle get labelSmall => TextStyle(
        fontFamily: bodyFamily,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        height: 1.4,
        letterSpacing: 0.8,
      );
}
