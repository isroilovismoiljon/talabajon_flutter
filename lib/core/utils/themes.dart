import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemes {
  final lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.dark,
      onPrimary: AppColors.light,
      secondary: AppColors.light,
      onSecondary: AppColors.dark,
      error: Colors.red,
      onError: Colors.yellow,
      surface: AppColors.light,
      onSurface: AppColors.dark,
    ),

    textTheme: TextTheme(
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.light,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.dark,
      ),
    ),
  );

  final darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.light,
      onPrimary: AppColors.dark,
      secondary: AppColors.light,
      onSecondary: AppColors.dark,
      error: Colors.red,
      onError: Colors.yellow,
      surface: AppColors.dark,
      onSurface: AppColors.light,
    ),

    textTheme: TextTheme(
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.light,
      ),
    ),
  );
}
