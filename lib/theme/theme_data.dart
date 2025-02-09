import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/theme/app_colors.dart";

final ThemeData customTheme = ThemeData (

  brightness: Brightness.dark, 
  primaryColor: amethyst,
  colorScheme: ColorScheme.dark(
    primary: amethyst,
    secondary: teal, 
  ),
  scaffoldBackgroundColor: dark,


  textTheme: TextTheme(
    headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: dark),
    bodyMedium: TextStyle(fontSize: 18, color: dark),
  ),


  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium), 
      borderSide: BorderSide(color: light), 
    ),
  ),


  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: amethyst,
      foregroundColor: dark,
      minimumSize: Size(50, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      textStyle: TextStyle(fontSize: 20),
    ),
  ),


);
