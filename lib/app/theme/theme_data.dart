import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  const Color primaryBlue = Color(0xFF003D7C);
  const Color textGray = Color(0xFF64748B);
  const Color borderGray = Color(0xFFE2E8F0);
  const Color backgroundLight = Color(0xFFF9FAFB);

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundLight,
    
    // 1. Color Palette Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBlue,
      primary: primaryBlue,
      secondary: textGray,
      background: backgroundLight,
    ),

    // 2. Global Typography (Matching weights seen in onboarding/auth)
    fontFamily: "OpenSans", // Make sure this matches your pubspec.yaml asset family name
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: primaryBlue, letterSpacing: -1),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
      bodyLarge: TextStyle(fontSize: 16, color: textGray),
      bodyMedium: TextStyle(fontSize: 14, color: textGray, height: 1.5),
    ),

    // 3. Elevated Button Theme (Primary Action Buttons like Login/Signup/Next)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Matching your card roundness
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    // 4. Outlined Button Theme (Secondary items like Google Login Button)
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: borderGray),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // 5. Global Input Decoration (TextFields/Dropdowns formatting)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      prefixIconColor: const Color(0xFF94A3B8),
      suffixIconColor: textGray,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryBlue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.0),
      ),
    ),

    // 6. Checkbox Theme configurations
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) return primaryBlue;
        return null;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    // 7. AppBar Theme Settings
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryBlue),
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: primaryBlue,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}