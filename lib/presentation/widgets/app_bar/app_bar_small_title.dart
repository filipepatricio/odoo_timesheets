import 'package:flutter/material.dart';

class AppBarSmallTitle extends StatelessWidget {
  const AppBarSmallTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
