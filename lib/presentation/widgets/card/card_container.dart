import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.m),
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08)),
      padding: const EdgeInsets.all(AppDimens.m),
      child: child,
    );
  }
}
