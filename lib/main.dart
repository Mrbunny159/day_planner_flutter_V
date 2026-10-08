import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/providers/theme_provider.dart';
import 'package:day_planner/ui/screens/planner_screen.dart';
import 'package:day_planner/app/theme/app_theme.dart';

import 'package:day_planner/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  runApp(const ProviderScope(child: DayPlannerApp()));
}

class DayPlannerApp extends ConsumerWidget {
  const DayPlannerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme mode provider to automatically switch themes
    final mode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Day Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      home: const PlannerScreen(),
    );
  }
}
