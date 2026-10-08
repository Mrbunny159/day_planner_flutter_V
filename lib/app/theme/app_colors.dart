import 'package:flutter/material.dart';

/// Application color tokens.
///
/// Two predefined themes are available: Default (dark) and Light.
/// Custom colors can override task/break fill and border colors.
///
/// Color values are inspired by the original Python source but
/// refined for cross-platform (iOS/Android) visual quality.
class AppColors {
  AppColors._();

  // ═══════════════════════════════════════════════════════════
  //  DARK THEME (Default)
  // ═══════════════════════════════════════════════════════════

  /// Main scaffold background.
  static const Color darkBackground = Color(0xFF121212);

  /// Timeline / scene background — slightly lighter.
  static const Color darkTimelineBg = Color(0xFF1E1E1E);

  /// Surface color for cards, dialogs.
  static const Color darkSurface = Color(0xFF252525);

  /// Task block fill.
  static const Color darkTaskFill = Color(0xB83C64C8); // RGBA(60,100,200,0.72)

  /// Task block border.
  static const Color darkTaskBorder = Color(0xFF6496DC); // RGB(100,150,220)

  /// Break block fill.
  static const Color darkBreakFill = Color(0xB83C7850); // RGBA(60,120,80,0.72)

  /// Break block border.
  static const Color darkBreakBorder = Color(0xFF64C878); // RGB(100,200,120)

  // ═══════════════════════════════════════════════════════════
  //  LIGHT THEME
  // ═══════════════════════════════════════════════════════════

  /// Main scaffold background.
  static const Color lightBackground = Color(0xFFF5F5F7);

  /// Timeline / scene background.
  static const Color lightTimelineBg = Color(0xFFFFFFFF);

  /// Surface color for cards, dialogs.
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// Task block fill — slightly deeper blue for readability on white.
  static const Color lightTaskFill = Color(0xCC3F72D6); // RGBA(63,114,214,0.80)

  /// Task block border.
  static const Color lightTaskBorder = Color(0xFF5B8FE8);

  /// Break block fill — muted green.
  static const Color lightBreakFill = Color(0xCC3D8B56); // RGBA(61,139,86,0.80)

  /// Break block border.
  static const Color lightBreakBorder = Color(0xFF5CB87A);

  // ═══════════════════════════════════════════════════════════
  //  SEMANTIC TOKENS (theme-independent)
  // ═══════════════════════════════════════════════════════════

  /// Current time indicator line.
  static const Color currentTimeLine = Color(
    0xCCFF0000,
  ); // Red, semi-transparent

  /// Current time pill background.
  static const Color currentTimePill = Color(0xCCC80000); // Dark red

  /// Current time pill text.
  static const Color currentTimePillText = Color(0xFFC8C8C8);

  /// Duration pill background.
  static const Color durationPillBg = Color(0xCCC80000);

  /// Duration pill border.
  static const Color durationPillBorder = Color(0xFFFFC8C8);

  /// Duration pill text.
  static const Color durationPillText = Color(0xFFC8C8C8);

  /// Recurring pill background.
  static const Color recurringPillBg = Color(0xCC467846);

  /// Recurring pill border.
  static const Color recurringPillBorder = Color(0xFFC8FFC8);

  /// Recurring pill text.
  static const Color recurringPillText = Color(0xFFDCFFDC);

  /// Selection / hover highlight border.
  static const Color selectionHighlight = Color(0xFFFFD54F);

  /// Conflict flash overlay.
  static const Color conflictFlash = Color(0x64FF5050);

  /// Text on dark task/break cards.
  static const Color cardTextPrimary = Color(0xFFF0F0F0);

  /// Secondary text on cards (time range).
  static const Color cardTextSecondary = Color(0xFFD2D2D2);

  /// Hour label text on timeline.
  static const Color hourLabelText = Color(0xFF888888);

  /// Hour separator line.
  static const Color hourSeparator = Color(0x32C8C8C8); // alpha ~20%

  /// Half-hour separator line.
  static const Color halfHourSeparator = Color(0x28C8C8C8); // alpha ~16%

  // ─── Toolbar button colors ───────────────────────────────
  static const Color btnAdd = Color(0xFF7AA9D9);
  static const Color btnDelete = Color(0xFFD78C8C);
  static const Color btnClearAll = Color(0xFFBD92C2);
  static const Color btnAutoPlan = Color(0xFFE8B977);
  static const Color btnSettings = Color(0xFFA0A6AD);

  // ─── Status colors ───────────────────────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color danger = Color(0xFFF44336);
}
