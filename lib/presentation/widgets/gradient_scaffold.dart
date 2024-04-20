import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({super.key, required this.appBar, required this.body});

  final PreferredSizeWidget appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return _GradientBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
      ),
    );
  }
}

class _GradientBackgroundContainer extends StatelessWidget {
  const _GradientBackgroundContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surface,
            ]),
      ),
      child: child,
    );
  }
}