import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
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
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black87),
        bodyLarge: TextStyle(fontSize: 16.sp, color: Colors.black87),
        bodySmall: TextStyle(fontSize: 12.sp, color: Colors.black54),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF007AFF),
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
