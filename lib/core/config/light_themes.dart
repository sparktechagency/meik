import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData get lightThemeData {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bgColorWhite,
      brightness: Brightness.light,
      colorSchemeSeed: AppColors.primaryColor,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bgColor,
      ),


      bottomSheetTheme: BottomSheetThemeData(
      ),
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
      colorSchemeSeed: AppColors.primaryColor,
      brightness: Brightness.dark,
    );
  }
}