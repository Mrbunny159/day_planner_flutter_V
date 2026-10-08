import 'package:flutter/material.dart';

/// Border radius tokens.
///
/// Every widget uses predefined radius values for consistency.
class AppRadius {
  AppRadius._();

  /// 8 px — small elements, pills.
  static const double small = 8.0;

  /// 12 px — medium elements, task cards, buttons.
  static const double medium = 12.0;

  /// 16 px — large elements, dialogs.
  static const double large = 16.0;

  // ─── Named Aliases ───────────────────────────────────────
  static const double card = medium;
  static const double dialog = large;
  static const double button = medium;
  static const double pill = small;

  // ─── BorderRadius Helpers ────────────────────────────────
  static final BorderRadius cardRadius = BorderRadius.circular(card);
  static final BorderRadius dialogRadius = BorderRadius.circular(dialog);
  static final BorderRadius buttonRadius = BorderRadius.circular(button);
  static final BorderRadius pillRadius = BorderRadius.circular(pill);
}
