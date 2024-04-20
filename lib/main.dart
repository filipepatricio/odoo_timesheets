import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/screens/timesheets_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          onPrimaryContainer: const Color(0xFF000000),
          onSurface: const Color(0xFFFFFFFF),
          secondaryContainer: const Color(0xFFFFFFFF).withOpacity(0.16),
          onSecondaryContainer: const Color(0xFFFFFFFF),
          onSecondary: const Color(0xFFFFFFFF),
          background: const Color(0xFF0C1D4D),
          surface: const Color(0xFF214ECC),
        ),
        textTheme: const TextTheme(
          headlineLarge:
              TextStyle(fontSize: 32, height: 40, fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
      home: const TimesheetsScreen(),
    );
  }
}
