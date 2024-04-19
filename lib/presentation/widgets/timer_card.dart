import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:odoo_apexive/models/task_timer.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/styles/vector_graphics.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({
    super.key,
    required this.taskTimer,
  });

  final TaskTimer taskTimer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.s),
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08)),
      padding: const EdgeInsets.all(AppDimens.m),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: AppDimens.xxs,
              color: const Color(0xFFFFC629),
            ),
            const SizedBox(width: AppDimens.s),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardTextLine(
                    svgIconPath: AppVectorGraphics.starBorderOutlined,
                    text: Text(
                      taskTimer.project,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: AppDimens.xs),
                  _CardTextLine(
                    svgIconPath: AppVectorGraphics.suitcaseBorderOutlined,
                    text: Text(
                      taskTimer.task,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: AppDimens.xs),
                  _CardTextLine(
                    svgIconPath: AppVectorGraphics.clockBorderOutlined,
                    text: Text(
                      'Deadline 07/20/2023',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 104,
              alignment: Alignment.center,
              height: AppDimens.xxxl,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(AppDimens.xc),
              ),
              child: Text(
                '00:30',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CardTextLine extends StatelessWidget {
  const _CardTextLine({
    required this.svgIconPath,
    required this.text,
  });

  final String svgIconPath;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Flexible(child: text)
      ],
    );
  }
}
