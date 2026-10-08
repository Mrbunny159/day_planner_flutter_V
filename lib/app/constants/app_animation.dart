import 'package:flutter/material.dart';

/// Animation duration and curve tokens.
///
/// Only two duration tiers are permitted.
/// Curves are assigned by interaction type.
class AppAnimation {
  AppAnimation._();

  // ─── Durations ───────────────────────────────────────────
  /// Standard transitions: 150 ms.
  static const Duration fast = Duration(milliseconds: 150);

  /// Extended transitions: 300 ms.
  static const Duration slow = Duration(milliseconds: 300);

  /// Conflict flash overlay duration (from Python source: 600 ms).
  static const Duration conflictFlash = Duration(milliseconds: 600);

  // ─── Curves ──────────────────────────────────────────────
  /// Current time indicator movement — linear.
  static const Curve currentTime = Curves.linear;

  /// Dialog open/close — ease in-out.
  static const Curve dialog = Curves.ease;

  /// Selection highlight — ease out.
  static const Curve selection = Curves.easeOut;

  /// Task movement after conflict — smooth deceleration.
  static const Curve taskMove = Curves.easeOutCubic;
}
