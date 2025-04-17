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


  static ThemeData get boardGameTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF8B5E3C), // Dunkles Holzbraun
      scaffoldBackgroundColor: const Color(0xFFF5EBD8), // Pergament-Beige

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF8B5E3C),
        brightness: Brightness.light,
        primary: const Color(0xFF8B5E3C), // Holzbraun
        secondary: const Color(0xFFB3925F), // Helleres Lederbraun
        error: const Color(0xFFAF302D), // Dunkles Rubinrot
        surface: const Color(0xFFF5EBD8),
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Color(0xFF4E342E), // Dunkler Holzton
          fontFamily: 'Cinzel', // Stilisiertes Mittelalter-Feeling
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Color(0xFF3E2723),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF5D4037),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB3925F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF8B5E3C), width: 1.5),
          ),
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFEFE6D1), // Vergilbtes Papier
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color(0xFF8B5E3C)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        hintStyle: TextStyle(color: Color(0xFF6D4C41)),
        labelStyle: TextStyle(color: Color(0xFF6D4C41)),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF8B5E3C),
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cinzel',
          color: Colors.white,
        ),
      ),

      cardTheme: CardTheme(
        color: const Color(0xFFE6D3B3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
