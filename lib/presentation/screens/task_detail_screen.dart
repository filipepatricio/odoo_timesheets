import 'package:flutter/material.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/presentation/widgets/gradient_scaffold.dart';
import 'package:odoo_apexive/presentation/widgets/main_app_bar.dart';
import 'package:odoo_apexive/utils/utils.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
      final duration = context.select((TimerBloc bloc) => bloc.state.duration);
      return GradientScaffold(
        appBar: MainAppBar(
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded)),
          title: Text(
            "Task detail",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Text(Utils.formatDuration(duration)),
        ),
      );
    });
  }
}
