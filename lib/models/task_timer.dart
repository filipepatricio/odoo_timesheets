import 'package:equatable/equatable.dart';

class TaskTimer extends Equatable {
  TaskTimer({
    required this.task,
    required this.project,
    this.duration = 30,
    this.description,
    this.isFavourite,
  }) {
    isFavourite = isFavourite ?? false;
  }

  final String task;
  final String project;
  final int duration;
  final String? description;

  bool? isFavourite;

  @override
  List<Object?> get props => [
        task,
        project,
        duration,
        description,
        isFavourite,
      ];
}
