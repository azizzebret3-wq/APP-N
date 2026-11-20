import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Material 3 light and dark themes for Nourou Academy.
abstract final class AppTheme {
  static const _radius = 18.0;

  // ── Light Theme ────────────────────────────────────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.surface,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.indigo,
          brightness: Brightness.light,
          primary: AppColors.indigo,
          secondary: AppColors.gold,
          tertiary: AppColors.coral,
          surface: AppColors.surface,
        ),
        fontFamily: AppTypography.bodyFamily,
        textTheme: TextTheme(
          displayLarge: AppTypography.displayLarge,
          displayMedium: AppTypography.displayMedium,
          displaySmall: AppTypography.displaySmall,
          headlineLarge: AppTypography.headlineLarge,
          headlineMedium: AppTypography.headlineMedium,
          headlineSmall: AppTypography.headlineSmall,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.labelMedium,
          labelSmall: AppTypography.labelSmall,
        ),
        cardTheme: CardThemeData(
          color: AppColors.card,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.indigo,
            foregroundColor: AppColors.textOnPrimary,
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.card,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.card,
          indicatorColor: AppColors.indigo.withAlpha(26),
          labelTextStyle: WidgetStatePropertyAll(
            AppTypography.labelSmall.copyWith(letterSpacing: 0),
          ),
        ),
      );

  // ── Dark Theme ─────────────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkSurface,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.indigo,
          brightness: Brightness.dark,
          primary: AppColors.indigoLight,
          secondary: AppColors.goldLight,
          tertiary: AppColors.coralSoft,
          surface: AppColors.darkSurface,
        ),
        fontFamily: AppTypography.bodyFamily,
        textTheme: TextTheme(
          displayLarge:
              AppTypography.displayLarge.copyWith(color: AppColors.darkTextPrimary),
          displayMedium:
              AppTypography.displayMedium.copyWith(color: AppColors.darkTextPrimary),
          displaySmall:
              AppTypography.displaySmall.copyWith(color: AppColors.darkTextPrimary),
          headlineLarge:
              AppTypography.headlineLarge.copyWith(color: AppColors.darkTextPrimary),
          headlineMedium:
              AppTypography.headlineMedium.copyWith(color: AppColors.darkTextPrimary),
          headlineSmall:
              AppTypography.headlineSmall.copyWith(color: AppColors.darkTextPrimary),
          bodyLarge:
              AppTypography.bodyLarge.copyWith(color: AppColors.darkTextPrimary),
          bodyMedium:
              AppTypography.bodyMedium.copyWith(color: AppColors.darkTextPrimary),
          bodySmall:
              AppTypography.bodySmall.copyWith(color: AppColors.darkTextSecondary),
          labelLarge:
              AppTypography.labelLarge.copyWith(color: AppColors.darkTextPrimary),
          labelMedium:
              AppTypography.labelMedium.copyWith(color: AppColors.darkTextPrimary),
          labelSmall:
              AppTypography.labelSmall.copyWith(color: AppColors.darkTextSecondary),
        ),
        cardTheme: CardThemeData(
          color: AppColors.darkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.indigoLight,
            foregroundColor: AppColors.textOnPrimary,
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkCard,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.darkCard,
          indicatorColor: AppColors.indigoLight.withAlpha(40),
          labelTextStyle: WidgetStatePropertyAll(
            AppTypography.labelSmall.copyWith(letterSpacing: 0),
          ),
        ),
      );
}
