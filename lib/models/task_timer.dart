import 'package:equatable/equatable.dart';
import 'package:odoo_apexive/blocs/timer_bloc/timer_bloc.dart';

class TaskTimer extends Equatable {
  TaskTimer({
    required this.task,
    required this.project,
    this.duration = 30,
    this.description,
    this.isFavourite = false,
  }) {
    timerBloc = TimerBloc(duration: duration);
  }

  final String task;
  final String project;
  final int duration;
  final String? description;

  bool isFavourite;

  late TimerBloc timerBloc;

  @override
  List<Object?> get props => [
        task,
        project,
        duration,
        description,
        isFavourite,
        timerBloc,
      ];
}
