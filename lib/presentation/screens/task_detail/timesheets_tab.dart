import 'package:flutter/material.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/data/models/task_timer.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/widgets/card/card_container.dart';
import 'package:odoo_apexive/presentation/widgets/card/title_label.dart';
import 'package:odoo_apexive/presentation/widgets/card/value_label.dart';
import 'package:odoo_apexive/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimesheetsTab extends StatelessWidget {
  const TimesheetsTab({
    super.key,
    required this.taskTimer,
  });

  final TaskTimer taskTimer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TitleLabel('Monday'),
                const ValueLabel('17.07.2023'),
                const TitleLabel('Start Time 10:00'),
                const _Clock(),
                if (taskTimer.description != null &&
                    taskTimer.description!.isNotEmpty) ...[
                  const Divider(),
                  const SizedBox(height: AppDimens.m),
                  TitleLabel(AppLocalizations.of(context)!.description),
                  const SizedBox(height: AppDimens.s),
                  ValueLabel(taskTimer.description!),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Clock extends StatelessWidget {
  const _Clock();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (BuildContext context, TimerState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.s),
          child: Row(
            children: [
              Text(
                Utils.formatDuration(
                    secondsDuration: state.secondsLeft, withHours: true),
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              _ClockSecondaryButton(
                onTap: () => context.read<TimerBloc>().add(const StopButton()),
                iconData: Icons.stop,
              ),
              const SizedBox(width: AppDimens.m),
              _ClockPrimaryButton(
                onTap: () =>
                    context.read<TimerBloc>().add(const PlayPauseButton()),
                iconData: state is TimerRunInProgress
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ClockSecondaryButton extends StatelessWidget {
  const _ClockSecondaryButton({
    required this.iconData,
    required this.onTap,
  });

  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimens.xxxl,
        width: AppDimens.xxxl,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(AppDimens.l),
        ),
        child: Icon(
          iconData,
          size: AppDimens.xl,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

class _ClockPrimaryButton extends StatelessWidget {
  const _ClockPrimaryButton({
    required this.iconData,
    required this.onTap,
  });

  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimens.xxxl,
        width: AppDimens.xxxl,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppDimens.l),
        ),
        child: Icon(
          iconData,
          size: AppDimens.xl,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
