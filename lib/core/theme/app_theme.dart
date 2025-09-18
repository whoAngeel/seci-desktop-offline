import 'package:flutter/material.dart';
import 'package:seci_desktop/core/theme/app_colors.dart';
import 'package:seci_desktop/core/theme/app_text_theme.dart';

class AppTheme {
  // tema claro

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      // background: AppColors.background,
      // onBackground: Colors.black,
      surface: AppColors.background,
      onSurface: Colors.black,
    ),
    // cardTheme: CardTheme(
    //   elevation: 2,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    // ),
    textTheme: appTextTheme,
  );

  // tema oscuro
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      // background: AppColors.oxfordBlue,
      // onBackground: Colors.white,
      surface: AppColors.charcoal,
      onSurface: Colors.white,
    ),
    textTheme: appTextTheme,
  );
}
