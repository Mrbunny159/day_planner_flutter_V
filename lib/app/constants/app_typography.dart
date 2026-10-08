import 'package:flutter/material.dart';

/// Typography tokens.
///
/// Only four font sizes and three weights are permitted.
class AppTypography {
  AppTypography._();

  // ─── Font Sizes ──────────────────────────────────────────
  static const double sizeXs = 12.0;
  static const double sizeSm = 14.0;
  static const double sizeMd = 16.0;
  static const double sizeLg = 20.0;

  // ─── Font Weights ────────────────────────────────────────
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  // ─── Pre-built TextStyles ────────────────────────────────
  static const TextStyle caption = TextStyle(
    fontSize: sizeXs,
    fontWeight: regular,
  );

  static const TextStyle body = TextStyle(
    fontSize: sizeSm,
    fontWeight: regular,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: sizeSm,
    fontWeight: medium,
  );

  static const TextStyle title = TextStyle(
    fontSize: sizeMd,
    fontWeight: medium,
  );

  static const TextStyle headline = TextStyle(
    fontSize: sizeLg,
    fontWeight: bold,
  );

  /// Task card name — bold, slightly larger.
  static const TextStyle taskName = TextStyle(
    fontSize: sizeSm,
    fontWeight: bold,
  );

  /// Task card time range — condensed, lighter weight.
  static const TextStyle taskTime = TextStyle(
    fontSize: sizeXs,
    fontWeight: medium,
    letterSpacing: -0.3,
  );

  /// Duration pill text — small, bold.
  static const TextStyle pillText = TextStyle(
    fontSize: sizeXs,
    fontWeight: bold,
  );

  /// Hour label on the timeline.
  static const TextStyle hourLabel = TextStyle(
    fontSize: sizeXs,
    fontWeight: regular,
  );
}
