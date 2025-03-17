import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  AppColor._();

  static const Color vulcan = Color(0xFF0B0C10);        // Dark background
  static const Color royalBlue = Color(0xFF45A29E);     // Primary Teal
  static const Color violet = Color(0xFF9B59B6);        // Accent Violet
  static const Color lightBackground = Color(0xFFF8F8F8); // Light theme BG
  static const Color greyText = Color(0xFFC5C6C7);      // Secondary text
  static const Color pinkAccent = Color(0xFFFF6F91);    // Soft pink for highlights
}

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.lightBackground,
      colorScheme: ColorScheme.light(
        primary: AppColor.royalBlue,
        secondary: AppColor.violet,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      cardColor: Colors.white.withOpacity(0.9),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.violet,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.vulcan,
      colorScheme: ColorScheme.dark(
        primary: AppColor.royalBlue,
        secondary: AppColor.pinkAccent,
      ),
      textTheme: GoogleFonts.robotoMonoTextTheme().apply(
        bodyColor: AppColor.greyText,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardColor: Colors.white.withOpacity(0.05),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.royalBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      useMaterial3: true,
    );
  }
}


