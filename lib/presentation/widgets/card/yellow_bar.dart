import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';

class YellowBar extends StatelessWidget {
  const YellowBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.xxs,
      color: const Color(0xFFFFC629),
    );
  }
}
