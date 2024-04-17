import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppThemeData {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: AppColors.primaryBlueMaterial,
      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.primaryBlue,
      ),
      textTheme: GoogleFonts.latoTextTheme()
          .apply(
            bodyColor: Colors.black, //<-- SEE HERE
            displayColor: Colors.black, //<
          )
          .copyWith(
            headline1: const TextStyle(
              fontSize: 24,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
            headline2: const TextStyle(
              fontSize: 22,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
            headline3: const TextStyle(
              fontSize: 20,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
            headline4: const TextStyle(fontSize: 18, color: Colors.black),
            headline5: const TextStyle(fontSize: 16),
            headline6: const TextStyle(fontSize: 14),
          ),
    );
  }
}
