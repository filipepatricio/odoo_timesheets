import 'package:flutter/material.dart';
import 'package:odoo_apexive/models/task_timer.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/widgets/gradient_background.dart';
import 'package:odoo_apexive/presentation/widgets/main_app_bar.dart';
import 'package:odoo_apexive/presentation/widgets/timer_card.dart';

class TimesheetsScreen extends StatelessWidget {
  const TimesheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackgroundContainer(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const MainAppBar(
        titleText: 'Timesheets',
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(AppDimens.m),
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (context, index) => TimerCard(
            taskTimer: TaskTimer(
              project: "iOS app deployment with odd",
              task: "SO056 - Booqio V2",
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: AppDimens.s,
          ),
        ),
      ),
    ));
  }
}
