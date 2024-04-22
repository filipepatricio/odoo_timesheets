import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';

class ValueLabel extends StatelessWidget {
  const ValueLabel(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.xxs),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
