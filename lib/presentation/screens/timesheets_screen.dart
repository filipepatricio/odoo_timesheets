import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/widgets/gradient_background.dart';
import 'package:odoo_apexive/presentation/widgets/main_app_bar.dart';

class TimesheetsScreen extends StatelessWidget {
  const TimesheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GradientBackgroundContainer(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MainAppBar(
        titleText: 'Timesheets',
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(AppDimens.m),
        child: Center(
          child: Text('Timesheet list'),
        ),
      ),
    ));
  }
}
