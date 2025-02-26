import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/theme/app_colors.dart";

final ThemeData customTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.amethyst,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.amethyst,
    secondary: AppColors.lavenda,
    error: AppColors.red,
  ),
  scaffoldBackgroundColor: AppColors.dark,
  textTheme: const TextTheme(
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
    labelStyle: const TextStyle(color: AppColors.lavenda),
    hintStyle: const TextStyle(color: AppColors.lavenda),
    helperStyle: const TextStyle(color: AppColors.lavenda),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      borderSide: const BorderSide(color: AppColors.light),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      borderSide: const BorderSide(color: AppColors.lavenda),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      borderSide: const BorderSide(color: AppColors.lavenda),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSmall,
        horizontal: AppDimensions.paddingBig,
      ),
      backgroundColor: AppColors.amethyst,
      foregroundColor: AppColors.light,
      textStyle: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.lighterDark,
    contentTextStyle: const TextStyle(color: AppColors.light, fontSize: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 5,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.lavenda,
      textStyle: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
    ),
  ),
);
