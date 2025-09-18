import 'package:flutter/material.dart';
import 'package:seci_desktop/core/theme/app_theme.dart';
import 'package:seci_desktop/features/counters/presentation/screen/counters.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SECI Desktop",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const CountersScreen(),
    );
  }
}
