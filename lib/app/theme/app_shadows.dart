import 'package:flutter/material.dart';

/// Shadow elevation tokens.
///
/// Only two elevation levels are permitted per the Design System.
class AppShadows {
  AppShadows._();

  /// Low elevation — subtle lift for cards.
  static const List<BoxShadow> low = [
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      blurRadius: 4.0,
      offset: Offset(0, 2),
    ),
  ];

  /// High elevation — prominent lift for dialogs, floating elements.
  static const List<BoxShadow> high = [
    BoxShadow(
      color: Color(0x33000000), // 20% black
      blurRadius: 12.0,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0D000000), // 5% black
      blurRadius: 4.0,
      offset: Offset(0, 1),
    ),
  ];
}
