/// Layout dimension tokens.
///
/// Button heights, touch targets, dialog widths, and
/// task/break card dimensions.
class AppLayout {
  AppLayout._();

  // ─── Button Heights ──────────────────────────────────────
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightNormal = 48.0;
  static const double buttonHeightLarge = 56.0;

  // ─── Touch Targets ───────────────────────────────────────
  /// Minimum touch target per Material guidelines.
  static const double minTouchTarget = 48.0;

  // ─── Dialog Widths ───────────────────────────────────────
  /// Maximum dialog width on desktop.
  static const double dialogMaxWidthDesktop = 500.0;

  /// Dialog width as fraction of screen width on mobile.
  static const double dialogWidthFractionMobile = 0.9;

  // ─── Task Card ───────────────────────────────────────────
  /// Fixed width for task blocks (from Python source: 360).
  static const double taskCardWidth = 360.0;

  /// Fixed width for break blocks (from Python source: 308).
  static const double breakCardWidth = 308.0;

  /// Left margin for task/break cards on the timeline.
  static const double cardLeftMargin = 70.0;

  /// Resize handle height at bottom of task cards.
  static const double resizeHandleHeight = 8.0;

  // ─── Timeline ────────────────────────────────────────────
  /// Width of the hour label column.
  static const double timeColumnWidth = 60.0;

  /// Vertical pixels per minute on the timeline (zoom level).
  static const double pixelsPerMinute = 2.0;

  // ─── Toolbar ─────────────────────────────────────────────
  /// Fixed height for the bottom toolbar.
  static const double toolbarHeight = 56.0;

  /// Fixed height for the summary bar.
  static const double summaryBarHeight = 40.0;
}
