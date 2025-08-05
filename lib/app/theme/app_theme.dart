import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get dark {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      primaryColor: const Color(0xFF214ECC),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24.r,
        ),
        titleTextStyle: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: TextStyle(fontSize: 57.sp, height: 64 / 57, color: Colors.white),
        displayMedium: TextStyle(fontSize: 45.sp, height: 52 / 45, color: Colors.white),
        displaySmall: TextStyle(fontSize: 36.sp, height: 44 / 36, color: Colors.white),
        headlineLarge: TextStyle(fontSize: 32.sp, height: 40 / 32, color: Colors.white),
        headlineMedium: TextStyle(fontSize: 28.sp, height: 36 / 28, color: Colors.white),
        headlineSmall: TextStyle(fontSize: 24.sp, height: 32 / 24, color: Colors.white),
        titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, height: 28 / 22, color: Colors.white),
        titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 24 / 16, letterSpacing: 0.15, color: Colors.white.withOpacity(0.87)),
        titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 20 / 14, letterSpacing: 0.1, color: Colors.white.withOpacity(0.87)),
        labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 20 / 14, letterSpacing: 0.1, color: Colors.white.withOpacity(0.7)),
        labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, height: 16 / 12, letterSpacing: -0.5, color: Colors.white.withOpacity(0.7)),
        labelSmall: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, height: 16 / 11, letterSpacing: 0.5, color: Colors.white.withOpacity(0.7)),
        bodyLarge: TextStyle(fontSize: 16.sp, height: 24 / 16, letterSpacing: 0.15, color: Colors.white.withOpacity(0.87)),
        bodyMedium: TextStyle(fontSize: 14.sp, height: 20 / 14, letterSpacing: 0.25, color: Colors.white.withOpacity(0.87)),
        bodySmall: TextStyle(fontSize: 12.sp, height: 16 / 12, letterSpacing: 0.4, color: Colors.white.withOpacity(0.7)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF214ECC).withOpacity(0.8),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.87)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.87)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
       checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(const Color(0xFF0C1D4D)),
        side: BorderSide(color: Colors.white.withOpacity(0.7)),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.05),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white.withOpacity(0.87)),
      tabBarTheme: TabBarThemeData(
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }

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
