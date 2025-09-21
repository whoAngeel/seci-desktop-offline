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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,

      home: const CountersScreen(),
    );
  }
}
