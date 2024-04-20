import 'package:flutter/material.dart';
import 'package:odoo_apexive/presentation/widgets/gradient_scaffold.dart';
import 'package:odoo_apexive/presentation/widgets/main_app_bar.dart';

class CreateTimerScreen extends StatelessWidget {
  const CreateTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: MainAppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text(
          "Create timer",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text('Create timer screen'),
      ),
    );
  }
}
