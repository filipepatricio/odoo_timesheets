import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new_rounded));
  }
}
