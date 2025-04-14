import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 236, 198, 73), // Sonnengelb
      scaffoldBackgroundColor: const Color(0xFFFFFBF2), // Creméweiß

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 235, 198, 80),
        brightness: Brightness.light,
        primary: const Color.fromARGB(255, 51, 38, 236), // Gelb
        secondary: const Color(0xFF3B82F6), // Blau
        error: const Color(0xFFEF4444), // Rubinrot
        surface: const Color(0xFFFFFFFF),
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937), // Anthrazit
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Color(0xFF1F2937), // Primärtext
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF6B7280), // Sekundärtext
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 248, 234, 31),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF3F4F6), // helles Grau
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: TextStyle(color: Color(0xFF6B7280)),
        labelStyle: TextStyle(color: Color(0xFF6B7280)),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFCD34D),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),

      cardTheme: CardTheme(
        color: const Color(0xFFF3F4F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        margin: const EdgeInsets.all(12),
      ),
    );
  }
}
