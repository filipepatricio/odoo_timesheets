import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';

import 'package:odoo_apexive/presentation/screens/timesheets_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskListBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
        ],
        theme: ThemeData(
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
            headlineLarge: TextStyle(
                fontSize: 32, height: 40, fontWeight: FontWeight.bold),
          ),
          useMaterial3: true,
        ),
        home: const TimesheetsScreen(),
      ),
    );
  }
}
