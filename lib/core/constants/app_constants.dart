/// Core application constants for the Day Planner.
///
/// Timeline operates on integer minutes (0–1439).
/// All scheduling snaps to a 15-minute grid.
class AppConstants {
  AppConstants._();

  // ─── Timeline ────────────────────────────────────────────
  /// Total minutes in a 24-hour day.
  static const int totalDayMinutes = 1440;

  /// Scheduling grid resolution in minutes.
  static const int gridResolution = 15;

  /// Minimum allowed task/break duration.
  static const int minDuration = 15;

  /// Maximum allowed task/break duration (entire day).
  static const int maxDuration = totalDayMinutes;

  /// Predefined duration options (minutes) shown in the dialog.
  static const List<int> durationOptions = [15, 30, 45, 60, 90, 120, 150, 180];

  // ─── Working Hours Defaults ──────────────────────────────
  /// Default workday start (9:00 AM = 540 minutes).
  static const int defaultDayStartMinute = 540;

  /// Default workday end (6:00 PM = 1080 minutes).
  static const int defaultDayEndMinute = 1080;

  // ─── Typography Defaults ─────────────────────────────────
  static const double defaultTimeFontSize = 10.0;
  static const bool defaultTimeFontBold = true;

  // ─── Timeline Visual ─────────────────────────────────────
  /// Pixels per minute on the timeline.
  /// In the original Python app, 1 minute = 1 pixel.
  static const double pixelsPerMinute = 1.0;

  /// Total timeline height in pixels.
  static const double timelineHeight = totalDayMinutes * pixelsPerMinute;

  /// Height of one hour on the timeline.
  static const double hourHeight = 60.0 * pixelsPerMinute;

  // ─── Undo ────────────────────────────────────────────────
  /// Maximum number of undo levels.
  static const int maxUndoLevels = 20;
}
