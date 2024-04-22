import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/models/task_timer.dart';
import 'package:odoo_apexive/presentation/screens/task_detail/task_detail_screen.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/styles/vector_graphics.dart';
import 'package:odoo_apexive/presentation/widgets/card/card_container.dart';
import 'package:odoo_apexive/presentation/widgets/card/title_label.dart';
import 'package:odoo_apexive/presentation/widgets/card/value_label.dart';
import 'package:odoo_apexive/presentation/widgets/card/yellow_bar.dart';
import 'package:odoo_apexive/utils/utils.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({
    super.key,
    required this.taskTimer,
  });

  final TaskTimer taskTimer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => taskTimer.timerBloc,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            TaskDetailScreen.routeName,
            arguments: taskTimer,
          );
        },
        child: CardContainer(child: _Data(taskTimer: taskTimer)),
      ),
    );
  }
}

class _Data extends StatelessWidget {
  const _Data({
    super.key,
    required this.taskTimer,
  });

  final TaskTimer taskTimer;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const YellowBar(),
          const SizedBox(width: AppDimens.s),
          Flexible(
            child: _InfoColumn(
              taskTimer: taskTimer,
            ),
          ),
          const _ClockButton()
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({
    super.key,
    required this.taskTimer,
  });

  final TaskTimer taskTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CardTextLine(
          svgIconPath: taskTimer.isFavourite
              ? AppVectorGraphics.starFilled
              : AppVectorGraphics.starBorderOutlined,
          child: ValueLabel(taskTimer.task),
        ),
        const SizedBox(height: AppDimens.xs),
        _CardTextLine(
          svgIconPath: AppVectorGraphics.suitcaseBorderOutlined,
          child: TitleLabel(taskTimer.project),
        ),
        const SizedBox(height: AppDimens.xs),
        const _CardTextLine(
          svgIconPath: AppVectorGraphics.clockBorderOutlined,
          child: TitleLabel('Deadline 07/20/2023'),
        ),
      ],
    );
  }
}

class _CardTextLine extends StatelessWidget {
  const _CardTextLine({
    required this.svgIconPath,
    required this.child,
  });

  final String svgIconPath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: AppDimens.l,
          width: AppDimens.l,
          child: Center(
            child: SvgPicture.asset(
              svgIconPath,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
            ),
          ),
        ),
        const SizedBox(width: AppDimens.xs),
        Flexible(child: child)
      ],
    );
  }
}

class _ClockButton extends StatelessWidget {
  const _ClockButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        final secondsLeft =
            context.select((TimerBloc bloc) => bloc.state.secondsLeft);

        final textColor = state is TimerRunInProgress
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSecondaryContainer;

        final backgroundColor = state is TimerRunInProgress
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.08);

        final iconData =
            state is TimerRunInProgress ? Icons.pause : Icons.play_arrow;

        return GestureDetector(
          onTap: () => context.read<TimerBloc>().add(const PlayPauseButton()),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.m,
              vertical: AppDimens.sl,
            ),
            alignment: Alignment.center,
            height: AppDimens.xxxl,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppDimens.xc),
            ),
            child: Row(
              children: [
                Text(
                  Utils.formatDuration(secondsDuration: secondsLeft),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: textColor),
                ),
                const SizedBox(width: AppDimens.xs),
                Icon(iconData, color: textColor)
              ],
            ),
          ),
        );
      },
    );
  }
}
