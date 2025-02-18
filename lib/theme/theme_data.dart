import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/theme/app_colors.dart";

final ThemeData customTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.amethyst,
  colorScheme: ColorScheme.dark(
    primary: AppColors.amethyst,
    secondary: AppColors.teal,
  ),
  scaffoldBackgroundColor: AppColors.dark,
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontSize: AppDimensions.fontSizeBig,
      fontWeight: FontWeight.bold,
      color: AppColors.light,
    ),
    bodyMedium: TextStyle(
      fontSize: AppDimensions.fontSizeSmall,
      color: AppColors.light,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      borderSide: BorderSide(color: AppColors.light),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.amethyst,
      foregroundColor: AppColors.dark,
      minimumSize: Size(50, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      textStyle: TextStyle(fontSize: AppDimensions.fontSizeMedium),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.lighterDark,
    contentTextStyle: TextStyle(color: AppColors.light, fontSize: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 5,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSmall,
        horizontal: AppDimensions.paddingBig,
      ),
      backgroundColor: AppColors.amethyst,
      foregroundColor: AppColors.dark,
      textStyle: TextStyle(fontSize: AppDimensions.fontSizeSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
    ),
  ),
);
