import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/providers/planner_provider.dart';

/// Provides the current [ThemeMode] based on the PlannerSettings in the database.
final themeModeProvider = Provider<ThemeMode>((ref) {
  final plannerState = ref.watch(plannerProvider);

  return plannerState.when(
    data: (planner) {
      final name = planner.settings.theme.toLowerCase();
      if (name == 'light' || name == 'default') return ThemeMode.light;
      if (name == 'dark' || name == 'gray') return ThemeMode.dark;
      if (name == 'system') return ThemeMode.system;
      return ThemeMode.dark;
    },
    loading: () => ThemeMode.dark, // Fallback during initial load
    error: (_, _) => ThemeMode.dark,
  );
});
