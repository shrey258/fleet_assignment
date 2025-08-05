import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      primaryColor: const Color(0xFF007AFF),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 24.r,
        ),
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: TextStyle(fontSize: 57.sp, height: 64 / 57, color: Colors.black87),
        displayMedium: TextStyle(fontSize: 45.sp, height: 52 / 45, color: Colors.black87),
        displaySmall: TextStyle(fontSize: 36.sp, height: 44 / 36, color: Colors.black87),
        headlineLarge: TextStyle(fontSize: 32.sp, height: 40 / 32, color: Colors.black87),
        headlineMedium: TextStyle(fontSize: 28.sp, height: 36 / 28, color: Colors.black87),
        headlineSmall: TextStyle(fontSize: 24.sp, height: 32 / 24, color: Colors.black87),
        titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, height: 28 / 22, color: Colors.black),
        titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 24 / 16, letterSpacing: 0.15, color: Colors.black87),
        titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 20 / 14, letterSpacing: 0.1, color: Colors.black87),
        labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 20 / 14, letterSpacing: 0.1, color: Colors.black54),
        labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, height: 16 / 12, letterSpacing: -0.5, color: Colors.black54),
        labelSmall: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, height: 16 / 11, letterSpacing: 0.5, color: Colors.black54),
        bodyLarge: TextStyle(fontSize: 16.sp, height: 24 / 16, letterSpacing: 0.15, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14.sp, height: 20 / 14, letterSpacing: 0.25, color: Colors.black87),
        bodySmall: TextStyle(fontSize: 12.sp, height: 16 / 12, letterSpacing: 0.4, color: Colors.black54),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF007AFF),
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
