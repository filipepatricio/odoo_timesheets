import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const MainAppBar({
    required this.titleText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      actions: [
        Container(
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );
}
