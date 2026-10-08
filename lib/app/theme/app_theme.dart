import 'package:flutter/material.dart';

import 'package:day_planner/app/theme/app_colors.dart';

/// Application theme builder.
///
/// Produces Material [ThemeData] for the two predefined themes:
/// - **Dark** (default) — matches the original Python app's appearance.
/// - **Light** — a clean, bright alternative.
///
/// Widgets should read colors via `Theme.of(context)` extensions
/// or directly from [AppColors] for planner-specific tokens.
class AppTheme {
  AppTheme._();

  // ─── Dark Theme ──────────────────────────────────────────
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkTaskFill,
        secondary: AppColors.darkBreakFill,
        surface: AppColors.darkSurface,
      ),
      cardColor: AppColors.darkSurface,

      dividerColor: AppColors.hourSeparator,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.cardTextPrimary),
        bodyMedium: TextStyle(color: AppColors.cardTextSecondary),
        titleMedium: TextStyle(
          color: AppColors.cardTextPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.cardTextPrimary,
        size: 24.0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          minimumSize: const Size(0, 48),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: AppColors.darkSurface,
      ),
    );
  }

  // ─── Light Theme ─────────────────────────────────────────
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightTaskFill,
        secondary: AppColors.lightBreakFill,
        surface: AppColors.lightSurface,
      ),
      cardColor: AppColors.lightSurface,

      dividerColor: AppColors.hourSeparator,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1A1A1A)),
        bodyMedium: TextStyle(color: Color(0xFF555555)),
        titleMedium: TextStyle(
          color: Color(0xFF1A1A1A),
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF333333), size: 24.0),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          minimumSize: const Size(0, 48),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: AppColors.lightSurface,
      ),
    );
  }

  /// Returns the [ThemeData] for the given theme name.
  ///
  /// Falls back to dark theme for unknown names.
  static ThemeData fromName(String name) {
    switch (name.toLowerCase()) {
      case 'light':
      case 'default':
        return light;
      case 'dark':
      case 'gray':
        return dark;
      default:
        return dark;
    }
  }
}
