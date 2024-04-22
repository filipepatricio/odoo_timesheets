import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.one,
      color: Theme.of(context).colorScheme.outline,
    );
  }
}
