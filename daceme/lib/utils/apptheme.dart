import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color black = Color(0xFF121212);
  static const Color primaryAccent = Color(0xFF6C5CE7);
  static const Color textLight = Colors.white;
  static const Color textDark = Colors.white70;
}

class AppTheme {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 35,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      ),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 35,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight.withOpacity(0.9),
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark.withOpacity(0.7),
      ),
      displayLarge: GoogleFonts.poppins(
        fontSize: 64,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAccent.withOpacity(0.2),
        foregroundColor: AppColors.textLight,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: const StadiumBorder(),
        elevation: 0,
        side: const BorderSide(color: AppColors.primaryAccent, width: 2),
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // Other theme properties can be customized here
  );
}
