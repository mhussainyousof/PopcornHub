import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  AppColor._();
  static const Color richBlack = Color(0xFF0D0D0D);       
  static const Color charcoalGrey = Color(0xFF1C1C1E);  
  static const Color pureWhite = Color(0xFFFFFFFF);      
  static const Color snowGrey = Color(0xFFF5F5F7);        

  static const Color electricBlue = Color(0xFF4F9DDE);    
  static const Color deepPurple = Color(0xFF7D5FFF);     
  static const Color softCoral = Color(0xFFFF6B6B);       
  static const Color mintGreen = Color(0xFF2CD6B4);       

  static const Color coolGrey = Color(0xFFA0A3BD);        
  static const Color slateGrey = Color(0xFF4E4B66);      
}

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.pureWhite,
      colorScheme: ColorScheme.light(
        primary: AppColor.electricBlue,
        secondary: AppColor.deepPurple,
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.cinzel(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        headlineMedium: GoogleFonts.cinzel(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        bodyLarge: GoogleFonts.robotoSlab(
          fontSize: 16,
          color: AppColor.slateGrey,
        ),
        bodyMedium: GoogleFonts.robotoSlab(
          fontSize: 14,
          color: AppColor.slateGrey,
        ),
        bodySmall: GoogleFonts.robotoSlab(
          fontSize: 12,
          color: AppColor.slateGrey,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: AppColor.pureWhite,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardColor: AppColor.snowGrey,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.electricBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.richBlack,
      colorScheme: ColorScheme.dark(
        primary: AppColor.electricBlue,
        secondary: AppColor.mintGreen,
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.cinzel(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.cinzel(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.robotoSlab(
          fontSize: 16,
          color: AppColor.coolGrey,
        ),
        bodyMedium: GoogleFonts.robotoSlab(
          fontSize: 14,
          color: AppColor.coolGrey,
        ),
        bodySmall: GoogleFonts.robotoSlab(
          fontSize: 12,
          color: AppColor.coolGrey,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: AppColor.richBlack,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardColor: AppColor.charcoalGrey,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.electricBlue,
          foregroundColor: Colors.white,
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


