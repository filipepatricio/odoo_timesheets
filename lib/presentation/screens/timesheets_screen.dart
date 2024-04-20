import 'package:flutter/material.dart';
import 'package:odoo_apexive/models/task_timer.dart';
import 'package:odoo_apexive/presentation/screens/create_timer_screen.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/widgets/gradient_scaffold.dart';
import 'package:odoo_apexive/presentation/widgets/main_app_bar.dart';
import 'package:odoo_apexive/presentation/widgets/timer_card.dart';

class TimesheetsScreen extends StatelessWidget {
  const TimesheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: MainAppBar(
        centerTitle: false,
        title: Text(
          "Timesheets",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: const [_CreateButton()],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(AppDimens.m),
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (context, index) => TimerCard(
            taskTimer: TaskTimer(
              task: "iOS app deployment with odd",
              project: "SO056 - Booqio V2",
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: AppDimens.s,
          ),
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateTimerScreen()),
        );
      },
      child: Container(
        width: AppDimens.xxxl,
        height: AppDimens.xxxl,
        margin: const EdgeInsets.only(right: AppDimens.m),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppDimens.sl))),
        child: Center(
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
