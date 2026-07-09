import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const lightBg = Color(0xFFFAFBFC);
  static const darkBg = Color(0xFF0A0F1E);
  static const lightSurface = Color(0xFFFFFFFF);
  static const darkSurface = Color(0xFF111827);
  static const primary = Color(0xFF6366F1);
  static const primaryGlow = Color(0xFF8B5CF6);
  static const accent = Color(0xFF22D3EE);
}

class ThemeConfig {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBg,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.lightSurface,
        ),
        textTheme: GoogleFonts.interTextTheme(),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.darkSurface,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      );
}
