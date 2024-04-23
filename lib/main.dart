import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/presentation/screens/create_timer_screen.dart';
import 'package:odoo_apexive/presentation/screens/task_detail/task_detail_screen.dart';

import 'package:odoo_apexive/presentation/screens/timesheets_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:odoo_apexive/presentation/styles/theme.dart';

void main() {
  runApp(const OdooTimesheets());
}

class OdooTimesheets extends StatelessWidget {
  const OdooTimesheets({super.key});

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
          routes: {
            CreateTimerScreen.routeName: (context) => const CreateTimerScreen(),
            TaskDetailScreen.routeName: (context) => const TaskDetailScreen(),
          },
          theme: TimesheetsTheme.getTheme(),
          home: const TimesheetsScreen(),
        ));
  }
}
