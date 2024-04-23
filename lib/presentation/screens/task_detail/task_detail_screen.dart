import 'package:flutter/material.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/data/models/task_timer.dart';
import 'package:odoo_apexive/presentation/screens/task_detail/details_tab.dart';
import 'package:odoo_apexive/presentation/screens/task_detail/timesheets_tab.dart';
import 'package:odoo_apexive/presentation/widgets/app_bar/app_bar_back_button.dart';
import 'package:odoo_apexive/presentation/widgets/app_bar/app_bar_small_title.dart';
import 'package:odoo_apexive/presentation/widgets/gradient_scaffold.dart';
import 'package:odoo_apexive/presentation/widgets/app_bar/main_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  static const routeName = '/taskScreen';

  @override
  Widget build(BuildContext context) {
    final taskTimer = ModalRoute.of(context)!.settings.arguments as TaskTimer;
    final timerBloc = taskTimer.timerBloc;

    return BlocProvider.value(
      value: timerBloc,
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return GradientScaffold(
            appBar: MainAppBar(
              centerTitle: true,
              leading: const AppBarBackButton(),
              title: AppBarSmallTitle(title: taskTimer.task.name),
            ),
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).colorScheme.onSurface,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.onSurface,
                    indicatorColor: Theme.of(context).colorScheme.onSurface,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        text: AppLocalizations.of(context)!.timeSheets,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.details,
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        TimesheetsTab(taskTimer: taskTimer),
                        DetailsTab(taskTimer: taskTimer),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
