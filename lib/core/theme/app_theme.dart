import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get kineticAmber {
    // Garantiza 100% offline sin intentar descargar fuentes en runtime
    GoogleFonts.config.allowRuntimeFetching = false;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brandYellow,
        primaryContainer: AppColors.brandYellowLight,
        secondary: AppColors.brandDark,
        secondaryContainer: AppColors.brandDarkSurface,
        surface: AppColors.surfacePure,
        error: AppColors.error,
        onPrimary: AppColors.brandDark,
        onSecondary: Colors.white,
        onSurface: AppColors.brandDark,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.brandDark,
          fontWeight: FontWeight.w800,
          fontSize: 32,
        ),
        headlineLarge: TextStyle(
          color: AppColors.brandDark,
          fontWeight: FontWeight.w700,
          fontSize: 26,
        ),
        headlineMedium: TextStyle(
          color: AppColors.brandDark,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        titleLarge: TextStyle(
          color: AppColors.brandDark,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        titleMedium: TextStyle(
          color: AppColors.brandDark,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        bodyLarge: TextStyle(
          color: AppColors.brandDark,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: AppColors.brandMuted,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: TextStyle(
          color: AppColors.brandMuted,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.scaffoldBackground,
        foregroundColor: AppColors.brandDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.brandDark,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfacePure,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.borderAmberSubtle, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceWarm,
        labelStyle: const TextStyle(color: AppColors.brandMuted, fontSize: 13),
        hintStyle: const TextStyle(color: AppColors.textDisabled, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.borderAmberInput),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.borderAmberInput),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.brandDark, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandDark,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.8,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.brandDark,
        foregroundColor: AppColors.brandYellow,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
    );
  }

  // Alias para mantener compatibilidad
  static ThemeData get dark => kineticAmber;
}
