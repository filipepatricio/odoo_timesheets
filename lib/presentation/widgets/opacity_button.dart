import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';

class OpacityButton extends StatelessWidget {
  const OpacityButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: AppDimens.xxxl,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.sl),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
            ),
          )),
    );
  }
}
