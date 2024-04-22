import 'package:flutter/material.dart';
import 'package:odoo_apexive/models/task_timer.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/widgets/card/card_container.dart';
import 'package:odoo_apexive/presentation/widgets/card/title_label.dart';
import 'package:odoo_apexive/presentation/widgets/card/value_label.dart';
import 'package:odoo_apexive/presentation/widgets/card/yellow_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({
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
                const TitleLabel('Project'),
                const SizedBox(height: AppDimens.xs),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      const YellowBar(),
                      const SizedBox(width: AppDimens.s),
                      ValueLabel(taskTimer.project),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimens.m),
                TitleLabel(AppLocalizations.of(context)!.deadline),
                const ValueLabel('10/11/2023'),
                const SizedBox(height: AppDimens.m),
                TitleLabel(AppLocalizations.of(context)!.assignedTo),
                const ValueLabel('Ivan Zhuikov'),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.s),
          CardContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TitleLabel(AppLocalizations.of(context)!.description),
                const ValueLabel(
                    'As a user, I would like to be able to buy a subscription, this would allow me to get a discount on the products and on the second stage of diagnosis'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
