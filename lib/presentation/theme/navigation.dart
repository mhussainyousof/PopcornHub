import 'package:flutter/material.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class AppNavigationBarTheme {
  AppNavigationBarTheme._();

  static NavigationBarThemeData lightNavigationBarTheme = NavigationBarThemeData(
    height: 60,
    elevation: 0,
    backgroundColor: AppColor.pureWhite,
    indicatorColor: AppColor.electricBlue.withAlpha(26),

    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) => TextStyle(
        fontSize: 10, 
        color: states.contains(WidgetState.selected)
            ? AppColor.electricBlue
            : AppColor.slateGrey,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) => IconThemeData(
        color: states.contains(WidgetState.selected)
            ? AppColor.electricBlue
            : AppColor.slateGrey,
        size: 20, 
      ),
    ),
  );

  static NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
    height: 60,
    elevation: 0,
    backgroundColor: AppColor.richBlack,
    indicatorColor: AppColor.mintGreen.withAlpha(51),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) => TextStyle(
        fontSize: 10, 
        color: states.contains(WidgetState.selected)
            ? AppColor.mintGreen
            : AppColor.coolGrey,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) => IconThemeData(
        color: states.contains(WidgetState.selected)
            ? AppColor.mintGreen
            : AppColor.coolGrey,
        size: 20, 
      ),
    ),
  );
}
    