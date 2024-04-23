import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/presentation/screens/create_timer_screen.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/styles/vector_graphics.dart';
import 'package:odoo_apexive/presentation/widgets/app_bar/app_bar_big_title.dart';
import 'package:odoo_apexive/presentation/widgets/gradient_scaffold.dart';
import 'package:odoo_apexive/presentation/widgets/app_bar/main_app_bar.dart';
import 'package:odoo_apexive/presentation/widgets/opacity_button.dart';
import 'package:odoo_apexive/presentation/widgets/timer_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimesheetsScreen extends StatelessWidget {
  const TimesheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: MainAppBar(
        centerTitle: false,
        title: AppBarBigTitle(title: AppLocalizations.of(context)!.timeSheets),
        actions: const [_CreateButton()],
      ),
      body: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          return state.taskTimerList.isNotEmpty
              ? ListView.separated(
                  itemCount: state.taskTimerList.length,
                  itemBuilder: (context, index) => TimerCard(
                    taskTimer: state.taskTimerList[index],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppDimens.s,
                  ),
                )
              : const _EmptyList();
        },
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppVectorGraphics.emptyTimesheets,
              ),
              const SizedBox(height: AppDimens.xl),
              Text(
                AppLocalizations.of(context)!.empty_timesheets_title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.s),
              Text(
                AppLocalizations.of(context)!.empty_timesheets_call_to_action,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
        OpacityButton(
          title: AppLocalizations.of(context)!.get_started,
          onTap: () =>
              Navigator.pushNamed(context, CreateTimerScreen.routeName),
        ),
      ],
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CreateTimerScreen.routeName);
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
