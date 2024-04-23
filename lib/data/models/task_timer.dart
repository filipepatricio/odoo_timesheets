import 'package:equatable/equatable.dart';
import 'package:odoo_apexive/blocs/timer_bloc/timer_bloc.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';

class TaskTimer extends Equatable {
  TaskTimer({
    required this.task,
    required this.project,
    this.description,
    this.isFavorite = false,
  }) {
    secondsLeft = task.duration;
    timerBloc = TimerBloc(duration: secondsLeft);
  }

  final Task task;
  final Project project;
  final String? description;

  bool isFavorite;
  bool isCompleted = false;

  late int secondsLeft;
  late TimerBloc timerBloc;

  @override
  List<Object?> get props => [
        task,
        project,
        secondsLeft,
        description,
        isFavorite,
        isCompleted,
      ];
}
