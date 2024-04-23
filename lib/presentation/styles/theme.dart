import 'package:flutter/material.dart';

class TimesheetsTheme {
  static ThemeData getTheme() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          onPrimaryContainer: const Color(0xFF000000),
          onSurface: const Color(0xFFFFFFFF),
          secondaryContainer: const Color(0xFFFFFFFF).withOpacity(0.16),
          onSecondaryContainer: const Color(0xFFFFFFFF),
          onSecondary: const Color(0xFFFFFFFF),
          background: const Color(0xFF0C1D4D),
          surface: const Color(0xFF214ECC),
          outline: const Color(0xFFFFFFFF).withOpacity(0.16),
        ),
        textTheme: const TextTheme(
          headlineLarge:
              TextStyle(fontSize: 32, height: 40, fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      );
}
