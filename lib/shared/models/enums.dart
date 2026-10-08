import 'package:flutter/material.dart';

/// Block type: either a schedulable task or a reserved break.
enum BlockType {
  task,
  breakBlock; // 'break' is a Dart reserved word

  /// JSON-safe string representation.
  String toJson() {
    switch (this) {
      case BlockType.task:
        return 'task';
      case BlockType.breakBlock:
        return 'break';
    }
  }

  /// Parse from JSON string.
  static BlockType fromJson(String value) {
    switch (value) {
      case 'break':
        return BlockType.breakBlock;
      case 'task':
      default:
        return BlockType.task;
    }
  }

  /// Human-readable display name.
  String get displayName {
    switch (this) {
      case BlockType.task:
        return 'Task';
      case BlockType.breakBlock:
        return 'Break';
    }
  }
}

/// Recurrence options for tasks and breaks.
enum Repeat {
  none,
  daily;

  String toJson() => name;

  static Repeat fromJson(String value) {
    switch (value) {
      case 'daily':
        return Repeat.daily;
      case 'none':
      default:
        return Repeat.none;
    }
  }

  String get displayName {
    switch (this) {
      case Repeat.none:
        return 'None';
      case Repeat.daily:
        return 'Daily';
    }
  }
}

/// Color tag options for tasks.
///
/// Colors here are the logical tag identifiers.
/// Actual fill colors are resolved via [ColorTag.color].
enum ColorTag {
  none,
  blue,
  green,
  orange,
  red;

  String toJson() => name;

  static ColorTag fromJson(String? value) {
    if (value == null) return ColorTag.none;
    switch (value) {
      case 'blue':
        return ColorTag.blue;
      case 'green':
        return ColorTag.green;
      case 'orange':
        return ColorTag.orange;
      case 'red':
        return ColorTag.red;
      case 'none':
      default:
        return ColorTag.none;
    }
  }

  /// The actual RGBA color associated with this tag.
  /// Matches the Python source color values.
  Color? get color {
    switch (this) {
      case ColorTag.none:
        return null;
      case ColorTag.blue:
        return const Color.fromRGBO(60, 100, 200, 0.7);
      case ColorTag.green:
        return const Color.fromRGBO(60, 120, 80, 0.7);
      case ColorTag.orange:
        return const Color.fromRGBO(200, 120, 40, 0.7);
      case ColorTag.red:
        return const Color.fromRGBO(180, 60, 60, 0.7);
    }
  }

  String get displayName {
    switch (this) {
      case ColorTag.none:
        return 'None';
      case ColorTag.blue:
        return 'Blue';
      case ColorTag.green:
        return 'Green';
      case ColorTag.orange:
        return 'Orange';
      case ColorTag.red:
        return 'Red';
    }
  }
}
