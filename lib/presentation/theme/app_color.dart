import 'package:flutter/material.dart';

import 'theme_text.dart'; 

class AppColor {
  AppColor._();

  static const Color vulcan = Color(0xFF141221);
  static const Color royalBlue = Color(0xFF604FEF);
  static const Color violet = Color(0xFFA74DBC);
  static const Color lightBackground = Colors.white;
}

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.lightBackground,
      colorScheme: ColorScheme.light(
        primary: AppColor.vulcan,
        secondary: AppColor.violet,
      ),
      textTheme: ThemeText.getLightTextTheme(), // Apply Light TextTheme
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.vulcan,
      colorScheme: ColorScheme.dark(
        primary: AppColor.royalBlue,
        secondary: AppColor.violet,
      ),
      textTheme: ThemeText.getTextTheme(), // Apply Dark TextTheme
    );
  }
}

