import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:app_munafa_job/core/constant/style/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme{
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.screenBackground,
      fontFamily: AppFonts.primaryFont,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColors,
        primary: AppColors.primaryColors,
        error: AppColors.error,
        surface: AppColors.cardBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardBackground,
        foregroundColor: AppColors.textHeading,
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground,
      )
    );
  }
}